// ignore_for_file: prefer_const_constructors, sort_child_properties_last, non_constant_identifier_names, unnecessary_this, unused_import, file_names, avoid_print

import 'package:final_project_sce/Admin/AdminRequestPage.dart';
import 'package:final_project_sce/Admin/MentorsDeatiles.dart';
import 'package:final_project_sce/Admin/addCourse.dart';
import 'package:final_project_sce/pages/LoginPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final String? email = FirebaseAuth.instance.currentUser?.email.toString();
  SignOut() {
    FirebaseAuth.instance.signOut();
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        // User is signed out
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LoginForm()),
        );

        print('User is signed out');
      } else {
        // User is signed in
        print('User is signed in');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                UserAccountsDrawerHeader(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/img/SCE_img.jpg"),
                        fit: BoxFit.cover),
                  ),
                  accountName: Text(
                    "",
                  ),
                  accountEmail: Text(
                    email.toString(),
                    style: TextStyle(color: Colors.black, fontSize: 25),
                  ),
                  currentAccountPictureSize: Size.square(99),
                  currentAccountPicture: CircleAvatar(
                      radius: 55,
                      backgroundImage: AssetImage("assets/img/download.png")),
                ),
                ListTile(
                    title: Text("Home"),
                    leading: Icon(Icons.home),
                    onTap: () {}),
                ListTile(
                    title: Text("add courses"),
                    leading: Icon(Icons.circle_notifications),
                    onTap: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AddCoursePage()));
                    }),
                    ListTile(
                    title: Text("Students Requests"),
                    leading: Icon(Icons.circle_notifications),
                    onTap: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AdminRequestsPage()));
                    }),
                      ListTile(
                    title: Text("List of mentors"),
                    leading: Icon(Icons.circle_notifications),
                    onTap: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MentorManagementPage()));
                    }),
                ListTile(
                    title: Text("Logout"),
                    leading: Icon(Icons.exit_to_app),
                    onTap: () {
                      SignOut();
                    }),
              ],
            ),
            Container(
              margin: EdgeInsets.only(bottom: 12),
              child: Text("Developed by Ismael AboAmra © 2024",
                  style: TextStyle(fontSize: 16)),
            )
          ],
        ),
      ),
      appBar:    AppBar(
        centerTitle: true,
        title: SvgPicture.asset('assets/icons/sceMentor.svg', height: 24),
        actions: [
          
        ],
      ),
    );
  }
}
