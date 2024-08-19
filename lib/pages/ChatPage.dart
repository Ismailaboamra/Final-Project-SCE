import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  final String mentorImageUrl;
  final String studentImageUrl;
  final String mentorId;  // Unique ID for mentor
  final String studentId; // Unique ID for student

  ChatScreen({
    required this.mentorImageUrl,
    required this.studentImageUrl,
    required this.mentorId,
    required this.studentId,
  });

  Future<String> _fetchStudentEmail() async {
    try {
      DocumentSnapshot docSnapshot = await FirebaseFirestore.instance
          .collection('userss')
          .doc(studentId)
          .get();

      if (docSnapshot.exists) {
        return docSnapshot.get('email') ?? 'Unknown';
      } else {
        return 'Unknown';
      }
    } catch (e) {
      print('Error fetching student email: $e');
      return 'Unknown';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: FutureBuilder<String>(
          future: _fetchStudentEmail(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            }
            if (!snapshot.hasData || snapshot.data == 'Unknown') {
              return Text(
                'Student Email Not Found',
                style: TextStyle(color: Colors.black),
              );
            }

            return Row(
              children: [
                CircleAvatar(
                  backgroundImage: studentImageUrl.isNotEmpty
                      ? NetworkImage(studentImageUrl)
                      : AssetImage('assets/icons/user.png') as ImageProvider,
                ),
                SizedBox(width: 10),
                Text(
                  snapshot.data!,
                  style: TextStyle(color: Colors.black),
                ),
              ],
            );
          },
        ),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 70.0),
            child: StreamBuilder<List<DocumentSnapshot>>(
              stream: _combinedChatStream(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                }

                var messages = snapshot.data!;

                if (messages.isEmpty) {
                  return Center(child: Text("No messages yet"));
                }

                return ListView.builder(
                  reverse: true,
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    var messageData = messages[index];
                    var isMentor = messageData['senderId'] == mentorId;

                    return isMentor
                        ? _buildMentorMessage(
                            context,
                            messageData['text'],
                            (messageData['timestamp'] as Timestamp)
                                .toDate()
                                .toString(),
                            mentorImageUrl.isNotEmpty
                                ? mentorImageUrl
                                : 'assets/default_user.png',
                          )
                        : _buildUserMessage(
                            context,
                            messageData['text'],
                            (messageData['timestamp'] as Timestamp)
                                .toDate()
                                .toString(),
                            studentImageUrl.isNotEmpty
                                ? studentImageUrl
                                : 'assets/default_user.png',
                          );
                  },
                );
              },
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: _buildMessageInputBar(),
          ),
        ],
      ),
    );
  }

  Stream<List<DocumentSnapshot>> _combinedChatStream() {
    final query1 = FirebaseFirestore.instance
        .collection('chats')
        .where('senderId', isEqualTo: mentorId)
        .where('receiverId', isEqualTo: studentId);

    final query2 = FirebaseFirestore.instance
        .collection('chats')
        .where('senderId', isEqualTo: studentId)
        .where('receiverId', isEqualTo: mentorId);

    return Stream<List<DocumentSnapshot>>.multi((controller) {
      late final StreamSubscription query1Subscription;
      late final StreamSubscription query2Subscription;

      query1Subscription = query1.snapshots().listen((snapshot1) {
        query2Subscription = query2.snapshots().listen((snapshot2) {
          final allDocs = [...snapshot1.docs, ...snapshot2.docs];
          allDocs.sort((a, b) =>
              (b['timestamp'] as Timestamp).compareTo(a['timestamp'] as Timestamp));

          controller.add(allDocs);
        });

        controller.onCancel = () {
          query1Subscription.cancel();
          query2Subscription.cancel();
        };
      });
    });
  }

  Widget _buildMentorMessage(
      BuildContext context, String message, String time, String imageUrl) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundImage: imageUrl.isNotEmpty
                ? NetworkImage(imageUrl)
                : AssetImage('assets/default_user.png') as ImageProvider,
          ),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.blue[100],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(message, style: TextStyle(color: Colors.black)),
                ),
                SizedBox(height: 5),
                Text(
                  time,
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUserMessage(
      BuildContext context, String message, String time, String imageUrl) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.red[100],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(message, style: TextStyle(color: Colors.black)),
                ),
                SizedBox(height: 5),
                Text(
                  time,
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ],
            ),
          ),
          SizedBox(width: 10),
          CircleAvatar(
            backgroundImage: imageUrl.isNotEmpty
                ? NetworkImage(imageUrl)
                : AssetImage('assets/default_user.png') as ImageProvider,
          ),
        ],
      ),
    );
  }

  Widget _buildMessageInputBar() {
    final TextEditingController _controller = TextEditingController();

    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
      child: Row(
        children: [
          Icon(Icons.emoji_emotions, color: Colors.grey),
          SizedBox(width: 8),
          Icon(Icons.image, color: Colors.grey),
          SizedBox(width: 8),
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: 'Type a message',
                border: InputBorder.none,
              ),
            ),
          ),
          SizedBox(width: 8),
          IconButton(
            icon: Icon(Icons.send, color: Colors.blue),
            onPressed: () async {
              if (_controller.text.isNotEmpty) {
                await FirebaseFirestore.instance.collection('chats').add({
                  'senderId': studentId,
                  'receiverId': mentorId,
                  'text': _controller.text,
                  'timestamp': FieldValue.serverTimestamp(),
                });
                _controller.clear();
              }
            },
          ),
        ],
      ),
    );
  }
}
