// ignore_for_file: prefer_const_constructors

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:learnable/UI/pages/mainpage.dart';
import 'package:learnable/UI/util/Courseplaying.dart';
import 'package:learnable/UI/util/decoratedcard.dart';
import 'package:learnable/UI/util/searchbar.dart';
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
  bool? istaped = false;
  TextEditingController _coursenamecontroller = TextEditingController();
  String? formatedate;
  String? instid;
  String title = 'Flutter Basics';

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
  String? parentcourse;
  String? imageurl;
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
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: ((context) => Searchbar(instid: docid,))));
                  },
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
                  onChanged: (value) {
                    title = value;
                  },
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
    ));
  }

  Widget obtainedcourses() {
    return SizedBox(
        height: 300,
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('Users')
              .where('Isinstructor', isEqualTo: true)
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            String? useridentity = snapshot.data?.docs[0]['uid'];
            
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data?.docs.length,
                itemBuilder: (contex, index) {
                  String? useridentity = snapshot.data?.docs[index]['uid'];
                  firstname = snapshot.data?.docs[index]['First Name'];
                  lastname = snapshot.data?.docs[index]['Last Name'];
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
                                docid = snapshot.data!.docs[index]['OwnerId'];
                                imageurl =
                                    snapshot.data?.docs[index]['coursetitle'];

                                coursename =
                                    snapshot.data?.docs[index]['coursetitle'];
                                time = snapshot.data?.docs[index]['timestamp'];
                                picurl =
                                    snapshot.data?.docs[index]['thumbnail'];
                                var timestamp =
                                    snapshot.data?.docs[index]['timestamp'];

                                var date = DateTime.parse(timestamp);
                                formatedate =
                                    (DateFormat('yyy').format(date.toUtc()));

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
                                              BorderRadius.circular(20)),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: ListTile(
                                          onTap: (() {
                                            setState(() {
                                              Navigator.pushReplacement(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          Courseplay(
                                                            docid: parentcourse,
                                                            ownid: docid,
                                                            coursetitle: snapshot
                                                                    .data!
                                                                    .docs[index]
                                                                ['coursetitle'],
                                                            description: snapshot
                                                                    .data!
                                                                    .docs[index]
                                                                ['desc'],
                                                            
                                                            courseid: snapshot
                                                                    .data!
                                                                    .docs[index]
                                                                ['docid'],
                                                          )));
                                            });
                                          }),
                                          leading: Container(
                                              width: 90,
                                              height: 70,
                                              decoration: BoxDecoration(
                                                  color: Colors.lightBlue,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  child:  CachedNetworkImage(
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
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.lightBlue)),
                                          subtitle: Text(formatedate.toString(),
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
                                  indicatorType: Indicator.ballRotateChase)),
                        );
                      });
                },
              );
            }
            return Container();
          },
        ));
  }
}
