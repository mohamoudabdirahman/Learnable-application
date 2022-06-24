// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Todowidget extends StatefulWidget {
  TextEditingController taskcontroller = TextEditingController();
  Todowidget({
    Key? key,required this.taskcontroller
  }) : super(key: key);

  @override
  State<Todowidget> createState() => _TodowidgetState();
}

class _TodowidgetState extends State<Todowidget> {
  bool ischecked = false;
  List<dynamic> taskcontrollers = [];
  @override
  void dispose() {
    // TODO: implement dispose
    widget.taskcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: Text('Add a Task'),
        content: Column(
          children: [
            TextField(
              controller: widget.taskcontroller,
              decoration: InputDecoration(
                  hintText: 'Add a task', border: InputBorder.none),
            ),
            MaterialButton(
              onPressed: () async {
               
              },
              child: Text('Add'),
            )
          ],
        ));
  }
}
