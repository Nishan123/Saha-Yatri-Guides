import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:saha_yatri_guides/services/auth_service.dart';
import 'package:saha_yatri_guides/views/widgets/custom_button.dart';
import 'package:saha_yatri_guides/views/widgets/custom_textfield.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController yearOfExpController = TextEditingController();

  final AuthService _authService = AuthService();
  bool showPhoneWarning = false;

  @override
  void initState() {
    super.initState();
    fetchAndSetUserData();

    // Add listener to phoneController
    phoneController.addListener(() {
      if (phoneController.text != "98........" && showPhoneWarning) {
        setState(() {
          showPhoneWarning = false;
        });
      }
    });
  }

  @override
  void dispose() {
    // Dispose controllers
    usernameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    yearOfExpController.dispose();
    super.dispose();
  }

  Future<void> fetchAndSetUserData() async {
    try {
      String currentUserUid = FirebaseAuth.instance.currentUser!.uid;
      Map<String, dynamic>? userData =
          await _authService.fetchUserData(uid: currentUserUid);

      if (userData != null) {
        setState(() {
          usernameController.text = userData['username'] ?? 'N/A';
          emailController.text = userData['email'] ?? 'N/A';
          phoneController.text = userData['phone'] ?? '98........';
          yearOfExpController.text = userData['yearOfExp'] ?? 'N/A';
          
          showPhoneWarning = phoneController.text == "98........";
        });
      }
    } catch (e) {
      _authService.showToast(
          "Unknown error occurred", Colors.red, Colors.white);
    }
  }

  Future<void> saveChanges() async {
    try {
      String currentUserUid = FirebaseAuth.instance.currentUser!.uid;
      await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUserUid)
          .set({
        'username': usernameController.text,
        'email': emailController.text,
        'phone': phoneController.text,
        'yearOfExp':yearOfExpController.text
      }, SetOptions(merge: true));

      _authService.showToast(
          "Profile updated successfully!", Colors.green, Colors.white);
    } catch (e) {
      _authService.showToast(
          "Failed to update profile.", Colors.red, Colors.white);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile & Setting"),
      ),
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 140,
                    width: 140,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          spreadRadius: 2,
                          blurRadius: 8,
                          offset: const Offset(0, 0),
                        ),
                      ],
                      color: Colors.white,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.white,
                        width: 7,
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                  CustomTextfield(
                    suffixIcon: const Icon(FeatherIcons.user),
                    hintText: "Username",
                    controller: usernameController,
                    obscureText: false,
                    textInputType: TextInputType.text,
                  ),
                  CustomTextfield(
                    suffixIcon: const Icon(FeatherIcons.mail),
                    hintText: "Email",
                    controller: emailController,
                    obscureText: false,
                    textInputType: TextInputType.text,
                  ),
                  CustomTextfield(
                    suffixIcon: const Icon(FeatherIcons.phone),
                    hintText: "Phone (UID)",
                    controller: phoneController,
                    obscureText: false,
                    textInputType: TextInputType.number,
                  ),
                  CustomTextfield(
                    suffixIcon: const Icon(FeatherIcons.clock),
                    hintText: "Year of exp",
                    controller: yearOfExpController,
                    obscureText: false,
                    textInputType: TextInputType.number,
                  ),
                  showPhoneWarning
                      ? const Text(
                          "Enter your phone number and year of exp to start using service",
                          style: TextStyle(color: Colors.red),
                        )
                      : const SizedBox(),
                  const SizedBox(height: 80),

                  // Edit profile button
                  CustomButton(
                    backgroundColor: Colors.black,
                    onPressed: () {
                      if (phoneController.text == "98........") {
                        setState(() {
                          showPhoneWarning = true;
                        });
                      } else {
                        saveChanges();
                      }
                    },
                    text: "Save changes",
                    textColor: Colors.white,
                  ),
                  const SizedBox(height: 10),

                  // Logout button
                  CustomButton(
                    backgroundColor: Colors.red,
                    onPressed: () {
                      AuthService().logOut();
                    },
                    text: "Log out",
                    textColor: Colors.white,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
