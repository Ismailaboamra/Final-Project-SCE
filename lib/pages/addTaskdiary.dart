// ignore_for_file: file_names, camel_case_types, prefer_const_constructors, non_constant_identifier_names, avoid_unnecessary_containers, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class addTask extends StatefulWidget {
  final DateTime selectedDate;
  const addTask({super.key, required this.selectedDate});

  @override
  State<addTask> createState() => _addTaskState();
}

class _addTaskState extends State<addTask> {
  // final DateTime selectedDate;
  TimeOfDay startTime = TimeOfDay(hour: 9, minute: 00);
  TimeOfDay EndTime = TimeOfDay(hour: 13, minute: 00); //
  void _showTimePicker1() {
    showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    ).then((value) {
      setState(() {
        startTime = value!;
      });
    });
  }

  void _showTimePicker2() {
    showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    ).then((value) {
      setState(() {
        EndTime = value!;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add task"),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(10, 20, 10, 0),
                child: TextFormField(
                  readOnly: true,
                  decoration: InputDecoration(
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    labelText: "Date",
                    labelStyle: TextStyle(fontSize: 23),
                    hintText:
                        DateFormat('dd/MM/yyyy').format(widget.selectedDate),
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 15),
                    floatingLabelStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 23,
                        fontWeight: FontWeight.bold),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.greenAccent),
                    ),
                    border: OutlineInputBorder(borderSide: BorderSide()),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(10, 20, 10, 0),
                child: TextField(
                  readOnly: true,
                  decoration: InputDecoration(
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    labelText: "Start Time",
                    labelStyle: TextStyle(fontSize: 23),
                    hintText: startTime.format(context).toString(),
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 15),
                    floatingLabelStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 23,
                        fontWeight: FontWeight.bold),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.greenAccent),
                    ),
                    border: OutlineInputBorder(borderSide: BorderSide()),
                    suffixIcon: IconButton(
                      icon:
                          Icon(Icons.access_time), // Adjust the icon as needed
                      onPressed: () {
                        _showTimePicker1();
                      }, // Handle icon click
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(10, 20, 10, 40),
                child: TextFormField(
                  readOnly: true,
                  decoration: InputDecoration(
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    labelText: "End Time",
                    labelStyle: TextStyle(fontSize: 23),
                    hintText: EndTime.format(context).toString(),
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 15),
                    floatingLabelStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 23,
                        fontWeight: FontWeight.bold),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.greenAccent),
                    ),
                    border: OutlineInputBorder(borderSide: BorderSide()),
                    suffixIcon: IconButton(
                      icon:
                          Icon(Icons.access_time), // Adjust the icon as needed
                      onPressed: () {
                        _showTimePicker2();
                      }, // Handle icon click
                    ),
                  ),
                ),
              ),
              Container(
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text(
                    'Create Task',
                    style: TextStyle(fontSize: 15),
                  ),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.black,
                    backgroundColor: Color(0xff4ac08a),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
