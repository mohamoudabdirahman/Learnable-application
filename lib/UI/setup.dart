// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:learnable/UI/Instructordashboard.dart';
import 'package:learnable/UI/details.dart';
import 'package:learnable/UI/instructordetails.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SetupOne extends StatefulWidget {
  const SetupOne({Key? key}) : super(key: key);

  @override
  _SetupOneState createState() => _SetupOneState();
}

class _SetupOneState extends State<SetupOne> {
  bool? boolvalue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Colors.lightBlue,
        ),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Padding(
          padding: const EdgeInsets.only(top: 40.0, left: 10.0, right: 10.0),
          child: Column(
            children: [
              Lottie.network(
                  "https://assets5.lottiefiles.com/packages/lf20_AXoQyR.json",
                  width: 300,
                  height: 400),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Learn and teach anytime ",
                    textAlign: TextAlign.start,
                    style: GoogleFonts.poppins(
                        fontSize: 25.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "and at anywhere",
                    textAlign: TextAlign.start,
                    style: GoogleFonts.poppins(
                        fontSize: 25.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Text(
                    '''learn any course at your home, work
any time your wish with Learnable''',
                    style: TextStyle(fontSize: 18.0, color: Colors.white54),
                  )
                ],
              ),
              SizedBox(
                height: 90.0,
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    MaterialButton(
                      onPressed: () async {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Profilepic()));
                      },
                      color: Colors.white,
                      child: Text(
                        "Get Started",
                        style: TextStyle(color: Colors.lightBlue),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
