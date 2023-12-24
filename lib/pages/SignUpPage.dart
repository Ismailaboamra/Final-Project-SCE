// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../shared/MyTextField.dart';

class SignUp extends StatelessWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromARGB(255, 0, 232, 159),
        onPressed: () {
          Navigator.pushNamed(context, '/');
        },
        
      ),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 0, 232, 159),
        elevation: 10,
        title: Text("SignUp Page"),
        centerTitle: true,
      ),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 50,
            ),
            SvgPicture.asset(
              "assets/img/userlogo.svg",
              alignment: Alignment.topCenter,
              height: 120,
              width: 150,
            ),
            Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    color: const Color.fromARGB(255, 255, 255, 255)),
                width: 300,
                child: MyTextField(
                    keyboardTypee: TextInputType.name,
                    hintTextt: "USERNAME",
                    obscureText: false,
                    prefixIcon: Icons.person)),
            Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    color: const Color.fromARGB(255, 255, 255, 255)),
                width: 300,
                child: MyTextField(
                    keyboardTypee: TextInputType.emailAddress,
                    hintTextt: "Email",
                    obscureText: false,
                    prefixIcon: Icons.email)),
            Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    color: const Color.fromARGB(255, 255, 255, 255)),
                width: 300,
                child: MyTextField(
                    keyboardTypee: TextInputType.visiblePassword,
                    hintTextt: "PASSWORD 1",
                    obscureText: true,
                    prefixIcon: Icons.password)),
            Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    color: const Color.fromARGB(255, 255, 255, 255)),
                width: 300,
                child: MyTextField(
                    keyboardTypee: TextInputType.visiblePassword,
                    hintTextt: "PASSWORD 2",
                    obscureText: true,
                    prefixIcon: Icons.password)),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {},
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all(Color.fromARGB(255, 0, 232, 159)),
              ),
              child: Text("LogIn",
                  style: TextStyle(fontSize: 25, color: Colors.black)),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "I alredy have account,",
                  style: TextStyle(fontSize: 16),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/LoginForm');
                  },
                  child: Text(
                    "SIGNUP",
                    style: TextStyle(fontSize: 18, color: Colors.black),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
