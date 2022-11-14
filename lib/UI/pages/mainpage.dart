// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:learnable/UI/util/Courseplaying.dart';
import 'package:learnable/usermodel/user_model.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_icons/weather_icons.dart';

class Mainpage extends StatefulWidget {
  String? obtainedcourse;
  String? obtaineddesc;
  Mainpage({Key? key, this.obtainedcourse, this.obtaineddesc})
      : super(key: key);

  @override
  _MainpageState createState() => _MainpageState();
}

class _MainpageState extends State<Mainpage> {
  String? imageurl;
  String? lastname;
  String? profilepic;
  FirebaseAuth user = FirebaseAuth.instance;
  String? formatedate;
  bool? iswishlisted = false;
  String? bookmarkedcourse;
  String? coursename;
  bool? isbookmarked;
  Bookmarks bookmarks = Bookmarks();
  Bookmarks obtainedcourse = Bookmarks();
  String? coursenames;
  final auth = FirebaseAuth.instance;
  List<QueryDocumentSnapshot<Map<String, dynamic>>>? result;
  String? time;
  String? picurl;
  String? docid;
  String? parentcourse;
  String? firstname;
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   User? user = auth.currentUser;
  //   FirebaseFirestore.instance
  //       .collection('Users')
  //       .doc(user!.uid)
  //       .collection('Wishlists')
  //       .get()
  //       .then((value) {
  //     //obtainedcourse = Bookmarks.fromMap(value.docs);
  //     if (value.docs.isNotEmpty) {
  //       result = value.docs;
  //     } else {}
  //     setState(() {});
  //     //print(result[0]['Course']);
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.white,
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                              color: Colors.grey.shade800.withOpacity(0.1),
                              offset: Offset(3, 3),
                              blurRadius: 8,
                            ),
                            BoxShadow(
                              color: Color.fromARGB(137, 255, 255, 255)
                                  .withOpacity(0.1),
                              offset: Offset(-3, -3),
                              blurRadius: 8,
                            ),
                          ]),
                      child: Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Image.asset(
                          "lib/images/learnable-blue.png",
                          height: 40,
                          color: Colors.lightBlue,
                        ),
                      )),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.white,
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                            color: Colors.grey.shade800.withOpacity(0.1),
                            offset: Offset(3, 3),
                            blurRadius: 8,
                          ),
                          BoxShadow(
                            color: Color.fromARGB(137, 255, 255, 255)
                                .withOpacity(0.1),
                            offset: Offset(-3, -3),
                            blurRadius: 8,
                          ),
                        ]),
                    child: IconButton(
                        onPressed: () {},
                        icon: Icon(
                          FontAwesomeIcons.solidBell,
                          color: Colors.lightBlue,
                        )),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              width: 354,
              height: 203,
              decoration: BoxDecoration(
                color: Colors.lightBlue,
                borderRadius: BorderRadius.circular(22),
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 30, right: 15, left: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    gettime(),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "What do you want to learn today?",
                      style: TextStyle(fontSize: 14, color: Colors.white70),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Recent Courses",
                    style: TextStyle(fontSize: 24, color: Colors.lightBlue),
                  ),
                  Text(
                    "View all",
                    style: TextStyle(fontSize: 14, color: Colors.lightBlue),
                  )
                ],
              ),
            ),
            SizedBox(
                height: 300,
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('Users')
                      .where('Isinstructor', isEqualTo: true)
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    String? useridentity = snapshot.data?.docs[0]['uid'];

                    if (snapshot.hasData) {
                      return ListView.builder(
                        itemCount: snapshot.data?.docs.length,
                        itemBuilder: (contex, index) {
                          String? useridentity =
                              snapshot.data?.docs[index]['uid'];
                          firstname = snapshot.data?.docs[index]['First Name'];
                          // print(firstname);
                          lastname = snapshot.data?.docs[index]['Last Name'];
                          //print(lastname);
                          return StreamBuilder(
                              stream: FirebaseFirestore.instance
                                  .collection('Users')
                                  .doc(useridentity)
                                  .collection('Course')
                                  .snapshots(),
                              builder: (BuildContext context,
                                  AsyncSnapshot<QuerySnapshot> snapshot) {
                                if (snapshot.hasData) {
                                  int number = snapshot.data!.docs.length;
                                  return ListView.builder(
                                      scrollDirection: Axis.vertical,
                                      shrinkWrap: true,
                                      itemCount: number,
                                      itemBuilder: (context, index) {
                                        parentcourse =
                                            snapshot.data?.docs[index]['docid'];
                                        docid = snapshot.data!.docs[index]
                                            ['OwnerId'];
                                        print(docid);
                                        imageurl = snapshot.data?.docs[index]
                                            ['coursetitle'];

                                        coursename = snapshot.data?.docs[index]
                                            ['coursetitle'];
                                        time = snapshot.data?.docs[index]
                                            ['timestamp'];
                                        picurl = snapshot.data?.docs[index]
                                            ['thumbnail'];
                                        var timestamp = snapshot
                                            .data?.docs[index]['timestamp'];

                                        var date = DateTime.parse(timestamp);
                                        formatedate = (DateFormat('yyy')
                                            .format(date.toUtc()));

                                        return Padding(
                                            padding: const EdgeInsets.only(
                                                top: 20, right: 20, left: 20),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  boxShadow: [
                                                    BoxShadow(
                                                        color: Colors.grey
                                                            .withOpacity(0.3),
                                                        offset: Offset(3, 4),
                                                        spreadRadius: 1.0,
                                                        blurRadius: 9.0),
                                                  ],
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20)),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: ListTile(
                                                  onTap: (() {
                                                    //print(docid);
                                                    setState(() {
                                                      Navigator.pushReplacement(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder:
                                                                  (context) =>
                                                                      Courseplay(
                                                                        docid:
                                                                            snapshot
                                                                            .data!
                                                                            .docs[index]['docid'],
                                                                        ownid: snapshot
                                                                            .data!
                                                                            .docs[index]['OwnerId'],
                                                                        coursetitle: snapshot
                                                                            .data!
                                                                            .docs[index]['coursetitle'],
                                                                        description: snapshot
                                                                            .data!
                                                                            .docs[index]['desc'],
                                                                        courseid: snapshot
                                                                            .data!
                                                                            .docs[index]['docid'],
                                                                      )));
                                                    });
                                                  }),
                                                  leading: Container(
                                                      width: 90,
                                                      height: 70,
                                                      decoration: BoxDecoration(
                                                          color:
                                                              Colors.lightBlue,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10)),
                                                      child: ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          child:
                                                              CachedNetworkImage(
                                                            imageUrl:
                                                                '${snapshot.data?.docs[index]['thumbnail']}',
                                                            height: 70,
                                                            width: 90,
                                                            maxHeightDiskCache:
                                                                250,
                                                            fit: BoxFit.cover,
                                                            errorWidget:
                                                                (context, url,
                                                                    error) {
                                                              return Center(
                                                                child: Icon(
                                                                  Icons.error,
                                                                  color: Colors
                                                                      .red,
                                                                ),
                                                              );
                                                            },
                                                            placeholder: (context,
                                                                    imageurl) =>
                                                                Center(
                                                                    child: SizedBox(
                                                                        height: 50,
                                                                        width: 50,
                                                                        child: LoadingIndicator(
                                                                          indicatorType:
                                                                              Indicator.ballRotateChase,
                                                                          colors: [
                                                                            Colors.white
                                                                          ],
                                                                        ))),
                                                          ))),
                                                  title: Text(
                                                      "${snapshot.data!.docs[index]['coursetitle']}",
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                          fontSize: 18,
                                                          color: Colors
                                                              .lightBlue)),
                                                  subtitle: Text(
                                                      formatedate.toString(),
                                                      style: TextStyle(
                                                          fontSize: 13,
                                                          color: Colors.grey)),
                                                ),
                                              ),
                                            ));
                                      });
                                }
                                return Center(
                                  child: SizedBox(
                                      height: 60,
                                      width: 60,
                                      child: LoadingIndicator(
                                          indicatorType:
                                              Indicator.ballRotateChase)),
                                );
                              });
                        },
                      );
                    }
                    return Container();
                  },
                ))
          ],
        ),
      ),
    ));
  }

  // void savebookmark() async {
  //   String docid = FirebaseFirestore.instance
  //       .collection("Users")
  //       .doc(user.currentUser!.uid)
  //       .collection("Wishlists")
  //       .doc()
  //       .id;
  //   isbookmarked = bookmarks.isbookmarked = true;
  //   coursenames = bookmarks.coursename = coursename;
  //   bookmarks.documentid = docid;
  //   bookmarks.timestamp = time;
  //   bookmarks.thumburl = picurl;
  //   await FirebaseFirestore.instance
  //       .collection('Users')
  //       .doc(user.currentUser!.uid)
  //       .collection('Wishlists')
  //       .doc(docid)
  //       .set(bookmarks.toMap());
  // }

  gettime() {
    var hour = TimeOfDay.now().hour;

    if (hour < 12) {
      return Row(
        children: [
          Text("Good Morning",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30.0,
                color: Colors.white,
              )),
          SizedBox(
            width: 20,
          ),
          BoxedIcon(WeatherIcons.day_sunny, color: Colors.white)
        ],
      );
    } else if (hour < 17) {
      return Row(
        children: [
          Text("Good Afternoon",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30.0,
                color: Colors.white,
              )),
          SizedBox(
            width: 20,
          ),
          BoxedIcon(
            WeatherIcons.day_sunny_overcast,
            color: Colors.white,
          )
        ],
      );
    } else {
      return Row(
        children: [
          Text("Good Afternoon",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30.0,
                color: Colors.white,
              )),
          SizedBox(
            width: 10,
          ),
          BoxedIcon(
            WeatherIcons.night_clear,
            color: Colors.white,
          )
        ],
      );
    }
  }
}
