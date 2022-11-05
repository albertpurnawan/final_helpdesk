import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:helpdesk_skripsi/routes/routes.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({super.key});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            // decoration: const BoxDecoration(color: Colors.red),
            child: Column(
              children: [
                Container(
                  height: 100,
                  padding: const EdgeInsets.all(12),
                  child: Center(
                    child: Image.asset(
                      "assets/images/logo.png",
                    ),
                  ),
                ),
                // Image.asset("assets/images/logo.png"),
                const SizedBox(height: 4),
                Text(
                  "Help Desk Mobile",
                  style: GoogleFonts.inter(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              ],
            ),
          ),
          // CREATE TICKET
          ListTile(
            leading: const Icon(
              Icons.info,
              size: 26,
            ),
            title: Text(
              'Create Ticket',
              style: GoogleFonts.inter(
                color: Colors.black,
                fontSize: 16,
              ),
            ),
            onTap: () {
              Get.toNamed(RouteClass.getCreateTicketRoute());
            },
          ),
          // REPORT HELPDESK
          ListTile(
            leading: const Icon(
              Icons.bar_chart,
              size: 26,
            ),
            title: Text(
              'Report Helpdesk',
              style: GoogleFonts.inter(
                color: Colors.black,
                fontSize: 16,
              ),
            ),
            onTap: () {},
          ),
          // BROWSE
          ListTile(
            leading: const Icon(
              Icons.search,
              size: 26,
            ),
            title: Text(
              'Browse',
              style: GoogleFonts.inter(
                color: Colors.black,
                fontSize: 16,
              ),
            ),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
