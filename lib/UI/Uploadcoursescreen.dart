// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_null_comparison

import 'dart:io';

import 'package:another_flushbar/flushbar.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:learnable/UI/util/dynamiccoursefield.dart';
import 'package:learnable/usermodel/user_model.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';
import 'package:loading_indicator/loading_indicator.dart';

class UploadCourse extends StatefulWidget {
  const UploadCourse({Key? key}) : super(key: key);

  @override
  State<UploadCourse> createState() => _UploadCourseState();
}

class _UploadCourseState extends State<UploadCourse> {
  final TextEditingController _coursetitle = TextEditingController();
  final TextEditingController _coursedescription = TextEditingController();
  PlatformFile? file;
  PlatformFile? video;
  bool iswidgetvissible = false;
  List<Dynamiccoursefield> dynamicwidget = [];
  List<PlatformFile> videos = [];
  List<String> lessontitles = [];
  bool istapped = false;
  FirebaseAuth auth = FirebaseAuth.instance;
  String? vidurl;
  String? thumburl;
  UploadTask? uploadTask;
  final _formkey = GlobalKey<FormState>();

  //dynamic widget for the course lessons field
  adddynamic() {
    dynamicwidget.add(Dynamiccoursefield(
      video: video,
      file: file,
    ));
    setState(() {});
  }

  //thumbnail of the course picking method
  Future getthumbnail() async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(type: FileType.image);
    setState(() {
      if (result != null) {
        file = result.files.first;
      }
    });
  }

  //video picking method

  // Future getvideos() async {
  //   FilePickerResult? result =
  //       await FilePicker.platform.pickFiles(type: FileType.video);
  //   setState(() {
  //     if (result != null) {
  //       video = result.files.first;
  //     }
  //   });
  // }

  submitdata() async {
    for (var widget in dynamicwidget) {
      User? user = FirebaseAuth.instance.currentUser;
      final images = File(widget.video!.path!);
      Reference vidref = FirebaseStorage.instance
          .ref("Users")
          .child(user!.uid)
          .child("Course");
      if (widget.video != null) {
        await vidref.putFile(images);
        vidurl = await vidref.getDownloadURL();
      }
      if (video == null) {
        print("video is null");
      }
    }
  }

  // future snapshot

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Course'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 50),
          child: SingleChildScrollView(
            child: Stack(
              children: [
                Form(
                  key: _formkey,
                  child: Column(
                    children: [
                      Container(
                        width: 299,
                        height: 233,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(28),
                            border:
                                Border.all(width: 1, color: Colors.lightBlue)),
                        child: Center(
                            child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            file == null
                                ? GestureDetector(
                                    onTap: () {
                                      getthumbnail();
                                    },
                                    child: Image.asset(
                                      'lib/images/imageupload.png',
                                      width: 40,
                                      color: Colors.lightBlue,
                                    ))
                                : Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 10,
                                    ),
                                    child: ClipRRect(
                                        borderRadius: BorderRadius.circular(20),
                                        child: Image.file(
                                          File(file!.path.toString()),
                                          height: 200,
                                          fit: BoxFit.cover,
                                        ))),
                            SizedBox(
                              height: 15,
                            ),
                            file == null
                                ? Text(
                                    "Upload the course thumbnail image",
                                    style: TextStyle(color: Colors.lightBlue),
                                  )
                                : Container(),
                          ],
                        )),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25),
                          child: TextFormField(
                              controller: _coursetitle,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "this field cannot be empty";
                                }
                              },
                              decoration: InputDecoration(
                                hintText: 'Course titile',
                                contentPadding: EdgeInsets.all(15.0),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ))),
                      SizedBox(
                        height: 15,
                      ),
                      Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25),
                          child: TextFormField(
                              controller: _coursedescription,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "this field cannot be empty";
                                }
                              },
                              minLines: 5,
                              maxLines: 10,
                              decoration: InputDecoration(
                                hintText: 'Course Description',
                                contentPadding: EdgeInsets.all(15.0),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ))),
                      SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      ListView.builder(
                          shrinkWrap: true,
                          physics: ScrollPhysics(),
                          itemCount: dynamicwidget.length,
                          itemBuilder: (context, index) =>
                              dynamicwidget[index]),
                       AvatarGlow(
                        endRadius: 30, glowColor: Colors.lightBlue, duration: Duration(milliseconds: 5000),repeatPauseDuration: Duration(milliseconds: 1000),
                        child: IconButton(
                            onPressed: () {
                              //getvideos();
                              setState(() {
                                // iswidgetvissible = true;
                                adddynamic();
                              });
                            },
                            icon: Icon(Icons.add,color: Colors.deepOrange,)),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      MaterialButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                        onPressed: () {
                          if (file == null && video?.name == null) {
                            Fluttertoast.showToast(
                                msg: 'Incomplete Course creation ',
                                backgroundColor: Colors.lightBlue,
                                textColor: Colors.white);
                          } else {
                            uploadcourse();
                          }
                        },
                        color: file == null && video?.name == null
                            ? Colors.grey
                            : Colors.lightBlue,
                        child: Text(
                          "Uploade Course",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> uploadcourse() async {
    if (_formkey.currentState!.validate()) {
      try {
        FirebaseFirestore firestore = FirebaseFirestore.instance;
        User? user = auth.currentUser;
        final image = File(file!.path!);

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

        Reference thumbref = FirebaseStorage.instance
            .ref("Users")
            .child(user!.uid)
            .child("Course")
            .child("thumbnail")
            .child(file!.name);
        uploadTask = thumbref.putFile(image);
        ;
        final snapshot = await uploadTask!.whenComplete(() => {});
        thumburl = await thumbref.getDownloadURL();

        String docid = firestore
            .collection("Users")
            .doc(user.uid)
            .collection("Course")
            .doc()
            .id;

        await FirebaseFirestore.instance
            .collection("Users")
            .doc(user.uid)
            .collection("Course")
            .doc(docid)
            .set({
          'coursetitle': _coursetitle.text,
          'desc': _coursedescription.text,
          'docid': docid,
          'timestamp': DateTime.now().toString(),
          'price': null,
          'OwnerId' : user.uid,
          'thumbnail': thumburl
        },SetOptions(merge: true));

        for (var widget in dynamicwidget) {
          final videoref = File(widget.video!.path!);
          Reference vidref = FirebaseStorage.instance
              .ref("Users")
              .child(user.uid)
              .child("Course")
              .child('videos')
              .child(widget.video!.name);
          if (widget.video != null) {
            await vidref.putFile(videoref);
            vidurl = await vidref.getDownloadURL();
          } else if (widget.video == null) {
            Navigator.of(context).pop();
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    content: Text("You did not select a video"),
                  );
                });
          }
          if (widget.video!.name == null) {
            print('there is nothing');
          }

          await FirebaseFirestore.instance
              .collection("Users")
              .doc(user.uid)
              .collection("Course")
              .doc(docid)
              .collection("videolessons")
              .doc()
              .set({
            'Chaptitle': widget.video!.name,
            'vidurl': vidurl,
            'courseid': docid
          });
        }

        Navigator.of(context).pop();

        SnackBar(
          content: Text("Course is uploaded"),
          duration: Duration(milliseconds: 600),
        );
      } catch (e) {
        Fluttertoast.showToast(msg: '$e');
      }
    }
  }
}
