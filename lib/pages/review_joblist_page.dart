import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:helpdesk_skripsi/Model/browse_model.dart';
import 'package:helpdesk_skripsi/data/browse_issue_data.dart';
import 'package:helpdesk_skripsi/style.dart';
import 'package:helpdesk_skripsi/util/appbar.dart';

class ReviewJoblist extends StatefulWidget {
  const ReviewJoblist({super.key});

  @override
  State<ReviewJoblist> createState() => _ReviewJoblistState();
}

class _ReviewJoblistState extends State<ReviewJoblist> {
  List<BrowseIssue> issueData = allIssue;
  String ticketNum = Get.parameters['tickteNum'].toString();
  String repairType = '';
  String supportType = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(title: 'Review Ticket', showBackBtn: true),
      backgroundColor: primaryColor,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      Icon(
                        Icons.circle,
                        size: 17,
                        color: secondaryColor,
                      ),
                      const SizedBox(width: 10),
                      Container(
                          height: MediaQuery.of(context).size.height * 0.7,
                          width: 1,
                          color: secondaryColor),
                    ],
                  ),
                  const SizedBox(width: 10),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("User Detail",
                          style: GoogleFonts.inter(
                              fontSize: 17,
                              color: secondaryColor,
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
                                  Text("Request For",
                                      style: GoogleFonts.inter(
                                          fontSize: 15,
                                          color: primaryColor,
                                          fontWeight: FontWeight.bold)),
                                  const SizedBox(height: 10),
                                  Text('Chris Anggawana',
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
                                  Text("NIK",
                                      style: GoogleFonts.inter(
                                          fontSize: 15,
                                          color: primaryColor,
                                          fontWeight: FontWeight.bold)),
                                  const SizedBox(height: 10),
                                  Text('MM04996',
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
                                  Text("Department",
                                      style: GoogleFonts.inter(
                                          fontSize: 15,
                                          color: primaryColor,
                                          fontWeight: FontWeight.bold)),
                                  const SizedBox(height: 10),
                                  Text('IT',
                                      style: GoogleFonts.inter(
                                        fontSize: 12,
                                        color: primaryColor,
                                      )),
                                  Divider(
                                    color: primaryColor,
                                    height: 30,
                                    thickness: 1,
                                  ),
                                  Text("Location",
                                      style: GoogleFonts.inter(
                                          fontSize: 15,
                                          color: primaryColor,
                                          fontWeight: FontWeight.bold)),
                                  const SizedBox(height: 10),
                                  Text('[WL99] CNS - Region Sumatera',
                                      style: GoogleFonts.inter(
                                        fontSize: 12,
                                        color: primaryColor,
                                      )),
                                  Divider(
                                    color: primaryColor,
                                    height: 30,
                                    thickness: 1,
                                  ),
                                  Text("Phone Number/Ext",
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
                                    thickness: 1,
                                  ),
                                  Text("Contact Email",
                                      style: GoogleFonts.inter(
                                          fontSize: 15,
                                          color: primaryColor,
                                          fontWeight: FontWeight.bold)),
                                  const SizedBox(height: 10),
                                  Text('chris.anggawana@mayora.co.id',
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
                          ))
                    ],
                  )
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      Icon(
                        Icons.circle,
                        size: 17,
                        color: secondaryColor,
                      ),
                      const SizedBox(width: 10),
                      Container(
                          height: MediaQuery.of(context).size.height * 0.8,
                          width: 1,
                          color: secondaryColor),
                    ],
                  ),
                  const SizedBox(width: 10),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Problem Detail",
                          style: GoogleFonts.inter(
                              fontSize: 17,
                              color: secondaryColor,
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
                                  Text("Ticket Number",
                                      style: GoogleFonts.inter(
                                          fontSize: 15,
                                          color: primaryColor,
                                          fontWeight: FontWeight.bold)),
                                  const SizedBox(height: 10),
                                  Text(ticketNum,
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
                                  Text("Created Date",
                                      style: GoogleFonts.inter(
                                          fontSize: 15,
                                          color: primaryColor,
                                          fontWeight: FontWeight.bold)),
                                  const SizedBox(height: 10),
                                  Text('MM04996',
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
                                  Text("Description",
                                      style: GoogleFonts.inter(
                                          fontSize: 15,
                                          color: primaryColor,
                                          fontWeight: FontWeight.bold)),
                                  const SizedBox(height: 10),
                                  Text('IT',
                                      style: GoogleFonts.inter(
                                        fontSize: 12,
                                        color: primaryColor,
                                      )),
                                  Divider(
                                    color: primaryColor,
                                    height: 30,
                                    thickness: 1,
                                  ),
                                  Text("Parent Category",
                                      style: GoogleFonts.inter(
                                          fontSize: 15,
                                          color: primaryColor,
                                          fontWeight: FontWeight.bold)),
                                  const SizedBox(height: 10),
                                  Text('[WL99] CNS - Region Sumatera',
                                      style: GoogleFonts.inter(
                                        fontSize: 12,
                                        color: primaryColor,
                                      )),
                                  Divider(
                                    color: primaryColor,
                                    height: 30,
                                    thickness: 1,
                                  ),
                                  Text("Category",
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
                                    thickness: 1,
                                  ),
                                  Text("Attachment",
                                      style: GoogleFonts.inter(
                                          fontSize: 15,
                                          color: primaryColor,
                                          fontWeight: FontWeight.bold)),
                                  const SizedBox(height: 10),
                                  for (int i = 0; i < 2; i++)
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
                                ],
                              ),
                            ),
                          )),
                    ],
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      Icon(
                        Icons.circle,
                        size: 17,
                        color: secondaryColor,
                      ),
                    ],
                  ),
                  const SizedBox(width: 10),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Support Detail",
                          style: GoogleFonts.inter(
                              fontSize: 17,
                              color: secondaryColor,
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
                                  Text("Task Kanban",
                                      style: GoogleFonts.inter(
                                          fontSize: 15,
                                          color: primaryColor,
                                          fontWeight: FontWeight.bold)),
                                  const SizedBox(height: 10),
                                  Text(ticketNum.toString(),
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
                                  Text("System",
                                      style: GoogleFonts.inter(
                                          fontSize: 15,
                                          color: primaryColor,
                                          fontWeight: FontWeight.bold)),
                                  const SizedBox(height: 10),
                                  Text('MM04996',
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
                                  Text("Application",
                                      style: GoogleFonts.inter(
                                          fontSize: 15,
                                          color: primaryColor,
                                          fontWeight: FontWeight.bold)),
                                  const SizedBox(height: 10),
                                  Text('IT',
                                      style: GoogleFonts.inter(
                                        fontSize: 12,
                                        color: primaryColor,
                                      )),
                                  Divider(
                                    color: primaryColor,
                                    height: 30,
                                    thickness: 1,
                                  ),
                                  Text("Sub Category 1",
                                      style: GoogleFonts.inter(
                                          fontSize: 15,
                                          color: primaryColor,
                                          fontWeight: FontWeight.bold)),
                                  const SizedBox(height: 10),
                                  Text('IT',
                                      style: GoogleFonts.inter(
                                        fontSize: 12,
                                        color: primaryColor,
                                      )),
                                  Divider(
                                    color: primaryColor,
                                    height: 30,
                                    thickness: 1,
                                  ),
                                  Text("Sub Category 2",
                                      style: GoogleFonts.inter(
                                          fontSize: 15,
                                          color: primaryColor,
                                          fontWeight: FontWeight.bold)),
                                  const SizedBox(height: 10),
                                  Text('IT',
                                      style: GoogleFonts.inter(
                                        fontSize: 12,
                                        color: primaryColor,
                                      )),
                                  Divider(
                                    color: primaryColor,
                                    height: 30,
                                    thickness: 1,
                                  ),
                                  Text("Repair Type",
                                      style: GoogleFonts.inter(
                                          fontSize: 15,
                                          color: primaryColor,
                                          fontWeight: FontWeight.bold)),
                                  const SizedBox(height: 10),
                                  Divider(
                                    color: primaryColor,
                                    height: 30,
                                    thickness: 1,
                                  ),
                                  Text("Sub Type",
                                      style: GoogleFonts.inter(
                                          fontSize: 15,
                                          color: primaryColor,
                                          fontWeight: FontWeight.bold)),
                                  const SizedBox(height: 10),
                                  Text('IT',
                                      style: GoogleFonts.inter(
                                        fontSize: 12,
                                        color: primaryColor,
                                      )),
                                  Divider(
                                    color: primaryColor,
                                    height: 30,
                                    thickness: 1,
                                  ),
                                  Text("Problem Identification",
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
                                    thickness: 1,
                                  ),
                                  Text("Corrective Action",
                                      style: GoogleFonts.inter(
                                          fontSize: 15,
                                          color: primaryColor,
                                          fontWeight: FontWeight.bold)),
                                  const SizedBox(height: 10),
                                ],
                              ),
                            ),
                          )),
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
