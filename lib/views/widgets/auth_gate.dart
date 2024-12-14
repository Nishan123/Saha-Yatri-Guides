import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:saha_yatri_guides/views/screens/login_signup_screen.dart';
import 'package:saha_yatri_guides/views/screens/main_screen.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return const MainScreen();
            } else {
              return const LoginSignupScreen();
            }
          }),
    );
  }
}
