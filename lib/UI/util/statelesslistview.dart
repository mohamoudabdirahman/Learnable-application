// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Listeviewstateless extends StatelessWidget {
  final String? vidurl;
  TextEditingController? chaptitle = TextEditingController();
  File? video;
  Listeviewstateless({Key? key, this.video, this.vidurl, this.chaptitle})
      : super(key: key);

  final _auth = FirebaseAuth.instance;
  int num = 1;

  Future videoPickerMethod() async {
    final pick = await ImagePicker().pickVideo(source: ImageSource.gallery);

    
      if (pick != null) {
        video = File(pick.path);
      } 
    
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: ((context, int index) {
        return Padding(
          padding: const EdgeInsets.only(top: 15.0),
          child: Container(
            width: 285,
            height: 84,
            decoration: BoxDecoration(
                border: Border.all(width: 1, color: Colors.white),
                borderRadius: BorderRadius.circular(12)),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                children: [
                  SizedBox(
                    width: 91,
                    height: 59,
                    child: GestureDetector(
                        onTap: () {
                          videoPickerMethod();
                        },
                        child: video == null
                            ? DottedBorder(
                                child: Center(
                                    child:
                                        Icon(Icons.add, color: Colors.white)),
                                color: Colors.white,
                                dashPattern: const [8, 4],
                                borderType: BorderType.RRect,
                                radius: Radius.circular(10),
                              )
                            : Container(
                                decoration: BoxDecoration(
                                    border: Border.all(
                                      width: 1.0,
                                      color: Colors.white,
                                    ),
                                    borderRadius: BorderRadius.circular(12)),
                                child: ClipRRect(
                                    child: Icon(
                                  Icons.check,
                                  size: 30.0,
                                  color: Colors.green,
                                )),
                              )),
                  ),
                  SizedBox(
                    width: 5.0,
                  ),
                  Flexible(
                      child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: 30.0,
                            width: 800.0,
                            child: TextField(
                              controller: chaptitle,
                              decoration: InputDecoration(
                                hintText: "Chapter Title",
                                hintStyle: TextStyle(
                                    fontSize: 10, color: Colors.white54),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.white, width: 1),
                                    borderRadius: BorderRadius.circular(5)),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.white, width: 1),
                                    borderRadius: BorderRadius.circular(5)),
                              ),
                            ),
                          ))),
                  Container(
                      child: IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.clear,
                            size: 10,
                          )))
                ],
              ),
            ),
          ),
        );
      }),
      itemCount: num,
      physics: ScrollPhysics(parent: null),
      shrinkWrap: true,
    );
  }


}
