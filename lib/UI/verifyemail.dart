// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, duplicate_ignore

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:learnable/UI/setup.dart';

import 'homescreen.dart';

class Verify extends StatefulWidget {
  const Verify({Key? key}) : super(key: key);

  @override
  _VerifyState createState() => _VerifyState();
}

class _VerifyState extends State<Verify> {
  final auth = FirebaseAuth.instance;
  late User? user = auth.currentUser;
  late Timer timer;

  @override
  void initState() {
    User? user = auth.currentUser;
    user!.sendEmailVerification();

    timer = Timer.periodic(const Duration(seconds: (5)), (timer) {
      checkemailverification();
    });
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          //crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // ignore: prefer_const_constructors
            Icon(
              FontAwesomeIcons.envelope,
              size: 80,
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              "verification Email hase been sent to ${user!.email}",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                color: Colors.lightBlue,
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            MaterialButton(
              onPressed: () {
                user!.sendEmailVerification();
              },
              child: Text("Resend"),
              color: Colors.lightBlue,
              minWidth: 150,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(22.0)),
            )
          ],
        ),
      ),
    );
  }

  Future<void> checkemailverification() async {
    User? user = auth.currentUser;
    await user!.reload();
    if (user.emailVerified) {
      timer.cancel();
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const SetupOne()));
    }
  }
}
