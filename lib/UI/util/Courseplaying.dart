// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:learnable/UI/homescreen.dart';
import 'package:learnable/UI/pages/mainpage.dart';
import 'package:learnable/usermodel/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';

class Courseplay extends StatefulWidget {
  String? coursetitle;
  String? description;
  String? firstname;
  Courseplay(
      {Key? key,
      required this.coursetitle,
      required this.description,
      required this.firstname})
      : super(key: key);

  @override
  State<Courseplay> createState() => _CourseplayState();
}

class _CourseplayState extends State<Courseplay> {
  User? user = FirebaseAuth.instance.currentUser;
  VideoPlayerController? _playerController;
  ChapterModel currentvideo = ChapterModel();
  String? obtainedname;
  // Mainpage mainpage = Mainpage();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getname() {
      Mainpage(
        obtainedcourse: obtainedname,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: ((context) => Homescreen())));
              },
              icon: Icon(Icons.arrow_back))),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 10, right: 15, left: 15),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 377,
                  height: 247,
                  decoration: BoxDecoration(
                      color: Colors.lightBlue,
                      borderRadius: BorderRadius.circular(25)),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  widget.coursetitle.toString(),
                  style: TextStyle(color: Colors.lightBlue, fontSize: 18),
                ),
                SizedBox(
                  height: 25,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.firstname.toString(),
                          style:
                              TextStyle(color: Colors.lightBlue, fontSize: 18),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    MaterialButton(
                      onPressed: () {},
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)),
                      minWidth: 60,
                      height: 30,
                      color: Colors.lightBlue,
                      child: Text(
                        'Enroll',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Divider(
                  color: Colors.lightBlue,
                  thickness: 0.3,
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  widget.description.toString(),
                  style: TextStyle(color: Colors.lightBlue, fontSize: 18),
                ),
                SizedBox(
                  height: 20,
                ),
                Text('lorem50'),

                //data of the videos
                StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('Users')
                        .where('Isinstructor', isEqualTo: true)
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (!snapshot.hasData) {
                        print('no user data');
                      }
                      if (snapshot.hasData) {
                        if (snapshot.data!.docs[0]['First Name'] ==
                            widget.firstname.toString()) {
                          return StreamBuilder(
                              stream: FirebaseFirestore.instance
                                  .collectionGroup('Course')
                                  .snapshots(),
                              builder: (BuildContext context,
                                  AsyncSnapshot<QuerySnapshot> snapshot) {
                                if (snapshot.hasData) {
                                  if(snapshot.data!.docs[0]['coursetitle'] == widget.coursetitle.toString()) {
                                    return  Text(
                                            '${snapshot.data!.docs[0]['desc']}');
                                  }
                                  // return ListView.builder(
                                  //     itemCount: snapshot.data!.docs.length,
                                  //     itemBuilder: ((context, index) {
                                  //       return
                                  //       //  Container(
                                  //       //   height: 400,

                                  //       //   child: Container(
                                  //       //     decoration: BoxDecoration(
                                  //       //         color: Colors.white,
                                  //       //         boxShadow: [
                                  //       //           BoxShadow(
                                  //       //               color: Colors.grey
                                  //       //                   .withOpacity(0.3),
                                  //       //               offset: Offset(3, 4),
                                  //       //               spreadRadius: 1.0,
                                  //       //               blurRadius: 9.0),
                                  //       //         ],
                                  //       //         borderRadius:
                                  //       //             BorderRadius.circular(20)),
                                  //       //     child: Padding(
                                  //       //       padding: const EdgeInsets.all(10.0),
                                  //       //       child: Row(
                                  //       //         children: [
                                  //       //           Container(
                                  //       //               width: 90,
                                  //       //               height: 70,
                                  //       //               decoration: BoxDecoration(
                                  //       //                   color: Colors.lightBlue,
                                  //       //                   borderRadius:
                                  //       //                       BorderRadius
                                  //       //                           .circular(10)),
                                  //       //               child: ClipRRect(
                                  //       //                   borderRadius:
                                  //       //                       BorderRadius
                                  //       //                           .circular(10),
                                  //       //                   child: Icon(Icons
                                  //       //                       .play_circle))),
                                  //       //           SizedBox(
                                  //       //             width: 10.0,
                                  //       //           ),
                                  //       //           Flexible(
                                  //       //             child: Column(
                                  //       //               crossAxisAlignment:
                                  //       //                   CrossAxisAlignment
                                  //       //                       .start,
                                  //       //               children: [
                                  //       //                 Text(
                                  //       //                     "${snapshot.data!.docs[index]['Chaptitle']}",
                                  //       //                     overflow:
                                  //       //                         TextOverflow.fade,
                                  //       //                     style: TextStyle(
                                  //       //                         fontSize: 20,
                                  //       //                         color: Colors
                                  //       //                             .lightBlue)),
                                  //       //                 SizedBox(
                                  //       //                   height: 10,
                                  //       //                 ),
                                  //       //                 // Text(
                                  //       //                 //     "${snapshot.data!.docs[index]['timestamp']}",
                                  //       //                 //     style: TextStyle(
                                  //       //                 //         fontSize: 13,
                                  //       //                 //         color: Colors
                                  //       //                 //             .grey)),
                                  //       //               ],
                                  //       //             ),
                                  //       //           )
                                  //       //         ],
                                  //       //       ),
                                  //       //     ),
                                  //       //   ),
                                  //       // );
                                  //     }));
                                }
                                return CircularProgressIndicator();
                              });
                        }
                      }
                      return Container();
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
