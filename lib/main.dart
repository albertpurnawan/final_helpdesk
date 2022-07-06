// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import 'NavBar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        drawer: NavBar(),
        appBar: AppBar(
          title: Text("Mayora Helpdesk"),
          backgroundColor: Colors.red,
        ),
      ),
    );
  }
}
