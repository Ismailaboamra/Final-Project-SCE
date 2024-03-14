// ignore_for_file: file_names, camel_case_types, prefer_const_constructors, non_constant_identifier_names, avoid_unnecessary_containers, sort_child_properties_last

import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class addTask extends StatefulWidget {
  final DateTime selectedDate;

  const addTask({super.key, required this.selectedDate});

  @override
  State<addTask> createState() => _addTaskState();
}

class _addTaskState extends State<addTask> {
  // final DateTime selectedDate;
  TimeOfDay startTime = TimeOfDay(hour: 9, minute: 00);
  TimeOfDay endTime = TimeOfDay(hour: 13, minute: 00); //
  String? selectedCourse;
  List<String> courses = ['Course A', 'Course B', 'Course C'];
  List<DateTime> dates = [];

  Future<void> _createTask() async {
    dates.add(widget.selectedDate);
    var kk = FirebaseFirestore.instance
        .collection('userss')
        .doc('User : ' + FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) async {
      if (documentSnapshot.exists) {
        Map<String, dynamic> taskDetails = {
          'MentorName': documentSnapshot.get('Username') as String,
          'UserID': FirebaseAuth.instance.currentUser!.uid,
          'selectedCourse': selectedCourse,
          'date': dates,
          'startTime': startTime.toString(),
          'endTime': endTime.toString(),
        };
        print(taskDetails);
        try {
          // Reference to the Firestore collection where you want to store the data
          CollectionReference collectionReference =
              FirebaseFirestore.instance.collection('wrok_schedule');

          // Add the data to Firestore
          await collectionReference.add(taskDetails);

          print('Data added to Firestore successfully');
        } catch (e) {
          print('Error adding data to Firestore: $e');
        }
      } else {
        print('Not Exsist');
      }
    });
  }

  void _showTimePicker1() {
    showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    ).then((value) {
      setState(() {
        startTime = value!;
      });
    });
  }

  void _showTimePicker2() {
    showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    ).then((value) {
      setState(() {
        endTime = value!;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add task"),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(10, 20, 10, 0),
                child: DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText: 'Select Course',
                  ),
                  value: selectedCourse,
                  onChanged: (value) {
                    setState(() {
                      selectedCourse = value;
                    });
                  },
                  items: courses.map((course) {
                    return DropdownMenuItem<String>(
                      value: course,
                      child: Text(course),
                    );
                  }).toList(),
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(10, 20, 10, 0),
                child: TextFormField(
                  readOnly: true,
                  decoration: InputDecoration(
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    labelText: "Date",
                    labelStyle: TextStyle(fontSize: 23),
                    hintText:
                        DateFormat('dd/MM/yyyy').format(widget.selectedDate),
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 15),
                    floatingLabelStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 23,
                        fontWeight: FontWeight.bold),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.greenAccent),
                    ),
                    border: OutlineInputBorder(borderSide: BorderSide()),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(10, 20, 10, 0),
                child: TextField(
                  readOnly: true,
                  decoration: InputDecoration(
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    labelText: "Start Time",
                    labelStyle: TextStyle(fontSize: 23),
                    hintText: startTime.format(context).toString(),
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 15),
                    floatingLabelStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 23,
                        fontWeight: FontWeight.bold),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.greenAccent),
                    ),
                    border: OutlineInputBorder(borderSide: BorderSide()),
                    suffixIcon: IconButton(
                      icon:
                          Icon(Icons.access_time), // Adjust the icon as needed
                      onPressed: () {
                        _showTimePicker1();
                      }, // Handle icon click
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(10, 20, 10, 40),
                child: TextFormField(
                  readOnly: true,
                  decoration: InputDecoration(
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    labelText: "End Time",
                    labelStyle: TextStyle(fontSize: 23),
                    hintText: endTime.format(context).toString(),
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 15),
                    floatingLabelStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 23,
                        fontWeight: FontWeight.bold),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.greenAccent),
                    ),
                    border: OutlineInputBorder(borderSide: BorderSide()),
                    suffixIcon: IconButton(
                      icon:
                          Icon(Icons.access_time), // Adjust the icon as needed
                      onPressed: () {
                        _showTimePicker2();
                      }, // Handle icon click
                    ),
                  ),
                ),
              ),
              Container(
                child: ElevatedButton(
                  onPressed: () {
                    _createTask();
                  },
                  child: Text(
                    'Create Task',
                    style: TextStyle(fontSize: 15),
                  ),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.black,
                    backgroundColor: Color(0xff4ac08a),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
