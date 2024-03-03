// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Alerts extends StatefulWidget {
  const Alerts({super.key});

  @override
  State<Alerts> createState() => _AlertsState();
}

class _AlertsState extends State<Alerts> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: SvgPicture.asset('assets/icons/sceMentor.svg', height: 24),
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.error_outline,
              )),
        ],
      ),

      body: AppBar(
        automaticallyImplyLeading: false,
        title: SvgPicture.asset('assets/icons/alerts.svg', height: 18),
      ),
    );
  }
}
