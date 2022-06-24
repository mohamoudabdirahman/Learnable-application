// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:learnable/UI/util/Courseplaying.dart';
import 'package:learnable/usermodel/user_model.dart';
import 'package:loading_indicator/loading_indicator.dart';

class Wishlist extends StatefulWidget {
  const Wishlist({Key? key}) : super(key: key);

  @override
  State<Wishlist> createState() => _WishlistState();
}

class _WishlistState extends State<Wishlist> {
  var formatedate;
  User? user = FirebaseAuth.instance.currentUser;

  String? coursename;
  bool? isunwishlisted = false;
  String? bookmarkedcourse;
  bool? isbookmarked;
  String? coursenames;
  Bookmarks bookmarks = Bookmarks();
  Bookmarks obtainedcourse = Bookmarks();
  final auth = FirebaseAuth.instance;
  List<QueryDocumentSnapshot<Map<String, dynamic>>>? result;
  String? docid;
  bool? iszero;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    User? user = auth.currentUser;
    FirebaseFirestore.instance
        .collection('Users')
        .doc(user!.uid)
        .collection('Wishlists')
        .get()
        .then((value) {
      //obtainedcourse = Bookmarks.fromMap(value.docs);
      if (value.docs.isNotEmpty && value.docs != null) {
        result = value.docs;
      } else {
        iszero = true;
      }
      setState(() {});
      //print(result[0]['Course']);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: null,
          title: Text(
            'Wishlist',
            style: TextStyle(color: Colors.grey),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0.0,
        ),
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                  child: iszero == true
                      ? AlertDialog(
                          content: Text(
                            'You have no saved Wishlists 🙄',
                            textAlign: TextAlign.center,
                          ),
                        )
                      : ListView.builder(
                          itemCount: result?.length,
                          itemBuilder: (context, index) {
                            var time = result?[index]['Timestamp'];
                            docid = result?[index]['DocumentId'];
                            //  var date = DateTime.parse(time.toString());
                            //             formatedate = (DateFormat('yyy')
                            //                 .format(date.toUtc()));
                            return Padding(
                              padding: const EdgeInsets.only(
                                  top: 15, right: 8, left: 8),
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                          color: (Color.fromRGBO(
                                              117, 117, 117, 0.527)),
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
                                  padding: const EdgeInsets.all(8.0),
                                  child: ListTile(
                                    leading: Container(
                                        width: 90,
                                        height: 90,
                                        decoration: BoxDecoration(
                                            boxShadow: [
                                              BoxShadow(
                                                  color: (Color.fromRGBO(
                                                      117, 117, 117, 0.527)),
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
                                                (Color.fromRGBO(
                                                    238, 238, 238, 0.397)),
                                                (Color.fromARGB(
                                                    129, 255, 255, 255)),
                                              ],
                                            ),
                                            color: Colors.lightBlue,
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            child: Image.network(
                                              "${result?[index]['thumurl']}",
                                              errorBuilder: ((context, error,
                                                  stackTrace) {
                                                return Icon(
                                                    Icons.do_not_disturb);
                                              }),
                                              fit: BoxFit.cover,
                                            ))),
                                    title: Text('${result?[index]['Course']}'),
                                    subtitle:
                                        Text('${result?[index]['Timestamp']}'),
                                    trailing: IconButton(
                                        onPressed: (() {
                                          setState(() {
                                            if (isunwishlisted == false) {
                                              isunwishlisted = true;
                                              deletebookmark();
                                              print(docid);
                                            }
                                          });
                                        }),
                                        icon: Icon(
                                          Icons.bookmark_remove,
                                          color: isunwishlisted == false
                                              ? Colors.lightBlue
                                              : Colors.grey,
                                        )),
                                  ),
                                ),
                              ),
                            );
                          }))
            ],
          ),
        ));
  }

  void deletebookmark() async {
 bookmarks.isbookmarked = true;
 bookmarks.coursename = coursename;
    bookmarks.documentid = docid;
    await FirebaseFirestore.instance
        .collection('Users')
        .doc(user!.uid)
        .collection('Wishlists')
        .doc(docid)
        .delete();
  }
}
