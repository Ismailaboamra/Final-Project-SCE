import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatListScreen extends StatelessWidget {
  final String currentUserId;

  ChatListScreen({required this.currentUserId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chats'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('chats')
            .where('participants', arrayContains: currentUserId)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          var chatDocs = snapshot.data!.docs;
          if (chatDocs.isEmpty) {
            return Center(child: Text("No chats available"));
          }

          // Extract unique users
          Set<Map<String, dynamic>> uniqueUsers = {};
          for (var chat in chatDocs) {
            var participants = List<String>.from(chat['participants']);
            var otherUserId = participants.firstWhere((id) => id != currentUserId);
            var otherUserName = chat['participantNames'][otherUserId]; // Assuming you store names
            uniqueUsers.add({
              'userId': otherUserId,
              'userName': otherUserName,
            });
          }

          return ListView.builder(
            itemCount: uniqueUsers.length,
            itemBuilder: (context, index) {
              var user = uniqueUsers.elementAt(index);
              return ListTile(
                title: Text(user['userName']),
                onTap: () {
                  // Navigate to chat screen
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ChatScreen(
                        currentUserId: currentUserId,
                        otherUserId: user['userId'],
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}

class ChatScreen extends StatelessWidget {
  final String currentUserId;
  final String otherUserId;

  ChatScreen({required this.currentUserId, required this.otherUserId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chat"),
      ),
      body: Center(
        child: Text("Chat with $otherUserId"),
      ),
    );
  }
}
