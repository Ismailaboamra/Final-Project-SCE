import 'package:final_project_sce/Admin/HomePage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddCoursePage extends StatefulWidget {
  @override
  _AddCoursePageState createState() => _AddCoursePageState();
}

class _AddCoursePageState extends State<AddCoursePage> {
  final TextEditingController _courseNameController = TextEditingController();
  final TextEditingController _courseDescriptionController = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  List<DocumentSnapshot> _students = [];
  List<DocumentSnapshot> _selectedStudents = [];

  @override
  void initState() {
    super.initState();
    _fetchStudents();
  }

  Future<void> _fetchStudents() async {
    QuerySnapshot querySnapshot = await _firestore.collection('userss').get();
    setState(() {
      _students = querySnapshot.docs;
    });
  }

  void _addCourse() async {
    final String courseName = _courseNameController.text.trim();
    final String courseDescription = _courseDescriptionController.text.trim();

    if (courseName.isNotEmpty && courseDescription.isNotEmpty && _selectedStudents.isNotEmpty) {
      await _firestore.collection('Courses').doc(courseName).set({
        'description': courseDescription,
        'students': _selectedStudents.map((student) {
          return {
            'name': student['Username'],
            'id': student.id,
          };
        }).toList(),
      });

      setState(() {
        _courseNameController.clear();
        _courseDescriptionController.clear();
        _selectedStudents.clear();
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Course added successfully!')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill in all fields and select students')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          actions: [
          IconButton(
              onPressed: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => HomePage()));
              },
              icon: Icon(Icons.undo_outlined))
        ],
        title: Text('Add Course'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _courseNameController,
              decoration: InputDecoration(labelText: 'Course Name'),
            ),
            TextField(
              controller: _courseDescriptionController,
              decoration: InputDecoration(labelText: 'Course Description'),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView(
                children: _students.map((student) {
                  return CheckboxListTile(
                    title: Text(student['Username']),
                    value: _selectedStudents.contains(student),
                    onChanged: (bool? selected) {
                      setState(() {
                        if (selected == true) {
                          _selectedStudents.add(student);
                        } else {
                          _selectedStudents.remove(student);
                        }
                      });
                    },
                  );
                }).toList(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _addCourse,
              child: Text('Add Course'),
            ),
          ],
        ),
      ),
    );
  }
}
