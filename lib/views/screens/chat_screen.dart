import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:saha_yatri_guides/services/auth_service.dart';
import 'package:saha_yatri_guides/services/chat_service.dart';
import 'package:saha_yatri_guides/views/screens/chat_room.dart';
import 'package:saha_yatri_guides/views/widgets/chat_user_tile.dart';
import 'package:saha_yatri_guides/views/widgets/search_bar_field.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chats"),
      ),
      body: _buildUserList(),
    );
  }

  Widget _buildUserList() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: StreamBuilder(
        stream: _chatService.getUsersStream(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text("Error"),
            );
          }
          if (!snapshot.hasData) {
            return const Center(
              child: Text("No any chat data"),
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          // Create a list of widgets
          final List<Widget> children = [
            SearchBarField(
              hintText: "Search user",
              controller: searchController,
              prefixIcon: const Icon(FeatherIcons.search),
            ),
            ...snapshot.data!.map<Widget>(
                (userData) => _buildUserListItem(userData, context)),
          ];

          return ListView(
            children: children,
          );
        },
      ),
    );
  }

  Widget _buildUserListItem(
      Map<String, dynamic> userData, BuildContext context) {
    if (userData["email"] != _authService.getCurrentUser()!.email) {
      return FutureBuilder<Map<String, dynamic>?>(
        future: _chatService.getLastMessage(
          _authService.getCurrentUser()!.uid,
          userData["uid"],
        ),
        builder: (context, snapshot) {
          String lastMessageText = "No messages yet";
          if (snapshot.connectionState == ConnectionState.waiting) {
            lastMessageText = "Loading...";
          } else if (snapshot.hasError) {
            lastMessageText = "Error loading message";
          } else if (snapshot.hasData && snapshot.data != null) {
            lastMessageText = snapshot.data!["message"] ?? "No content";
          }

          return ChatUserTile(
            text: userData["username"],
            lastMessage: lastMessageText,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ChatRoom(
                    reciverUsername: userData["username"],
                    reciverId: userData["uid"],
                    receiverEmail: userData["email"],
                  ),
                ),
              );
            },
          );
        },
      );
    } else {
      return const SizedBox();
    }
  }
}
