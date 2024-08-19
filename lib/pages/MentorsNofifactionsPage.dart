import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project_sce/pages/ChatPage.dart';
import 'package:flutter/material.dart';

class MentorNotificationsPage extends StatelessWidget {
  final String mentorEmail;
  final String mentorId;

  MentorNotificationsPage({required this.mentorEmail, required this.mentorId});

  Future<List<Map<String, dynamic>>> _fetchNotifications() async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('notifications')
          .where('mentorEmail', isEqualTo: mentorEmail)
          .get();
      return querySnapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();
    } catch (e) {
      print('Error fetching notifications: $e');
      return [];
    }
  }

  Future<String?> _fetchStudentId(String studentEmail) async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('userss')
          .where('email', isEqualTo: studentEmail)
          .limit(1)
          .get();
      if (querySnapshot.docs.isNotEmpty) {
        return querySnapshot.docs.first.id; // Return the student document ID
      }
    } catch (e) {
      print('Error fetching student ID: $e');
    }
    return null; // Return null if not found or if an error occurs
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications'),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _fetchNotifications(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No notifications'));
          }

          List<Map<String, dynamic>> notifications = snapshot.data!;

          return ListView.builder(
            itemCount: notifications.length,
            itemBuilder: (context, index) {
              var notification = notifications[index];
              return ListTile(
                title: Text(notification['message']),
                subtitle: Text('Student: ${notification['studentEmail']}'),
                trailing: IconButton(
                  icon: Icon(Icons.chat),
                  onPressed: () async {
                    String studentEmail = notification['studentEmail'];
                    String? studentId = await _fetchStudentId(studentEmail);

                    if (studentId != null) {
                      // Navigate to ChatScreen with the correct IDs
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ChatScreen(
                            // mentorName: mentorEmail,
                            mentorImageUrl: 'https://upload.wikimedia.org/wikipedia/commons/e/e0/Userimage.png',
                            studentImageUrl: 'https://upload.wikimedia.org/wikipedia/commons/e/e0/Userimage.png',
                            mentorId: mentorId,
                            studentId: studentId,
                          ),
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Student ID not found')),
                      );
                    }
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
