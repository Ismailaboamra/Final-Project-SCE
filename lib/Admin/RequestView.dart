import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project_sce/Admin/AdminRequestPage.dart';
import 'package:flutter/material.dart';

class RequestDetailsPage extends StatelessWidget {
  final String requestId;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> _sendRequestToMentors(
      String requestId, String course, String studentEmail) async {
    try {
      QuerySnapshot querySnapshot = await _firestore
          .collection('Mentors')
          .where('courses', arrayContains: course)
          .get();
      for (var doc in querySnapshot.docs) {
        String mentorEmail = doc.get('email');
        print('mentor email :' + mentorEmail);
        await _firestore.collection('notifications').add({
          'mentorEmail': mentorEmail,
          'studentEmail': studentEmail,
          'requestId': requestId,
          'message': 'New lesson request for course $course',
        });
      }
      print('Requests sent to mentors');
    } catch (e) {
      print('Error sending requests to mentors: $e');
    }
  }

  RequestDetailsPage(this.requestId);

  Future<Map<String, dynamic>?> _fetchRequestDetails(String requestId) async {
    try {
      DocumentSnapshot doc = await FirebaseFirestore.instance
          .collection('requests')
          .doc(requestId)
          .get();
      return doc.data() as Map<String, dynamic>?;
    } catch (e) {
      print('Error fetching request details: $e');
      return null;
    }
  }

  Future<void> _updateRequestStatus(String requestId, String status) async {
    try {
      await FirebaseFirestore.instance
          .collection('requests')
          .doc(requestId)
          .update({'status': status});
      print('Request status updated to $status');
    } catch (e) {
      print('Error updating request status: $e');
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
                        builder: (context) => AdminRequestsPage()));
              },
              icon: Icon(Icons.undo_outlined))
        ],
      ),
      body: FutureBuilder<Map<String, dynamic>?>(
        future: _fetchRequestDetails(requestId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data == null) {
            return Center(child: Text('Request not found'));
          }

          Map<String, dynamic> requestDetails = snapshot.data!;
          String course = requestDetails['course'];
          String numHours = requestDetails['numHours'];
          String emailStudent = requestDetails['email'];
          String? userID = requestDetails['userId'];

          return Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // FutureBuilder(future:, builder: ),
                Text('Course: $course'),
                Text('Number of hours: $numHours'),
                Text('Student Email: $emailStudent'),
                // Text('Mentor: ${mentor ?? 'Not selected'}'),
                SizedBox(height: 20),
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        // _updateRequestStatus(requestId, 'approved');
                        _sendRequestToMentors(
                            requestId, course, '$emailStudent');
                        // ScaffoldMessenger.of(context).showSnackBar(
                        //   SnackBar(content: Text('Request approved')),
                        // );
                      },
                      child: Text('Send to Mentors'),
                    ),
                    SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: () {
                        _updateRequestStatus(requestId, 'rejected');
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Request rejected')),
                        );
                      },
                      child: Text('Reject'),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
