// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:learnable/UI/updatecourse.dart';
import 'package:learnable/usermodel/user_model.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:cached_network_image/cached_network_image.dart';

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

  var timestamp;

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
        appBar: AppBar(
          title: Text('My Courses'),
          centerTitle: true,
        ),
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
                      child: SizedBox(
                          height: 50,
                          width: 50,
                          child: LoadingIndicator(
                            indicatorType: Indicator.ballRotateChase,
                          )),
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
                  if (!snapshot.hasData) {
                    return Center(
                      child: Text('sucks'),
                    );
                  }

                  if (snapshot.data?.size == 0) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '🙄',
                            style: TextStyle(fontSize: 30),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text('There are no courses yet'),
                        ],
                      ),
                    );
                  }
                  if (snapshot.hasData) {
                    return ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          String? thumb =
                              snapshot.data!.docs[index]['thumbnail'];
                          String? docid = snapshot.data!.docs[index]['docid'];
                          return Padding(
                            padding: const EdgeInsets.only(
                                top: 20, right: 20, left: 20),
                            child: Slidable(
                              endActionPane: ActionPane(
                                  motion: const ScrollMotion(),
                                  children: [
                                    SlidableAction(
                                      onPressed: ((context) {
                                        setState(() {
                                          showDialog(
                                              context: (context),
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20)),
                                                  title: Text('Delete'),
                                                  content: Text(
                                                      'Are you sure you want to delete this course?'),
                                                  actions: [
                                                    TextButton(
                                                        onPressed: () async {
                                                          FirebaseFirestore
                                                              .instance
                                                              .collection(
                                                                  'Users')
                                                              .doc(user!.uid)
                                                              .collection(
                                                                  'Course')
                                                              .doc(docid)
                                                              .delete();

                                                          
                                                              FirebaseFirestore
                                                                  .instance
                                                                  .collection(
                                                                      'Users')
                                                                  .doc(
                                                                      user!.uid)
                                                                  .collection(
                                                                      'Course')
                                                                  .doc(docid)
                                                                  .collection(
                                                                      'videolessons')
                                                                  .doc()
                                                                  .delete();

                                                         

                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child: Text('Yes')),
                                                    TextButton(
                                                        onPressed: () {
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child: Text('No'))
                                                  ],
                                                );
                                              });
                                        });
                                      }),
                                      backgroundColor: Colors.transparent,
                                      foregroundColor: Colors.red,
                                      icon: Icons.delete,
                                      label: 'Delete',
                                    ),
                                    SlidableAction(
                                      onPressed: ((context) {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    Updatecourse(
                                                        thumbnailurl: thumb,
                                                        courseid: snapshot.data!
                                                                .docs[index]
                                                            ['docid'])));
                                      }),
                                      backgroundColor: Colors.transparent,
                                      foregroundColor: Colors.lightBlue,
                                      icon: FontAwesomeIcons.pen,
                                      label: 'Update',
                                    ),
                                  ]),
                              child: Container(
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 1, color: Colors.lightBlue),
                                    borderRadius: BorderRadius.circular(20)),
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 90,
                                        height: 70,
                                        decoration: BoxDecoration(
                                            color: Colors.lightBlue,
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            child: CachedNetworkImage(
                                              imageUrl: '$thumb',
                                              height: 70,
                                              width: 90,
                                              maxHeightDiskCache: 250,
                                              fit: BoxFit.cover,
                                              errorWidget:
                                                  (context, url, error) =>
                                                      Center(
                                                child: Icon(
                                                  Icons.error,
                                                  color: Colors.red,
                                                ),
                                              ),
                                              placeholder:
                                                  (context, imageurl) => Center(
                                                      child: SizedBox(
                                                          height: 50,
                                                          width: 50,
                                                          child:
                                                              LoadingIndicator(
                                                            indicatorType: Indicator
                                                                .ballRotateChase,
                                                            colors: [
                                                              Colors.white
                                                            ],
                                                          ))),
                                            )),
                                      ),
                                      SizedBox(
                                        width: 10.0,
                                      ),
                                      Flexible(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                                "${snapshot.data!.docs[index]['coursetitle']}",
                                                overflow: TextOverflow.fade,
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    color: Colors.lightBlue)),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                                "${snapshot.data!.docs[index]['timestamp']}",
                                                style: TextStyle(
                                                    fontSize: 13,
                                                    color: Colors.grey)),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        });
                  }
                  return LoadingIndicator(
                    indicatorType: Indicator.ballRotateChase,
                  );
                })));
  }
}
