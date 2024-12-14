import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  final String message;
  final bool isCurrentUser;

  const ChatBubble({
    super.key,
    required this.message,
    required this.isCurrentUser,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: const Radius.circular(16),
          topRight: const Radius.circular(16),
          bottomLeft: isCurrentUser ? const Radius.circular(16) : const Radius.circular(0),
          bottomRight: isCurrentUser ? const Radius.circular(0) : const Radius.circular(16),

        ),
        color: isCurrentUser
            ? const Color.fromARGB(255, 62, 62, 62)
            : const Color.fromARGB(255, 190, 190, 190),
      ),
      child: Text(
        message,
        style: TextStyle(
          color: isCurrentUser ? Colors.white : Colors.black,
          fontSize: 16,
        ),
      ),
    );
  }
}
