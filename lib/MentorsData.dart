// ignore_for_file: file_names, prefer_const_constructors, unused_import, avoid_print, prefer_interpolation_to_compose_strings

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/Cupertino.dart';
import 'package:final_project_sce/Controller/MentorController.dart';

class MentorData {
  FirebaseFirestore db = FirebaseFirestore.instance;
  // // final String fieldName;
  //  Mentor mentor;

  // MentorData({
  //   required this.mentor,
  //   // required this.fieldName,
  // });

  Future<void> getMentorDataFromFirestore() async {
    Map<String, dynamic> mentors;
    await db.collection("Mentors").get().then((event) {
      for (var doc in event.docs) {
        print("${doc.id} => ${doc.data()}" + "${doc.get('username')}");
      }
    });
  }

  // static Future<Mentor> getMentorByEmail(String email) async {
  //   // var event = await FirebaseFirestore.instance.collection("Mentors").get();
  //   // for (var doc in event.docs) {
  //   //   if (doc.get('email').toString() == email) {
  //   //     print('exammmm -------' +
  //   //         '${doc.get('email')}' +
  //   //         '${doc.get('username')}');
  //   //     return Mentor(email, doc.get('username'), id: '', email: '', courses: []);
  //   //   }
  //   // }
  //   // print('----Null------');
  //   // return Mentor('email', 'userName'); // default value if not found
  // }

  static Future<Map<String, String>> getMaxMentorLikes() async {
    Map<String, String> detailsMentor = new Map<String, String>();
    var max = 0;
    var username = '';
    var event = await FirebaseFirestore.instance.collection("Mentors").get();
    for (var doc in event.docs) {
      if (max < doc.get('likes')) {
        max = doc.get('likes');
        username = doc.get('username');
      }
      print(doc.get('likes'));
    }
    detailsMentor['username'] = username;
    detailsMentor['likes'] = max.toString();
    return detailsMentor;
  }

  // Future<void> printCollection() async {
  //   try {
  //     // Access the Firestore instance and collection
  //     final CollectionReference collection =
  //         FirebaseFirestore.instance.collection('userss');

  //     // Query the collection
  //     QuerySnapshot querySnapshot = await collection.get();

  //     // Loop through the documents and print their data
  //     querySnapshot.docs.forEach((doc) {
  //       print(doc.data());
  //     });
  //   } catch (e) {
  //     // Handle any errors that occur
  //     print('Error retrieving collection: $e');
  //   }
  // }

  // Future<Map<String, dynamic>?> getUserDataField(String field) async {
  //   try {
  //     // Fetch user data from Firestore
  //     Map<String, dynamic>? userData = await getUserDataFromFirestore(uid);
  //     // If user data exists and the field exists in the data, return the field value
  //     if (userData != null && userData.containsKey(field)) {
  //       return userData; // Return the whole user data map
  //     } else {
  //       // If user data or field does not exist, return null
  //       return null;
  //     }
  //   } catch (e) {
  //     // Return null and log the error if an exception occurs
  //     print('Error fetching user data field: $e');
  //     return null;
  //   }
  // }
}
