// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Page"),
        titleTextStyle: TextStyle(fontSize: 27, color: Colors.black),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 0, 232, 159),
      ),
  
    );
  }
}
