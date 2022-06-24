// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_brace_in_string_interps

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:learnable/UI/homescreen.dart';
import 'package:learnable/UI/pages/mainpage.dart';
import 'package:learnable/usermodel/user_model.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';

class Courseplay extends StatefulWidget {
  String? coursetitle;
  String? description;
  String? firstname;
  String? courseid;
  String? lastname;
  String? ownid;
  String? docid;
  Courseplay(
      {Key? key,
      required this.coursetitle,
      required this.description,
      required this.courseid,
      required this.firstname,
      required this.lastname,
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
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 247,
                  decoration: BoxDecoration(
                    color: Colors.lightBlue,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    widget.coursetitle.toString(),
                    style: TextStyle(color: Colors.lightBlue, fontSize: 18),
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                      color: (Color.fromRGBO(
                                          117, 117, 117, 0.527)),
                                      offset: Offset(1.0, 1.0),
                                      blurRadius: 8.0,
                                      spreadRadius: 0.4),
                                  BoxShadow(
                                      color: Colors.white,
                                      offset: Offset(-2.0, -2.0),
                                      blurRadius: 8.0,
                                      spreadRadius: 0.3),
                                ],
                                gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    (Color.fromRGBO(238, 238, 238, 0.397)),
                                    (Color.fromARGB(129, 255, 255, 255)),
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
                            '5.5k Students',
                            style: TextStyle(color: Colors.grey),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                      color: (Color.fromRGBO(
                                          117, 117, 117, 0.527)),
                                      offset: Offset(1.0, 1.0),
                                      blurRadius: 8.0,
                                      spreadRadius: 0.4),
                                  BoxShadow(
                                      color: Colors.white,
                                      offset: Offset(-2.0, -2.0),
                                      blurRadius: 8.0,
                                      spreadRadius: 0.3),
                                ],
                                gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    (Color.fromRGBO(238, 238, 238, 0.397)),
                                    (Color.fromARGB(129, 255, 255, 255)),
                                  ],
                                ),
                              ),
                              child: Icon(
                                Icons.favorite,
                                color: Colors.lightBlue,
                              )),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            '1300 likes',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text(
                    'A course by',
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    children: [
                      StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection('Users')
                              .where('uid', isEqualTo: widget.ownid)
                              .snapshots(),
                          builder: (BuildContext context,
                              AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (snapshot.hasData) {
                              String firstname =
                                  snapshot.data!.docs[0]['First Name'];
                              String lastname =
                                  snapshot.data!.docs[0]['Last Name'];
                              return Row(
                                children: [
                                  Container(
                                    height: 60,
                                    width: 60,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(50.0),
                                        image: DecorationImage(
                                            image: NetworkImage(snapshot
                                                .data!.docs[0]['downloadUrl']),
                                            fit: BoxFit.fill),
                                        boxShadow: [
                                          BoxShadow(
                                              //offset: Offset(-1, -1),
                                              spreadRadius: -10,
                                              blurRadius: 18.0,
                                              color: Color.fromARGB(
                                                      95, 129, 129, 129)
                                                  .withOpacity(0.2))
                                        ]),
                                  ),
                                  SizedBox(
                                    width: 15.0,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('$firstname $lastname',
                                          style: TextStyle(
                                              fontSize: 17,
                                              color: Colors.grey)),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        user!.email.toString(),
                                        style: TextStyle(
                                            fontSize: 17, color: Colors.grey),
                                        overflow: TextOverflow.ellipsis,
                                      )
                                    ],
                                  ),
                                ],
                              );
                            }
                            return Center(
                              child: SizedBox(
                                height: 50,
                                width: 50,
                                child: LoadingIndicator(
                                    indicatorType: Indicator.ballRotateChase),
                              ),
                            );
                          })
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    widget.description.toString(),
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                //data of the videos
                SizedBox(
                  height: 300,
                  child: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collectionGroup('videolessons')
                          .where('courseid', isEqualTo: widget.docid.toString())
                          .snapshots(),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasData) {
                          int number = snapshot.data!.docs.length;
                          print(number);
                          return ListView.builder(
                              itemCount: number,
                              itemBuilder: ((context, index) {
                                return Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                            color: (Color.fromRGBO(
                                                117, 117, 117, 0.527)),
                                            offset: Offset(1.0, 1.0),
                                            blurRadius: 8.0,
                                            spreadRadius: 0.4),
                                        BoxShadow(
                                            color: Colors.white,
                                            offset: Offset(-2.0, -2.0),
                                            blurRadius: 8.0,
                                            spreadRadius: 0.3),
                                      ],
                                      gradient: LinearGradient(
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                        colors: [
                                          (Color.fromRGBO(
                                              238, 238, 238, 0.397)),
                                          (Color.fromARGB(129, 255, 255, 255)),
                                        ],
                                      )),
                                  child: ListTile(
                                      leading: Container(
                                          width: 96,
                                          height: 63,
                                          decoration: BoxDecoration(
                                              color: Colors.lightBlue,
                                              border: Border.all(
                                                  width: 1,
                                                  color: Colors.lightBlue),
                                              borderRadius:
                                                  BorderRadius.circular(12)),
                                          child: Image.asset(
                                              'lib/images/todo.png'))),
                                );
                              }));
                        } else {
                          print('nothing');
                        }
                        return Center(child: CircularProgressIndicator());
                      }),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
