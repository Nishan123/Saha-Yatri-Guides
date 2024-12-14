import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:saha_yatri_guides/services/auth_service.dart';
import 'package:saha_yatri_guides/services/chat_service.dart';
import 'package:saha_yatri_guides/views/widgets/chat_bubble.dart';


class ChatRoom extends StatelessWidget {
  final String receiverEmail;
  final String reciverId;
  final String reciverUsername;

  ChatRoom({
    super.key,
    required this.receiverEmail,
    required this.reciverId, required this.reciverUsername,
  });
  final TextEditingController messageController = TextEditingController();
  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();

  void sendMessage() async {
    if (messageController.text.isNotEmpty) {
      await _chatService.sendMessage(reciverId, messageController.text);
      messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(reciverUsername),
        ),
        body: Column(
          children: [
            // display all message
            Expanded(child: _buildMessageList()),

            //display message input field
            _buildUserInput()
          ],
        ));
  }

  Widget _buildMessageList() {
    String senderId = _authService.getCurrentUser()!.uid;
    return StreamBuilder(
      stream: _chatService.getMessages(reciverId, senderId),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Center(
            child: Text("Error Occoured !"),
          );
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return ListView(
          children:
              snapshot.data!.docs.map((doc) => _buildMessageItem(doc)).toList(),
        );
      },
    );
  }

  Widget _buildMessageItem(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    // check if its the current user
    bool isCurrentUser = data['senderId'] == _authService.getCurrentUser()!.uid;

    // align the message to right is the current user is sender
    var alignment =
        isCurrentUser ? Alignment.centerRight : Alignment.centerLeft;

    return Container(
      alignment: alignment,
      child: Column(
        crossAxisAlignment:
            isCurrentUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          ChatBubble(
            message: data["message"],
            isCurrentUser: isCurrentUser,
          )
        ],
      ),
    );
  }

  Widget _buildUserInput() {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              style: const TextStyle(color: Colors.white),
              controller: messageController,
              maxLines: null,
              keyboardType: TextInputType.multiline,
              decoration: InputDecoration(
                hintText: "Type your Message....",
                filled: true,
                fillColor: const Color.fromARGB(96, 0, 0, 0),
                hintStyle: const TextStyle(
                  color: Colors.white30,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  borderSide: const BorderSide(color: Colors.white, width: 1.5),
                ),
              ),
            ),
          ),
        ),
        IconButton(onPressed: sendMessage, icon: const Icon(Icons.send))
      ],
    );
  }
}
