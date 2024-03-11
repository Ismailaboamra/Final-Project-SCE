// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:final_project_sce/shared/colors.dart';

class diary extends StatefulWidget {
  const diary({super.key});

  @override
  State<diary> createState() => _diaryState();
}

class _diaryState extends State<diary> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('schedule management',
            style: TextStyle(
                fontSize: 20,
                // fontWeight: FontWeight.bold,
                color: primaryColor)),
      ),
      body: Column(
        children: [
          Row(
            children: [
              Column(
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(20, 0, 0, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          DateFormat.yMMMMd().format(DateTime.now()),
                          style: TextStyle(
                            fontSize: 20,
                            color: secondaryColor,
                          ),
                        ),
                        Text(
                          "Today",
                          style: TextStyle(
                              fontSize: 20,
                              color: primaryColor,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
