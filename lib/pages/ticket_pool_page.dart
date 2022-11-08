import 'package:flutter/material.dart';
import 'package:helpdesk_skripsi/util/bottom_navbar.dart';

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
      bottomNavigationBar: const BottomNavbar(),
      // drawer: const MyDrawer(),
    );
  }
}
