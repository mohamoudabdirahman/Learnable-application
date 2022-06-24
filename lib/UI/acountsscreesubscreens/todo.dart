// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:learnable/UI/pages/acountscreen.dart';
import 'package:learnable/UI/util/clock.dart';
import 'package:learnable/UI/util/tododynamicwidget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Todoscreen extends StatefulWidget {
  const Todoscreen({Key? key}) : super(key: key);

  @override
  State<Todoscreen> createState() => _TodoscreenState();
}

class _TodoscreenState extends State<Todoscreen> {
  late TextEditingController taskcontroller;
  List<Todowidget> dynamicwidget = [];
  String? obtainedtask;
  String? task = '';

  addtask() {
    setState(() {
      dynamicwidget.add(Todowidget(
        taskcontroller: taskcontroller,
      ));
    });
    setState(() {});
  }

  gettask() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    obtainedtask = prefs.getString('task');
    print(obtainedtask);
    return Text(obtainedtask!);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    taskcontroller = TextEditingController();
    setState(() {});
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    taskcontroller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment:  MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Center(child: Clock()),
                      SizedBox(
                        height: 50,),
                         Container(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('Coming Soon 🧐',style: TextStyle(fontSize: 24,color: Colors.lightBlue,fontWeight: FontWeight.bold),),
                          ),
                            // child: ListView.builder(
                            //     physics: ScrollPhysics(),
                            //     shrinkWrap: true,
                            //     itemCount: taskcontroller.text.length,
                            //     itemBuilder: (context, index) {
                            //       return Text(task!);
                            //     })),
                      ),
                      // AvatarGlow(
                      //     child: IconButton(
                      //       onPressed: (() async {
                      //         final task = await opendialog();
                      //         if (task == null || task.isEmpty) return;
                      //         setState(() => this.task = task);
                      //       }),
                      //       icon: Icon(
                      //         Icons.add,
                      //         color: Colors.lightBlue,
                      //       ),
                      //     ),
                      //     endRadius: 30),
                      // Container(
                      //   decoration: BoxDecoration(boxShadow: [
                      //     BoxShadow(
                      //         spreadRadius: -12.0,
                      //         blurRadius: 12.0,
                      //         color: Colors.black38.withOpacity(0.4))
                      //   ]),
                      //   child: MaterialButton(
                      //     onPressed: () async {},
                      //     color: Colors.white,
                      //     child: Text(
                      //       'Save Task',
                      //       style: TextStyle(color: Colors.lightBlue),
                      //     ),
                      //   ),
                      // )
                    ],
                  ),
                ]),
          ),
        ),
      ),
    );
  }

  Future<String?> opendialog() => showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add a Task'),
          content: Column(
            children: [
              TextField(
                controller: taskcontroller,
                decoration: InputDecoration(
                    hintText: 'Add a task', border: InputBorder.none),
              ),
              MaterialButton(
                onPressed: add,
                child: Text('Add'),
              )
            ],
          ),
        );
      });

  void add() {
    Navigator.of(context).pop(taskcontroller.text);
  }
}
