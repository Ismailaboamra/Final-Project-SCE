// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, file_names, avoid_unnecessary_containers, avoid_print

import 'package:final_project_sce/pages/addLesson.dart';
import 'package:final_project_sce/pages/alerts.dart';
import 'package:final_project_sce/pages/home.dart';
import 'package:final_project_sce/pages/lessons.dart';
import 'package:final_project_sce/pages/myProfile.dart';
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
  int currentPage = 0;
  int lastPage = 0;
  TextEditingController nameStudent = TextEditingController();
  TextEditingController nameSubject = TextEditingController();
  TextEditingController date = TextEditingController();

  void _showModalBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 900,
          width: 800,
          child: Column(
            // child: Column(
            children: [
              Container(
                // margin: EdgeInsets.only(left: 90, right: 100),
                margin: EdgeInsets.fromLTRB(90, 20, 90, 20),
                child:
                    SvgPicture.asset('assets/icons/addAlesson.svg', height: 24),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: TextField(
                  controller: nameStudent,
                  decoration: InputDecoration(
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    labelText: "Name for the student:",
                    labelStyle: TextStyle(fontSize: 23),
                    hintText: "Enter the name",
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 15),
                    floatingLabelStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 23,
                        fontWeight: FontWeight.bold),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.greenAccent),
                    ),
                    border: OutlineInputBorder(borderSide: BorderSide()),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(10, 20, 10, 0),
                child: TextField(
                  controller: nameSubject,
                  decoration: InputDecoration(
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    labelText: "Name for the subject:",
                    labelStyle: TextStyle(fontSize: 23),
                    hintText: "Enter the subject",
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 15),
                    floatingLabelStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 23,
                        fontWeight: FontWeight.bold),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.greenAccent),
                    ),
                    border: OutlineInputBorder(borderSide: BorderSide()),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(10, 20, 10, 0),
                child: TextField(
                    controller: date,
                    decoration: InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      labelText: "Data of the lesson",
                      labelStyle: TextStyle(fontSize: 23),
                      hintText: "Date",
                      hintStyle: TextStyle(color: Colors.grey, fontSize: 15),
                      floatingLabelStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 23,
                          fontWeight: FontWeight.bold),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.greenAccent),
                      ),
                      prefixIcon: Icon(Icons.calendar_today),
                      border: OutlineInputBorder(borderSide: BorderSide()),
                      // filled: true,
                    ),
                    readOnly: true,
                    onTap: () {
                      _selectData();
                      // print(_selectData());
                    }),
              ),
            ],
          ),
        );
      },
    );
  }

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
                _showModalBottomSheet();
              }
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
              icon: Image.asset('assets/icons/add.png',
                  // color: currentPage == 2 ? primaryColor : secondaryColor,
                  width: 200.0,
                  height: 200.0),
            ),
            BottomNavigationBarItem(
                icon: Icon(
              Icons.notifications_none,
              color: currentPage == 3 ? primaryColor : secondaryColor,
            )),
            BottomNavigationBarItem(
                icon: Image.asset('assets/icons/user.png',
                    color: currentPage == 4 ? primaryColor : secondaryColor,
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
            AddLessons(
              lastPage: lastPage,
            ),
            Alerts(),
            myProfile(),
          ],
        ));
  }

  Future<void> _selectData() async {
    DateTime? _picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2024),
        lastDate: DateTime(2025));
    if (_picked != null) {
      setState(() {
        date.text = _picked.toString().split(" ")[0];
      });
    }
  }
}
