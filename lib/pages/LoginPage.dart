// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project_sce/getUsersFromFiresore.dart';
import 'package:final_project_sce/pages/HomePage.dart';
import 'package:final_project_sce/pages/SignUpPage.dart';
import 'package:final_project_sce/pages/home.dart';
import 'package:final_project_sce/pages/myProfile.dart';
import 'package:final_project_sce/responsive/mobile.dart';
import 'package:final_project_sce/responsive/mobileOfmentor.dart';
import 'package:final_project_sce/shared/SnackBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:email_validator/email_validator.dart';
import '../shared/MyTextField.dart';

class LoginForm extends StatefulWidget {
  LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginForm();
}

class _LoginForm extends State<LoginForm> {
  final email_Controller = TextEditingController();
  final password_Controller = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isVisable = true;
  String? _selecteduserType;
  bool isMentor = false;

  @override
  void dispose() {
    email_Controller.dispose();
    password_Controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.fromLTRB(21, 18, 20, 18),
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xeaffffff),
                Color.fromARGB(206, 207, 231, 241),
                Color(0xaf68cbf2),
                Color(0xaa68cbf2),
              ],
              stops: [0, 0.48, 0.79, 0],
            ),
            borderRadius: BorderRadius.circular(0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 100,
              ),
              SvgPicture.asset(
                "assets/img/userlogo.svg",
                alignment: Alignment.topCenter,
                height: 120,
                width: 150,
              ),
              SizedBox(height: 10),
              SvgPicture.asset('assets/icons/sceMentor.svg', height: 24),
              SizedBox(height: 20),
              Text(
                'Sign In',
                style: TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.black
                    // fontStyle: FontStyle.
                    ),
              ),
              SizedBox(height: 20),
              Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(0),
                      color: const Color.fromARGB(255, 255, 255, 255)),
                  width: 300,
                  height: 55,
                  child: MyTextField(
                      validator: (value) {
                        return value!.contains(RegExp(
                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+"))
                            ? null
                            : "Enter a valid email";
                      },
                      autovalidateMode: AutovalidateMode.disabled,
                      myController: email_Controller,
                      keyboardTypee: TextInputType.emailAddress,
                      hintTextt: "  Email",
                      obscureText: false,
                      suffixIcon: IconButton(
                          onPressed: () {}, icon: Icon(Icons.email)))),
              SizedBox(height: 10),
              Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(0),
                      color: Colors.white),
                  width: 300,
                  height: 55,
                  child: MyTextField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a password';
                        }
                        return null;
                      },
                      autovalidateMode: AutovalidateMode.disabled,
                      myController: password_Controller,
                      keyboardTypee: TextInputType.visiblePassword,
                      hintTextt: "  Password :",
                      obscureText: isVisable ? true : false,
                      suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              isVisable = !isVisable;
                            });
                          },
                          icon: Icon(Icons.visibility)))),
              SizedBox(height: 10),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('LogIn as :', style: TextStyle(fontSize: 20)),
                  Radio<String>(
                    value: 'Student',
                    groupValue: _selecteduserType,
                    onChanged: (value) {
                      setState(() {
                        _selecteduserType = value;
                      });
                    },
                  ),
                  Text(
                    'Student',
                    style: TextStyle(fontSize: 17),
                  ),
                  Radio<String>(
                    value: 'Mentor',
                    groupValue: _selecteduserType,
                    onChanged: (value) {
                      setState(() {
                        _selecteduserType = value;
                      });
                    },
                  ),
                  Text('Mentor', style: TextStyle(fontSize: 17)),
                ],
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  SignIn();
                  if (!mounted) {
                    return;
                  }
                },
                child: Text(
                  'Sign in',
                  style: TextStyle(fontSize: 25),
                ),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.black,
                  backgroundColor: Color(0xff4ac08a),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(90),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account?",
                    style: TextStyle(fontSize: 16),
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) => SignUp()));
                      },
                      child: Text(
                        "SignUp",
                        style: TextStyle(color: Colors.black, fontSize: 18),
                      )),
                  SizedBox(
                    height: 400,
                  )
                ],
              ),
              SizedBox(height: 140)
            ],
          ),
        ),
      ],
    )));
  }

  void SignIn() async {
    try {
      if (email_Controller.text.isEmpty || password_Controller.text.isEmpty) {
        // Display error if email or password is empty
        showSnackBar(context, 'Email OR password are required.', Colors.red);
        return;
      }
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email_Controller.text, password: password_Controller.text);
      email_Controller.clear();
      password_Controller.clear();

      if (FirebaseAuth.instance.currentUser == null) {
        showSnackBar(context, 'User not signed In.', Colors.red);
      } else {
        if (_selecteduserType == 'Student') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MobileScreen()),
          );
          print('Document does not exist on the database');
        } else {
          User? user = FirebaseAuth.instance.currentUser;
          var kk = FirebaseFirestore.instance
              .collection('userss')
              .doc('User : ' + user!.uid)
              .get()
              .then((DocumentSnapshot documentSnapshot) {
            if (documentSnapshot.exists) {
              print(documentSnapshot.get('Mentor').runtimeType.toString());
              // isMentor = isMentor && documentSnapshot.get('Mentor');
              print('is mentor : ' + isMentor.toString());

              if (documentSnapshot.get('Mentor') as bool == true) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MobileScreenMentor(),
                  ),
                );
                print('Document does not exist on the database');
              } else {
                showSnackBar(context, 'THis user not mentor', Colors.red);
                // Navigator.pop(context);
              }
            } else {}
          });
        }
      }

      showSnackBar(context, '   Done ...)}', Colors.green);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        showSnackBar(context, 'No user found for that email.', Colors.red);
      } else if (e.code == 'wrong-password') {
        showSnackBar(
            context, 'Incorrect password. Please try again.', Colors.red);
      } else {
        // Handle other Firebase Authentication exceptions
        showSnackBar(context, 'An error occurred: ${e.message}', Colors.red);
      }
    } catch (e) {
      // Handle other exceptions
      showSnackBar(context, 'An unexpected error occurred: $e', Colors.red);
    }
  }
}
