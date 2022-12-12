import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:helpdesk_skripsi/Model/browse_model.dart';
import 'package:helpdesk_skripsi/data/browse_issue_data.dart';
import 'package:helpdesk_skripsi/routes/routes.dart';
import 'package:helpdesk_skripsi/style.dart';
import 'package:helpdesk_skripsi/util/appbar.dart';
import 'package:intl/intl.dart';

class BrowsesDetailPage extends StatefulWidget {
  const BrowsesDetailPage({super.key});

  @override
  State<BrowsesDetailPage> createState() => _BrowseDetailPageState();
}

class _BrowseDetailPageState extends State<BrowsesDetailPage> {
  List<BrowseIssue> issueData = allIssue;
  String ticketNum = Get.parameters['tickteNum'].toString();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(title: 'Detail Ticket', showBackBtn: true),
      backgroundColor: primaryColor,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            ElevatedButton.icon(
                style: TextButton.styleFrom(
                  foregroundColor: primaryColor,
                  backgroundColor: greyColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  Get.toNamed(
                    '${RouteClass.showstatus}/${Get.parameters['tickteNum']}',
                  );
                },
                icon: const Icon(Icons.info_outline_rounded),
                label: Text('Show Status',
                    style: GoogleFonts.inter(
                        color: primaryColor, fontWeight: FontWeight.bold))),
            const SizedBox(height: 10),
            //  Top card
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
                    Text("Status:",
                        style: GoogleFonts.inter(
                            fontSize: 15,
                            color: primaryColor,
                            fontWeight: FontWeight.bold)),
                    const SizedBox(height: 10),
                    Text(issueData[0].status,
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          color: primaryColor,
                        )),
                    Divider(
                      color: primaryColor,
                      height: 30,
                      thickness: 1,
                    ),
                    Text("Created Date:",
                        style: GoogleFonts.inter(
                            fontSize: 15,
                            color: primaryColor,
                            fontWeight: FontWeight.bold)),
                    const SizedBox(height: 10),
                    Text(DateFormat.yMd().format(issueData[0].createdDate),
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          color: primaryColor,
                        )),
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
                    Text("Created By:",
                        style: GoogleFonts.inter(
                            fontSize: 15,
                            color: primaryColor,
                            fontWeight: FontWeight.bold)),
                    const SizedBox(height: 10),
                    Text(issueData[1].createdBy,
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
            // Bottom Card
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // icon dan garis
                  Column(
                    children: [
                      Icon(
                        Icons.circle,
                        size: 17,
                        color: blackColor,
                      ),
                      const SizedBox(width: 10),
                      Container(
                          height: MediaQuery.of(context).size.height * 0.7,
                          width: 1,
                          color: blackColor),
                    ],
                  ),
                  // card problem detail
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Problem Detail",
                            style: GoogleFonts.inter(
                                fontSize: 18,
                                color: greyColor,
                                fontWeight: FontWeight.bold)),
                        const SizedBox(height: 10),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.8,
                          child: Card(
                            elevation: 10,
                            color: secondaryColor,
                            child: Padding(
                              padding: const EdgeInsets.all(20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("On Handled By",
                                      style: GoogleFonts.inter(
                                          fontSize: 15,
                                          color: primaryColor,
                                          fontWeight: FontWeight.bold)),
                                  const SizedBox(height: 10),
                                  Text('--',
                                      style: GoogleFonts.inter(
                                        fontSize: 12,
                                        color: primaryColor,
                                      )),
                                  Divider(
                                    color: primaryColor,
                                    height: 30,
                                    indent: 5,
                                    endIndent: 5,
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
                                    indent: 5,
                                    endIndent: 5,
                                    thickness: 1,
                                  ),
                                  Text("Attachments",
                                      style: GoogleFonts.inter(
                                          fontSize: 15,
                                          color: primaryColor,
                                          fontWeight: FontWeight.bold)),
                                  const SizedBox(height: 10),
                                  for (int i = 0; i < 1; i++)
                                    Card(
                                      elevation: 5,
                                      color: primaryColor,
                                      child: GestureDetector(
                                        onTap: () {
                                          showDialog(
                                              context: context,
                                              builder: (context) => AlertDialog(
                                                    title: Text(
                                                        issueData[1].createdBy,
                                                        style:
                                                            GoogleFonts.inter(
                                                                fontSize: 14,
                                                                color:
                                                                    blackColor,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold)),
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
                                                  decoration: TextDecoration
                                                      .underline)),
                                        ),
                                      ),
                                    ),
                                  Divider(
                                    color: primaryColor,
                                    height: 30,
                                    indent: 5,
                                    endIndent: 5,
                                    thickness: 1,
                                  ),
                                  Text("Messages/Comments",
                                      style: GoogleFonts.inter(
                                          fontSize: 15,
                                          color: primaryColor,
                                          fontWeight: FontWeight.bold)),
                                  const SizedBox(height: 10),
                                  Text("--",
                                      style: GoogleFonts.inter(
                                        fontSize: 12,
                                        color: primaryColor,
                                      )),
                                  Divider(
                                    color: primaryColor,
                                    height: 30,
                                    indent: 5,
                                    endIndent: 5,
                                    thickness: 1,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
            const Card()
          ],
        ),
      ),
    );
  }
}
