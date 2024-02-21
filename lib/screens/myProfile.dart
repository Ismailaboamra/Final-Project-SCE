// ignore_for_file: file_names, camel_case_types, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/Cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:final_project_sce/shared/colors.dart';

class myProfile extends StatefulWidget {
  const myProfile({super.key});

  @override
  State<myProfile> createState() => _myProfileState();
}

class _myProfileState extends State<myProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SvgPicture.asset('assets/icons/sceMentor.svg', height: 24),
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.settings,
              )),
        ],
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(20, 20, 0, 0),
            child: SvgPicture.asset('assets/icons/myProfile.svg', height: 18),
          ),
          Container(
            height: 120,
            width: 120,
            margin: EdgeInsets.fromLTRB(23, 23, 23, 5),
            child: CircleAvatar(
              radius: 24,
              backgroundImage: NetworkImage(
                  "https://images.pexels.com/photos/2820884/pexels-photo-2820884.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500"),
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(30, 20, 0, 0),
            child: Row(children: [
              Stack(
                children: [
                  Container(
                    height: 50,
                    width: 300,
                    margin: EdgeInsets.fromLTRB(20, 0, 0, 0),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.fill,
                        image: AssetImage('assets/img/background3.png'),
                      ),
                    ),
                  ),
                  Align(
                    child: Container(
                      height: 40,
                      margin: EdgeInsets.fromLTRB(210, 0, 0, 0),
                      child: Row(
                        children: [
                          IconButton(
                              onPressed: () {},
                              icon: Image.asset('assets/icons/like.png')),
                        ],
                      ),
                    ),
                  ),
                  Align(
                    child: Container(
                      // color: Colors.amber,
                      margin: EdgeInsets.fromLTRB(250, 10, 0, 0),
                      child: Row(
                        children: [
                          Text(
                            "1251",
                            style: TextStyle(fontSize: 18),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Align(
                    child: Container(
                      margin: EdgeInsets.fromLTRB(40, 8, 0, 0),
                      child: Text(
                        "Bhaa Alden Aldda",
                        style: TextStyle(
                          fontSize: 18,
                          color: primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ]),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
            child: Text(
              "There is nothing that stands in the way of desire - a software engineering student, with experience in giving private lessons, giving lessons in physics and Hadva1.",
              style: TextStyle(color: secondaryColor),
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(30, 20, 20, 0),
            child: Row(
              children: [
                IconButton(
                    onPressed: () {},
                    icon: Image.asset(
                      'assets/icons/request.png',
                      height: 40,
                    )),
                IconButton(
                    onPressed: () {},
                    icon: Image.asset(
                      'assets/icons/edit.png',
                      height: 40,
                    )),
              ],
            ),
          )
        ],
      ),
    );
  }
}
