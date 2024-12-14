import 'package:flutter/material.dart';
import 'package:saha_yatri_guides/views/screens/chat_screen.dart';
import 'package:saha_yatri_guides/views/screens/emergency_screen.dart';
import 'package:saha_yatri_guides/views/screens/home_screen.dart';
import 'package:saha_yatri_guides/views/widgets/custom_button_nav_bar.dart';


class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  final List<Widget> _screens = [
    const HomeScreen(),
    const ChatScreen(),
    const EmergencyScreen(),
  ];
  void _onNavBarTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _screens[_selectedIndex],
        bottomNavigationBar: CustomButtomNavBar(
          currentIndex: _selectedIndex,
          onTap: _onNavBarTap,
        ));
  }
}
