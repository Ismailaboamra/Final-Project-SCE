// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, implementation_imports, unused_import, prefer_const_literals_to_create_immutables, avoid_print, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:final_project_sce/shared/colors.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SvgPicture.asset('assets/icons/sceMentor.svg', height: 24),
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.messenger_outline,
              )),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Stack(children: [
              Container(
                height: 300,
                // width: 316,
                margin: EdgeInsets.only(left: 0, right: 0),
                decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.fill,
                        image: AssetImage('assets/img/background1.png'))),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  margin: EdgeInsets.only(left: 50, right: 50, top: 200),
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 255, 255, 255),
                      borderRadius: BorderRadius.circular(35)),
                  child: TextField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'What you want to learn?',
                      prefixIcon: Icon(Icons.search),
                    ),
                  ),
                ),
              ),
              // ),
            ]),
            SizedBox(
              height: 40,
            ),
            Container(
              margin: EdgeInsets.only(left: 20, right: 130),
              child:
                  SvgPicture.asset('assets/icons/recommended.svg', height: 24),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Column(
                  children: [
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
                      // color: Colors.amber,
                      margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                      child: Text(
                        "Bhaa Aldda",
                        style: TextStyle(
                          fontSize: 20,
                          color: primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        // color: Colors.amber,
                        margin: EdgeInsets.fromLTRB(10, 0, 0, 10),
                        child: Text(
                          "see all 10 courses he mentors",
                          // textAlign: TextAlign.end,
                          style: TextStyle(
                            fontSize: 13,
                            color: secondaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Stack(
                      children: [
                        Container(
                          height: 50,
                          width: 200,
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
                            margin: EdgeInsets.fromLTRB(25, 0, 0, 0),
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
                            margin: EdgeInsets.fromLTRB(60, 10, 0, 0),
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
                            margin: EdgeInsets.fromLTRB(170, 0, 0, 0),
                            child: IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.messenger_outline,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
