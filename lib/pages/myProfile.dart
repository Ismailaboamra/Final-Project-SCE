// ignore_for_file: file_names, camel_case_types, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:final_project_sce/pages/LoginPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  final String? email = FirebaseAuth.instance.currentUser?.email.toString();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: SvgPicture.asset('assets/icons/sceMentor.svg', height: 24),
        actions: [
          IconButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
                FirebaseAuth.instance.authStateChanges().listen((User? user) {
                  if (user == null) {
                    // User is signed out
                    // Navigator.push(context,MaterialPageRoute(builder: (context) => LoginForm()),);
                    Navigator.pop(context);
                    print('User is signed out');
                  } else {
                    // User is signed in
                    print('User is signed in');
                  }
                });
              },
              icon: Icon(
                Icons.exit_to_app,
                size: 35,
              )),
        ],
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(20, 20, 0, 0),
            child: SvgPicture.asset('assets/icons/myProfile.svg', height: 20),
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
                        email.toString(),
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
          ),
          Container(
              margin: EdgeInsets.fromLTRB(20, 50, 20, 0),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal, // تحديد الاتجاه الأفقي

                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        onPressed: () {},
                        icon: Image.asset(
                          'assets/icons/diary.png',
                          height: 100,
                        )),
                    IconButton(
                        onPressed: () {},
                        icon: Image.asset(
                          'assets/icons/comments.png',
                          height: 100,
                        )),
                    IconButton(
                        onPressed: () {},
                        icon: Image.asset(
                          'assets/icons/rating.png',
                          height: 100,
                        )),
                    IconButton(
                        onPressed: () {},
                        icon: Image.asset(
                          'assets/icons/rating.png',
                          height: 100,
                        )),
                    IconButton(
                        onPressed: () {},
                        icon: Image.asset(
                          'assets/icons/rating.png',
                          height: 100,
                        )),
                  ],
                ),
              )),

          SizedBox(height: 30,),
          Container(
      
            alignment: Alignment.centerLeft,
            child: Row(
            
              children: [
                Text("Email : ",style: TextStyle(fontSize: 25),),
                Text(email.toString(),style: TextStyle(fontSize: 20),)

              ],
            ),

          )
        ],
      ),
    );
  }
}
