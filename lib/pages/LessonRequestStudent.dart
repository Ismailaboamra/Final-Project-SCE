import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project_sce/shared/MyTextField.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LessonRequestForm extends StatefulWidget {
  @override
  _AddLessonPageState createState() => _AddLessonPageState();
}

class _AddLessonPageState extends State<LessonRequestForm> {
  final numhoursController = TextEditingController();
  final String? userEmail = FirebaseAuth.instance.currentUser?.email;
  String? selectedCourse;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<String> _courseNames = [];

  @override
  void initState() {
    super.initState();
    _fetchCourseNames();
  }

  Future<void> _fetchCourseNames() async {
    try {
      QuerySnapshot querySnapshot =
          await _firestore.collection('Courses').get();
      List<String> courseNames = [];
      for (var doc in querySnapshot.docs) {
        courseNames.add(doc.id); // Document ID is the course name
      }
      setState(() {
        _courseNames = courseNames;
      });
    } catch (e) {
      print('Error fetching course names: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error fetching course names')),
      );
    }
  }

  Future<void> _sendRequest() async {
    if (selectedCourse != null && numhoursController.text.isNotEmpty) {
      try {
        // Get the current user's UID
        final String? userId = FirebaseAuth.instance.currentUser?.uid;

        if (userId != null) {
          await _firestore.collection('requests').add({
            'course': selectedCourse,
            'numHours': numhoursController.text,
            'userId': userId, // Store the user's UID
            'email': userEmail,
            'status': '', // Additional fields can be added here as needed
          });

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Request sent successfully!')),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('User not logged in')),
          );
        }
      } catch (e) {
        print('Error sending request: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error sending request')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please select a course and enter the number of hours')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 40),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                labelText: 'Select Course',
              ),
              value: selectedCourse,
              onChanged: (value) {
                setState(() {
                  selectedCourse = value;
                });
                if (value != null) {
                  _fetchCourseNames();
                }
              },
              items: _courseNames.map((course) {
                return DropdownMenuItem<String>(
                  value: course,
                  child: Text(course),
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            Text('Select hours'),
            MyTextField(
                validator: (value) {
                  return value!.contains(RegExp("r^[1,2,3,4,5,6,7,8,9]"))
                      ? null
                      : "Enter your hours of ";
                },
                autovalidateMode: AutovalidateMode.disabled,
                myController: numhoursController,
                keyboardTypee: TextInputType.emailAddress,
                hintTextt: "num hours",
                obscureText: false,
                suffixIcon:
                    IconButton(onPressed: () {}, icon: Icon(Icons.numbers))),
            
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _sendRequest,
              child: Text('Request Lesson'),
            ),
          ],
        ),
      ),
    );
  }
}
