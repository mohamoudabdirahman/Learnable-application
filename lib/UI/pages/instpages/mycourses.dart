// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:learnable/usermodel/user_model.dart';

class MyCourses extends StatefulWidget {
  const MyCourses({Key? key}) : super(key: key);

  @override
  State<MyCourses> createState() => _MyCoursesState();
}

class _MyCoursesState extends State<MyCourses> {
  User? user = FirebaseAuth.instance.currentUser;
  CourseModel data = CourseModel();
  ChapterModel lesson = ChapterModel();

  String docid = FirebaseFirestore.instance.collection("Course").doc().id;

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   FirebaseFirestore.instance
  //       .collection("Users")
  //       .doc(user!.uid)
  //       .collection("Course")
  //       .doc(docid)
  //       .get()
  //       .then((value) {
  //     data = CourseModel.fromMap(value.data());

  //     FirebaseFirestore.instance
  //         .collection("Users")
  //         .doc(user!.uid)
  //         .collection("Course")
  //         .doc(docid)
  //         .collection("videolessons")
  //         .doc()
  //         .get()
  //         .then(
  //       (value) {
  //         lesson = ChapterModel.fromMap(value.data());
  //         print(lesson.videolesson);
  //       },
  //     );

  //     setState(() {});
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GestureDetector(
            onTap: () {},
            child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("Users")
                    .doc(user!.uid)
                    .collection("Course")
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (snapshot.hasError) {
                    return Center(
                      child: AlertDialog(
                        title: Text("Error"),
                        content: Text("Something went wrong"),
                      ),
                    );
                  }
                  if (snapshot.hasData) {
                    return ListView.builder(
                        itemCount: 4,
                        itemBuilder: (context, index) {
                          return Container(
                            child: Row(
                              children: [
                               Text("${snapshot.data!.docs[index]['coursetitle']}")
                                
                              ],
                            ),
                          );
                          
                        });
                  }
                  return CircularProgressIndicator();
                })));
  }
}
