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
          ],
        ),
      ),
    );
  }
}
