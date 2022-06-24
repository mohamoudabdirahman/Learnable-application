// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:learnable/UI/pages/mainpage.dart';
import 'package:learnable/UI/util/Courseplaying.dart';
import 'package:learnable/UI/util/decoratedcard.dart';
import 'package:learnable/usermodel/user_model.dart';
import 'package:loading_indicator/loading_indicator.dart';

class Explorepage extends StatefulWidget {
  const Explorepage({Key? key}) : super(key: key);

  @override
  State<Explorepage> createState() => _ExplorepageState();
}

class _ExplorepageState extends State<Explorepage> {
  String? firstname;
  String? lastname;
  String? docid;
  String? parentcourseid;
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();

  String? formatedate;

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Explore',
                      style: GoogleFonts.breeSerif(
                          fontSize: 27, color: Colors.lightBlue))
                ],
              ),
            ),
            Container(
              width: 317,
              child: Container(
                height: 38,
                decoration: BoxDecoration(
                    //borderRadius:BorderRadius.circular(30),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: Colors.grey.shade800.withOpacity(0.1),
                        offset: Offset(3, 3),
                        blurRadius: 8,
                      ),
                    ]),
                child: TextFormField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16)),
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
                          borderSide:
                              BorderSide(color: Colors.lightBlue, width: 0.8),
                          borderRadius: BorderRadius.circular(16)),
                      hintText: "Search Courses",
                      hintStyle:
                          TextStyle(fontSize: 12, color: Colors.lightBlue)),
                  style: TextStyle(fontSize: 14),
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: DecoratedCard(),
            ),
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('All Courses',
                      style: GoogleFonts.breeSerif(
                          fontSize: 22, color: Colors.lightBlue)),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            obtainedcourses(),
          ],
        ),
      ),
    );
  }

  Widget obtainedcourses() {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('Users')
          .where('Isinstructor', isEqualTo: true)
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        String? useridentity = snapshot.data?.docs[0]['uid'];
        String? firstname = snapshot.data?.docs[0]['First Name'];
        String? lastname = snapshot.data?.docs[0]['Last Name'];
        if (snapshot.hasData) {
          print(useridentity);
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
                  return Expanded(
                    child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2),
                        itemCount: number,
                        itemBuilder: (context, index) {
                          parentcourseid = snapshot.data?.docs[index]['docid'];
                          docid = snapshot.data!.docs[index]['OwnerId'];
                          var timestamp =
                              snapshot.data?.docs[index]['timestamp'];
                          var date = DateTime.parse(timestamp);
                          formatedate =
                              (DateFormat('yyy').format(date.toUtc()));
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 25),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: ((context) => Courseplay(
                                          docid: parentcourseid,
                                              ownid: docid,
                                              coursetitle: snapshot.data!
                                                  .docs[index]['coursetitle'],
                                              description: snapshot
                                                  .data!.docs[index]['desc'],
                                              courseid: snapshot
                                                  .data!.docs[index]['docid'],
                                              firstname: firstname,
                                              lastname: lastname,
                                            ))));
                              },
                              child: Stack(
                                children: [
                                  Container(
                                      width: 145,
                                      height: 160,
                                      decoration: BoxDecoration(
                                        boxShadow: <BoxShadow>[
                                          BoxShadow(
                                            color: Colors.grey.shade800
                                                .withOpacity(0.1),
                                            offset: Offset(0, 3),
                                            blurRadius: 8,
                                          ),
                                        ],
                                        color: Colors.lightBlue,
                                        borderRadius: BorderRadius.circular(18),
                                      ),
                                      child: snapshot.data!.docs[index]
                                                  ['thumbnail'] !=
                                              null
                                          ? ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(18),
                                              child: Image.network(
                                                "${snapshot.data!.docs[index]['thumbnail']}",
                                                errorBuilder: ((context, error,
                                                    stackTrace) {
                                                  return Icon(
                                                      Icons.do_not_disturb);
                                                }),
                                                fit: BoxFit.cover,
                                              ),
                                            )
                                          : Icon(Icons.do_not_disturb)),
                                  Positioned(
                                    bottom: 0,
                                    child: Container(
                                      width: 145,
                                      height: 51,
                                      decoration: BoxDecoration(
                                        boxShadow: <BoxShadow>[
                                          BoxShadow(
                                            color: Colors.grey.shade800
                                                .withOpacity(0.1),
                                            offset: Offset(0, 3),
                                            blurRadius: 8,
                                          ),
                                        ],
                                        color: Colors.white,
                                        borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(18),
                                            bottomRight: Radius.circular(18)),
                                      ),
                                      child: Column(
                                        children: [
                                          Expanded(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 6),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "${snapshot.data!.docs[index]['coursetitle']}",
                                                    style: TextStyle(
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        fontSize: 14,
                                                        color:
                                                            Colors.lightBlue),
                                                  ),
                                                  SizedBox(height: 6),
                                                  Row(
                                                    children: [
                                                      Text(
                                                        formatedate.toString(),
                                                        style: TextStyle(
                                                            fontSize: 10,
                                                            color: Colors.grey
                                                                .withOpacity(
                                                                    0.9)),
                                                      )
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        }),
                  );
                }
                return Center(
                  child: SizedBox(
                    height: 60,
                    width: 60,
                    child: LoadingIndicator(
                        indicatorType: Indicator.ballRotateChase),
                  ),
                );
              });
        }
        return Container();
      },
    );
  }
}
