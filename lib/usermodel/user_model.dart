import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserModel {
  String? uid;
  String? firstname;
  String? lastname;
  String? email;
  bool? isinstructor = false;
  final auth = FirebaseAuth.instance.currentUser;
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  UserModel(
      {this.uid, this.firstname, this.lastname, this.email, this.isinstructor});

  //recieving data from the server

  // ignore: avoid_types_as_parameter_names
  factory UserModel.fromMap(map) {
    return UserModel(
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
