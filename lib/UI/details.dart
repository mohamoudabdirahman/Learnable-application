// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, non_constant_identifier_names

import 'dart:io';
import 'dart:math';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:learnable/UI/Instructordashboard.dart';
import 'package:learnable/UI/homescreen.dart';
import 'package:learnable/usermodel/user_model.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profilepic extends StatefulWidget {
  const Profilepic({Key? key}) : super(key: key);

  @override
  _ProfilepicState createState() => _ProfilepicState();
}

class _ProfilepicState extends State<Profilepic> {
  File? _image;
  String? downloadUrl;
  User? user = FirebaseAuth.instance.currentUser;

  InstructorModel loggedInInstructor = InstructorModel();
  UserModel loggedinUser = UserModel();

  Future ImagePickerMethod() async {
    final pick = await ImagePicker().pickImage(source: ImageSource.gallery);

    setState(() {
      if (pick != null) {
        _image = File(pick.path);
      } else {
        showSnackBar("Something went wrong", Duration(microseconds: 400));
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FirebaseFirestore.instance
        .collection('Users')
        .doc(user!.uid)
        .get()
        .then((value) {
      loggedinUser = UserModel.fromMap(value.data());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 100.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Lottie.network(
                  "https://assets5.lottiefiles.com/packages/lf20_owggins0.json",
                  height: 250),
              Center(
                child: Stack(children: [
                  Container(
                    child: GestureDetector(
                      onTap: () {
                        ImagePickerMethod();
                      },
                      child: _image == null
                          ? Container(
                              width: 150,
                              height: 150,
                              decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.grey,
                                        offset: Offset(3, 4),
                                        blurRadius: 7.0),
                                  ],
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.lightBlue),
                              child: Center(
                                  child: Text(
                                "No file is selected",
                                style: TextStyle(color: Colors.white),
                              )),
                            )
                          : Center(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.file(
                                  _image!,
                                  height: 150,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                    ),
                  ),
                  Positioned(
                    right: 2,
                    bottom: 2,
                    child: IconButton(
                      onPressed: () {
                        ImagePickerMethod();
                      },
                      icon: Icon(
                        FontAwesomeIcons.edit,
                        size: 30,
                        color: Colors.black38,
                      ),
                    ),
                  )
                ]),
              ),
              SizedBox(
                height: 20.0,
              ),
              Text(
                "choose Your profile picture",
                style: TextStyle(fontSize: 20, color: Colors.lightBlue),
              ),
              SizedBox(
                height: 30.0,
              ),
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                  MaterialButton(
                    onPressed: () {
                      if (_image != null) {
                        uploadimages();
                      } else {
                        showSnackBar("No images is selected",
                            Duration(microseconds: 1000));
                      }
                    },
                    color: Colors.lightBlue,
                    child: Text(
                      "Finish",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ]),
              )
            ],
          ),
        ),
      ),
    );
  }

  showSnackBar(String snackText, Duration d) {
    final snackBar = SnackBar(
        content: Text(
          snackText,
          style: TextStyle(color: Colors.white),
        ),
        duration: d,
        backgroundColor: Colors.lightBlue);
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Future uploadimages() async {
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
    FirebaseFirestore.instance;
    Reference ref = FirebaseStorage.instance
        .ref()
        .child(user!.uid)
        .child('profile picture')
        .child('profilepic');
    await ref.putFile(_image!);
    downloadUrl = await ref.getDownloadURL();

    await FirebaseFirestore.instance
        .collection("Users")
        .doc(user!.uid)
        .set({'downloadUrl': downloadUrl},SetOptions(merge: true)).then((value) => {
              showSnackBar(
                  'you have successfully uploaded your profile picture 🎉',
                  Duration(milliseconds: 600))
            });
    Navigator.pop(context);
    
    if (loggedinUser.isinstructor == false) {
      Navigator.push(
          context, MaterialPageRoute(builder: ((context) => Homescreen())));
    }else if(loggedinUser.isinstructor == true)
    {
       Navigator.push(
          context, MaterialPageRoute(builder: ((context) => InstructorDash())));
    }
  }
}
