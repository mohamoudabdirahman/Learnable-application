// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables



import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loading_indicator/loading_indicator.dart';

class PersonalInfo extends StatefulWidget {
  PersonalInfo({Key? key}) : super(key: key);

  @override
  State<PersonalInfo> createState() => _PersonalInfoState();
}

class _PersonalInfoState extends State<PersonalInfo> {
  final TextEditingController _fnamecontroller = TextEditingController();
  final TextEditingController _lnamecontroller = TextEditingController();
  User? user = FirebaseAuth.instance.currentUser;
  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _formkey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Personal Information',
                style: TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              SizedBox(
                height: 34,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                            color: (Color.fromRGBO(117, 117, 117, 0.527)),
                            offset: Offset(1.0, 1.0),
                            blurRadius: 8.0,
                            spreadRadius: 0.4),
                        BoxShadow(
                            color: Colors.white,
                            offset: Offset(-2.0, -2.0),
                            blurRadius: 8.0,
                            spreadRadius: 0.3),
                      ],
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          (Color.fromRGBO(238, 238, 238, 0.397)),
                          (Color.fromARGB(129, 255, 255, 255)),
                        ],
                      )),
                  child: TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'This must not be empty';
                      } else if (value.length < 3) {
                        return 'The Name must be more than 3 Characters';
                      }
                    },
                    controller: _fnamecontroller,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'First Name',
                        contentPadding: EdgeInsets.only(left: 20)),
                  ),
                ),
              ),
              SizedBox(
                height: 28,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                            color: (Color.fromRGBO(117, 117, 117, 0.527)),
                            offset: Offset(1.0, 1.0),
                            blurRadius: 8.0,
                            spreadRadius: 0.4),
                        BoxShadow(
                            color: Colors.white,
                            offset: Offset(-2.0, -2.0),
                            blurRadius: 8.0,
                            spreadRadius: 0.3),
                      ],
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          (Color.fromRGBO(238, 238, 238, 0.397)),
                          (Color.fromARGB(129, 255, 255, 255)),
                        ],
                      )),
                  child: TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'This must not be empty';
                      } else if (value.length < 3) {
                        return 'The Name must be more than 3 Characters';
                      }
                    },
                    controller: _lnamecontroller,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'First Name',
                        contentPadding: EdgeInsets.only(left: 20)),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              MaterialButton(
                onPressed: () {
                  updateinfo();
                },
                minWidth: 250,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                height: 45,
                color: Colors.lightBlue,
                child: Text(
                  'Save',
                  style: TextStyle(color: Colors.white),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void updateinfo() async {
    if (_formkey.currentState!.validate()) {
      try {
        showDialog(
            context: context,
            builder: (context) {
              return AbsorbPointer(
                absorbing: true,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: Center(
                      child: SizedBox(
                    height: 50,
                    width: 50,
                    child: LoadingIndicator(
                        indicatorType: Indicator.ballRotateChase),
                  )),
                ),
              );
            });
        await FirebaseFirestore.instance
            .collection('Users')
            .doc(user!.uid)
            .update({
          'First Name': _fnamecontroller.text,
          'Last Name': _lnamecontroller.text
        });
        Navigator.pop(context);
        Fluttertoast.showToast(msg: 'You have successfullly changed your Name 😀',textColor: Colors.white,backgroundColor: Colors.lightBlue);
      } on Exception catch (e) {
        Navigator.pop(context);
        Fluttertoast.showToast(msg: '$e');
      }
    }
  }
}
