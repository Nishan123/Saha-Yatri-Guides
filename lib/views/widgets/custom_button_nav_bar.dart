import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';


class CustomButtomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomButtomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: const Color.fromARGB(255, 219, 219, 219),
      currentIndex: currentIndex,
      selectedIconTheme: const IconThemeData(color: Colors.black),
      unselectedIconTheme:
          const IconThemeData(color: Color.fromARGB(255, 169, 155, 149)),
      selectedLabelStyle: const TextStyle(
          fontSize: 10, color: Colors.black, fontWeight: FontWeight.bold),
      unselectedLabelStyle: const TextStyle(
        fontWeight: FontWeight.normal,
        fontSize: 10,
        color: Colors.black,
      ),
      onTap: onTap,
      items: const [
        BottomNavigationBarItem(icon: Icon(FeatherIcons.checkSquare), label: 'Requests'),
        BottomNavigationBarItem(
            icon: Icon(FeatherIcons.messageCircle), label: 'Chats'),
        BottomNavigationBarItem(
            icon: Icon(FeatherIcons.flag), label: 'Emergency'),
    
 
      ],
    );
  }
}
