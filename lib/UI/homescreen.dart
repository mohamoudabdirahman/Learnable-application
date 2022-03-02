// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:learnable/UI/pages/acountscreen.dart';
import 'package:learnable/UI/pages/favourates.dart';
import 'package:learnable/UI/pages/mainpage.dart';
import 'package:learnable/usermodel/user_model.dart';
import 'package:provider/provider.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({Key? key}) : super(key: key);

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  int CurrentIndex = 0;

  final List<Widget> _pages = [Mainpage(), Favourites(), Accountpage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _pages[CurrentIndex],
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Colors.black,
                blurRadius: 10,
              ),
            ],
          ),
          child: BottomNavigationBar(
            backgroundColor: Colors.lightBlue,
            currentIndex: CurrentIndex,
            onTap: (value) => setState(() {
              CurrentIndex = value;
            }),
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                  icon: Icon(FontAwesomeIcons.home), label: "Home"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.save_alt_rounded), label: "Saved"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person), label: "Profile")
            ],
          ),
        ));
  }
}
