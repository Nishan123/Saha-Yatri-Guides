import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:saha_yatri_guides/views/screens/profile_screen.dart';

class HomeAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String username;
  const HomeAppbar({
    super.key,
    required this.username,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      actions: [
        InkWell(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (_) => const ProfileScreen()));
          },
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: CircleAvatar(
              backgroundColor: Colors.black,
              child: Icon(
                FeatherIcons.user,
                color: Colors.white,
              ),
            ),
          ),
        )
      ],
      title: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Text(
            "👋",
            style: TextStyle(fontSize: 36),
          ),
          const SizedBox(
            width: 6,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Text(
                "Hi,",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Text(
                username,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
