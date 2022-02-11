// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:learnable/UI/signinscreen.dart';

class Accountpage extends StatefulWidget {
  const Accountpage({Key? key}) : super(key: key);

  @override
  _AccountpageState createState() => _AccountpageState();
}

class _AccountpageState extends State<Accountpage> {
  final _Auth = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "account",
              style: TextStyle(color: Colors.black, fontSize: 40),
            ),
            SizedBox(
              height: 25.0,
            ),
            MaterialButton(
              onPressed: () {
                deleteaccount();
              },
              child: Text("delete account"),
              color: Colors.lightBlue,
            )
          ],
        ),
      ),
    );
  }

  void deleteaccount() async{
    
    await _Auth!.delete().then((value) => Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => SignIn())));
  }
}
