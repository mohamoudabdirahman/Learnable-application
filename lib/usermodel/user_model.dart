import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserModel {
  String? uid;
  String? firstname;
  String? lastname;
  String? email;
  String? phonenumber;
  bool? isinstructor = false;
  final auth = FirebaseAuth.instance.currentUser;
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  UserModel(
      {this.uid,
      this.firstname,
      this.lastname,
      this.email,
      this.isinstructor,
      this.phonenumber});

  //recieving data from the server

  // ignore: avoid_types_as_parameter_names
  factory UserModel.fromMap(map) {
    return UserModel(
        uid: map[FirebaseAuth.instance.currentUser!.uid],
        firstname: map['First Name'],
        phonenumber: map['Phone Number'],
        lastname: map['Last Name'],
        email: map['Email'],
        isinstructor: map['Isinstructor']);
  }

  //sending data to the server

  Map<String, dynamic> toMap() {
    return {
      'uid': FirebaseAuth.instance.currentUser!.uid,
      'First Name': firstname,
      'Last Name': lastname,
      'Email': email,
      'Isinstructor': isinstructor
    };
  }
}

class InstructorModel {
  String? uid;
  String? firstname;
  String? lastname;
  String? email;
  bool? isinstructor = false;
  final auth = FirebaseAuth.instance.currentUser;
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  InstructorModel(
      {this.uid, this.firstname, this.lastname, this.email, this.isinstructor});

  //recieving data from the server

  // ignore: avoid_types_as_parameter_names
  factory InstructorModel.fromMap(map) {
    return InstructorModel(
        uid: map[FirebaseAuth.instance.currentUser!.uid],
        firstname: map['First Name'],
        lastname: map['Last Name'],
        email: map['Email'],
        isinstructor: map['Isinstructor']);
  }

  //sending data to the server

  Map<String, dynamic> toMap() {
    return {
      'uid': FirebaseAuth.instance.currentUser!.uid,
      'First Name': firstname,
      'Last Name': lastname,
      'Email': email,
      'Isinstructor': isinstructor
    };
  }
}

class InstructorImageUpload {
  String? downlaodurl;

  InstructorImageUpload({this.downlaodurl});

  factory InstructorImageUpload.fromMap(map) {
    return InstructorImageUpload(downlaodurl: map['downloadUrl']);
  }

  Map<String, dynamic> toMap() {
    return {'downloadUrl': downlaodurl};
  }
}

class CourseModel {
  String? coursetitle;
  String? courterating;
  String? price;
  String? desc;
  String? thumbnail;
  String? docid = FirebaseFirestore.instance.collection("Course").doc().id;
  final auth = FirebaseAuth.instance.currentUser;

  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  CourseModel(
      {this.coursetitle,
      this.docid,
      this.courterating,
      this.price,
      this.desc,
      this.thumbnail});

  factory CourseModel.fromMap(map) {
    return CourseModel(
        coursetitle: map['Coursetitle'],
        docid: map["docid"],
        courterating: map['Courserating'],
        price: map['price'],
        desc: map['desc'],
        thumbnail: map['thumbnail']);
  }

  Map<String, dynamic> toMap() {
    return {
      'Coursetitle': coursetitle,
      'Courserating': courterating,
      "docid": docid,
      'price': price,
      'desc': desc,
      'thumbnail': thumbnail
    };
  }
}

class ChapterModel {
  String? chaptertitle;
  String? videolesson;

  ChapterModel({this.chaptertitle, this.videolesson});

  factory ChapterModel.fromMap(map) {
    return ChapterModel(
        chaptertitle: map['chaptitle'], videolesson: map['vidurl']);
  }

  Map<String, dynamic> toMap() {
    return {'chaptitle': chaptertitle, 'vidurl': videolesson};
  }
}

class Bookmarks {
  bool? isbookmarked;
  String? coursename;
  String? documentid;
  String? timestamp;
  String? thumburl;
  Bookmarks({this.isbookmarked, this.coursename, this.documentid,this.timestamp,this.thumburl});

  factory Bookmarks.fromMap(map) {
    return Bookmarks(
        isbookmarked: map['Isbookmarked'],
        coursename: map['Course'],
        documentid: map['DocumentId'],
        timestamp: map['Timestamp'],
        thumburl: map['thumburl']);
  }
  Map<String, dynamic> toMap() {
    return {
      'Isbookmarked': isbookmarked,
      'Course': coursename,
      'DocumentId': documentid,
      'Timestamp' : timestamp,
      'thumurl' : thumburl
    };
  }
}
