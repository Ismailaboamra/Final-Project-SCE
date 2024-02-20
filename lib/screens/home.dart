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
    ));
  }
}
