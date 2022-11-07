import 'package:flutter/material.dart';
import 'package:helpdesk_skripsi/util/drawer.dart';

class MasterCategoryPage extends StatelessWidget {
  const MasterCategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Manage Master Category"),
        centerTitle: true,
        backgroundColor: Colors.grey,
      ),
      drawer: const MyDrawer(),
    );
  }
}
