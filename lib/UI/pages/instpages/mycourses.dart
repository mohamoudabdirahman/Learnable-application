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
                  if (!snapshot.hasData) {
                    return Center(
                      child: AlertDialog(
                        title: Text("Error"),
                        content: Text("There is no Courses Yet"),
                      ),
                    );
                  }
                  if (snapshot.hasData) {
                    return ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(
                                top: 40, right: 20, left: 20),
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
                                          child: Image.network(
                                            "${snapshot.data!.docs[index]['thumbnail']}",
                                            errorBuilder:
                                                ((context, error, stackTrace) {
                                              return Icon(Icons.do_not_disturb);
                                            }),
                                            fit: BoxFit.cover,
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
                          );
                        });
                  }
                  return CircularProgressIndicator();
                })));
  }
}
