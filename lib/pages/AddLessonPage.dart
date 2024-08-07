// ignore_for_file: file_names, use_key_in_widget_constructors, library_private_types_in_public_api, prefer_const_constructors, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class LessonRequestForm  extends StatefulWidget {
  @override
  _AddLessonPageState createState() => _AddLessonPageState();
}

class _AddLessonPageState extends State<LessonRequestForm > {
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
      QuerySnapshot querySnapshot = await _firestore.collection('Courses').get();
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
  Map<String, bool> selectedDays = {
    'Sunday': false,
    'Monday': false,
    'Tuesday': false,
    'Wednesday': false,
    'Thursday': false,
    'Friday': false,
  };
  RangeValues timeRange = const RangeValues(8, 24);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 40,),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                labelText: 'Select Course',
              ),
              value: selectedCourse,
              onChanged: (value) {
                setState(() {
                  selectedCourse = value;
                });
              },
              items: _courseNames.map((course) {
                return DropdownMenuItem<String>(
                  value: course,
                  child: Text(course),
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            Text('Select Days:'),
            SizedBox(height: 10),
            Column(
              children: selectedDays.entries.map((entry) {
                return CheckboxListTile(
                  title: Text(entry.key),
                  value: entry.value,
                  onChanged: (value) {
                    setState(() {
                      selectedDays[entry.key] = value!;
                    });
                  },
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            Text('Select Time Range:'),
            RangeSlider(
              values: timeRange,
              onChanged: (values) {
                setState(() {
                  timeRange = values;
                });
              },
              min: 0,
              max: 24,
              divisions: 24,
              labels: RangeLabels('${timeRange.start}', '${timeRange.end}'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Handle the request submission here
                print('Course: $selectedCourse');
                print('Selected Days: $selectedDays');
                print('Time Range: ${timeRange.start} - ${timeRange.end}');
              },
              child: Text('Request Lesson'),
            ),
          ],
        ),
      ),
    );
  }
}
