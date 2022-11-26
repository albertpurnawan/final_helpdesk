import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:helpdesk_skripsi/Model/browse_model.dart';
import 'package:helpdesk_skripsi/data/browse_issue_data.dart';
import 'package:helpdesk_skripsi/style.dart';
import 'package:helpdesk_skripsi/util/appbar.dart';
import 'package:helpdesk_skripsi/util/bottom_navbar.dart';
import 'package:helpdesk_skripsi/util/searchBar.dart';
import 'package:intl/intl.dart';

import '../routes/routes.dart';

class BrowsePage extends StatefulWidget {
  const BrowsePage({super.key});

  @override
  State<BrowsePage> createState() => _BrowsePageState();
}

class _BrowsePageState extends State<BrowsePage> {
  List<BrowseIssue> issueData = allIssue;
  String query = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(title: 'Browse Ticket'),
      backgroundColor: primaryColor,
      body: Column(
        children: [
          buildSearch(),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: ListView.builder(
                itemCount: issueData.length,
                itemBuilder: (context, index) {
                  final issue = issueData[index];
                  return GestureDetector(
                    child: buildCard(issue),
                    onTap: () {
                      Get.toNamed('${RouteClass.detail}/${issue.ticketNum}');
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: const BottomNavbar(),
      // drawer: const MyDrawer(),
    );
  }

  Card buildCard(BrowseIssue issue) {
    return Card(
      elevation: 10,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // COLUMN KIRI
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Ticket Number",
                      style: GoogleFonts.inter(
                          fontSize: 15,
                          color: secondaryColor,
                          fontWeight: FontWeight.bold),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5),
                      child: Text(
                        issue.ticketNum.toString(),
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          color: secondaryColor,
                        ),
                      ),
                    ),
                    Text(
                      "Request For",
                      style: GoogleFonts.inter(
                          fontSize: 15,
                          color: secondaryColor,
                          fontWeight: FontWeight.bold),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5),
                      child: SizedBox(
                        width: 130,
                        child: Text(
                          issue.requestFor.toString(),
                          style: GoogleFonts.inter(
                            fontSize: 12,
                            color: secondaryColor,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    Text(
                      "Status",
                      style: GoogleFonts.inter(
                          fontSize: 15,
                          color: secondaryColor,
                          fontWeight: FontWeight.bold),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5),
                      child: Text(
                        issue.status.toString(),
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          color: secondaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
                // COLUMN KANAN
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Created Date",
                      style: GoogleFonts.inter(
                          fontSize: 15,
                          color: secondaryColor,
                          fontWeight: FontWeight.bold),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5),
                      child: Text(
                        DateFormat.yMd().format(issue.createdDate),
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          color: secondaryColor,
                        ),
                      ),
                    ),
                    Text(
                      "Created By",
                      style: GoogleFonts.inter(
                          fontSize: 15,
                          color: secondaryColor,
                          fontWeight: FontWeight.bold),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5),
                      child: SizedBox(
                        width: 130,
                        child: Text(
                          issue.createdBy.toString(),
                          style: GoogleFonts.inter(
                            fontSize: 12,
                            color: secondaryColor,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    Text(
                      "Support Category",
                      style: GoogleFonts.inter(
                          fontSize: 15,
                          color: secondaryColor,
                          fontWeight: FontWeight.bold),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5),
                      child: Text(
                        issue.supportCategory.toString(),
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          color: secondaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Text(
            "Issue Desc",
            style: GoogleFonts.inter(
                fontSize: 15,
                color: secondaryColor,
                fontWeight: FontWeight.bold),
          ),
          Container(
            padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
            child: Text(
              issue.issueDesc.toString(),
              style: GoogleFonts.inter(
                fontSize: 12,
                color: secondaryColor,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildSearch() => SearchWidget(
        text: query,
        hintText: 'Search...',
        onChanged: searchIssue,
      );

  void searchIssue(String query) {
    final tickets = allIssue.where((issue) {
      final ticketNum = issue.ticketNum.toString().toLowerCase();
      final createdBy = issue.createdBy.toLowerCase();
      final requestFor = issue.requestFor.toLowerCase();
      final suupportCategory = issue.supportCategory.toLowerCase();
      final searchLower = query.toLowerCase();

      return ticketNum.contains(searchLower) ||
          createdBy.contains(searchLower) ||
          requestFor.contains(searchLower) ||
          suupportCategory.contains(searchLower);
    }).toList();

    setState(() {
      this.query = query;
      issueData = tickets;
    });
  }
}
