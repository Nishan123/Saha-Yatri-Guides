import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:saha_yatri_guides/models/message.dart';

class ChatService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //get user data
  Stream<List<Map<String, dynamic>>> getUsersStream() {
    return _firestore.collection("users").snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        final user = doc.data();
        return user;
      }).toList();
    });
  }

 

  // for sending message
  Future<void> sendMessage(String reciverId, String message) async {
    // Trim the message to remove trailing spaces or newlines
    message = message.trim();

    // Check if the message is empty after trimming
    if (message.isEmpty) {
      debugPrint("Message is empty, not sending.");
      return;
    }

    // Get current user info
    final String currentUserId = _auth.currentUser!.uid;
    final String currentUserEmail = _auth.currentUser!.email!;
    final Timestamp timestamp = Timestamp.now();

    // Create a new message
    Message newMessage = Message(
      senderId: currentUserId,
      reciverId: reciverId,
      message: message,
      senderEmail: currentUserEmail,
      timestamp: timestamp,
    );

    // Create a chat room Id for two users
    List<String> ids = [currentUserId, reciverId];
    ids.sort();
    String chatRoomId = ids.join("_");

    // Add message to Db
    await _firestore
        .collection("chat_rooms")
        .doc(chatRoomId)
        .collection("message")
        .add(
          newMessage.toMap(),
        );
  }
  Stream<QuerySnapshot> getMessages(String userId, String otherUserId) {
    List<String> ids = [userId, otherUserId];
    ids.sort();
    String chatRoomId = ids.join("_");
    return _firestore
        .collection("chat_rooms")
        .doc(chatRoomId)
        .collection("message")
        .orderBy("timestamp", descending: false)
        .snapshots();
  }

  Future<Map<String, dynamic>?> getLastMessage(
    String currentUserId, String receiverId) async {
  try {
    // Create chatRoomId based on the user IDs
    List<String> ids = [currentUserId, receiverId];
    ids.sort();
    String chatRoomId = ids.join("_");

    // Query Firestore to get the last message
    final querySnapshot = await FirebaseFirestore.instance
        .collection("chat_rooms")
        .doc(chatRoomId)
        .collection("message")
        .orderBy("timestamp", descending: true) // Assumes you have a timestamp field
        .limit(1)
        .get();

    // Check if there are any messages
    if (querySnapshot.docs.isNotEmpty) {
      // Return the last message as a map
      return querySnapshot.docs.first.data();
    } else {
      // No messages found
      return null;
    }
  } catch (e) {
    debugPrint("Error fetching last message: $e");
    return null;
  }
}
}
