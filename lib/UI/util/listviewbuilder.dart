// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:learnable/UI/Uploadcoursescreen.dart';
import 'package:learnable/usermodel/user_model.dart';

class CreateCourse extends StatefulWidget {
  String? vidurl;
  TextEditingController? chaptitle = TextEditingController();
  File? video;
  CreateCourse({
    this.vidurl,
    this.chaptitle,
    this.video,
    Key? key,
  }) : super(key: key);

  @override
  State<CreateCourse> createState() => _CreateCourseState();
}

class _CreateCourseState extends State<CreateCourse> {
  // needvideo() {
  //   UploadCourse(
  //     video: video,
  //     chaptitle: chaptitle,
  //     vidurl: vidurl,
  //   );
  // }

  int num = 1;
  // String? vidurl;
  // File? video;
  // final chaptitle = TextEditingController();
  //firebase Auth
  final _auth = FirebaseAuth.instance;

  Future videoPickerMethod() async {
    final pick = await ImagePicker().pickVideo(source: ImageSource.gallery);

    setState(() {
      if (pick != null) {
        widget.video = File(pick.path);
      } else {
        showSnackBar("Something went wrong", Duration(microseconds: 400));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: ((context, int index) {
        return Padding(
          padding: const EdgeInsets.only(top: 15.0),
          child: Container(
            width: 285,
            height: 84,
            decoration: BoxDecoration(
                border: Border.all(width: 1, color: Colors.white),
                borderRadius: BorderRadius.circular(12)),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                children: [
                  SizedBox(
                    width: 91,
                    height: 59,
                    child: GestureDetector(
                        onTap: () {
                          videoPickerMethod();
                          
                        },
                        child: widget.video == null
                            ? DottedBorder(
                                child: Center(
                                    child:
                                        Icon(Icons.add, color: Colors.white)),
                                color: Colors.white,
                                dashPattern: const [8, 4],
                                borderType: BorderType.RRect,
                                radius: Radius.circular(10),
                              )
                            : Container(
                                decoration: BoxDecoration(
                                    border: Border.all(
                                      width: 1.0,
                                      color: Colors.white,
                                    ),
                                    borderRadius: BorderRadius.circular(12)),
                                child: ClipRRect(
                                    child: Icon(
                                  Icons.check,
                                  size: 30.0,
                                  color: Colors.green,
                                )),
                              )),
                  ),
                  SizedBox(
                    width: 5.0,
                  ),
                  Flexible(
                      child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: 30.0,
                            width: 800.0,
                            child: TextField(
                              controller: widget.chaptitle,
                              decoration: InputDecoration(
                                hintText: "Chapter Title",
                                hintStyle: TextStyle(
                                    fontSize: 10, color: Colors.white54),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.white, width: 1),
                                    borderRadius: BorderRadius.circular(5)),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.white, width: 1),
                                    borderRadius: BorderRadius.circular(5)),
                              ),
                            ),
                          ))),
                  Container(
                      child: IconButton(
                          onPressed: () {
                            setState(() {
                              index = index--;
                            });
                          },
                          icon: Icon(
                            Icons.clear,
                            size: 10,
                          )))
                ],
              ),
            ),
          ),
        );
      }),
      itemCount: num,
      physics: ScrollPhysics(parent: null),
      shrinkWrap: true,
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
}
