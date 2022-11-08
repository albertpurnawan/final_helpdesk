import 'package:flutter/material.dart';
import 'package:helpdesk_skripsi/util/bottom_navbar.dart';

class JoblistPage extends StatelessWidget {
  const JoblistPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Joblist Page"),
        centerTitle: true,
        backgroundColor: Colors.red,
      ),
      bottomNavigationBar: const BottomNavbar(),
      // drawer: const MyDrawer(),
    );
  }
}
