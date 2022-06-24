// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:learnable/UI/util/splashscreen.dart';
import 'package:loading_indicator/loading_indicator.dart';

class Nointernetscreen extends StatefulWidget {
  const Nointernetscreen({Key? key}) : super(key: key);

  @override
  State<Nointernetscreen> createState() => _NointernetscreenState();
}

class _NointernetscreenState extends State<Nointernetscreen> {
  bool? hasinternet = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    color: (Color.fromRGBO(117, 117, 117, 0.527)),
                    offset: Offset(1.0, 1.0),
                    blurRadius: 8.0,
                    spreadRadius: 0.4),
                BoxShadow(
                    color: Colors.white,
                    offset: Offset(-2.0, -2.0),
                    blurRadius: 8.0,
                    spreadRadius: 0.3),
              ],
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  (Color.fromRGBO(238, 238, 238, 0.397)),
                  (Color.fromARGB(129, 255, 255, 255)),
                ],
              ),
            ),
            child: Center(
              child: Icon(
                Icons.signal_wifi_bad,
                size: 50,
                color: Colors.lightBlue,
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            'Ooops!',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.lightBlue,
                fontSize: 35,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            '''You have no active internet!
Check your internet connection''',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.grey,
              fontSize: 16,
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    color: (Color.fromRGBO(117, 117, 117, 0.527)),
                    offset: Offset(1.0, 1.0),
                    blurRadius: 8.0,
                    spreadRadius: 0.4),
                BoxShadow(
                    color: Colors.white,
                    offset: Offset(-2.0, -2.0),
                    blurRadius: 8.0,
                    spreadRadius: 0.3),
              ],
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  (Color.fromRGBO(238, 238, 238, 0.397)),
                  (Color.fromARGB(129, 255, 255, 255)),
                ],
              ),
            ),
            child: MaterialButton(
              onPressed: () async {
                showDialog(
            context: context,
            builder: (context) {
              return AbsorbPointer(
                absorbing: true,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: Center(
                      child: SizedBox(
                    height: 50,
                    width: 50,
                    child: LoadingIndicator(
                        indicatorType: Indicator.ballRotateChase),
                  )),
                ),
              );
            });
                hasinternet = await InternetConnectionChecker().hasConnection;
                if (hasinternet == true) {
                  Navigator.pop(context);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => SplashScreen())));
                } else {
                  Navigator.pop(context);

                  Fluttertoast.showToast(msg: 'still no internet connection');
                }
              },
              minWidth: 150,
              elevation: 0.0,
              color: Colors.white,
              child: Text(
                'Try again',
                style: TextStyle(color: Colors.lightBlue),
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
