// ignore_for_file: file_names, prefer_const_constructors, unused_import, avoid_print, prefer_interpolation_to_compose_strings

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/Cupertino.dart';

class UserData {
  final String uid;
  final String fieldName;
  String data;

  UserData({required this.uid, required this.fieldName, required this.data});

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

  void getUserDataField(String uid, String field) async {
    try {
      // Fetch user data from Firestore
      Map<String, dynamic>? userData = await getUserDataFromFirestore(uid);
      // If user data exists and the field exists in the data, return the field value
      if (userData != null && userData.containsKey(field)) {
        data = userData[field];
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

  String getData() {
    getUserDataField(uid, fieldName);
    print(data);
    return fieldName+" : "+  data.toString();
  }

}
