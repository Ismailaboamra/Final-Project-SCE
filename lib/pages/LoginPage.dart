// ignore_for_file: prefer_const_constructors, file_names, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../shared/MyTextField.dart';

class LoginForm extends StatelessWidget {
  LoginForm({super.key});

  final username_Controller = TextEditingController();
  final Password_Credential = TextEditingController();

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
                        return null;
                      },
                      autovalidateMode: AutovalidateMode.disabled,
                      myController: username_Controller,
                      keyboardTypee: TextInputType.emailAddress,
                      hintTextt: "USERNAME",
                      obscureText: false,
                      prefixIcon: Icons.person)),
              SizedBox(
                height: 20,
              ),
              Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      color: Colors.white),
                  width: 300,
                  child: MyTextField(
                      validator: (p0) {
                        
                      },
                      autovalidateMode: AutovalidateMode.disabled,
                      myController: Password_Credential,
                      keyboardTypee: TextInputType.visiblePassword,
                      hintTextt: "Enter Your Password :",
                      obscureText: true,
                      prefixIcon: Icons.lock)),
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
    );
  }
}
