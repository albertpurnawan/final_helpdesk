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
          //DASHBOARD
          const SizedBox(height: 16),
          buildDrawerItem(
            icon: Icons.dashboard,
            text: "Dashboard",
            onTap: () => navigate(0),
            tileColor: Get.currentRoute == RouteClass.getDashboardRoute()
                ? Colors.green[50]
                : null,
            textIconColor: Get.currentRoute == RouteClass.getDashboardRoute()
                ? Colors.green
                : Colors.black,
          ),
          //CREATE TICKET
          const SizedBox(height: 16),
          buildDrawerItem(
            icon: Icons.info,
            text: "Create Ticket",
            onTap: () => navigate(1),
            tileColor: Get.currentRoute == RouteClass.getCreateTicketRoute()
                ? Colors.green[50]
                : null,
            textIconColor: Get.currentRoute == RouteClass.getCreateTicketRoute()
                ? Colors.green
                : Colors.black,
          ),
          //TICKET POOL
          const SizedBox(height: 16),
          buildDrawerItem(
            icon: Icons.list,
            text: "Ticket Pool",
            onTap: () => navigate(2),
            tileColor: Get.currentRoute == RouteClass.getTicketPoolRoute()
                ? Colors.green[50]
                : null,
            textIconColor: Get.currentRoute == RouteClass.getTicketPoolRoute()
                ? Colors.green
                : Colors.black,
          ),
          //JOBLIST
          const SizedBox(height: 16),
          buildDrawerItem(
            icon: Icons.cases_rounded,
            text: "My Joblist",
            onTap: () => navigate(3),
            tileColor: Get.currentRoute == RouteClass.getJoblistRoute()
                ? Colors.green[50]
                : null,
            textIconColor: Get.currentRoute == RouteClass.getJoblistRoute()
                ? Colors.green
                : Colors.black,
          ),
          //MANAGE MASTER CATEGORY
          const SizedBox(height: 16),
          buildDrawerItem(
            icon: Icons.settings,
            text: "Manage Master Category",
            onTap: () => navigate(4),
            tileColor: Get.currentRoute == RouteClass.getMasterCategoryRoute()
                ? Colors.green[50]
                : null,
            textIconColor:
                Get.currentRoute == RouteClass.getMasterCategoryRoute()
                    ? Colors.green
                    : Colors.black,
          ),
          //REPORT HELPDESK
          const SizedBox(height: 16),
          buildDrawerItem(
            icon: Icons.bar_chart,
            text: "Report Helpdesk",
            onTap: () => navigate(5),
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
            onTap: () => navigate(6),
            tileColor: Get.currentRoute == RouteClass.getBrowseRoute()
                ? Colors.green[50]
                : null,
            textIconColor: Get.currentRoute == RouteClass.getBrowseRoute()
                ? Colors.green
                : Colors.black,
          ),
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
    // Navigator.pop(context);
    switch (index) {
      case 0:
        Get.toNamed(RouteClass.getDashboardRoute());
        break;
      case 1:
        Get.toNamed(RouteClass.getCreateTicketRoute());
        break;
      case 2:
        Get.toNamed(RouteClass.getTicketPoolRoute());
        break;
      case 3:
        Get.toNamed(RouteClass.getJoblistRoute());
        break;
      case 4:
        Get.toNamed(RouteClass.getMasterCategoryRoute());
        break;
      case 5:
        Get.toNamed(RouteClass.getReportRoute());
        break;
      case 6:
        Get.toNamed(RouteClass.getBrowseRoute());
        break;
    }
  }
}
