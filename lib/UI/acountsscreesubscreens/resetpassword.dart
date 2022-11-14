// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loading_indicator/loading_indicator.dart';

class Resetpass extends StatefulWidget {
  const Resetpass({Key? key}) : super(key: key);

  @override
  State<Resetpass> createState() => _ResetpassState();
}

class _ResetpassState extends State<Resetpass> {
  TextEditingController _resetemaicontroller = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  User? user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formkey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Personal Information',
              style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Recieve an Email to reset your password',
              style: TextStyle(fontSize: 18, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                          color: (Color.fromRGBO(117, 117, 117, 0.527)),
                          offset: Offset(1.0, 1.0),
                          blurRadius: 8.0,
                          spreadRadius: 0.4),
                      BoxShadow(
                          color: Colors.white,
                          offset: Offset(-2.0, -2.0),
                          blurRadius: 8.0,
                          spreadRadius: 0.3),
                    ],
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        (Color.fromRGBO(238, 238, 238, 0.397)),
                        (Color.fromARGB(129, 255, 255, 255)),
                      ],
                    )),
                child: TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return ("Please Enter Your Email");
                    }
                    // reg expression for email validation
                    if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                        .hasMatch(value)) {
                      return ("Please Enter a valid email");
                    }
                    return null;
                  },
                  controller: _resetemaicontroller,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Email',
                      contentPadding: EdgeInsets.only(left: 20)),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            MaterialButton(
              onPressed: () {
                resetpass();
              },
              minWidth: 250,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              height: 45,
              color: Colors.lightBlue,
              child: Text(
                'Reset',
                style: TextStyle(color: Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }

  void resetpass() async {
    if (_formkey.currentState!.validate()) {
      try {
        showDialog(
            context: context,
            builder: (context) {
              return AbsorbPointer(
                absorbing: true,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: Center(
                      child: SizedBox(
                    height: 50,
                    width: 50,
                    child: LoadingIndicator(
                        indicatorType: Indicator.ballRotateChase),
                  )),
                ),
              );
            });
        await FirebaseAuth.instance
            .sendPasswordResetEmail(email: _resetemaicontroller.text);
        Navigator.pop(context);
        Fluttertoast.showToast(
            msg: 'Email has been Sent to your Email ✨',
            textColor: Colors.white,
            backgroundColor: Colors.lightBlue);
      } on Exception catch (e) {
        Navigator.pop(context);
        Fluttertoast.showToast(msg: '$e');
      }
    }
  }
}
