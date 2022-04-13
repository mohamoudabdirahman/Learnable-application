// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:learnable/usermodel/user_model.dart';
import 'package:video_player/video_player.dart';

class Courseplay extends StatefulWidget {
  const Courseplay({Key? key}) : super(key: key);

  @override
  State<Courseplay> createState() => _CourseplayState();
}

class _CourseplayState extends State<Courseplay> {
  User? user = FirebaseAuth.instance.currentUser;
  VideoPlayerController? _playerController;
  ChapterModel currentvideo = ChapterModel();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FirebaseFirestore.instance
        .collection("Users")
        .doc(user!.uid)
        .collection("Course")
        .doc("Chapters")
        .get()
        .then((value) {
      currentvideo = ChapterModel.fromMap(value.data());

      // _playerController =
      //     VideoPlayerController.network("${currentvideo.videolesson}")
      //     ..initialize().then(){
      //      _playerController!.play();
      //     }

      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            child: Text("wait"),
          )
        ],
      ),
    );
  }
}
