// ignore_for_file: prefer_const_constructors, unused_local_variable

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../shared/MyTextField.dart';

class SignUp extends StatefulWidget {
  SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final email_Controller = TextEditingController();

  final username_Controller = TextEditingController();

  final password1_Controller = TextEditingController();

  final password2_Controller = TextEditingController();
  bool isLoading = false;

  // void Print_values() {
  SignUP() async {
    setState(() {
      isLoading = true;
    });
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email_Controller.text,
        password: password1_Controller.text,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    email_Controller.dispose();
    password1_Controller.dispose();
    super.dispose();
  }

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
      body: SingleChildScrollView(
        child: SizedBox(
          // width: double.infinity,
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.center,
            // mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: 20,
              ),
              SvgPicture.asset(
                "assets/img/userlogo.svg",
                // alignment: Alignment.topCenter,
                height: 120,
                width: 150,
              ),
              Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      color: const Color.fromARGB(255, 255, 255, 255)),
                  width: 300,
                  child: MyTextField(
                      myController: username_Controller,
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
                      myController: email_Controller,
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
                      myController: password1_Controller,
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
                      myController: password2_Controller,
                      keyboardTypee: TextInputType.visiblePassword,
                      hintTextt: "PASSWORD 2",
                      obscureText: true,
                      prefixIcon: Icons.password)),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  SignUP();
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                      Color.fromARGB(255, 0, 232, 159)),
                ),
                child: isLoading? CircularProgressIndicator(color: Colors.black,):Text("SignUp",
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
                      "LogIn",
                      style: TextStyle(fontSize: 18, color: Colors.black),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
