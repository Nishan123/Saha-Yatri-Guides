import 'package:flutter/material.dart';
import 'package:saha_yatri_guides/services/auth_service.dart';
import 'package:saha_yatri_guides/views/widgets/custom_button.dart';
import 'package:saha_yatri_guides/views/widgets/custom_textfield.dart';

class LoginSignupScreen extends StatefulWidget {
  const LoginSignupScreen({super.key});

  @override
  State<LoginSignupScreen> createState() => _LoginSignupScreenState();
}

class _LoginSignupScreenState extends State<LoginSignupScreen> {
  bool isObscure = true;
  bool isSignup = false;

  void authChange() {
    setState(() {
      isSignup = !isSignup;
    });
  }

  void onPressedSuffix() {
    setState(() {
      isObscure = !isObscure;
    });
  }

  final TextEditingController loginEmailController = TextEditingController();
  final TextEditingController signupEmailController = TextEditingController();
  final TextEditingController signupPasswordController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final TextEditingController loginPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var mq = MediaQuery.of(context).size;
    return Scaffold(
      body: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: mq.height * 0.28,
                  width: mq.width,
                  child: Image.asset(
                    "assets/banner.png",
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 30),
                      Text(
                        isSignup
                            ? "Create a new account."
                            : "Welcome, Login to continue.",
                        style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 1),
                      ),
                      const SizedBox(height: 10),
                      CustomTextfield(
                        hintText: "Email",
                        controller: isSignup?signupEmailController:loginEmailController,
                        obscureText: false,
                        textInputType: TextInputType.emailAddress,
                        suffixIcon: const Icon(Icons.email_outlined),
                      ),
                      if (isSignup)
                        CustomTextfield(
                          hintText: "Username",
                          controller: usernameController,
                          obscureText: false,
                          textInputType: TextInputType.text,
                          suffixIcon: const Icon(Icons.person_outline_rounded),
                        ),
                      CustomTextfield(
                        hintText: "Password",
                        controller: isSignup?signupPasswordController:loginPasswordController,
                        obscureText: isObscure,
                        textInputType: TextInputType.emailAddress,
                        suffixIcon: const Icon(Icons.visibility_outlined),
                        onPressedSuffix: onPressedSuffix,
                      ),
                      if (isSignup)
                        CustomTextfield(
                          hintText: "Confirm password",
                          controller: confirmPasswordController,
                          obscureText: isObscure,
                          textInputType: TextInputType.emailAddress,
                          suffixIcon: const Icon(Icons.visibility_outlined),
                          onPressedSuffix: onPressedSuffix,
                        ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: CustomButton(
                    backgroundColor: Colors.black,
                    onPressed: () {
                      if (signupPasswordController.text ==
                          confirmPasswordController.text) {
                        isSignup
                            ? AuthService().signUp(
                                signupEmailController.text, signupPasswordController.text, usernameController.text)
                            : AuthService().login(context, loginEmailController.text,
                                loginPasswordController.text);
                      } else {
                        AuthService().showToast("Confirm password must be same",
                            Colors.red, Colors.white);
                      }
                    },
                    text: isSignup ? "Signup" : "Login",
                    textColor: Colors.white,
                  ),
                ),
                const SizedBox(
                  height: 80,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(isSignup
                        ? "Already have an account?"
                        : "Don't have an account?"),
                    TextButton(
                      onPressed: () {
                        authChange();
                      },
                      child: Text(
                        isSignup ? "Login" : "Create one",
                        style: const TextStyle(color: Colors.blue),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
