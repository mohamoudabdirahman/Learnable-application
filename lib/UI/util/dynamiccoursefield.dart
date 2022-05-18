// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class Dynamiccoursefield extends StatefulWidget {
  final PlatformFile? file;
  PlatformFile? video;
  Dynamiccoursefield({Key? key, this.file, this.video}) : super(key: key);

  @override
  State<Dynamiccoursefield> createState() => _DynamiccoursefieldState();
}

class _DynamiccoursefieldState extends State<Dynamiccoursefield> {
  FirebaseAuth auth = FirebaseAuth.instance;
  String? vidurl;
  Future getvideos() async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(type: FileType.video);
    setState(() {
      if (result != null) {
        widget.video = result.files.first;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Slidable(
        // ignore: prefer_const_literals_to_create_immutables
        endActionPane: ActionPane(motion: DrawerMotion(), children: [
          SlidableAction(
            onPressed: ((context) {}),
            icon: Icons.delete,
            foregroundColor: Colors.lightBlue,
            //backgroundColor: Colors.lightBlue,
          )
        ]),
        child: Container(
            width: 380,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(width: 1, color: Colors.lightBlue)),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: widget.video == null
                  ? IconButton(
                      onPressed: () {
                        getvideos();
                      },
                      icon: Icon(Icons.add))
                  : Row(
                      children: [
                        Container(
                          height: 60,
                          width: 80,
                          decoration: BoxDecoration(
                              color: Colors.lightBlue,
                              borderRadius: BorderRadius.circular(10)),
                          child: Icon(
                            Icons.check,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.video!.name,
                                overflow: TextOverflow.fade,
                                maxLines: 2,
                                softWrap: true,
                                style: TextStyle(
                                    fontSize: 18, color: Colors.lightBlue),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                widget.video!.size.toString(),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
            )),
      ),
    );
  }

  getvideoforfirebase() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    User? user = auth.currentUser;
    final File image = File("${widget.file!.path}");
    final File videoref = File("${widget.video!.path}");
    Reference vidref =
        FirebaseStorage.instance.ref("Users").child(user!.uid).child("Course");
    if (widget.video != null) {
      await vidref.putFile(videoref);
      vidurl = await vidref.getDownloadURL();
    }
    if (widget.video == null) {
      print("video is null");
    }
  }
}
