// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:learnable/UI/choice.dart';
import 'package:learnable/UI/homescreen.dart';
import 'package:learnable/UI/signupscreen.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);
  @override
  _signupState createState() => _signupState();
}

class _signupState extends State<SignIn> {
  // google signin

  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ["email"]);

  //controllers of Sign in fields
  final TextEditingController emailcontroller = TextEditingController();
  final TextEditingController passwordcontroller = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  //firbase

  final auth.FirebaseAuth _Auth = auth.FirebaseAuth.instance;
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
                              obscureText: true,
                              validator: (value) {
                                RegExp regex = new RegExp(r'^.{6,}$');
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
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                //fillColor: Colors.lightBlue,
                                //filled: true,
                                hintText: "password",
                              )),
                          SizedBox(
                            height: 25.0,
                          ),
                          MaterialButton(
                            onPressed: () {
                              signin(emailcontroller.text,
                                  passwordcontroller.text);
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
                              MaterialButton(
                                  color: Colors.lightBlue,
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
                                          color: Colors.white,
                                          fontSize: 14,
                                        ),
                                      )
                                    ],
                                  ))
                            ],
                          ),
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
                  ),
                ),
              ),
            )));
  }

  void signin(String email, String password) async {
    if (_formkey.currentState!.validate()) {
      await _Auth.signInWithEmailAndPassword(email: email, password: password)
          .then((uid) => {
                Fluttertoast.showToast(msg: "you are seccusfully Signed In"),
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => Homescreen()))
              })
          .catchError((e) {
        Fluttertoast.showToast(msg: e!.message);
      });
    }
  }

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
