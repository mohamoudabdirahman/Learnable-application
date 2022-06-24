// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:another_flushbar/flushbar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loading_indicator/loading_indicator.dart';

class Updatecourse extends StatefulWidget {
  final String? courseid;
  final String? thumbnailurl;
  const Updatecourse(
      {Key? key, required this.courseid, required this.thumbnailurl})
      : super(key: key);

  @override
  State<Updatecourse> createState() => _UpdatecourseState();
}

class _UpdatecourseState extends State<Updatecourse> {
  final TextEditingController _title = TextEditingController();
  final TextEditingController _description = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  User? user = FirebaseAuth.instance.currentUser;
  PlatformFile? file;
  String? thumbnailurl;

  Future getthumbnail() async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(type: FileType.image);
    setState(() {
      if (result != null) {
        file = result.files.first;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Course'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Form(
          key: _formkey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: 299,
                  height: 233,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(28),
                      border: Border.all(width: 1, color: Colors.lightBlue)),
                  child: Center(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                          onTap: () {
                            getthumbnail();
                          },
                          child: StreamBuilder(
                              stream: FirebaseFirestore.instance
                                  .collection('Users')
                                  .doc(user!.uid)
                                  .collection('Course')
                                  .doc(widget.courseid.toString())
                                  .snapshots(),
                              builder: (BuildContext context,
                                  AsyncSnapshot<DocumentSnapshot> snapshot) {
                                return Container();
                              })),
                      file != null
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.file(
                                File(file!.path.toString()),
                                height: 200,
                                fit: BoxFit.cover,
                              ))
                          : Center(
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: CachedNetworkImage(
                                  imageUrl: widget.thumbnailurl.toString(),
                                  fit: BoxFit.cover,
                                  height: 200.0,
                                  errorWidget: (context, url, error) => Center(
                                    child: Icon(
                                      Icons.error,
                                      color: Colors.red,
                                    ),
                                  ),
                                  maxHeightDiskCache: 75,
                                  placeholder: (context, imageurl) => Center(
                                      child: SizedBox(
                                          height: 200,
                                          width: 200,
                                          child: LoadingIndicator(
                                            indicatorType:
                                                Indicator.ballRotateChase,
                                            colors: const [Colors.lightBlue],
                                          ))),
                                )),
                          ),
                      SizedBox(
                        height: 15,
                      ),
                    ],
                  )),
                ),
                SizedBox(
                  height: 15.0,
                ),
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: TextFormField(
                        controller: _title,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'the field is blank!';
                          }
                        },
                        decoration: InputDecoration(
                          hintText: 'Course titile',
                          contentPadding: EdgeInsets.all(15.0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ))),

                SizedBox(
                  height: 15,
                ),
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: TextFormField(
                        controller: _description,
                        minLines: 5,
                        maxLines: 10,
                        decoration: InputDecoration(
                          hintText: 'Course Description',
                          contentPadding: EdgeInsets.all(15.0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ))),
                // ignore: prefer_const_constructors
                SizedBox(
                  height: 15.0,
                ),
                MaterialButton(
                    onPressed: () {
                      setState(() {
                        savechanges();
                      });
                    },
                    color: Colors.lightBlue,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                    minWidth: 250,
                    height: 50,
                    child: const Text('Save Changes',
                        style: TextStyle(color: Colors.white))),
                SizedBox(
                  height: 15.0,
                ),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(width: 1, color: Colors.lightBlue)),
                  child: MaterialButton(
                      onPressed: () {},
                      minWidth: 250,
                      height: 50,
                      child: const Text('Add lessons',
                          style: TextStyle(color: Colors.lightBlue))),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void savechanges() async {
    if (_title.text.isEmpty || _description.text.isEmpty) {
      Fluttertoast.showToast(
          msg: 'There is nothing to update(try making some changes) 😕',
          backgroundColor: Colors.lightBlue,
          textColor: Colors.white);
    } else if (_formkey.currentState!.validate()) {
      try {
        FirebaseFirestore.instance
            .collection('Users')
            .doc(user!.uid)
            .collection('Course')
            .doc(widget.courseid.toString())
            .update({"coursetitle": _title.text});
      } catch (e) {
        Flushbar(message: '$e', duration: Duration(milliseconds: 600));
      }

      Fluttertoast.showToast(
          msg: 'Course has been updated successfully ✨',
          backgroundColor: Colors.lightBlue,
          textColor: Colors.white);
    }
  }
}
