// ignore_for_file: prefer_const_constructors, unused_local_variable, non_constant_identifier_names, use_build_context_synchronously, unused_import, unused_field, file_names, prefer_const_constructors_in_immutables

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
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 0, 232, 159),
        elevation: 10,
        title: Text("SignUp Page"),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
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
                SizedBox(height: 20),
                Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(0),
                        color: Color.fromARGB(179, 213, 213, 213)),
                    width: 350,
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
                        color: Color.fromARGB(179, 213, 213, 213)),
                    width: 350,
                    child: MyTextField(
                        validator: (email) {
                          return email!.contains(RegExp(
                                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+"))
                              ? null
                              : "Enter a valid email";
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
                        color: Color.fromARGB(179, 213, 213, 213)),
                    width: 350,
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
                        color: Color.fromARGB(179, 213, 213, 213)),
                    width: 350,
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
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      SignUP();
                    } else {
                      showSnackBar(context, 'ERROR', Colors.red);
                    }
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        Color.fromARGB(255, 0, 232, 159)),
                  ),
                  child: isLoading
                      ? CircularProgressIndicator(
                          color: Colors.black,
                        )
                      : Text("SignUp",
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
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
