// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_brace_in_string_interps

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:learnable/UI/homescreen.dart';
import 'package:learnable/UI/pages/mainpage.dart';
import 'package:learnable/usermodel/user_model.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';

class Courseplay extends StatefulWidget {
  String? coursetitle;
  String? description;

  String? courseid;

  String? ownid;
  String? docid;
  Courseplay(
      {Key? key,
      required this.coursetitle,
      required this.description,
      required this.courseid,
      required this.ownid,
      required this.docid})
      : super(key: key);

  @override
  State<Courseplay> createState() => _CourseplayState();
}

class _CourseplayState extends State<Courseplay> {
  User? user = FirebaseAuth.instance.currentUser;
  VideoPlayerController? _playerController;
  ChapterModel currentvideo = ChapterModel();
  String? obtainedname;
  String? imageurl;
  bool shouldpop = true;
  List<QueryDocumentSnapshot<Map<String, dynamic>>>? data;
  bool isplayed = false;
  var actualvido;
  VideoPlayerController? _controller;
  bool? ontouch = false;
  bool _isplaying = false;
  bool _dispose = false;
  int? ind;
  int _isplayingindex = -1;
  int? number;
  bool? isbuffered;
  bool isfullscreen = false;
  bool isenrolled = false;
  bool isliked = false;
  bool? nolikes;
  String? docsid;
  String? documentsid;
  bool? enrollment;
  bool? likes;
  List<QueryDocumentSnapshot<Map<String, dynamic>>>? result;
  // Mainpage mainpage = Mainpage();

  @override
  void dispose() {
    // TODO: implement dispose
    _dispose = true;
    _controller?.pause();
    _controller?.dispose();
    _controller == null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          leading: IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Homescreen()));
              },
              icon: Icon(Icons.arrow_back_ios_rounded)),
        ),
        body: isfullscreen == true
            ? fullscreen()
            : SafeArea(
                child: SingleChildScrollView(
                  child: Stack(
                      // fit: isfullscreen == true ? StackFit.expand : StackFit.loose,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                                width: MediaQuery.of(context).size.width,
                                height: 221,
                                decoration: BoxDecoration(
                                  color: Colors.lightBlue,
                                ),
                                child: isplayed == true
                                    ? playingvideos(context)
                                    : Center(
                                        child: GestureDetector(
                                          onTap: () {},
                                          child: Image.asset(
                                            'lib/images/play.png',
                                            color: Colors.white,
                                          ),
                                        ),
                                      )),
                            SizedBox(
                              height: 20,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Text(
                                widget.coursetitle.toString(),
                                style: TextStyle(
                                    color: Colors.lightBlue, fontSize: 18),
                              ),
                            ),
                            SizedBox(
                              height: 25,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  StreamBuilder(
                                      stream: FirebaseFirestore.instance
                                          .collection('Users')
                                          .doc(user!.uid)
                                          .collection('Enrolled Courses')
                                          .snapshots(),
                                      builder: (BuildContext context,
                                          AsyncSnapshot<QuerySnapshot>
                                              snapshot) {
                                        if (snapshot.hasData) {
                                          if (snapshot != null) {
                                            enrollment = snapshot.data?.docs[0]
                                                ['IseEnrolled'];
                                          }

                                          return Row(
                                            children: [
                                              Container(
                                                  width: 40,
                                                  height: 40,
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    shape: BoxShape.circle,
                                                    boxShadow: [
                                                      BoxShadow(
                                                          color:
                                                              (Color.fromRGBO(
                                                                  117,
                                                                  117,
                                                                  117,
                                                                  0.527)),
                                                          offset:
                                                              Offset(1.0, 1.0),
                                                          blurRadius: 8.0,
                                                          spreadRadius: 0.4),
                                                      BoxShadow(
                                                          color: Colors.white,
                                                          offset: Offset(
                                                              -2.0, -2.0),
                                                          blurRadius: 8.0,
                                                          spreadRadius: 0.3),
                                                    ],
                                                    gradient: LinearGradient(
                                                      begin: Alignment.topLeft,
                                                      end:
                                                          Alignment.bottomRight,
                                                      colors: [
                                                        (Color.fromRGBO(238,
                                                            238, 238, 0.397)),
                                                        (Color.fromARGB(129,
                                                            255, 255, 255)),
                                                      ],
                                                    ),
                                                  ),
                                                  child: Icon(
                                                    Icons.people,
                                                    color: Colors.lightBlue,
                                                  )),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                '${snapshot.data!.docs.length} Students',
                                                style: TextStyle(
                                                    color: Colors.grey),
                                              )
                                            ],
                                          );
                                        }
                                        return Container();
                                      }),
                                  StreamBuilder(
                                      stream: FirebaseFirestore.instance
                                          .collection('Users')
                                          .doc(widget.ownid)
                                          .collection('Course')
                                          .doc(widget.docid)
                                          .collection('Likes')
                                          .snapshots(),
                                      builder: (BuildContext context,
                                          AsyncSnapshot<QuerySnapshot>
                                              snapshot) {
                                        if (snapshot.hasError) {
                                          return Container();
                                        }
                                        if (!snapshot.hasData) {
                                          return Container();
                                        }
                                        if (snapshot.hasData &&
                                            snapshot.data != null) {
                                          // docsid =
                                          //     snapshot.data!.docs[0]['cellid'];
                                          // likes =
                                          //     snapshot.data?.docs[0]['IsLiked'];
                                          return Row(
                                            children: [
                                              // Container(
                                              //     width: 40,
                                              //     height: 40,
                                              //     decoration: BoxDecoration(
                                              //       color: Colors.white,
                                              //       shape: BoxShape.circle,
                                              //       boxShadow: [
                                              //         BoxShadow(
                                              //             color:
                                              //                 (Color.fromRGBO(
                                              //                     117,
                                              //                     117,
                                              //                     117,
                                              //                     0.527)),
                                              //             offset:
                                              //                 Offset(1.0, 1.0),
                                              //             blurRadius: 8.0,
                                              //             spreadRadius: 0.4),
                                              //         BoxShadow(
                                              //             color: Colors.white,
                                              //             offset: Offset(
                                              //                 -2.0, -2.0),
                                              //             blurRadius: 8.0,
                                              //             spreadRadius: 0.3),
                                              //       ],
                                              //       gradient: LinearGradient(
                                              //         begin: Alignment.topLeft,
                                              //         end:
                                              //             Alignment.bottomRight,
                                              //         colors: [
                                              //           (Color.fromRGBO(238,
                                              //               238, 238, 0.397)),
                                              //           (Color.fromARGB(129,
                                              //               255, 255, 255)),
                                              //         ],
                                              //       ),
                                              //     ),
                                              //     child: IconButton(
                                              //         onPressed: () {
                                              //           if (isliked == false) {
                                              //             setState(() {
                                              //               isliked = true;
                                              //               likedcourse();
                                              //             });
                                              //           } else {
                                              //             if (isliked == true ||
                                              //                 likes == true) {
                                              //               setState(() {
                                              //                 isliked = false;
                                              //                 dislikedcourse();
                                              //               });
                                              //             }
                                              //           }
                                              //         },
                                              //         icon: Icon(Icons.favorite,
                                              //             color: isliked ==
                                              //                         true ||
                                              //                     likes == true
                                              //                 ? Colors.lightBlue
                                              //                 : Colors.grey))),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              // Text(
                                              //   '${snapshot.data?.docs.length} Likes',
                                              //   style: TextStyle(
                                              //       color: Colors.grey),
                                              // ),
                                            ],
                                          );
                                        }
                                        return Container();
                                      })
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'A course by',
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                  // MaterialButton(
                                  //   shape: RoundedRectangleBorder(
                                  //       borderRadius:
                                  //           BorderRadius.circular(12)),
                                  //   color:
                                  //       isenrolled == true && enrollment == true
                                  //           ? Colors.grey
                                  //           : Colors.lightBlue,
                                  //   onPressed: () {
                                  //     setState(() {
                                  //       if (isenrolled == false) {
                                  //         setState(() {
                                  //           isenrolled = true;
                                  //           erollcourse();
                                  //         });
                                  //         return;
                                  //       }
                                  //       if (isenrolled == true ||
                                  //           enrollment == true) {
                                  //         setState(() {
                                  //           isenrolled = true;
                                  //         });

                                  //         return;
                                  //       }
                                  //     });
                                  //   },
                                  //   child: isenrolled == true
                                  //       ? Icon(Icons.check)
                                  //       : Text(
                                  //           'Enroll',
                                  //           style: TextStyle(
                                  //               color: isenrolled == true &&
                                  //                       enrollment == true
                                  //                   ? Colors.grey
                                  //                   : Colors.white),
                                  //         ),
                                  // )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              child: Row(
                                children: [
                                  StreamBuilder(
                                      stream: FirebaseFirestore.instance
                                          .collection('Users')
                                          .where('uid', isEqualTo: widget.ownid)
                                          .snapshots(),
                                      builder: (BuildContext context,
                                          AsyncSnapshot<QuerySnapshot>
                                              snapshot) {
                                        if (snapshot.hasData) {
                                          return Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Container(
                                                    height: 60,
                                                    width: 60,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(50.0),
                                                        image: DecorationImage(
                                                            image: NetworkImage(
                                                                snapshot.data!
                                                                        .docs[0]
                                                                    [
                                                                    'downloadUrl']),
                                                            fit: BoxFit.fill),
                                                        boxShadow: [
                                                          BoxShadow(
                                                              //offset: Offset(-1, -1),
                                                              spreadRadius: -10,
                                                              blurRadius: 18.0,
                                                              color: Color
                                                                      .fromARGB(
                                                                          95,
                                                                          129,
                                                                          129,
                                                                          129)
                                                                  .withOpacity(
                                                                      0.2))
                                                        ]),
                                                  ),
                                                  SizedBox(
                                                    width: 15.0,
                                                  ),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                          '${snapshot.data!.docs[0]['First Name']} ${snapshot.data!.docs[0]['Last Name']}',
                                                          style: TextStyle(
                                                              fontSize: 17,
                                                              color:
                                                                  Colors.grey)),
                                                      SizedBox(
                                                        height: 10,
                                                      ),
                                                      Text(
                                                        '${snapshot.data!.docs[0]['Email']}',
                                                        style: TextStyle(
                                                            fontSize: 17,
                                                            color: Colors.grey),
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      )
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 20,
                                              ),
                                              Text(
                                                widget.description.toString(),
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.black,
                                                ),
                                                textAlign: TextAlign.left,
                                              ),
                                            ],
                                          );
                                        }
                                        return Center(
                                          child: SizedBox(
                                            height: 50,
                                            width: 50,
                                            child: LoadingIndicator(
                                                indicatorType:
                                                    Indicator.ballRotateChase),
                                          ),
                                        );
                                      })
                                ],
                              ),
                            ),
                            //data of the videos
                            SizedBox(
                              height: 300,
                              child: StreamBuilder(
                                  stream: FirebaseFirestore.instance
                                      .collection('Users')
                                      .doc(widget.ownid)
                                      .collection('Course')
                                      .doc(widget.docid)
                                      .collection('videolessons')
                                      .snapshots(),
                                  builder: (BuildContext context,
                                      AsyncSnapshot<QuerySnapshot> snapshot) {
                                    if (snapshot.hasData) {
                                      number = snapshot.data!.docs.length;

                                      return ListView.builder(
                                          shrinkWrap: true,
                                          physics: ScrollPhysics(),
                                          itemCount: number,
                                          itemBuilder: ((context, index) {
                                            return Container(
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                  color: Colors.white,
                                                  boxShadow: [
                                                    BoxShadow(
                                                        color: (Color.fromRGBO(
                                                            117,
                                                            117,
                                                            117,
                                                            0.527)),
                                                        offset:
                                                            Offset(1.0, 1.0),
                                                        blurRadius: 8.0,
                                                        spreadRadius: 0.4),
                                                    BoxShadow(
                                                        color: Colors.white,
                                                        offset:
                                                            Offset(-2.0, -2.0),
                                                        blurRadius: 8.0,
                                                        spreadRadius: 0.3),
                                                  ],
                                                  gradient: LinearGradient(
                                                    begin: Alignment.topLeft,
                                                    end: Alignment.bottomRight,
                                                    colors: [
                                                      (Color.fromRGBO(238, 238,
                                                          238, 0.397)),
                                                      (Color.fromARGB(
                                                          129, 255, 255, 255)),
                                                    ],
                                                  )),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 20.0),
                                                child: ListTile(
                                                  onTap: () {
                                                    setState(() {
                                                      ind = index;
                                                      actualvido =
                                                          snapshot.data!.docs;
                                                      playvid(index);
                                                      if (isplayed == false) {
                                                        isplayed = true;
                                                      }
                                                    });
                                                  },
                                                  leading: Container(
                                                      width: 96,
                                                      height: 63,
                                                      decoration: BoxDecoration(
                                                          border: Border.all(
                                                              width: 1,
                                                              color: Colors
                                                                  .lightBlue),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      12)),
                                                      child: Image.asset(
                                                        'lib/images/playv2.png',
                                                      )),
                                                  title: Text(
                                                      '${snapshot.data!.docs[index]['Chaptitle']}'),
                                                ),
                                              ),
                                            );
                                          }));
                                    } else {}
                                    return Center(
                                        child: CircularProgressIndicator());
                                  }),
                            )
                          ],
                        ),
                        isfullscreen == true ? fullscreen() : Container()
                      ]),
                ),
              ),
      ),
    );
  }

  Widget playingvideos(BuildContext context) {
    final controller = _controller;
    final noMute = (_controller?.value.volume ?? 0) > 0;
    if (controller != null && controller.value.isInitialized) {
      return Stack(children: [
        GestureDetector(
            onTap: () {
              if (ontouch == false) {
                setState(() {
                  ontouch = true;
                });
              } else if (ontouch == true) {
                setState(() {
                  ontouch = false;
                });
              }
            },
            child: AspectRatio(
                aspectRatio: 16 / 9, child: VideoPlayer(controller))),
        ontouch == true
            ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisAlignment: isfullscreen == true
                      ? MainAxisAlignment.spaceAround
                      : MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 90),
                      child: Row(
                        mainAxisAlignment: isfullscreen == true
                            ? MainAxisAlignment.spaceBetween
                            : MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                              onTap: () {
                                final index = _isplayingindex - 1;

                                if (index >= 0 && number! >= 0) {
                                  playvid(index);
                                } else {
                                  Fluttertoast.showToast(
                                      backgroundColor: Colors.lightBlue,
                                      textColor: Colors.white,
                                      msg: 'No videos ahead!');
                                }
                              },
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 40),
                                child:
                                    Image.asset('lib/images/fast_rewind.png'),
                              )),
                          GestureDetector(
                              onTap: () {
                                if (_isplaying) {
                                  setState(() {
                                    _isplaying = false;
                                    _controller?.pause();
                                  });
                                } else {
                                  setState(() {
                                    _isplaying = true;
                                    _controller?.play();
                                  });
                                }
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(left: 9),
                                child: _isplaying
                                    ? SizedBox(
                                        height: isfullscreen == true ? 70 : 50,
                                        child:
                                            Image.asset('lib/images/pause.png'))
                                    : SizedBox(
                                        height: isfullscreen == true ? 70 : 50,
                                        child:
                                            Image.asset('lib/images/play.png')),
                              )),
                          GestureDetector(
                              onTap: () {
                                final index = _isplayingindex + 1;

                                if (index <= number! - 1) {
                                  playvid(index);
                                } else {
                                  Fluttertoast.showToast(
                                      backgroundColor: Colors.lightBlue,
                                      textColor: Colors.white,
                                      msg:
                                          'You have watched all the videos! Congrats ✨');
                                }
                              },
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 40),
                                child:
                                    Image.asset('lib/images/fast_forward.png'),
                              ))
                        ],
                      ),
                    ),
                    Padding(
                      padding: isfullscreen == true
                          ? const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 5)
                          : const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                              onPressed: () {
                                if (noMute) {
                                  _controller?.setVolume(0);
                                } else {
                                  _controller?.setVolume(1.0);
                                }
                                setState(() {});
                              },
                              icon: Icon(
                                noMute ? Icons.volume_up : Icons.volume_off,
                                size: isfullscreen == true ? 70 : 20,
                                color: Colors.white,
                              )),
                          // IconButton(
                          //     onPressed: () {
                          //       setState(() {
                          //         if (isfullscreen == false) {
                          //           setState(() {
                          //             isfullscreen = true;
                          //           });
                          //         } else {
                          //           if (isfullscreen == true) {
                          //             setState(() {
                          //               isfullscreen = false;
                          //             });
                          //           }
                          //         }
                          //       });
                          //     },
                          //     icon: Icon(
                          //       Icons.fullscreen,
                          //       size: isfullscreen == true ? 70: 20,
                          //       color: Colors.white,
                          //     )),
                        ],
                      ),
                    ),
                    VideoProgressIndicator(
                      _controller!,
                      allowScrubbing: true,
                      colors: VideoProgressColors(
                          playedColor: Colors.lightBlue,
                          bufferedColor: Colors.red),
                    )
                  ],
                ),
              )
            : Container()
      ]);
    } else {
      return AbsorbPointer(
        absorbing: true,
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Center(
              child: SizedBox(
            height: 50,
            width: 50,
            child: LoadingIndicator(colors: [
              isfullscreen == true ? Colors.lightBlue : Colors.white
            ], indicatorType: Indicator.ballRotateChase),
          )),
        ),
      );
    }
  }

  Widget fullscreen() {
    final controller = _controller;
    final sized = controller?.value.size;
    final height = sized?.height;
    final width = sized?.width;
    if (controller != null) {
      return FittedBox(
        fit: BoxFit.cover,
        child: RotatedBox(
          quarterTurns: 1,
          child: SizedBox(
              height: height,
              width: width,
              child: Stack(children: [
                GestureDetector(
                    onTap: () {
                      if (_isplaying == false) {
                        setState(() {
                          _isplaying = true;
                        });
                      } else {
                        setState(() {
                          _isplaying = false;
                        });
                      }
                    },
                    child: VideoPlayer(_controller!)),
                _isplaying == true
                    ? playingvideos(context)
                    : AbsorbPointer(
                        absorbing: true,
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height,
                          child: Center(
                              child: SizedBox(
                            height: 50,
                            width: 50,
                            child: LoadingIndicator(colors: [
                              isfullscreen == true
                                  ? Colors.lightBlue
                                  : Colors.white
                            ], indicatorType: Indicator.ballRotateChase),
                          )),
                        ),
                      )
              ])),
        ),
      );
    } else {
      return Text('nothing');
    }
  }

  erollcourse() async {
    try {
      await FirebaseFirestore.instance
          .collection('Users')
          .doc(widget.ownid)
          .collection('Course')
          .doc(widget.docid)
          .collection('Students')
          .doc()
          .set({'StudentEmail': user!.email, 'IseEnrolled': true});

      await FirebaseFirestore.instance
          .collection('Users')
          .doc(user!.uid)
          .collection('Enrolled Courses')
          .doc()
          .set({'CourseName': widget.coursetitle, 'IseEnrolled': true});
    } on Exception catch (e) {
      Fluttertoast.showToast(msg: '$e');
    }
  }

  likedcourse() async {
    try {
      String documentssid = FirebaseFirestore.instance
          .collection("Users")
          .doc(widget.ownid)
          .collection("Course")
          .doc(widget.docid)
          .collection('Likes')
          .doc()
          .id;
      documentsid = documentssid;
      await FirebaseFirestore.instance
          .collection('Users')
          .doc(widget.ownid)
          .collection('Course')
          .doc(widget.docid)
          .collection('Likes')
          .doc(documentssid)
          .set({
        'LikedStudents': user!.email,
        'cellid': documentssid,
        'IsLiked': true
      });

      await FirebaseFirestore.instance
          .collection('Users')
          .doc(user!.uid)
          .collection('LikedCoures')
          .doc(documentssid)
          .set({
        'CourseName': widget.coursetitle,
        'cellid': documentssid,
        'IsLiked': true
      });
    } on Exception catch (e) {
      Fluttertoast.showToast(msg: '$e');
    }
  }

  dislikedcourse() async {
    try {
      await FirebaseFirestore.instance
          .collection('Users')
          .doc(widget.ownid)
          .collection('Course')
          .doc(widget.docid)
          .collection('Likes')
          .doc(documentsid)
          .delete();

      await FirebaseFirestore.instance
          .collection('Users')
          .doc(user!.uid)
          .collection('LikedCoures')
          .doc(documentsid)
          .delete();
    } on Exception catch (e) {
      // TODO
      Fluttertoast.showToast(msg: '$e');
    }
  }

  var _onUpdatecontrollerTime;
  void onupdatecontroller() async {
    if (_dispose) {
      return;
    }
    _onUpdatecontrollerTime = 0;
    final now = DateTime.now().millisecondsSinceEpoch;

    if (_onUpdatecontrollerTime > now) {
      return;
    }
    _onUpdatecontrollerTime = now + 500;
    final controller = _controller;
    if (controller == null) {
      //print('the controller is null');
      return;
    }
    if (!controller.value.isInitialized) {
      //print('controller is not initialized');
      return;
    }
    final playing = _isplaying;
  }

  playvid(int index) async {
    final controller =
        VideoPlayerController.network(actualvido[index]['vidurl']);
    final oldcon = _controller;
    _controller = controller;
    if (oldcon != null) {
      oldcon.removeListener(onupdatecontroller);
      oldcon.pause();
    }
    setState(() {});
    // ignore: avoid_single_cascade_in_expression_statements
    controller
      ..initialize().then((_) {
        oldcon?.dispose();
        isbuffered = controller.value.isBuffering;
        _isplayingindex = index;
        controller.addListener(() {
          onupdatecontroller();
        });
        controller.play();
        setState(() {});
      });
  }
}
