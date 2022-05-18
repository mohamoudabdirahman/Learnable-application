// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

//import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:learnable/UI/homescreen.dart';
import 'package:learnable/UI/verifyemail.dart';
import 'package:learnable/usermodel/user_model.dart';
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
      body: SingleChildScrollView(
        child: SafeArea(
          child: Expanded(
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 17.0, right: 17.0, top: 34.0, bottom: 0.0),
              child: Form(
                key: _formkey,
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
                                return ("Password is required for login");
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
                                return ("Password is required for login");
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
                            signup(emailcontrollers.text,
                                passwordcontrollers.text);
                            setState(() {
                              isinstructor = true;
                            });
                          },
                          color: Colors.white,
                          child: Text(
                            "Sign Up",
                            style: TextStyle(
                                color: Colors.lightBlue, fontSize: 18),
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
      ),
    );
  }

  void signup(String email, String password) async {
    if (_formkey.currentState!.validate()) {
      await auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) => {postDetailsToFirestore()})
          .catchError((e) {
        Fluttertoast.showToast(msg: e!.message);
      });
    }
  }

  Future postDetailsToFirestore() async {
    //calling firestore
    //calling usermodel
    //sending values

    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = auth.currentUser;

    UserModel usermodel = UserModel();

    

    //writing values to firestore

    usermodel.email = user!.email;
    usermodel.uid = user.uid;
    usermodel.firstname = firstnames.text;
    usermodel.lastname = surname.text;
    usermodel.isinstructor = isinstructor;

    await firebaseFirestore
        .collection("Users")
        .doc(user.uid)
        .set(usermodel.toMap());
    Fluttertoast.showToast(msg: "Account created successfully");

    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => Verify()));
  }
}
