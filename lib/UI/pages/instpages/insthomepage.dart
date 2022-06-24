// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:learnable/UI/Uploadcoursescreen.dart';

class Instructorhomepage extends StatefulWidget {
  const Instructorhomepage({Key? key}) : super(key: key);

  @override
  State<Instructorhomepage> createState() => _InstructorhomepageState();
}

class _InstructorhomepageState extends State<Instructorhomepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10, left: 25, right: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Learnable",
                      style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.lightBlue)),
                  IconButton(
                      onPressed: () {},
                      icon: Icon(
                        FontAwesomeIcons.solidBell,
                        color: Colors.lightBlue,
                      ))
                ],
              ),
            ),
            SizedBox(
              height: 15.0,
            ),
            Container(
              width: 350,
              height: 200,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: Colors.lightBlue,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey,
                        offset: Offset(3, 4),
                        blurRadius: 7.0),
                  ]),
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '''Upload your first
lessons''',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          fontSize: 25.0,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    MaterialButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (contex) => UploadCourse()));
                        },
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        minWidth: 150,
                        color: Colors.white,
                        child: Text(
                          "Upload course",
                          style: TextStyle(color: Colors.lightBlue),
                        ))
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 35.0,
            ),
            Container(
                width: 355,
                height: 288,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey,
                          // ignore: prefer_const_constructors
                          offset: Offset(3, 4),
                          blurRadius: 7.0),
                    ]),
                child: Center(
                    child: Text(
                  "N/A",
                  style: TextStyle(
                      fontSize: 18.0, color: Colors.lightBlue.shade400),
                ))),
          ],
        ),
      )),
    );
  }
}
