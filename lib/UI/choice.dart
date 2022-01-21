// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/services.dart';
import 'package:learnable/UI/signinscreen.dart';
import 'package:learnable/UI/signupscreen.dart';

class Choicescreen extends StatefulWidget {
  const Choicescreen({Key? key}) : super(key: key);

  @override
  _ChoicescreenState createState() => _ChoicescreenState();
}

class _ChoicescreenState extends State<Choicescreen> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.lightBlue[600]));
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Colors.lightBlue,
        child: Column(
          children: [
            Container(
              width: 600.0,
              height: 550.0,
              decoration: BoxDecoration(
                  color: Colors.lightBlue[600],
                  //border: Border.all(color: Colors.white, width: 2.0),
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.elliptical(200, 200),
                      bottomRight: Radius.elliptical(200, 200)),
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(0, 2),
                      color: Colors.white24,
                      blurRadius: 10,
                      spreadRadius: 3,
                    )
                  ]),
            ),
            SizedBox(
              height: 20.0,
            ),
            MaterialButton(
              onPressed: () {},
              color: Colors.white,
              minWidth: 262.0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(50.0))),
              child: Text(
                "I am an Instructor",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.lightBlue,
                ),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            MaterialButton(
              onPressed: () {
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (context) => Signup()));
              },
              minWidth: 262.0,
              shape: RoundedRectangleBorder(
                  side: BorderSide(color: Colors.white, width: 1),
                  borderRadius: BorderRadius.circular(50)),
              child: Text(
                "I am Student",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(
              height: 15.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("You have an account?",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black54,
                      letterSpacing: 1,
                    )),
                SizedBox(
                  width: 10.0,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => SignIn()));
                  },
                  child: Text(
                    "Login",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                      letterSpacing: 1,
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
