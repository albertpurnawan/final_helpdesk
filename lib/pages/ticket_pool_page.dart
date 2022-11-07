import 'package:flutter/material.dart';
import 'package:helpdesk_skripsi/util/drawer.dart';

class TicketPoolPage extends StatelessWidget {
  const TicketPoolPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ticket Pool"),
        centerTitle: true,
        backgroundColor: Colors.amber,
      ),
      drawer: const MyDrawer(),
    );
  }
}
