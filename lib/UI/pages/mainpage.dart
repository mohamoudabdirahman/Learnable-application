// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:learnable/UI/util/Courseplaying.dart';
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
  String? firstname;
  String? profilepic;
  FirebaseAuth user = FirebaseAuth.instance;

  @override
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
                    Container(
                      height: 38,
                      child: TextFormField(
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12)),
                            contentPadding: EdgeInsets.all(15.0),
                            fillColor: Colors.white,
                            filled: true,
                            suffixIcon: GestureDetector(
                                onTap: () {},
                                child: Icon(
                                  FontAwesomeIcons.search,
                                  size: 18,
                                )),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.lightBlue, width: 2.0),
                                borderRadius: BorderRadius.circular(12)),
                            hintText: "Search Courses",
                            hintStyle: TextStyle(
                                fontSize: 12, color: Colors.lightBlue)),
                        style: TextStyle(fontSize: 14),
                      ),
                    )
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
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (snapshot.hasData) { 
                      firstname = snapshot.data!.docs[0]['First Name'];
                      if (snapshot.data!.docs[0]['Isinstructor'] == true) {
                        return StreamBuilder(
                            stream: FirebaseFirestore.instance
                                .collectionGroup('Course')
                                .snapshots(),
                            builder: (BuildContext context,
                                AsyncSnapshot<QuerySnapshot> snapshot) {
                              if (snapshot.hasData) {
                                int number = snapshot.data!.docs.length;
                                return ListView.builder(
                                    scrollDirection: Axis.vertical,
                                    shrinkWrap: true,
                                    itemCount: number - 1,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: const EdgeInsets.only(
                                            top: 20, right: 20, left: 20),
                                        child: GestureDetector(
                                          onTap: () async {
                                            Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        Courseplay(
                                                          coursetitle: snapshot
                                                                  .data!
                                                                  .docs[index]
                                                              ['coursetitle'],
                                                          description: snapshot
                                                                  .data!
                                                                  .docs[index]
                                                              ['desc'],
                                                          firstname: firstname,
                                                        )));
                                          },
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
                                                    BorderRadius.circular(20)),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(10.0),
                                              child: Row(
                                                children: [
                                                  Container(
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
                                                          child: Image.network(
                                                            "${snapshot.data!.docs[index]['thumbnail']}",
                                                            errorBuilder:
                                                                ((context,
                                                                    error,
                                                                    stackTrace) {
                                                              return Icon(Icons
                                                                  .do_not_disturb);
                                                            }),
                                                            fit: BoxFit.cover,
                                                          ))),
                                                  SizedBox(
                                                    width: 10.0,
                                                  ),
                                                  Flexible(
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                            "${snapshot.data!.docs[index]['coursetitle']}",
                                                            overflow:
                                                                TextOverflow
                                                                    .fade,
                                                            style: TextStyle(
                                                                fontSize: 20,
                                                                color: Colors
                                                                    .lightBlue)),
                                                        SizedBox(
                                                          height: 10,
                                                        ),
                                                        Text(
                                                            "${snapshot.data!.docs[index]['timestamp']}",
                                                            style: TextStyle(
                                                                fontSize: 13,
                                                                color: Colors
                                                                    .grey)),
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
                              return Container();
                            });
                      } else {
                        return Container();
                      }
                    }
                    return CircularProgressIndicator();
                  }),
            )
          ],
        ),
      ),
    ));
  }

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
