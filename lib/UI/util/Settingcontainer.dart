// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';

class SettingContainer extends StatelessWidget {
  String setting;
  IconData settingicon;
  SettingContainer({Key? key, required this.setting,required this.settingicon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
                   Row(
                    children: [
                      Container(
                        height: 39,
                        width: 39,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                  //offset: Offset(-1, -1),
                                  spreadRadius: -10,
                                  blurRadius: 18.0,
                                  color: Color.fromARGB(95, 129, 129, 129)
                                      .withOpacity(0.6))
                            ]),
                        child: Icon(settingicon,color: Colors.lightBlue,),
                      ),
                      SizedBox(
                        width: 15.0,
                      ),
                      Text(
                        setting,
                        style: TextStyle(fontSize: 17, color: Colors.grey),
                      )
                    ],
                  ),
              ],
    );
  }
}
