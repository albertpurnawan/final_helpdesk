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
          buildDrawerHeader(),
          //CREATE TICKET
          const SizedBox(height: 16),
          buildDrawerItem(
            icon: Icons.info,
            text: "Create Ticket",
            onTap: () => navigate(0),
            tileColor: Get.currentRoute == RouteClass.getCreateTicketRoute()
                ? Colors.green[50]
                : null,
            textIconColor: Get.currentRoute == RouteClass.getCreateTicketRoute()
                ? Colors.green
                : Colors.black,
          ),
          //REPORT HELPDESK
          const SizedBox(height: 16),
          buildDrawerItem(
            icon: Icons.bar_chart,
            text: "Report Helpdesk",
            onTap: () => navigate(1),
            tileColor: Get.currentRoute == RouteClass.getReportRoute()
                ? Colors.green[50]
                : null,
            textIconColor: Get.currentRoute == RouteClass.getReportRoute()
                ? Colors.green
                : Colors.black,
          ),
          //BROWSE
          const SizedBox(height: 16),
          buildDrawerItem(
            icon: Icons.search,
            text: "Browse",
            onTap: () => navigate(2),
            tileColor: Get.currentRoute == RouteClass.getBrowseRoute()
                ? Colors.green[50]
                : null,
            textIconColor: Get.currentRoute == RouteClass.getBrowseRoute()
                ? Colors.green
                : Colors.black,
          ),
          // CREATE TICKET
          // ListTile(
          //   leading: const Icon(
          //     Icons.info,
          //     size: 26,
          //   ),
          //   title: Text(
          //     'Create Ticket',
          //     style: GoogleFonts.inter(
          //       color: Colors.black,
          //       fontSize: 16,
          //     ),
          //   ),
          //   onTap: () {
          //     Get.toNamed(RouteClass.getCreateTicketRoute());
          //   },
          // ),
          // REPORT HELPDESK
          // ListTile(
          //   leading: const Icon(
          //     Icons.bar_chart,
          //     size: 26,
          //   ),
          //   title: Text(
          //     'Report Helpdesk',
          //     style: GoogleFonts.inter(
          //       color: Colors.black,
          //       fontSize: 16,
          //     ),
          //   ),
          //   onTap: () {},
          // ),
          // BROWSE
          // ListTile(
          //   leading: const Icon(
          //     Icons.search,
          //     size: 26,
          //   ),
          //   title: Text(
          //     'Browse',
          //     style: GoogleFonts.inter(
          //       color: Colors.black,
          //       fontSize: 16,
          //     ),
          //   ),
          //   onTap: () {},
          // ),
        ],
      ),
    );
  }

  Widget buildDrawerHeader() {
    return DrawerHeader(
      child: Column(
        children: [
          Container(
            height: 100,
            padding: const EdgeInsets.all(12),
            child: Center(
              child: Image.asset("assets/images/logo.png"),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            "Help Desk Mobile",
            style: GoogleFonts.inter(
                fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
          ),
        ],
      ),
    );
  }

  Widget buildDrawerItem({
    required String text,
    required IconData icon,
    required Color textIconColor,
    required Color? tileColor,
    required Function() onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: textIconColor),
      title: Text(text, style: TextStyle(color: textIconColor)),
      tileColor: tileColor,
      onTap: onTap,
    );
  }

  navigate(int index) {
    switch (index) {
      case 0:
        Get.toNamed(RouteClass.getCreateTicketRoute());
        break;
      case 1:
        Get.toNamed(RouteClass.getReportRoute());
        break;
      case 2:
        Get.toNamed(RouteClass.getBrowseRoute());
        break;
    }
  }
}
