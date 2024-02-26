// ignore_for_file: unused_import, prefer_const_constructors, sort_child_properties_last, use_super_parameters

import 'package:final_project_sce/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:final_project_sce/responsive/mobile.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'pages/HomePage.dart';
import 'pages/LoginPage.dart';
import 'pages/SignUpPage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) {
        return;
      },
      child: MaterialApp(
        title: "myApp",
        debugShowCheckedModeBanner: false,
        home: MobileScreen(),
        // home: StreamBuilder(
        //   stream: FirebaseAuth.instance.authStateChanges(),
        //   builder: (context, snapshot) {
        //     if (snapshot.hasData) {
        //       return MobileScreen();
        //     } else {
        //       return LoginForm();
        //     }
        //   },
        // ),
      ),
    );

    // return MaterialApp(
    //   debugShowCheckedModeBanner: false,
    //   theme: ThemeData.light(useMaterial3: true),
    //   initialRoute: '/LoginForm',

    //   routes: {
    //      '/':(context) => const HomePage(),
    //     '/LoginForm':(context) =>  LoginForm(),
    //     '/SignUp':(context) =>  SignUp()

    //   },
    // );
  }
}
