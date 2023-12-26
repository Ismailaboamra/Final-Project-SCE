// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors

import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final TextInputType keyboardTypee;
  final String hintTextt;
  final bool obscureText;
  final IconData prefixIcon;
  final TextEditingController myController;

  const MyTextField({
    super.key,
    required this.keyboardTypee,
    required this.hintTextt,
    required this.obscureText,
    required this.prefixIcon,
    required this.myController,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: myController,
      keyboardType: keyboardTypee,
      obscureText: obscureText,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color.fromARGB(255, 0, 232, 159))),
          prefixIcon: Icon(
            prefixIcon,
            size: 30,
            color: Colors.black,
          ),
          hintText: hintTextt,
          hintStyle: TextStyle(fontSize: 19),
          border: InputBorder.none),
    );
  }
}
