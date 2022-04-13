// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Coursedetailspageone extends StatefulWidget {
  TextEditingController? title = TextEditingController();
  TextEditingController? description = TextEditingController();
  File? image;
  Coursedetailspageone({Key? key, this.description, this.title,this.image})
      : super(key: key);

  @override
  State<Coursedetailspageone> createState() => _CoursedetailspageoneState();
}

class _CoursedetailspageoneState extends State<Coursedetailspageone> {
  File? _image;

  Future imagePickerMethod() async {
    final pick = await ImagePicker().pickImage(source: ImageSource.gallery);

    setState(() {
      if (pick != null) {
        _image = File(pick.path);
      } else {
        showSnackBar("Something went wrong", Duration(microseconds: 400));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      SizedBox(
        width: 224.0,
        height: 194.0,
        child: DottedBorder(
            strokeWidth: 1,
            color: Colors.white,
            dashPattern: [8, 4],
            borderType: BorderType.RRect,
            radius: Radius.circular(12),
            child: Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _image == null
                        ? IconButton(
                            onPressed: () {
                              imagePickerMethod();
                            },
                            icon: Icon(Icons.add))
                        : Padding(
                            padding: const EdgeInsets.only(top: 2.0),
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.file(
                                  _image!,
                                  fit: BoxFit.cover,
                                  height: 180,
                                  width: 170.0,
                                )),
                          ),
                    SizedBox(
                      height: 8.0,
                    ),
                    _image == null
                        // ignore: prefer_const_constructors
                        ? Text(
                            "Upload an image thumbnail for the course",
                            textAlign: TextAlign.center,
                            style:
                                TextStyle(color: Colors.white, fontSize: 13.0),
                          )
                        : SizedBox(
                            height: 0.0,
                          )
                  ]),
            )),
      ),
      SizedBox(
        height: 22.0,
      ),
      Container(
        height: 52,
        width: 285,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
        child: TextFormField(
          controller: widget.title,
          validator: (value) {
            if (value!.isEmpty) {
              Text("This field can't be empty");
            }
            return value;
          },
          decoration: InputDecoration(
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white, width: 1),
                  borderRadius: BorderRadius.circular(12)),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white, width: 1),
                  borderRadius: BorderRadius.circular(12)),
              fillColor: Colors.white,
              filled: true,
              hintText: "Course Title",
              hintStyle: TextStyle(fontSize: 12.0, color: Colors.lightBlue),
              contentPadding: EdgeInsets.all(15.0),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              )),
        ),
      ),
      SizedBox(
        height: 22.0,
      ),
      Container(
          height: 52,
          width: 285,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
          child: TextFormField(
            controller: widget.description,
            validator: (value) {
              if (value!.isEmpty) {
                Text("This field can't be empty");
              }
            },
            keyboardType: TextInputType.multiline,
            maxLines: 10,
            decoration: InputDecoration(
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white, width: 1),
                  borderRadius: BorderRadius.circular(12)),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white, width: 1),
                  borderRadius: BorderRadius.circular(12)),
              fillColor: Colors.white,
              filled: true,
              hintText: "Description",
              hintStyle: TextStyle(fontSize: 12.0, color: Colors.lightBlue),
              contentPadding: EdgeInsets.all(15.0),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ))
    ]);
  }

  showSnackBar(String snackText, Duration d) {
    final snackBar = SnackBar(
        content: Text(
          snackText,
          style: TextStyle(color: Colors.white),
        ),
        duration: d,
        backgroundColor: Colors.lightBlue);
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
