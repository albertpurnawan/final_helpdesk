import 'package:flutter/src/widgets/framework.dart';

class User {
  final String UserLogin;
  final String AccessibleApplication;
  final String AccessiblePortalMenu;

  User(
      {required this.UserLogin,
      required this.AccessibleApplication,
      required this.AccessiblePortalMenu});

  Map<String, dynamic> toMap() {
    return {
      'UserLogin': UserLogin,
      'AccessibleApplication': AccessibleApplication,
      'AccessiblePortalMenu': AccessiblePortalMenu
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      UserLogin: map['UserLogin'] ?? '',
      AccessibleApplication: map['AccessibleApplication'] ?? '',
      AccessiblePortalMenu: map['AccessiblePortalMenu'] ?? '',
    );
  }
}

class UserProfile {
  final String username;
  final String password;
  final String name;
  final String empId;
  final String email;
  final String groupCode;
  final bool isDeleted;
  final bool usingLDAP;

  UserProfile(
      {required this.username,
      required this.password,
      required this.name,
      required this.empId,
      required this.email,
      required this.groupCode,
      required this.isDeleted,
      required this.usingLDAP});

  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'password': password,
      'name': name,
      'empId': empId,
      'email': email,
      'groupCode': groupCode,
      'isDeleted': isDeleted,
      'usingLDAP': usingLDAP
    };
  }

  factory UserProfile.fromMap(Map<String, dynamic> map) {
    return UserProfile(
        username: map['username'] ?? '',
        password: map['password'] ?? '',
        name: map['name'] ?? '',
        empId: map['empId'] ?? '',
        email: map['email'] ?? '',
        groupCode: map['groupCode'] ?? '',
        isDeleted: map['isDeleted'],
        usingLDAP: map['usingLDAP']);
  }
}
