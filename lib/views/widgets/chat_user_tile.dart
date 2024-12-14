import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';

class ChatUserTile extends StatelessWidget {
  final String text;
  final String lastMessage;
  final void Function()? onTap;

  const ChatUserTile({
    super.key,
    required this.text,
    required this.lastMessage,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Row(
          children: [
            const CircleAvatar(
              child: Icon(FeatherIcons.user),
            ),
            const SizedBox(
              width: 10,
            ),
            // Use Column with mainAxisSize set to min to prevent expanding to an unbounded height
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize
                  .min, // Ensure the column does not expand infinitely
              children: [
                Text(
                  text,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                // Text widget will be wrapped in Flexible without forcing it to take extra space
                Flexible(
                  fit:
                      FlexFit.loose, // Ensures it only takes the space it needs
                  child: Text(
                    lastMessage,
                    maxLines: 1,
                    overflow:
                        TextOverflow.ellipsis, // Handle overflow with ellipsis
                    style: const TextStyle(
                      fontWeight: FontWeight.w100,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
