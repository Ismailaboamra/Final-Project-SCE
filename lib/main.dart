// ignore_for_file: unused_import, prefer_const_constructors, sort_child_properties_last

import 'package:flutter/material.dart';

import 'pages/HomePage.dart';
import 'pages/LoginPage.dart';
import 'pages/SignUpPage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(useMaterial3: true),
      initialRoute: '/LoginForm',
      routes: {
         '/':(context) => const HomePage(),
        '/LoginForm':(context) => const LoginForm(),
        '/SignUp':(context) => const SignUp()


      },
    );
  }
}


