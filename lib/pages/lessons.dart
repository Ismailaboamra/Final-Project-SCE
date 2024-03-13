// ignore_for_file: prefer_const_constructors, unused_import

import 'package:final_project_sce/pages/AddLessonPage.dart';
import 'package:final_project_sce/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Lessons extends StatefulWidget {
  const Lessons({super.key});

  @override
  State<Lessons> createState() => _LessonsState();
}

class _LessonsState extends State<Lessons> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   automaticallyImplyLeading: false,
      //   title: SvgPicture.asset('assets/icons/sceMentor.svg', height: 24),
      //   actions: [
      //     IconButton(
      //         onPressed: () {},
      //         icon: Icon(
      //           Icons.history,
      //         )),
      //   ],
      // ),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LessonRequestForm ()));
                Navigator.push(context, MaterialPageRoute(builder: (context) => LessonRequestForm()));
              },
              icon: Icon(Icons.add)),
        ],
        title: SvgPicture.asset('assets/icons/lessons.svg', height: 18),
      ),
    );
  }
}
