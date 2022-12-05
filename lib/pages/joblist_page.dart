import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:helpdesk_skripsi/style.dart';
import 'package:helpdesk_skripsi/tabs/joblist_history_tab.dart';
import 'package:helpdesk_skripsi/util/appbar.dart';

class JoblistPage extends StatelessWidget {
  const JoblistPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: const MyAppBar(title: 'My Joblist', showBackBtn: true),
        backgroundColor: primaryColor,
        body: Column(
          children: [
            TabBar(
              physics: const BouncingScrollPhysics(),
              indicatorColor: blackColor,
              isScrollable: true,
              tabs: [
                Tab(
                  child: Text(
                    "In Progress",
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      color: blackColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Tab(
                  child: Text(
                    "History",
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      color: blackColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  Center(
                    child: Text(
                      "No record",
                      style: GoogleFonts.inter(
                        fontSize: 25,
                        color: blackColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const JoblistHistory(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
