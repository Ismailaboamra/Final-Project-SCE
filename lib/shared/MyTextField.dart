// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, unused_field, file_names

import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final TextInputType keyboardTypee;
  final String hintTextt;
  final bool obscureText;
  final IconButton suffixIcon;
  final TextEditingController myController;
  final String? Function(String?)? validator;
  final AutovalidateMode autovalidateMode;

  const MyTextField({
    super.key,
    required this.keyboardTypee,
    required this.hintTextt,
    required this.obscureText,
    required this.suffixIcon,
    required this.myController,
    required this.validator,
    required this.autovalidateMode,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode: autovalidateMode,
      validator: validator,
      controller: myController,
      keyboardType: keyboardTypee,
      obscureText: obscureText,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color.fromARGB(255, 0, 232, 159))),
          suffixIcon: suffixIcon,
          hintText: hintTextt,
          hintStyle: TextStyle(fontSize: 19),
          border: InputBorder.none),
    );
  }
}
