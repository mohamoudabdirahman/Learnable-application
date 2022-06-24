// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:learnable/UI/Instructordashboard.dart';
import 'package:learnable/UI/acountsscreesubscreens/resetpassword.dart';
import 'package:learnable/UI/choice.dart';
import 'package:learnable/UI/homescreen.dart';
import 'package:learnable/UI/signupscreen.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:firebase_core/firebase_core.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:learnable/usermodel/user_model.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'instructor.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);
  @override
  _signupState createState() => _signupState();
}

class _signupState extends State<SignIn> {
  //collection
  final Stream<QuerySnapshot> userref =
      FirebaseFirestore.instance.collection("users").snapshots();

  //controllers of Sign in fields
  final TextEditingController emailcontroller = TextEditingController();
  final TextEditingController passwordcontroller = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  //firbase

  final auth.FirebaseAuth _Auth = auth.FirebaseAuth.instance;
  final authentications = FirebaseFirestore.instance;
  FirebaseAuth users = FirebaseAuth.instance;
  UserModel loggedInuser = UserModel();

  final user = auth.FirebaseAuth.instance;
  bool ispressed = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => Choicescreen()));
            },
            icon: Icon(FontAwesomeIcons.arrowLeft),
            iconSize: 18,
          ),
          backgroundColor: Colors.lightBlue,
          elevation: 0.0,
          centerTitle: true,
          title: Text(
            "L E A R N A B L E",
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Center(
                child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: SingleChildScrollView(
                child: Form(
                  key: _formkey,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "W E L C O M E !",
                          style: TextStyle(
                              color: Colors.lightBlue,
                              fontSize: 25,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 35.0,
                        ),
                        TextFormField(
                            controller: emailcontroller,
                            keyboardType: TextInputType.emailAddress,
                            //validation
                            validator: (value) {
                              if (value!.isEmpty) {
                                return ("Please Enter Your Email");
                              }
                              // reg expression for email validation
                              if (!RegExp(
                                      "^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                                  .hasMatch(value)) {
                                return ("Please Enter a valid email");
                              }
                              return null;
                            },
                            onSaved: (value) {
                              emailcontroller.text = value!;
                            },
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(15.0),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              //fillColor: Colors.lightBlue,
                              //filled: true,
                              hintText: "Email",
                            )),
                        SizedBox(
                          height: 15.0,
                        ),
                        TextFormField(
                            controller: passwordcontroller,
                            obscureText: ispressed,
                            validator: (value) {
                              RegExp regex = RegExp(r'^.{6,}$');
                              if (value!.isEmpty) {
                                return ("Password is required for login");
                              }
                              if (!regex.hasMatch(value)) {
                                return ("Enter Valid Password(Min. 6 Character)");
                              }
                              return null;
                            },
                            onSaved: (value) {
                              passwordcontroller.text = value!;
                            },
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    ispressed = !ispressed;
                                  });
                                  // buttonpressed();
                                },
                                icon: Icon(
                                  ispressed
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  size: 20.0,
                                ),
                              ),
                              contentPadding: EdgeInsets.all(15.0),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              //fillColor: Colors.lightBlue,
                              //filled: true,
                              hintText: "password",
                            )),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: ((context) => Resetpass())));
                              },
                              child: Text(
                                'Forgot Your Password?',
                                style: TextStyle(color: Colors.lightBlue),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 25.0,
                        ),
                        MaterialButton(
                          onPressed: () {
                            signin(emailcontroller.text);
                          },
                          color: Colors.lightBlue,
                          child: Text(
                            "login",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          minWidth: 150,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(22.0)),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 20.0,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("Don't have an account?"),
                                  SizedBox(
                                    width: 5.0,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) => Signup()));
                                    },
                                    child: Text(
                                      "Register",
                                      style: TextStyle(color: Colors.lightBlue),
                                    ),
                                  )
                                ],
                              )
                            ]),
                      ]),
                ),
              ),
            ))));
  }

  void signin(String phonenumber) async {
    // User? user = FirebaseAuth.instance.currentUser;
    InstructorModel instructorModel = InstructorModel();
    try {
      if (_formkey.currentState!.validate()) {
        showDialog(
            context: context,
            builder: (context) {
              return Center(
                  child: SizedBox(
                      height: 50,
                      width: 50,
                      child: LoadingIndicator(
                        indicatorType: Indicator.ballRotateChase,
                      )));
            });

        await _Auth.signInWithEmailAndPassword(
            email: emailcontroller.text, password: passwordcontroller.text);

        Navigator.of(context).pop();
        //shared preferences
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('email', emailcontroller.text);
        prefs.setString('id', user.currentUser!.uid);
        //uploading data to firebase

        await FirebaseFirestore.instance
            .collection('Users')
            .doc(user.currentUser!.uid)
            .get()
            .then((value) {
          loggedInuser = UserModel.fromMap(value.data());
        });

        setState(() {
          if (loggedInuser.isinstructor == false) {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => Homescreen()));
          } else if (loggedInuser.isinstructor == true) {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => InstructorDash()));
          }
        });
      }
    } on auth.FirebaseAuthException catch (error) {
      Navigator.pop(context);
      Fluttertoast.showToast(msg: "${error.message}");
    }
  }
}
