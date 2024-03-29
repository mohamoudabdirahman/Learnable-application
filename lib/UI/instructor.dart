// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

//import 'dart:html';

import 'dart:math';

import 'package:another_flushbar/flushbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_pw_validator/flutter_pw_validator.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:learnable/UI/choice.dart';
import 'package:learnable/UI/homescreen.dart';
import 'package:learnable/UI/phonenumber.dart';
import 'package:learnable/UI/verifyemail.dart';
import 'package:learnable/usermodel/user_model.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Instructors extends StatefulWidget {
  const Instructors({Key? key}) : super(key: key);

  @override
  _InstructorsState createState() => _InstructorsState();
}

class _InstructorsState extends State<Instructors> {
  //firebase
  final auth = FirebaseAuth.instance;

  bool isinstructor = false;
  //controller variables
  final firstnames = TextEditingController();
  final surname = TextEditingController();
  final emailcontrollers = TextEditingController();
  final passwordcontrollers = TextEditingController();
  final confirmpasswords = TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  bool? finalbool;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: ((context) => Choicescreen())));
            },
            icon: Icon(Icons.arrow_back)),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
              left: 17.0, right: 17.0, top: 34.0, bottom: 0.0),
          child: Form(
            key: _formkey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "W E L C O M E",
                    style: TextStyle(
                      fontSize: 30,
                      color: Colors.lightBlue,
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    "Sign Up as an Instructor",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  Column(
                    children: [
                      TextFormField(
                          controller: firstnames,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return ("LastName is required for Registration");
                            }
                          },
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(15.0),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            //fillColor: Colors.lightBlue,
                            //filled: true,
                            hintText: "First Name",
                          )),
                      SizedBox(
                        height: 15.0,
                      ),
                      TextFormField(
                          controller: surname,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return ("LastName is required for Registration");
                            }
                          },
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(15.0),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            //fillColor: Colors.lightBlue,
                            //filled: true,
                            hintText: "Last Name",
                          )),
                      SizedBox(
                        height: 15.0,
                      ),
                      TextFormField(
                          controller: emailcontrollers,
                          keyboardType: TextInputType.emailAddress,
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
                            emailcontrollers.text = value!;
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
                          controller: passwordcontrollers,
                          obscureText: true,
                          onSaved: (value) {
                            passwordcontrollers.text = value!;
                          },
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(15.0),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            //fillColor: Colors.lightBlue,
                            //filled: true,
                            hintText: "Password",
                          )),
                      SizedBox(
                        height: 5.0,
                      ),
                      FlutterPwValidator(
                          width: 400,
                          height: 150,
                          minLength: 8,
                          onSuccess: () {},
                          uppercaseCharCount: 1,
                          numericCharCount: 1,
                          specialCharCount: 1,
                          controller: passwordcontrollers),
                      SizedBox(
                        height: 15.0,
                      ),
                      TextFormField(
                          controller: confirmpasswords,
                          obscureText: true,
                          validator: (value) {
                            if (confirmpasswords.text.length < 6 &&
                                confirmpasswords.text != value) {
                              return "password dont match";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(15.0),
                            border: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.white, width: 1.0),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            //fillColor: Colors.lightBlue,
                            //filled: true,
                            hintText: "confirm password",
                          )),
                      SizedBox(height: 20.0),
                      MaterialButton(
                        onPressed: () async {
                          signup(
                              emailcontrollers.text, passwordcontrollers.text);
                          setState(() {
                            isinstructor = true;
                          });
                        },
                        color: Colors.white,
                        child: Text(
                          "Sign Up",
                          style:
                              TextStyle(color: Colors.lightBlue, fontSize: 18),
                        ),
                        minWidth: 150,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(22.0)),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void signup(String email, String password) async {
    try {
      if (_formkey.currentState!.validate()) {
        showDialog(
            context: context,
            builder: (context) {
              return Center(
                  child: SizedBox(
                      width: 60,
                      height: 60,
                      child: LoadingIndicator(
                        indicatorType: Indicator.ballRotateChase,
                      )));
            });

        await auth
            .createUserWithEmailAndPassword(email: email, password: password)
            .then((value) => {
                  Navigator.of(context).pop(),
                  postDetailsToFirestore(),
                });
      }
    } on FirebaseAuthException catch (error) {
      Navigator.of(context).pop();
      Fluttertoast.showToast(msg: '$error');
    }
  }

  postDetailsToFirestore() async {
    //calling firestore
    //calling usermodel
    //sending values

    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = auth.currentUser;

    UserModel userModel = UserModel();
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    sharedPreferences.setBool('isinstructor', false);

    //writing values to firestore

    userModel.email = user!.email;
    userModel.uid = user.uid;
    userModel.firstname = firstnames.text;
    userModel.lastname = surname.text;
    userModel.isinstructor = true;
    await firebaseFirestore
        .collection("Users")
        .doc(user.uid)
        .set(userModel.toMap());
    Fluttertoast.showToast(msg: "Account created successfully");

    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => Phonenumber()));
  }
}
