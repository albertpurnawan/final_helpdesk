import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:helpdesk_skripsi/Model/browse_model.dart';
import 'package:helpdesk_skripsi/data/browse_issue_data.dart';
import 'package:helpdesk_skripsi/style.dart';
import 'package:helpdesk_skripsi/util/appbar.dart';

class HistoryDetailPage extends StatefulWidget {
  const HistoryDetailPage({super.key});

  @override
  State<HistoryDetailPage> createState() => _HistoryDetailPageState();
}

class _HistoryDetailPageState extends State<HistoryDetailPage> {
  List<BrowseIssue> issueData = allIssue;
  String ticketNum = Get.parameters['tickteNum'].toString();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(title: '', showBackBtn: true),
      backgroundColor: primaryColor,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              elevation: 20,
              color: secondaryColor,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Ticket Number:",
                        style: GoogleFonts.inter(
                            fontSize: 15,
                            color: primaryColor,
                            fontWeight: FontWeight.bold)),
                    const SizedBox(height: 10),
                    Text(Get.parameters['tickteNum'].toString(),
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          color: primaryColor,
                        )),
                    Divider(
                      color: primaryColor,
                      height: 30,
                      thickness: 1,
                    ),
                    Text(
                      "Description",
                      style: GoogleFonts.inter(
                          fontSize: 15,
                          color: primaryColor,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      issueData[2].issueDesc,
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        color: primaryColor,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                    Divider(
                      color: primaryColor,
                      height: 30,
                      thickness: 1,
                    ),
                    Text("Request For:",
                        style: GoogleFonts.inter(
                            fontSize: 15,
                            color: primaryColor,
                            fontWeight: FontWeight.bold)),
                    const SizedBox(height: 10),
                    Text(issueData[0].requestFor,
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          color: primaryColor,
                        )),
                    Divider(
                      color: primaryColor,
                      height: 30,
                      thickness: 1,
                    ),
                    Text("File:",
                        style: GoogleFonts.inter(
                            fontSize: 15,
                            color: primaryColor,
                            fontWeight: FontWeight.bold)),
                    const SizedBox(height: 10),
                    for (int i = 0; i < 5; i++)
                      Card(
                        elevation: 5,
                        color: primaryColor,
                        child: GestureDetector(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                      title: Text(issueData[1].createdBy,
                                          style: GoogleFonts.inter(
                                              fontSize: 14,
                                              color: blackColor,
                                              fontWeight: FontWeight.bold)),
                                      content: Image.asset(
                                          "assets/images/iuProfile.jpg"),
                                    ));
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Text(issueData[1].createdBy,
                                style: GoogleFonts.inter(
                                    fontSize: 12,
                                    color: secondaryColor,
                                    decoration: TextDecoration.underline)),
                          ),
                        ),
                      ),
                    Divider(
                      color: primaryColor,
                      height: 30,
                      thickness: 1,
                    ),
                    Text("Suport Category:",
                        style: GoogleFonts.inter(
                            fontSize: 15,
                            color: primaryColor,
                            fontWeight: FontWeight.bold)),
                    const SizedBox(height: 10),
                    Text(issueData[1].supportCategory,
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          color: primaryColor,
                        )),
                    Divider(
                      color: primaryColor,
                      height: 30,
                      thickness: 1,
                    ),
                    Text("Category:",
                        style: GoogleFonts.inter(
                            fontSize: 15,
                            color: primaryColor,
                            fontWeight: FontWeight.bold)),
                    const SizedBox(height: 10),
                    Text(issueData[1].supportCategory,
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          color: primaryColor,
                        )),
                    Divider(
                      color: primaryColor,
                      height: 30,
                      thickness: 1,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
