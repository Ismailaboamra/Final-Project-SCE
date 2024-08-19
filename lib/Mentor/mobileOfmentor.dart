// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, file_names, avoid_unnecessary_containers, avoid_print, unnecessary_import, sized_box_for_whitespace, no_leading_underscores_for_local_identifiers

import 'package:final_project_sce/pages/addLesson.dart';
import 'package:final_project_sce/pages/MentorsNofifactionsPage.dart';
import 'package:final_project_sce/pages/diary.dart';
import 'package:final_project_sce/pages/home.dart';
import 'package:final_project_sce/pages/lessons.dart';
import 'package:final_project_sce/pages/myProfile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/Cupertino.dart';
import 'package:final_project_sce/shared/colors.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';

class MobileScreenMentor extends StatefulWidget {
  const MobileScreenMentor({super.key});

  @override
  State<MobileScreenMentor> createState() => _MobileScreenMentorState();
}

class _MobileScreenMentorState extends State<MobileScreenMentor> {
  final PageController _pageController = PageController();
  final String? email = FirebaseAuth.instance.currentUser?.email.toString();
    final User? userID = FirebaseAuth.instance.currentUser;


  int currentPage = 0;
  int lastPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CupertinoTabBar(
        onTap: (index) {
          _pageController.jumpToPage(index);

          setState(() {
            lastPage = currentPage;
            currentPage = index;
            if (lastPage == 3 || lastPage == 4) {
              lastPage--;
            }
            if (currentPage == 2) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => diary()),
              );
            }
          });
        },
        backgroundColor: mobileBackgroundColor,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: currentPage == 0 ? primaryColor : secondaryColor,
            ),
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/icons/cap.png',
              color: currentPage == 1 ? primaryColor : secondaryColor,
              width: 32.0,
              height: 32.0,
            ),
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/icons/add.png',
              width: 200.0,
              height: 200.0,
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.notifications_none,
              color: currentPage == 3 ? primaryColor : secondaryColor,
            ),
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/icons/user.png',
              color: currentPage == 4 ? primaryColor : secondaryColor,
              width: 55.0,
              height: 55.0,
            ),
          ),
        ],
      ),
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        controller: _pageController,
        children: [
          Home(),
          Lessons(),
          AddLessons(lastPage: lastPage),
          MentorNotificationsPage(mentorEmail: email!,mentorId: userID!.uid,), // Here the notifications page
          myProfile(),
        ],
      ),
    );
  }
}