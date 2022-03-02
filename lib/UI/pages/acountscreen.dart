// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:learnable/UI/mylearning.dart';
import 'package:learnable/UI/pages/mainpage.dart';
import 'package:learnable/UI/util/accountrows.dart';
import 'package:learnable/usermodel/user_model.dart';

class Accountpage extends StatefulWidget {
  const Accountpage({Key? key}) : super(key: key);

  @override
  _AccountpageState createState() => _AccountpageState();
}

class _AccountpageState extends State<Accountpage> {
  final auth = FirebaseAuth.instance;
  UserModel loggedInUser = UserModel();

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
    return SafeArea(
      child: Container(
          child: Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 5,
                          color: Colors.black.withOpacity(0.3),
                          spreadRadius: 0,
                          offset: Offset(0, 5))
                    ],
                  ),
                  child: CircleAvatar(
                    radius: 40.0,
                    backgroundImage: NetworkImage(
                        "https://images.unsplash.com/photo-1522228115018-d838bcce5c3a?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80"),
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  "${loggedInUser.firstname} ${loggedInUser.lastname}",
                  style: TextStyle(color: Colors.lightBlue, fontSize: 17.0),
                ),
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
                          "Student Mode",
                          style: TextStyle(fontSize: 16.0, color: Colors.white),
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        Switch.adaptive(
                            value: true,
                            onChanged: (bool state) {
                              print(state);
                            })
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Container(
                  height: 454.9,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(52),
                        topRight: Radius.circular(52)),
                    color: Colors.lightBlue,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 52.0, top: 62.0, right: 53.0),
                    child: Column(
                      children: [
                        ProfileRows(
                          iconimage: 'lib/images/Group 1.png',
                          title: 'My Learning',
                        ),
                        ProfileRows(
                          iconimage: 'lib/images/favourites.png',
                          title: 'Wishlist',
                        ),
                        ProfileRows(
                          iconimage: 'lib/images/settings.png',
                          title: 'Account Settings',
                        ),
                        ProfileRows(
                          iconimage: 'lib/images/logout.png',
                          title: 'Logout',
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height),
    );
  }
}
