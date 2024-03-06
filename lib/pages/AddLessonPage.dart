// ignore_for_file: file_names, use_key_in_widget_constructors, library_private_types_in_public_api, prefer_const_constructors

import 'package:flutter/material.dart';

class AddLesson extends StatefulWidget {
  @override
  _AddLessonPageState createState() => _AddLessonPageState();
}

class _AddLessonPageState extends State<AddLesson> {
  String _selectedDay = 'Monday';
  TimeOfDay _startTime = TimeOfDay.now();
  TimeOfDay _endTime = TimeOfDay.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Lesson Time'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DropdownButtonFormField(
              value: _selectedDay,
              items: ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday']
                  .map((day) => DropdownMenuItem(value: day, child: Text(day)))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _selectedDay = value.toString();
                });
              },
            ),
            SizedBox(height: 16.0),
            Text('Start Time'),
            ElevatedButton(
              onPressed: () {
                _selectStartTime(context);
              },
              child: Text(_startTime.format(context)),
            ),
            SizedBox(height: 16.0),
            Text('End Time'),
            ElevatedButton(
              onPressed: () {
                _selectEndTime(context);
              },
              child: Text(_endTime.format(context)),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                // Save lesson time to Firebase
                // Implement Firebase logic here
              },
              child: Text('Save Lesson Time'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _selectStartTime(BuildContext context) async {
    final TimeOfDay? startTime =
        await showTimePicker(context: context, initialTime: _startTime);
    if (startTime != null && startTime != _startTime) {
      setState(() {
        _startTime = startTime;
      });
    }
  }

  Future<void> _selectEndTime(BuildContext context) async {
    final TimeOfDay? endTime =
        await showTimePicker(context: context, initialTime: _endTime);
    if (endTime != null && endTime != _endTime) {
      setState(() {
        _endTime = endTime;
      });
    }
  }
}
