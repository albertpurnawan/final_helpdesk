import 'package:flutter/widgets.dart';
import 'package:helpdesk_skripsi/controller/controller.dart';

class User {
  final String username;
  final String password;
  final String ua;
  final String email;
  final String image;
  final String name;
  final String groupcode;
  final String groupname;
  final String empid;

  User(
      {required this.username,
      required this.password,
      required this.ua,
      required this.email,
      required this.image,
      required this.name,
      required this.groupcode,
      required this.empid,
      required this.groupname});

  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'password': password,
      'useraccess': ua,
      'email': email,
      'image': image,
      'name': name,
      'groupcode': groupcode,
      'empid': empid,
      'groupname': groupname
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
        username: map['username'] ?? '',
        password: map['password'] ?? '',
        email: map['email'] ?? '',
        ua: map['useraccess'] ?? '',
        image: map['image'] ?? '',
        name: map['name'] ?? '',
        groupcode: map['groupcode'],
        empid: map['empid'],
        groupname: map['groupname']);
  }
}
