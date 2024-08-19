// ignore_for_file: file_names, use_key_in_widget_constructors, library_private_types_in_public_api, prefer_const_constructors, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project_sce/Admin/HomePage.dart';
import 'package:final_project_sce/Admin/RequestView.dart';
import 'package:flutter/material.dart';

class AdminRequestsPage extends StatefulWidget {
  @override
  _AdminRequestsPageState createState() => _AdminRequestsPageState();
}

class _AdminRequestsPageState extends State<AdminRequestsPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> _updateRequestStatus(String requestId, String status) async {
    if (status == 'approved') {
      try {
        await _firestore.collection('requests').doc(requestId).update({
          'status': status,
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Request updated successfully!')),
        );
      } catch (e) {
        print('Error updating request: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error updating request')),
        );
      }
    } else {
      _firestore.collection("requests").doc(requestId).delete().then(
            (doc) => print("Document deleted"),
            onError: (e) => print("Error updating document $e"),
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
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => HomePage()));
              },
              icon: Icon(Icons.forward))
        ],
        title: Text('Student Requests'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestore.collection('requests').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          final requests = snapshot.data!.docs;

          return ListView.builder(
            itemCount: requests.length,
            itemBuilder: (context, index) {
              var request = requests[index];
              var requestId = request.id;
              var requestData = request.data() as Map<String, dynamic>;

              return ListTile(
                title: Text('Course: ${requestData['course']}'),
                subtitle: Text('Requested by: ${requestData['email']}'),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // ElevatedButton(
                    //   onPressed: () =>
                    //       _updateRequestStatus(requestId, 'approved'),
                    //   child: Text('Approve'),
                    // ),
                    // SizedBox(width: 8),
                    // ElevatedButton(
                    //   onPressed: () =>
                    //       _updateRequestStatus(requestId, 'denied'),
                    //   child: Text('Deny'),
                    // ),
                    // SizedBox(
                    //   width: 8,
                    // ),
                    ElevatedButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      RequestDetailsPage(requestId)));
                        },
                        child: Text('View'))
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
