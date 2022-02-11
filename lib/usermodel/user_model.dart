import 'package:firebase_auth/firebase_auth.dart';

class UserModel {
  String? uid;
  String? firstname;
  String? lastname;
  String? email;
  bool? isinstructor = false;

  UserModel({this.uid, this.firstname, this.lastname, this.email, this.isinstructor});

  //recieving data from the server

  // ignore: avoid_types_as_parameter_names
  factory UserModel.fromMap(map) {
    return UserModel(
        uid: map('uid'),
        firstname: map('First Name'),
        lastname: map('Last Name'),
        email: map('Email'),
        isinstructor: map('Isinstructor'));
  }

  //sending data to the server

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'First Name': firstname,
      'Last Name': lastname,
      'Email': email,
      'Isinstructor': isinstructor
    };
  }
}




