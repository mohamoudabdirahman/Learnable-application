// ignore_for_file: unnecessary_brace_in_string_interps, prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:learnable/UI/acountsscreesubscreens/Personalinfor.dart';
import 'package:learnable/UI/acountsscreesubscreens/resetpassword.dart';
import 'package:learnable/UI/util/Settingcontainer.dart';

class AccountSettings extends StatefulWidget {
  const AccountSettings({Key? key}) : super(key: key);

  @override
  State<AccountSettings> createState() => _AccountSettingsState();
}

class _AccountSettingsState extends State<AccountSettings> {
  String? imageurl;
  User? user = FirebaseAuth.instance.currentUser;
  String? firstname;
  String? lastname;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        title: Text(
          'Account Settings',
          style: TextStyle(color: Colors.grey),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 24, right: 24, top: 20),
            child:
                Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
              Container(
                height: 80,
                width: 80,
                child: CircleAvatar(
                    child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('Users')
                      .doc(user!.uid)
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<DocumentSnapshot> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    }
                    if (snapshot.hasError) {
                      return Icon(Icons.error);
                    }
                    if (snapshot.hasData) {
                      imageurl = snapshot.data!['downloadUrl'];
                      return Container(
                        height: 90,
                        width: 94,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50.0),
                            image: DecorationImage(
                                image: NetworkImage(imageurl!),
                                fit: BoxFit.fill),
                            boxShadow: [
                              BoxShadow(
                                  //offset: Offset(-1, -1),
                                  spreadRadius: -10,
                                  blurRadius: 18.0,
                                  color: Color.fromARGB(95, 129, 129, 129)
                                      .withOpacity(0.2))
                            ]),
                      );
                    }
                    return const CircularProgressIndicator(color: Colors.white);
                  },
                )),
              ),
              const SizedBox(
                width: 15.0,
              ),
              StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('Users')
                    .doc(user!.uid)
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<DocumentSnapshot> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  }
                  if (snapshot.hasError) {
                    return Icon(Icons.error);
                  }
                  if (snapshot.hasData) {
                    firstname = snapshot.data!.get('First Name');
                    lastname = snapshot.data!.get('Last Name');
                    return Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('${firstname} ${lastname}',
                              style:
                                  TextStyle(fontSize: 17, color: Colors.grey)),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            user!.email.toString(),
                            style: TextStyle(fontSize: 17, color: Colors.grey),
                            overflow: TextOverflow.ellipsis,
                          )
                        ],
                      ),
                    );
                  }
                  return const CircularProgressIndicator();
                },
              )
            ]),
          ),
          SizedBox(
            height: 46,
          ),
          Container(
            width: 365,
            height: 307,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
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
                )),
            child: Padding(
              padding: const EdgeInsets.only(right: 24, left: 24, top: 40),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: ((context) => PersonalInfo(
                                    ))));
                    },
                    child: SettingContainer(
                        setting: 'Change Your Information',
                        settingicon: Icons.info),
                  ),
                  SizedBox(
                    height: 28,
                  ),
                  GestureDetector(
                    onTap: () {
                       Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: ((context) => Resetpass(
                                  ))));
                    },
                    child: SettingContainer(
                        setting: 'Reset Your Password',
                        settingicon: Icons.password),
                  ),
                  SizedBox(
                    height: 28,
                  ),
                  SettingContainer(
                      setting: 'Visit Our Website', settingicon: Icons.web)
                ],
              ),
            ),
          ),
          SizedBox(
            height: 120,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'lib/images/learnable-blue.png',
                color: Colors.lightBlue,
                height: 40,
              )
            ],
          )
        ],
      ),
    );
  }
}
