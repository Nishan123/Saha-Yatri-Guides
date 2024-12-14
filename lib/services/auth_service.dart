import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AuthService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // to get current user
  User? getCurrentUser() {
    return _auth.currentUser;
  }

  void showToast(String message, Color backgroundColor, Color textColor) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.TOP,
      backgroundColor: backgroundColor,
      textColor: textColor,
      fontSize: 16.0,
    );
  }

  Future<void> login(
      BuildContext context, String email, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      showToast("Login successful!", Colors.green, Colors.white);
      debugPrint("User signed in: ${userCredential.user?.email}");
    } on FirebaseAuthException catch (e) {
      String message = '';
      switch (e.code) {
        case "invalid-email":
          message = "Invalid email! Check again.";
          break;
        case "wrong-password":
          message = "Incorrect password. Please try again.";
          break;
        case "user-not-found":
          message = "No user found with this email.";
          break;
        case "user-disabled":
          message = "User account has been disabled.";
          break;
        case "network-request-failed":
          message = "Network error. Please check your internet connection.";
          break;
        default:
          message = "An unknown error occurred. Please try again.";
          break;
      }
      showToast(message, Colors.red, Colors.white);
      debugPrint("FirebaseAuthException: ${e.code}");
    } catch (e) {
      showToast("An error occurred: ${e.toString()}", Colors.red, Colors.white);
      debugPrint("Error: ${e.toString()}");
    }
  }

// logout function
  Future<void> logOut() async {
    return await _auth.signOut();
  }

  // get user details from database
  Future<Map<String, dynamic>?> fetchUserData({required String uid}) async {
    try {
      // Fetch the document with the UID from the 'users' collection
      DocumentSnapshot userDoc =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();

      if (userDoc.exists) {
        // Return the data as a Map
        return {
          'email': userDoc['email'],
          'phone': userDoc['phone'],
          'username': userDoc['username'],
        };
      } else {
        debugPrint("No user data found for UID: $uid");
        return null;
      }
    } catch (e) {
      debugPrint("Error fetching user data: $e");
      return null;
    }
  }

  Future<UserCredential?> signUp(
      String email, String password, String username) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      // Save user details in the Firestore database
      await _firestore.collection("users").doc(userCredential.user!.uid).set({
        'uid': userCredential.user!.uid,
        'email': email,
        'profilePic': "",
        'user': 'user',
        'year_of_exp': "",
        'username': username,
        'phone': "98........"
      });

      showToast("Account created successfully", Colors.blue, Colors.white);
      return userCredential;
    } on FirebaseAuthException catch (e) {
      String message = '';
      switch (e.code) {
        case "weak-password":
          message = "Password is too weak";
          break;
        case "email-already-in-use":
          message = "Email is already in use";
          break;
        case "invalid-email":
          message = "Email format not valid";
          break;
        default:
          message = "An unknown error occurred. Please try again.";
          break;
      }
      showToast(
        message,
        Colors.red,
        Colors.white,
      );
      debugPrint(e.code);
      return null;
    } catch (e) {
      showToast(
        "An error occurred: ${e.toString()}",
        Colors.red,
        Colors.white,
      );
      debugPrint("Generic Exception: $e");
      return null;
    }
  }
}
