

import 'package:flutter/material.dart';

showSnackBar(BuildContext context, String text,Color color) {
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: Colors.white,
      duration: Duration(days: 1),
      content: Text(text,style: TextStyle(color:color,fontSize: 20),),
      action: SnackBarAction(label: "close",textColor: Colors.black,disabledTextColor: Colors.teal, onPressed: () {}),
    ));
 }