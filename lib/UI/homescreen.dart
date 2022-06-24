// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:learnable/UI/acountsscreesubscreens/todo.dart';
import 'package:learnable/UI/explore.dart';
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

  final List<Widget> _pages = [Mainpage(),Explorepage(),Favourites(),Todoscreen(), Accountpage(),];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _pages[CurrentIndex],
        bottomNavigationBar: CurvedNavigationBar(
          animationDuration: Duration(milliseconds: 400),
            index: CurrentIndex,
            onTap: (value) {
              setState(() {
                CurrentIndex = value;
              });
            },
            backgroundColor: Colors.white,
            color: Colors.lightBlue,
            buttonBackgroundColor: Colors.lightBlue,
            items: [
              Icon(
                Icons.home,
                color: Colors.white,
              ),
              Icon(
                Icons.explore,
                color: Colors.white,
              ),
              Icon(
                Icons.favorite,
                color: Colors.white,
              ),
              Icon(Icons.checklist,color: Colors.white,),
              Icon(
                Icons.person,
                color: Colors.white,
              )
            ]));
  }
}
