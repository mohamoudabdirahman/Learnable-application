// ignore_for_file: file_names, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:learnable/UI/Uploadcoursescreen.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:learnable/UI/details.dart';
import 'package:learnable/UI/pages/acountscreen.dart';
import 'package:learnable/UI/pages/instpages/insthomepage.dart';
import 'package:learnable/UI/pages/instpages/mycourses.dart';

class InstructorDash extends StatefulWidget {
  const InstructorDash({Key? key}) : super(key: key);

  @override
  _InstructorDashState createState() => _InstructorDashState();
}

class _InstructorDashState extends State<InstructorDash> {
  int currentindex = 0;

  final List <Widget> _instpages = [Instructorhomepage(),MyCourses(),UploadCourse(),Accountpage()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: _instpages[currentindex],
        bottomNavigationBar: CurvedNavigationBar(
            index: currentindex,
            onTap: (value) {
              setState(() {
                currentindex = value;
              });
            },
            backgroundColor: Colors.white,
            color: Colors.lightBlue,
            buttonBackgroundColor: Colors.lightBlue,
            items: [
              Icon(
                Icons.home,
                color: Colors.white,
              ),
              Icon(
                Icons.book,
                color: Colors.white,
              ),
              Icon(
                Icons.add,
                color: Colors.white,
              ),
              Icon(
                Icons.person,
                color: Colors.white,
              )
            ]));
  }
}
