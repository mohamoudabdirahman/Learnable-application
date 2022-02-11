// ignore_for_file: file_names, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class InstructorDash extends StatefulWidget {
  const InstructorDash({ Key? key }) : super(key: key);

  @override
  _InstructorDashState createState() => _InstructorDashState();
}

class _InstructorDashState extends State<InstructorDash> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Text("hello Instructor",
            style: TextStyle(
              color: Colors.lightBlue,
              fontSize: 30
            ),),
            MaterialButton(onPressed: (){},
            child: Text("upload a course"),)
          ],
        ),
      ),
    );
  }
}