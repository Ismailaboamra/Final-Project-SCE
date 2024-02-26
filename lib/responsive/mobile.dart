// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations

import 'package:flutter/material.dart';
import 'package:flutter/Cupertino.dart';
import 'package:final_project_sce/shared/colors.dart';
import 'package:final_project_sce/screens/home.dart';
import 'package:final_project_sce/screens/alerts.dart';
import 'package:final_project_sce/screens/lessons.dart';
import 'package:final_project_sce/screens/myProfile.dart';

class MobileScreen extends StatefulWidget {
  const MobileScreen({super.key});

  @override
  State<MobileScreen> createState() => _MobileScreenState();
}

class _MobileScreenState extends State<MobileScreen> {
  final PageController _pageController = PageController();
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: CupertinoTabBar(
          onTap: (index) {
            _pageController.jumpToPage(index);
            setState(() {
              currentPage = index;
            });
          },
          backgroundColor: mobileBackgroundColor,
          items: [
            BottomNavigationBarItem(
                icon: Icon(
              Icons.home,
              color: currentPage == 0 ? primaryColor : secondaryColor,
            )),
            BottomNavigationBarItem(
                icon: Image.asset('assets/icons/cap.png',
                    color: currentPage == 1 ? primaryColor : secondaryColor,
                    width: 32.0,
                    height: 32.0)),
            BottomNavigationBarItem(
                icon: Icon(
              Icons.notifications_none,
              color: currentPage == 2 ? primaryColor : secondaryColor,
            )),
            BottomNavigationBarItem(
                icon: Image.asset('assets/icons/user.png',
                    color: currentPage == 3 ? primaryColor : secondaryColor,
                    width: 55.0,
                    height: 55.0)),
          ],
        ),
        body: PageView(
          // onPageChanged: (index) {},
          physics: NeverScrollableScrollPhysics(),
          controller: _pageController,
          children: [
            Home(),
            Lessons(),
            Alerts(),
            myProfile(),
          ],
        ));
  }
}
