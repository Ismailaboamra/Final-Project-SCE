// ignore_for_file: file_names, prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/Cupertino.dart';

class UserData {
  final String uid;
  // final String fieldName;
  static dynamic data;

  UserData({
    required this.uid,
    // required this.fieldName,
  });

  static Future<Map<String, dynamic>?> getUserDataFromFirestore(
      String uid) async {
    try {
      // Get a reference to the document for the given UID
      DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
          .instance
          .collection('userss')
          .doc('User : ' + uid)
          .get();

      // Check if the document exists
      if (snapshot.exists) {
        // Return the user data if the document exists
        return snapshot.data();
      } else {
        // Return null if the document does not exist
        return null;
      }
    } catch (e) {
      // Return null and log the error if an exception occurs
      print('Error fetching user data: $e');
      return null;
    }
  }

Future<void> printCollection() async {
  try {
    // Access the Firestore instance and collection
    final CollectionReference collection = FirebaseFirestore.instance.collection('userss');

    // Query the collection
    QuerySnapshot querySnapshot = await collection.get();

    // Loop through the documents and print their data
    querySnapshot.docs.forEach((doc) {
      print(doc.data());
    });
  } catch (e) {
    // Handle any errors that occur
    print('Error retrieving collection: $e');
  }
}
Future<Map<String, dynamic>?> getUserDataField(String field) async {
  try {
    // Fetch user data from Firestore
    Map<String, dynamic>? userData = await getUserDataFromFirestore(uid);
    // If user data exists and the field exists in the data, return the field value
    if (userData != null && userData.containsKey(field)) {
      return userData; // Return the whole user data map
    } else {
      // If user data or field does not exist, return null
      return null;
    }
  } catch (e) {
    // Return null and log the error if an exception occurs
    print('Error fetching user data field: $e');
    return null;
  }
}


}
