import 'package:final_project_sce/pages/MentorsNofifactionsPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_svg/flutter_svg.dart';
// import 'mentor_notifications_page.dart';

class MentorHomePage extends StatelessWidget {
  final String? mentorEmail = FirebaseAuth.instance.currentUser?.email.toString();
    final User? userID = FirebaseAuth.instance.currentUser;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome Mentor'),
        backgroundColor: Colors.blueAccent,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            // לוגו של המכללה SCE
            Container(
              height: 150,
              child: SvgPicture.asset('assets/sce_logo.svg'), // Ensure the logo file is added to assets
            ),
            SizedBox(height: 20),
            // שם המנטור
            Text(
              'Hello, ${mentorEmail ?? 'Mentor'}',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 40),
            // כפתור התראות
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MentorNotificationsPage(mentorEmail: mentorEmail!,
                  mentorId: userID!.uid,)),
                );
              },
              child: Text('Notifications'),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                textStyle: TextStyle(fontSize: 18),
              ),
            ),
            SizedBox(height: 20),
            // כפתור ניהול שיעורים
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ManageLessonsPage()),
                );
              },
              child: Text('Manage Lessons'),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                textStyle: TextStyle(fontSize: 18),
              ),
            ),
            SizedBox(height: 20),
            // כפתור פרופיל
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MentorProfilePage()),
                );
              },
              child: Text('Profile'),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                textStyle: TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ManageLessonsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Manage Lessons'),
      ),
      body: Center(
        child: Text('Manage Lessons Page'),
      ),
    );
  }
}

class MentorProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Center(
        child: Text('Mentor Profile Page'),
      ),
    );
  }
}
