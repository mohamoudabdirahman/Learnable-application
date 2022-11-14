// ignore_for_file: prefer_const_constructors

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:provider/provider.dart';

class Searchbar extends StatefulWidget {
  String? instid;
  Searchbar({Key? key, required this.instid}) : super(key: key);

  @override
  State<Searchbar> createState() => _SearchbarState();
}

class _SearchbarState extends State<Searchbar> {
  String title = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Card(
            child: TextFormField(
              onTap: () {},
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16)),
                  contentPadding: EdgeInsets.all(15.0),
                  fillColor: Colors.white,
                  filled: true,
                  suffixIcon: GestureDetector(
                      onTap: () {},
                      child: Icon(
                        FontAwesomeIcons.search,
                        size: 18,
                      )),
                  enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.lightBlue, width: 0.8),
                      borderRadius: BorderRadius.circular(16)),
                  hintText: "Search Courses",
                  hintStyle: TextStyle(fontSize: 12, color: Colors.lightBlue)),
              style: TextStyle(fontSize: 14),
              onChanged: (value) {
                setState(() {
                  title = value;
                });
              },
            ),
          ),
        ),
        body: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('Users')
                .where('Isinstructor', isEqualTo: true)
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else {
                return StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collectionGroup('Course')
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                            itemCount: snapshot.data?.docs.length,
                            itemBuilder: (context, index) {
                              var data = snapshot.data?.docs[index].data()
                                  as Map<String, dynamic>;
                              if (title.isEmpty) {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            width: 1, color: Colors.lightBlue),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: ListTile(
                                        leading: Container(
                                          width: 90,
                                          height: 70,
                                          child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              child:  CachedNetworkImage(
                                                            imageUrl:
                                                                data['thumbnail'],
                                                            height: 70,
                                                            width: 90,
                                                            maxHeightDiskCache:
                                                                250,
                                                            fit: BoxFit.cover,
                                                            errorWidget:
                                                                (context, url,
                                                                    error) {
                                                              return Center(
                                                                child: Icon(
                                                                  Icons.error,
                                                                  color: Colors
                                                                      .red,
                                                                ),
                                                              );
                                                            },
                                                            placeholder: (context,
                                                                    imageurl) =>
                                                                Center(
                                                                    child: SizedBox(
                                                                        height: 50,
                                                                        width: 50,
                                                                        child: LoadingIndicator(
                                                                          indicatorType:
                                                                              Indicator.ballRotateChase,
                                                                          colors: [
                                                                            Colors.white
                                                                          ],
                                                                        ))),
                                                          )),
                                        ),
                                        title: Text(data['coursetitle']),
                                         subtitle: Text(data['timestamp'],
                                        overflow: TextOverflow.ellipsis,)
                                      ),
                                    ),
                                  ),
                                );
                              }
                              if (data['coursetitle']
                                  .toString()
                                  .toLowerCase()
                                  .startsWith(title.toLowerCase())) {
                                return  Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            width: 1, color: Colors.lightBlue),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: ListTile(
                                        leading: Container(
                                          width: 90,
                                          height: 70,
                                          child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              child: CachedNetworkImage(
                                                            imageUrl:
                                                                data['thumbnail'],
                                                            height: 70,
                                                            width: 90,
                                                            maxHeightDiskCache:
                                                                250,
                                                            fit: BoxFit.cover,
                                                            errorWidget:
                                                                (context, url,
                                                                    error) {
                                                              return Center(
                                                                child: Icon(
                                                                  Icons.error,
                                                                  color: Colors
                                                                      .red,
                                                                ),
                                                              );
                                                            },
                                                            placeholder: (context,
                                                                    imageurl) =>
                                                                Center(
                                                                    child: SizedBox(
                                                                        height: 50,
                                                                        width: 50,
                                                                        child: LoadingIndicator(
                                                                          indicatorType:
                                                                              Indicator.ballRotateChase,
                                                                          colors: [
                                                                            Colors.white
                                                                          ],
                                                                        ))),
                                                          )),
                                        ),
                                        title: Text(data['coursetitle']),
                                        subtitle: Text(data['timestamp'],
                                        overflow: TextOverflow.ellipsis,),
                                      ),
                                    ),
                                  ),
                                );
                              }
                              return Container();
                            });
                      }
                      return Container();
                    });
              }
            }));
  }
}
