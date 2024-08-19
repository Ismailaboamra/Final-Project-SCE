import 'package:final_project_sce/Admin/HomePage.dart';
import 'package:final_project_sce/Controller/MentorController.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MentorManagementPage extends StatefulWidget {
  @override
  _MentorManagementPageState createState() => _MentorManagementPageState();
}

class _MentorManagementPageState extends State<MentorManagementPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> _addMentor() async {
    String email = '';
    String course = '';
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add Mentor'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                onChanged: (value) {
                  email = value;
                },
                decoration: InputDecoration(hintText: "Enter Mentor's Email"),
              ),
              TextField(
                onChanged: (value) {
                  course = value;
                },
                decoration: InputDecoration(hintText: "Enter Course Name"),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
             TextButton(
              onPressed: () async {
                if (email.isNotEmpty && course.isNotEmpty) {
                  // הוספת מנטור חדש
                  DocumentReference mentorRef = await _firestore.collection('Mentors').add({
                    'email': email,
                    'courses': [course],
                  });

                  // עדכון השדה mentor ל-true ב-Users
                  QuerySnapshot userSnapshot = await _firestore.collection('Users').where('email', isEqualTo: email).get();
                  if (userSnapshot.docs.isNotEmpty) {
                    DocumentReference userRef = userSnapshot.docs.first.reference;
                    await userRef.update({'Mentor': true});
                  }
                }
                Navigator.of(context).pop();
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _updateMentor(Mentor mentor) async {
    String email = mentor.email;
    String course = '';
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Update Mentor'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                onChanged: (value) {
                  email = value;
                },
                decoration: InputDecoration(
                  hintText: "Enter Mentor's Email",
                  labelText: mentor.email,
                ),
              ),
              TextField(
                onChanged: (value) {
                  course = value;
                },
                decoration: InputDecoration(hintText: "Enter New Course Name"),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                if (email.isNotEmpty) {
                  if (course.isNotEmpty) {
                    mentor.courses.add(course);
                  }
                  await _firestore
                      .collection('Mentors')
                      .doc(mentor.id)
                      .update(mentor.toMap());
                }
                Navigator.of(context).pop();
              },
              child: Text('Update'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _deleteMentor(String id) async {
    await _firestore.collection('Mentors').doc(id).delete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
               leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
              Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => HomePage()));
          },
        ),
        title: Text('Mentor Management'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: _addMentor,
          ),
        ],
      ),
      body: StreamBuilder(
        stream: _firestore.collection('Mentors').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          return ListView(
            children: snapshot.data!.docs.map((doc) {
              Mentor mentor = Mentor.fromDocument(doc);
              return ListTile(
                title: Text(mentor.email),
                subtitle: Text('Courses: ${mentor.courses.join(', ')}'),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () => _updateMentor(mentor),
                    ),
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () => _deleteMentor(mentor.id),
                    ),
                  ],
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
