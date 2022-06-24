// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:timer_builder/timer_builder.dart';

class Clock extends StatefulWidget {
  const Clock({Key? key}) : super(key: key);

  @override
  State<Clock> createState() => _ClockState();
}

class _ClockState extends State<Clock> {
  @override
  Widget build(BuildContext context) {
    return Stack(alignment: Alignment.center, children: [
      Container(
        width: 350,
        height: 350,
        decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                  //offset: Offset(-1, -1),
                  spreadRadius: -10,
                  blurRadius: 18.0,
                  color: Color.fromARGB(95, 129, 129, 129).withOpacity(0.2))
            ]),
      ),
      Container(
        width: 300,
        height: 300,
        decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                  //offset: Offset(-1, -1),
                  spreadRadius: -10,
                  blurRadius: 18.0,
                  color: Color.fromARGB(95, 129, 129, 129).withOpacity(0.5))
            ]),
      ),
      Container(
        width: 250,
        height: 250,
        decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                  //offset: Offset(-1, -1),
                  spreadRadius: -10,
                  blurRadius: 20.0,
                  color: Colors.black38)
            ]),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 60),
              child: Text(
                'time',
                style: TextStyle(fontSize: 18, letterSpacing: 2),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: 30.0,
            ),
            TimerBuilder.periodic(Duration(seconds: 1), builder: ((context) {
              return Text(
                TimeOfDay.now().format(context).toString(),
                style: GoogleFonts.cabin(
                    fontSize: 42,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 39, 6, 94)),
              );
            }))
          ],
        ),
      ),
    ]);
  }
}
