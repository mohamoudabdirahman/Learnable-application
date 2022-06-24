// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:learnable/UI/Instructordashboard.dart';
import 'package:learnable/UI/acountsscreesubscreens/accountsettings.dart';
import 'package:learnable/UI/acountsscreesubscreens/todo.dart';
import 'package:learnable/UI/acountsscreesubscreens/wishlist.dart';
import 'package:learnable/UI/homescreen.dart';
import 'package:learnable/UI/mylearning.dart';
import 'package:learnable/UI/pages/mainpage.dart';
import 'package:learnable/UI/signinscreen.dart';
import 'package:learnable/UI/util/accountrows.dart';
import 'package:learnable/usermodel/user_model.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Accountpage extends StatefulWidget {
  Color backcolor = Color(0x00ffffff);

  @override
  _AccountpageState createState() => _AccountpageState();
}

class _AccountpageState extends State<Accountpage> {
  bool ispressed = false;
  final auth = FirebaseAuth.instance;
  UserModel loggedInUser = UserModel();
  User? user = FirebaseAuth.instance.currentUser;
  String? imageurl;
  @override
  void initState() {
    super.initState();
    User? user = auth.currentUser;
    FirebaseFirestore.instance
        .collection("Users")
        .doc(user!.uid)
        .get()
        .then((value) {
      loggedInUser = UserModel.fromMap(value.data());
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
            child: Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 80.0,
                    height: 80.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: CircleAvatar(
                        child: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('Users')
                          .doc(user!.uid)
                          .snapshots(),
                      builder: (BuildContext context,
                          AsyncSnapshot<DocumentSnapshot> snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return CircularProgressIndicator();
                        }
                        if (snapshot.hasError) {
                          return Icon(Icons.error);
                        }
                        if (snapshot.hasData) {
                          imageurl = snapshot.data!['downloadUrl'];
                          return CircleAvatar(
                            backgroundImage: NetworkImage(imageurl!),
                            radius: 80,
                          );
                        }
                        return CircularProgressIndicator();
                      },
                    )),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text("${loggedInUser.firstname} ${loggedInUser.lastname}",
                      style: TextStyle(fontSize: 16, color: Colors.lightBlue)),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.lightBlue,
                          borderRadius: BorderRadius.circular(8)),
                      width: 350,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            ispressed == true ? "Dark Mode" : 'Light mode',
                            style:
                                TextStyle(fontSize: 16.0, color: Colors.white),
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
                          Switch.adaptive(
                              value: ispressed,
                              onChanged: (value) {
                                setState(() {
                                  ispressed = value;
                                });
                              })
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Expanded(
                    child: Container(
                      height: 454.9,
                      decoration: BoxDecoration(
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                              color: Colors.grey.shade800.withOpacity(0.5),
                              offset: Offset(3, 3),
                              blurRadius: 8,
                            )
                          ],
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(52),
                              topRight: Radius.circular(52)),
                          color: Colors.white),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 52.0, top: 62.0, right: 53.0),
                        child: Column(
                          children: [
                            ProfileRows(
                                iconimage: loggedInUser.isinstructor == true
                                    ? 'lib/images/courses.png'
                                    : 'lib/images/Group 1.png',
                                title: loggedInUser.isinstructor == true
                                    ? 'My courses'
                                    : 'My Learnings'),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: ((context) => Wishlist())));
                              },
                              child: ProfileRows(
                                iconimage: loggedInUser.isinstructor == true
                                    ? 'lib/images/todo.png'
                                    : 'lib/images/favourites.png',
                                title: 'Wishlist',
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: ((context) =>
                                            AccountSettings())));
                              },
                              child: ProfileRows(
                                iconimage: 'lib/images/settings.png',
                                title: 'Account Settings',
                              ),
                            ),
                            GestureDetector(
                              onTap: () async {
                                FirebaseAuth.instance.signOut();
                                SharedPreferences sharedPreferences =
                                    await SharedPreferences.getInstance();
                                sharedPreferences.remove('email');
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SignIn()));
                              },
                              child: ProfileRows(
                                iconimage: 'lib/images/logout.png',
                                title: 'Logout',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height),
      ),
    );
  }
}
