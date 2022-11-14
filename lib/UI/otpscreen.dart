// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:learnable/UI/Instructordashboard.dart';
import 'package:learnable/UI/homescreen.dart';
import 'package:learnable/UI/phonenumber.dart';
import 'package:learnable/UI/setup.dart';
import 'package:learnable/usermodel/user_model.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OtpScreen extends StatefulWidget {
  final String? phonenumber;
  final String? initialcode;
  final String? firstname;
  final String? lastname;
  final String? email;
  final bool? isinstructor;
  const OtpScreen(
      {Key? key,
      required this.phonenumber,
      required this.initialcode,
      this.firstname,
      this.lastname,
      this.email,
      this.isinstructor})
      : super(key: key);

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  String? _verificatiocode;
  final TextEditingController _field1 = TextEditingController();
  final TextEditingController _field2 = TextEditingController();
  final TextEditingController _field3 = TextEditingController();
  final TextEditingController _field4 = TextEditingController();
  final TextEditingController _field5 = TextEditingController();
  final TextEditingController _field6 = TextEditingController();
  User? user = FirebaseAuth.instance.currentUser;
  UserModel newuser = UserModel();

  String? email;
  String? firstname;
  String? lastname;
  bool? role;
  FirebaseAuth auth = FirebaseAuth.instance;

  void getdata() {
    FirebaseFirestore.instance
        .collection('Users')
        .doc(user!.uid)
        .get()
        .then((value) async {
      newuser = UserModel.fromMap(value.data());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Phonenumber()));
              },
              icon: Icon(Icons.arrow_back_ios_outlined))),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      'Verification Code',
                      style: TextStyle(fontSize: 24, color: Colors.black),
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      'We have sent a verification code to ${widget.phonenumber}',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border:
                                Border.all(width: 1, color: Colors.lightBlue)),
                        child: SizedBox(
                          height: 58,
                          width: 54,
                          child: TextField(
                              controller: _field1,
                              onChanged: (value) {
                                if (value.length == 1) {
                                  FocusScope.of(context).nextFocus();
                                }
                              },
                              textAlign: TextAlign.center,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(1),
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              keyboardType: TextInputType.phone,
                              style: Theme.of(context).textTheme.headline4,
                              decoration:
                                  InputDecoration(border: InputBorder.none)),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border:
                                Border.all(width: 1, color: Colors.lightBlue)),
                        child: SizedBox(
                          height: 58,
                          width: 54,
                          child: TextField(
                              controller: _field2,
                              onChanged: (value) {
                                if (value.length == 1) {
                                  FocusScope.of(context).nextFocus();
                                }
                              },
                              textAlign: TextAlign.center,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(1)
                              ],
                              keyboardType: TextInputType.phone,
                              style: Theme.of(context).textTheme.headline4,
                              decoration:
                                  InputDecoration(border: InputBorder.none)),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border:
                                Border.all(width: 1, color: Colors.lightBlue)),
                        child: SizedBox(
                          height: 58,
                          width: 54,
                          child: TextField(
                              controller: _field3,
                              onChanged: (value) {
                                if (value.length == 1) {
                                  FocusScope.of(context).nextFocus();
                                }
                              },
                              textAlign: TextAlign.center,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(1)
                              ],
                              keyboardType: TextInputType.phone,
                              style: Theme.of(context).textTheme.headline4,
                              decoration:
                                  InputDecoration(border: InputBorder.none)),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border:
                                Border.all(width: 1, color: Colors.lightBlue)),
                        child: SizedBox(
                          height: 58,
                          width: 54,
                          child: TextField(
                              controller: _field4,
                              onChanged: (value) {
                                if (value.length == 1) {
                                  FocusScope.of(context).nextFocus();
                                }
                              },
                              textAlign: TextAlign.center,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(1)
                              ],
                              keyboardType: TextInputType.phone,
                              style: Theme.of(context).textTheme.headline4,
                              decoration:
                                  InputDecoration(border: InputBorder.none)),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border:
                                Border.all(width: 1, color: Colors.lightBlue)),
                        child: SizedBox(
                          height: 58,
                          width: 54,
                          child: TextField(
                              controller: _field5,
                              onChanged: (value) {
                                if (value.length == 1) {
                                  FocusScope.of(context).nextFocus();
                                }
                              },
                              textAlign: TextAlign.center,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(1)
                              ],
                              keyboardType: TextInputType.phone,
                              style: Theme.of(context).textTheme.headline4,
                              decoration:
                                  InputDecoration(border: InputBorder.none)),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border:
                                Border.all(width: 1, color: Colors.lightBlue)),
                        child: SizedBox(
                          height: 58,
                          width: 54,
                          child: TextField(
                              controller: _field6,
                              textAlign: TextAlign.center,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(1)
                              ],
                              keyboardType: TextInputType.phone,
                              style: Theme.of(context).textTheme.headline4,
                              decoration:
                                  InputDecoration(border: InputBorder.none)),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 430,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                  width: 1, color: Colors.lightBlue)),
                          child: MaterialButton(
                              onPressed: () {},
                              minWidth: 150,
                              height: 50,
                              child: Text(
                                'Resend',
                                style: TextStyle(
                                    fontSize: 16, color: Colors.lightBlue),
                              )),
                        ),
                        MaterialButton(
                          onPressed: () async {
                            if (_field1.text == '' &&
                                _field2.text == '' &&
                                _field3.text == '' &&
                                _field3.text == '' &&
                                _field4.text == '' &&
                                _field5.text == '' &&
                                _field6.text == '') {
                              Fluttertoast.showToast(
                                  msg: 'fields cannot be empty');
                            } else {
                              try {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AbsorbPointer(
                                        absorbing: true,
                                        child: Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          height: MediaQuery.of(context)
                                              .size
                                              .height,
                                          child: Center(
                                              child: SizedBox(
                                            height: 50,
                                            width: 50,
                                            child: LoadingIndicator(
                                                indicatorType:
                                                    Indicator.ballRotateChase),
                                          )),
                                        ),
                                      );
                                    });

                                final AuthCredential credentials =
                                    PhoneAuthProvider.credential(
                                        verificationId:
                                            _verificatiocode.toString(),
                                        smsCode: _field1.text +
                                            _field2.text +
                                            _field3.text +
                                            _field4.text +
                                            _field5.text +
                                            _field6.text);
                                print(_verificatiocode.toString());
                                user!.linkWithCredential(credentials);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: ((context) => SetupOne())));
                              } on Exception catch (e) {
                                Fluttertoast.showToast(msg: '$e');
                              }
                            }
                          },
                          minWidth: 150,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                          height: 50,
                          color: Colors.lightBlue,
                          child: Text(
                            'Verify OTP',
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void verifycode() async {
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: widget.initialcode! + widget.phonenumber.toString(),
        verificationCompleted: (PhoneAuthCredential credential) async {
          await FirebaseAuth.instance
              .signInWithCredential(credential)
              .then((value) async {
            print('it is done');
          });
        },
        verificationFailed: (FirebaseAuthException e) {
          Fluttertoast.showToast(msg: '$e');
        },
        codeSent: (String verificationID, int? resendToken) {
          setState(() {
            _verificatiocode = verificationID;
          });
        },
        codeAutoRetrievalTimeout: (String verificationID) {
          setState(() {
            _verificatiocode = verificationID;
          });
        },
        timeout: const Duration(seconds: 60));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    verifycode();
  }
}
