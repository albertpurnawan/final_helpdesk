import 'package:flutter/material.dart';
import 'package:helpdesk_skripsi/util/drawer.dart';

class ReportPage extends StatelessWidget {
  const ReportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Report"),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      drawer: const MyDrawer(),
    );
  }
}
