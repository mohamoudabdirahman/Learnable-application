// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:learnable/UI/util/listviewbuilder.dart';
import 'package:learnable/pageviewpages/coursedetails1.dart';
import 'package:learnable/usermodel/user_model.dart';

class Videolessons extends StatefulWidget {
  const Videolessons({Key? key}) : super(key: key);

  @override
  State<Videolessons> createState() => _VideolessonsState();
}

class _VideolessonsState extends State<Videolessons> {
  needcontrollers() {
    Coursedetailspageone(
      description: description,
      title: title,
      image: _image,
    );
  }

  File? video;
  String? vidurl;
  final TextEditingController chaptitle = TextEditingController();

  FirebaseAuth _auth = FirebaseAuth.instance;
  TextEditingController title = TextEditingController();
  TextEditingController description = TextEditingController();

  File? _image;
  String? thumburl;

  bool iswidgetvisible = false;

  Future videoPickerMethod() async {
    final pick = await ImagePicker().pickVideo(source: ImageSource.gallery);

    setState(() {
      if (pick != null) {
        video = File(pick.path);
      } else {
        showSnackBar("Something went wrong", Duration(microseconds: 400));
      }
    });
  }

  List<Widget> listdynamic = [];

  adddynamic() {
    listdynamic.add(CreateCourse(
      video: video,
      vidurl: vidurl,
      chaptitle: chaptitle,
    ));
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 50.0, right: 24.0, left: 24.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  "Chapters of the course",
                  style: TextStyle(fontSize: 15, color: Colors.white),
                ),
                SizedBox(
                  height: 5.0,
                ),
                ListView.builder(
                    physics: ScrollPhysics(parent: null),
                    shrinkWrap: true,
                    itemCount: listdynamic.length,
                    itemBuilder: ((context, index) => listdynamic[index])),
                // iswidgetvisible
                //     ? Column(
                //         children: [
                //           CreateCourse(),
                //           CreateCourse(),
                //           CreateCourse(),
                //           CreateCourse(),
                //           CreateCourse(),
                //           CreateCourse(),
                //           CreateCourse(),
                //           CreateCourse(),
                //         ],
                //       )
                //     : Container(),
                IconButton(
                    onPressed: () {
                      setState(() {
                        iswidgetvisible = true;
                        //videoPickerMethod();
                        adddynamic();
                      });
                      //CreateCourse();
                    },
                    icon: Icon(
                      Icons.add,
                      color: Colors.white,
                    )),
              ],
            ),
          ),
        ),
        MaterialButton(
          onPressed: () {
            uploadCoursedetails();
          },
          color: Colors.white,
          child: Text("Upload course"),
        ),
      ],
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

  uploadCoursedetails() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;
    CourseModel coursemodel = CourseModel();

    ChapterModel chapterModel = ChapterModel();

    Reference thumbref = FirebaseStorage.instance
        .ref("Users")
        .child(user!.uid)
        .child("Course")
        .child("details/thumbnail");
    await thumbref.putFile(_image!);
    thumburl = await thumbref.getDownloadURL();

    Reference vidref =
        FirebaseStorage.instance.ref("Users").child(user.uid).child("Course");
    if (video != null) {
      await vidref.putFile(video!);
      vidurl = await vidref.getDownloadURL();
    }
    if (video == null) {
      print("video is null");
    }

    coursemodel.coursetitle = title.text;
    coursemodel.desc = description.text;
    coursemodel.thumbnail = thumburl;
    chapterModel.chaptertitle = chaptitle.text;

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
      'coursetitle': title.text,
      'desc': description.text,
      'docid': docid,
      'timestamp': TimeOfDay.now().toString(),
      'price': null,
      'thumbnail': thumburl
    });
    print(docid);

    // FirebaseFirestore.instance
    //     .collection("Users")
    //     .doc(user.uid)
    //     .collection("Course")
    //     .doc(docid)
    //     .collection("videoessons")
    //     .doc()
    //     .set(chapterModel.toMap());

    DocumentReference docref = await FirebaseFirestore.instance
        .collection("Users")
        .doc(user.uid)
        .collection("Course")
        .doc(docid)
        .collection("videolessons")
        .add({'chaptitle': title.text, 'vidurl': vidurl});

    print("video is uploaded");

    showSnackBar("it is been uploaded", Duration(milliseconds: 600));
  }
}
