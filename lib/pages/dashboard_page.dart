import 'package:flutter/material.dart';
import 'package:helpdesk_skripsi/util/drawer.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dashboard"),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
      ),
      drawer: const MyDrawer(),
    );
  }
}
