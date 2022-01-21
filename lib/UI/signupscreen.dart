// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:learnable/UI/homescreen.dart';
import 'package:learnable/UI/signinscreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:learnable/usermodel/user_model.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  //firebase instance

  //google sign in

  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ["email"]);

  final _Auth = FirebaseAuth.instance;

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  //editing controllers

  final firstnamecontroller = TextEditingController();
  final lastnamecontroller = TextEditingController();
  final emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();
  final confirmpasswordcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    GoogleSignInAccount? user = _googleSignIn.currentUser;
    return Scaffold(
      appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.white,
          leading: IconButton(
              onPressed: () {
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (_) => SignIn()));
              },
              icon: Icon(
                Icons.arrow_back,
                color: Colors.lightBlue,
              ))),

      //body
      body: Padding(
        padding: const EdgeInsets.fromLTRB(22, 10, 0, 0),
        child: Container(
          width: 350.0,
          height: 580.0,
          decoration: BoxDecoration(
              color: Colors.lightBlue,
              borderRadius: BorderRadius.circular(37),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 3,
                  blurRadius: 6,
                  offset: Offset(0, 5), // changes position of shadow
                ),
              ]),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(35, 50, 30, 30),
            child: SingleChildScrollView(
              child: Form(
                key: _formkey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Welcome!",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                          ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          "Sign Up to continue",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 35.0,
                    ),
                    Column(
                      children: [
                        TextFormField(
                            controller: firstnamecontroller,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return ("first Name cannot be Empty");
                              }

                              return null;
                            },
                            onSaved: (value) {
                              firstnamecontroller.text = value!;
                            },
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(15.0),
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.white, width: 1.0),
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
                            controller: lastnamecontroller,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return ("first Name cannot be Empty");
                              }

                              return null;
                            },
                            onSaved: (value) {
                              lastnamecontroller.text = value!;
                            },
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(15.0),
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.white, width: 1.0),
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
                            controller: emailcontroller,
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
                              emailcontroller.text = value!;
                            },
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(15.0),
                              focusedBorder: InputBorder.none,
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.white, width: 1.0),
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
                              passwordcontroller.text = value!;
                            },
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(15.0),
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.white, width: 1.0),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              //fillColor: Colors.lightBlue,
                              //filled: true,
                              hintText: "password",
                            )),
                        SizedBox(
                          height: 15.0,
                        ),
                        TextFormField(
                            controller: confirmpasswordcontroller,
                            obscureText: true,
                            validator: (value) {
                              if (confirmpasswordcontroller.text.length < 6 &&
                                  passwordcontroller.text != value) {
                                return "password dont match";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(15.0),
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.white, width: 1.0),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              //fillColor: Colors.lightBlue,
                              //filled: true,
                              hintText: "confirm password",
                            )),
                        SizedBox(
                          height: 15,
                        ),
                        MaterialButton(
                          onPressed: () async {
                            signup(
                                emailcontroller.text, passwordcontroller.text);
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
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(13, 5, 0, 0),
                      child: Container(
                        width: 250,
                        height: 35,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(50.0)),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              MaterialButton(
                                  onPressed: () {
                                    googlesignin();
                                  },
                                  minWidth: 250,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(50.0))),
                                  child: Row(
                                    children: [
                                      Icon(
                                        FontAwesomeIcons.google,
                                        color: Colors.red,
                                        size: 20,
                                      ),
                                      SizedBox(
                                        width: 15.0,
                                      ),
                                      Text(
                                        "Sign Up with Google",
                                        style: TextStyle(
                                          color: Colors.lightBlue,
                                          fontSize: 14,
                                        ),
                                      )
                                    ],
                                  ))
                            ],
                          ),
                        ),
                      ),
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

  void signup(String email, String Password) async {
    if (_formkey.currentState!.validate()) {
      await _Auth.createUserWithEmailAndPassword(
              email: email, password: Password)
          .then((value) => {postDetailsToFirestore()})
          .catchError((e) {
        Fluttertoast.showToast(msg: e!.message);
      });
    }
  }

  postDetailsToFirestore() async {
    //calling firestore
    //calling usermodel
    //sending values

    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _Auth.currentUser;

    UserModel userModel = UserModel();

    //writing values to firestore

    userModel.email = user!.email;
    userModel.uid = user.uid;
    userModel.firstname = firstnamecontroller.text;
    userModel.lastname = lastnamecontroller.text;

    await firebaseFirestore
        .collection("Users")
        .doc(user.uid)
        .set(userModel.toMap());
    Fluttertoast.showToast(msg: "Account created successfully");

    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => Homescreen()));
  }

  //google sign-in function

  void googlesignin() async {
    await _googleSignIn
        .signIn()
        .then((value) => {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => Homescreen()))
            })
        .catchError((e) {
      Fluttertoast.showToast(msg: "something went wrong");
    });
  }
}
