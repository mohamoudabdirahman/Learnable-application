// ignore_for_file: prefer_const_constructors

import 'dart:async';

import 'package:another_flushbar/flushbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:learnable/UI/Instructordashboard.dart';
import 'package:learnable/UI/choice.dart';
import 'package:learnable/UI/homescreen.dart';
import 'package:learnable/UI/util/nointernet.dart';
import 'package:learnable/usermodel/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String? finaleamil;
  String? finaluserid;
  UserModel data = UserModel();
  User? user = FirebaseAuth.instance.currentUser;
  bool? hasinternet;
  @override
  void initState() {
    // TODO: implement initState

    FirebaseFirestore.instance
        .collection('Users')
        .doc(user?.uid)
        .get()
        .then((value) => data = UserModel.fromMap(value.data()));
    print(data.isinstructor);
    try {
      getobtaineddata().whenComplete(() => {
            Timer(const Duration(seconds: 3), (() async {
              hasinternet = await InternetConnectionChecker().hasConnection;
              if (hasinternet == true) {
                if (finaleamil == null) {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => Choicescreen()));
                } else if (finaleamil != null && data.isinstructor == false) {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => Homescreen()));
                } else if (finaleamil != null && data.isinstructor == true) {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => InstructorDash()));
                }
              } else if (hasinternet == false) {
                print('has no internet');
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Nointernetscreen()));
              }
            }))
          });
    } on PlatformException catch (error) {
      Flushbar(
        message: '$error',
        duration: Duration(seconds: 3),
        flushbarPosition: FlushbarPosition.TOP,
        backgroundColor: Colors.lightBlue,
      );
    }
  }

  Future getobtaineddata() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    var obtaineddata = sharedPreferences.getString('email');
    var obtaineduid = sharedPreferences.getString('id');

    setState(() {
      finaleamil = obtaineddata;
      finaluserid = obtaineduid;
    });
    print(finaleamil);
    print(finaluserid);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.lightBlue,
        body: Center(
            child: Image.asset(
          'lib/images/learnable-blue.png',
          color: Colors.white,
          height: 80,
        )));
  }
}
