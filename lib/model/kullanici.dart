import 'package:flutter/material.dart';

class Kullanici {
  final String userID;
  String email;
  String userName;
  String profilUrl;

  Kullanici({@required this.userID, @required this.email,this.userName,this.profilUrl});

  Map<String, dynamic> toMap() {
    return {
      'userID': userID,
      'email': email,
      'userName': userName ?? '',
      'profilUrl': profilUrl ?? '',
    };
  }

  Kullanici.fromMap(Map<String, dynamic> map)
      : userID = map['userID'],
        email = map['email'],
        userName = map['userName'],
        profilUrl = map['profilUrl'];

  @override
  String toString() {
    return 'Kullanici{userID: $userID, email: $email, userName: $userName, profilUrl: $profilUrl}';
  }
}
