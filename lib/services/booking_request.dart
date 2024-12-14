import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class BookingService {
// Function to fetch all documents from a collection
  Future<void> getBookingRequest() async {
    try {
      // Reference to the collection
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection(
              'guide_request') // Replace with your collection name
          .get();

      // Loop through the documents and print each one
      for (var doc in querySnapshot.docs) {
        var documentData = doc.data() as Map<String, dynamic>;
        debugPrint('Document ID: ${doc.id}');
        debugPrint('Document Data: $documentData');
      }
    } catch (e) {
      debugPrint('Error fetching documents: $e');
    }
  }
  Future<void> rejectBooking(String collectionName, String docId) async {
  try {
    // Get a reference to the Firestore collection and document
    await FirebaseFirestore.instance
        .collection(collectionName)
        .doc(docId)
        .delete();

    print("Rejected");
  } catch (e) {
    // Handle errors
    print("Error deleting document: $e");
  }
}
}
