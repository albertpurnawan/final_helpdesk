import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:helpdesk_skripsi/Model/browse_model.dart';
import 'package:helpdesk_skripsi/data/browse_issue_data.dart';
import 'package:helpdesk_skripsi/style.dart';
import 'package:helpdesk_skripsi/util/appbar.dart';
import 'package:helpdesk_skripsi/util/bottom_navbar.dart';
import 'package:intl/intl.dart';

class BrowsePage extends StatefulWidget {
  const BrowsePage({super.key});

  @override
  State<BrowsePage> createState() => _BrowsePageState();
}

class _BrowsePageState extends State<BrowsePage> {
  List<BrowseIssue>? issueData;

  @override
  void initState() {
    issueData = allIssue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(),
      backgroundColor: primaryColor,
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: ListView.builder(
                itemCount: allIssue.length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 10,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 20, bottom: 20, top: 30),
                              child: SizedBox(
                                width: 130,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Ticket Number",
                                      style: GoogleFonts.inter(
                                          fontSize: 15,
                                          color: secondaryColor,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      allIssue[index].ticketNum.toString(),
                                      style: GoogleFonts.inter(
                                        fontSize: 12,
                                        color: secondaryColor,
                                      ),
                                    ),
                                    Text(
                                      "Request For",
                                      style: GoogleFonts.inter(
                                          fontSize: 15,
                                          color: secondaryColor,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      allIssue[index].requestFor.toString(),
                                      style: GoogleFonts.inter(
                                        fontSize: 12,
                                        color: secondaryColor,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Text(
                                      "Status",
                                      style: GoogleFonts.inter(
                                          fontSize: 15,
                                          color: secondaryColor,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      allIssue[index].status.toString(),
                                      style: GoogleFonts.inter(
                                        fontSize: 12,
                                        color: secondaryColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 140,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Created Date",
                                    style: GoogleFonts.inter(
                                        fontSize: 15,
                                        color: secondaryColor,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    DateFormat.yMd()
                                        .format(allIssue[index].createdDate),
                                    style: GoogleFonts.inter(
                                      fontSize: 12,
                                      color: secondaryColor,
                                    ),
                                  ),
                                  Text(
                                    "Created By",
                                    style: GoogleFonts.inter(
                                        fontSize: 15,
                                        color: secondaryColor,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    allIssue[index].createdBy.toString(),
                                    style: GoogleFonts.inter(
                                      fontSize: 12,
                                      color: secondaryColor,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    "Support Category",
                                    style: GoogleFonts.inter(
                                        fontSize: 15,
                                        color: secondaryColor,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    allIssue[index].supportCategory.toString(),
                                    style: GoogleFonts.inter(
                                      fontSize: 12,
                                      color: secondaryColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, bottom: 5),
                          child: Text(
                            "Issue Desc",
                            style: GoogleFonts.inter(
                                fontSize: 15,
                                color: secondaryColor,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: Text(
                            allIssue[index].issueDesc.toString(),
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
}
