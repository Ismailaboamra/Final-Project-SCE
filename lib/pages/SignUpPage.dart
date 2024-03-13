// ignore_for_file: prefer_const_constructors, unused_local_variable, non_constant_identifier_names, use_build_context_synchronously, unused_import, unused_field, file_names, prefer_const_constructors_in_immutables, prefer_interpolation_to_compose_strings, avoid_print, prefer_const_literals_to_create_immutables, sort_child_properties_last

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project_sce/pages/LoginPage.dart';
import 'package:final_project_sce/shared/SnackBar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:email_validator/email_validator.dart';
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
  final _formKey = GlobalKey<FormState>();

  bool isLoading = false;
  bool isVisable1 = true;
  bool isVisable2 = true;

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
      CollectionReference users =
          FirebaseFirestore.instance.collection("userss");
      users
          .doc('User : ' + FirebaseAuth.instance.currentUser!.uid.toString())
          .set({
            'Username': username_Controller.text,
            'email': email_Controller.text,
            'password': password1_Controller.text,
            'Mentor': false
          })
          .then((value) => print("User Added"))
          .catchError((error) => print("Failed to add user: $error"));
      showSnackBar(context, '   Done ...', Colors.green);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        // print('The password provided is too weak.');
        showSnackBar(context, 'The password provided is too weak.', Colors.red);
      } else if (e.code == 'email-already-in-use') {
        // print('The account already exists for that email.');
        showSnackBar(
            context, 'The account already exists for that email.', Colors.red);
      } else {
        showSnackBar(context, 'ERROR - Please try again late.', Colors.red);
      }
    } catch (e) {
      // print(e);
      showSnackBar(context, e.toString(), Colors.red);
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  void dispose() {
    email_Controller.dispose();
    password1_Controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Form(
      key: _formKey,
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
                  'Sign Up',
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
                        color: Color.fromARGB(255, 255, 255, 255)),
                    width: 300,
                    height: 55,
                    child: MyTextField(
                        validator: (value) {
                          return null;
                        },
                        autovalidateMode: AutovalidateMode.disabled,
                        myController: username_Controller,
                        keyboardTypee: TextInputType.name,
                        hintTextt: " USERNAME",
                        obscureText: false,
                        suffixIcon: IconButton(
                            onPressed: () {}, icon: Icon(Icons.person)))),
                SizedBox(height: 20),
                Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(0),
                        color: Color.fromARGB(255, 255, 255, 255)),
                    width: 300,
                    height: 55,
                    child: MyTextField(
                        validator: (email) {
                          return email!.contains(RegExp(
                                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+"))
                              ? null
                              : " Enter a valid email";
                        },
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        myController: email_Controller,
                        keyboardTypee: TextInputType.emailAddress,
                        hintTextt: " Email: eamil@exm.com",
                        obscureText: false,
                        suffixIcon: IconButton(
                            onPressed: () {}, icon: Icon(Icons.email)))),
                SizedBox(height: 20),
                Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(0),
                        color: Color.fromARGB(255, 255, 255, 255)),
                    width: 300,
                    height: 55,
                    child: MyTextField(
                        validator: (value) {
                          if (value!.length < 8) {
                            return "   Enter at least 8 characters";
                          } else {
                            return null;
                          }
                        },
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        myController: password1_Controller,
                        keyboardTypee: TextInputType.visiblePassword,
                        hintTextt: " PASSWORD 1",
                        obscureText: isVisable1 ? true : false,
                        suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                isVisable1 = !isVisable1;
                              });
                            },
                            icon: Icon(Icons.visibility)))),
                SizedBox(height: 20),
                Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(0),
                        color: Color.fromARGB(255, 255, 255, 255)),
                    width: 300,
                    height: 55,
                    child: MyTextField(
                        validator: (value) {
                          if (value!.length < 8) {
                            return "   Enter at least 8 characters";
                          } else {
                            return null;
                          }
                        },
                        autovalidateMode: AutovalidateMode.disabled,
                        myController: password2_Controller,
                        keyboardTypee: TextInputType.visiblePassword,
                        hintTextt: " PASSWORD 2",
                        obscureText: isVisable2 ? true : false,
                        suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                isVisable2 = !isVisable2;
                              });
                            },
                            icon: Icon(Icons.visibility)))),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      SignUP();
                    } else {
                      showSnackBar(context, 'ERROR', Colors.red);
                    }
                  },
                  child: Text(
                    'Sign Up',
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "I alredy have account,",
                      style: TextStyle(fontSize: 16),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginForm()));
                      },
                      child: Text(
                        "LogIn",
                        style: TextStyle(fontSize: 18, color: Colors.black),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 170,
                )
              ],
            ),
          ),
        ],
      ),
    )));
    
  }
}
