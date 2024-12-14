import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:saha_yatri_guides/firebase_options.dart';
import 'package:saha_yatri_guides/views/widgets/auth_gate.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Saha-Yatri Guides',
      theme: ThemeData(
          appBarTheme: const AppBarTheme(
            titleTextStyle: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
          fontFamily: "Inter",),
      home: const AuthGate(),
    );
  }
}
