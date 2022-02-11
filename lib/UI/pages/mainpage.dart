// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:learnable/usermodel/user_model.dart';

class Mainpage extends StatefulWidget {
  const Mainpage({Key? key}) : super(key: key);

  @override
  _MainpageState createState() => _MainpageState();
}

class _MainpageState extends State<Mainpage> {
  User? user = FirebaseAuth.instance.currentUser!;
  UserModel loggedInUser = UserModel();
  final TimeOfDay goodmorning = TimeOfDay(
    hour: 3 - 17,
    minute: 00,
  );
  final TimeOfDay currenttime = TimeOfDay.now();

  final TimeOfDay goodevinning = TimeOfDay(
    hour: 18 - 2,
    minute: 00,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Column(
        children: [
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Learnable",
                    style: TextStyle(
                        fontSize: 20,
                        letterSpacing: 1,
                        color: Colors.lightBlue,
                        fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                      onPressed: () {},
                      icon: Icon(
                        FontAwesomeIcons.solidBell,
                        color: Colors.lightBlue,
                      ))
                ],
              ),
            ),
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  width: 374.0,
                  height: 230.0,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(39),
                      color: Colors.lightBlue,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey,
                            offset: Offset(3, 4),
                            blurRadius: 7.0),
                      ]),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10.0, 40.0, 0.0, 0.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Row(
                            children: [gettime()],
                          ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Text(
                            "What do you want to learn today?",
                            style: TextStyle(
                                fontSize: 14, color: Colors.grey[300]),
                          ),
                        ),
                        SizedBox(
                          height: 40.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: TextField(
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    FontAwesomeIcons.search,
                                    size: 14,
                                  )),
                              contentPadding: EdgeInsets.only(left: 25),
                              hintText: "Search Courses",
                              hintStyle: TextStyle(
                                  letterSpacing: 1,
                                  fontSize: 10,
                                  color: Colors.lightBlue),
                              fillColor: Colors.white,
                              filled: true,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(17)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 15.0,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 23, right: 23),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Featured Courses",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.lightBlue,
                  ),
                ),
                Text(
                  "view all",
                  style: TextStyle(fontSize: 14, color: Colors.lightBlue),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  gettime() {
    return currenttime == goodmorning
        ? Text("Good Morning",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 30.0,
              color: Colors.white,
            ))
        : Text("Good evening",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 30.0,
              color: Colors.white,
            ));
  }
}
