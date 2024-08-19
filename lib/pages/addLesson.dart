// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, implementation_imports, unused_import, prefer_const_literals_to_create_immutables, avoid_print, avoid_unnecessary_containers, file_names, camel_case_types, sort_child_properties_last, use_super_parameters, no_logic_in_create_state

import 'package:final_project_sce/pages/MentorsNofifactionsPage.dart';
import 'package:final_project_sce/pages/home.dart';
import 'package:final_project_sce/pages/lessons.dart';
import 'package:final_project_sce/pages/myProfile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:final_project_sce/shared/colors.dart';

class AddLessons extends StatefulWidget {
  final int lastPage;
  // final String? email = FirebaseAuth.instance.currentUser?.email.toString();

  const AddLessons({Key? key, required this.lastPage}) : super(key: key);

  @override
  State<AddLessons> createState() => _AddLessonsState(lastPage);
}

class _AddLessonsState extends State<AddLessons> {
  final int lastPage;
  final String? email = FirebaseAuth.instance.currentUser?.email.toString();
  final User? userID = FirebaseAuth.instance.currentUser;

  _AddLessonsState(this.lastPage);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        children: [
          Home(),
          Lessons(),
          MentorNotificationsPage(
            mentorEmail: '$email',
            mentorId: userID!.uid,
          ),
          myProfile(),
        ],
        controller: PageController(
          initialPage: lastPage,
        ),
      ),
    );
  }
}
