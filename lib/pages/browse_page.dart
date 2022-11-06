import 'package:flutter/material.dart';
import 'package:helpdesk_skripsi/util/drawer.dart';

class BrowsePage extends StatelessWidget {
  const BrowsePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Browse"),
        centerTitle: true,
        backgroundColor: Colors.red,
      ),
      drawer: const MyDrawer(),
    );
  }
}
