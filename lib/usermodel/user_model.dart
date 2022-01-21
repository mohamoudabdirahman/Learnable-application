import 'package:firebase_auth/firebase_auth.dart';

class UserModel {
  String? uid;
  String? firstname;
  String? lastname;
  String? email;

  UserModel({this.uid, this.firstname, this.lastname, this.email});

  //recieving data from the server

  // ignore: avoid_types_as_parameter_names
  factory UserModel.fromMap(map) {
    return UserModel(
        uid: map('uid'),
        firstname: map('First Name'),
        lastname: map('Last Name'),
        email: map('Email'));
  }

  //sending data to the server

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'First Name': firstname,
      'Last Name': lastname,
      'Email': email
    };
  }
}



class Instructors {
  String? uid;
  String? name;
  String? surname;
  String? phonenumber;

  Instructors({this.name, this.surname, this.phonenumber, this.uid});

  factory Instructors.fromMap(map) {
    return Instructors(
        uid: map('uid'),
        name: map('Name'),
        surname: map('Surname'),
        phonenumber: map('Phone Number'));
  }

  Map<String, dynamic> tomap() {
    return {
      'uid': uid,
      'Name': name,
      'Surname': surname,
      'Phone Number': phonenumber
    };
  }
}
