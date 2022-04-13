// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:learnable/UI/choice.dart';
import 'package:learnable/UI/setup.dart';
import 'package:learnable/UI/signinscreen.dart';
import 'package:learnable/UI/verifyemail.dart';
import 'dart:io' show Platform;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      // options: FirebaseOptions(
      //     apiKey: "AIzaSyDv9VTSGUl6hIuv65dLL1TNQmCd1mnn1tc",
      //     appId: "1:467155727487:web:b4334d2c100fbe151b3b4a",
      //     messagingSenderId: "467155727487",
      //     projectId: "learnable-d5272")
          );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  var os = Platform.operatingSystem;
  User? user = FirebaseAuth.instance.currentUser;
  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Choicescreen(),
    );
  }
}
