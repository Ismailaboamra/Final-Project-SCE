import 'package:cloud_firestore/cloud_firestore.dart';

class Mentor {
  String id;
  String email;
  List<String> courses;

  Mentor({required this.id, required this.email, required this.courses});

  factory Mentor.fromDocument(DocumentSnapshot doc) {
    return Mentor(
      id: doc.id,
      email: doc['email'],
      courses: List<String>.from(doc['courses']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'courses': courses,
    };
  }
}
