import 'package:flutter/material.dart';
import 'package:helpdesk_skripsi/util/drawer.dart';

class JoblistPage extends StatelessWidget {
  const JoblistPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Joblist"),
        centerTitle: true,
        backgroundColor: Colors.brown,
      ),
      drawer: const MyDrawer(),
    );
  }
}
