// ignore_for_file: prefer_const_constructors, file_names, non_constant_identifier_names, no_logic_in_create_state, unused_local_variable, prefer_const_constructors_in_immutables, unused_import, use_build_context_synchronously

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
  SignIn() async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email_Controller.text, password: password_Controller.text);
      showSnackBar(context, '   Done ...', Colors.green);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        showSnackBar(context, 'No user found for that email.', Colors.red);
      } else if (e.code == 'wrong-password') {
        showSnackBar(
            context, 'Wrong password provided for that user.', Colors.red);
      } else {
        showSnackBar(context, "  Error - Try Again.", Colors.red);
      }
    
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    email_Controller.dispose();
    password_Controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 248, 248, 248),
        onPressed: () {
          Navigator.pushNamed(context, '/LoginForm');
        },
        child: IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/LoginForm');
            },
            icon: Icon(
              Icons.home,
              color: Colors.black,
            )),
      ),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 0, 232, 159),
        elevation: 15,
        title: Text("LogIn Page"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: SizedBox(
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
                SizedBox(
                  height: 20,
                ),
                Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        color: const Color.fromARGB(255, 255, 255, 255)),
                    width: 300,
                    child: MyTextField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a email';
                          }
                          return null;
                        },
                        autovalidateMode: AutovalidateMode.disabled,
                        myController: email_Controller,
                        keyboardTypee: TextInputType.emailAddress,
                        hintTextt: "Email",
                        obscureText: false,
                        suffixIcon: IconButton(
                            onPressed: () {}, icon: Icon(Icons.email)))),
                SizedBox(
                  height: 20,
                ),
                Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        color: Colors.white),
                    width: 300,
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
                        hintTextt: "Enter Your Password :",
                        obscureText: isVisable ? true : false,
                        suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                isVisable = !isVisable;
                              });
                            },
                            icon: Icon(Icons.visibility)))),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () async {
                    await SignIn();
                    if (!mounted) {
                      return;
                    }
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        Color.fromARGB(255, 0, 232, 159)),
                  ),
                  child: Text("LogIn",
                      style: TextStyle(fontSize: 25, color: Colors.black)),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account?",
                      style: TextStyle(fontSize: 16),
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/SignUp');
                        },
                        child: Text(
                          "SignUp",
                          style: TextStyle(color: Colors.black, fontSize: 18),
                        ))
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
