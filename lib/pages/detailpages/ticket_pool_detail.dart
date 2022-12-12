import 'package:dropdown_button2/custom_dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:helpdesk_skripsi/data/ticket_pool_data.dart';
import 'package:helpdesk_skripsi/model/ticket_pool_model.dart';
import 'package:helpdesk_skripsi/routes/routes.dart';
import 'package:helpdesk_skripsi/style.dart';
import 'package:helpdesk_skripsi/util/appbar.dart';
import 'package:intl/intl.dart';

class TicketPoolDetailPage extends StatefulWidget {
  const TicketPoolDetailPage({super.key});

  @override
  State<TicketPoolDetailPage> createState() => _TicketPoolDetailPageState();
}

class _TicketPoolDetailPageState extends State<TicketPoolDetailPage> {
  List<TicketPool> issueData = allIssue;
  String? selectedValue;
  String ticketNum = Get.parameters['tickteNum'].toString();
  final List<String> comunicationBy = [
    'Mayora Portal1',
    'Mayora Portal2',
    'Mayora Portal3'
  ];

  final List<String> supportCategory = [
    'Technical Problem1',
    'Technical Problem2',
    'Technical Problem3'
  ];

  final List<String> category = ['Services1', 'Services2', 'Services3'];
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
                            fontWeight: FontWeight.bold)),
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
                            fontWeight: FontWeight.bold)),
                    Divider(
                      color: primaryColor,
                      height: 30,
                      thickness: 1,
                    ),
                    Text("Requester:",
                        style: GoogleFonts.inter(
                            fontSize: 15,
                            color: primaryColor,
                            fontWeight: FontWeight.bold)),
                    const SizedBox(height: 10),
                    Text(issueData[0].requester,
                        style: GoogleFonts.inter(
                            fontSize: 12,
                            color: primaryColor,
                            fontWeight: FontWeight.bold)),
                    Divider(
                      color: primaryColor,
                      height: 30,
                      thickness: 1,
                    ),
                    Text("Requester Email:",
                        style: GoogleFonts.inter(
                            fontSize: 15,
                            color: primaryColor,
                            fontWeight: FontWeight.bold)),
                    const SizedBox(height: 10),
                    Text(issueData[0].requesterEmail,
                        style: GoogleFonts.inter(
                            fontSize: 12,
                            color: primaryColor,
                            fontWeight: FontWeight.bold)),
                    Divider(
                      color: primaryColor,
                      height: 30,
                      thickness: 1,
                    ),
                    Text("Requester's Phone Number:",
                        style: GoogleFonts.inter(
                            fontSize: 15,
                            color: primaryColor,
                            fontWeight: FontWeight.bold)),
                    const SizedBox(height: 10),
                    Text(issueData[0].requesterPhoneNum,
                        style: GoogleFonts.inter(
                            fontSize: 12,
                            color: primaryColor,
                            fontWeight: FontWeight.bold)),
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
                    Text(issueData[0].createdBy,
                        style: GoogleFonts.inter(
                            fontSize: 12,
                            color: primaryColor,
                            fontWeight: FontWeight.bold)),
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
                            fontWeight: FontWeight.bold)),
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
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
                                height:
                                    MediaQuery.of(context).size.height * 0.5,
                                width: 1,
                                color: blackColor),
                          ],
                        ),
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Description",
                                          style: GoogleFonts.inter(
                                              fontSize: 15,
                                              color: primaryColor,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        const SizedBox(height: 10),
                                        Text(
                                          issueData[0].issueDesc,
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
                                        Text(
                                            Get.parameters['tickteNum']
                                                .toString(),
                                            style: GoogleFonts.inter(
                                                fontSize: 12,
                                                color: primaryColor,
                                                fontWeight: FontWeight.bold)),
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
                                                fontWeight: FontWeight.bold)),
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
                              )
                            ],
                          ),
                        ),

                        const SizedBox(height: 10),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // icon dan garis
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Communication By",
                                    style: GoogleFonts.inter(
                                        fontSize: 18,
                                        color: greyColor,
                                        fontWeight: FontWeight.bold)),
                                const SizedBox(height: 10),
                                CustomDropdownButton2(
                                  hint: 'Select Communication By',
                                  buttonWidth:
                                      MediaQuery.of(context).size.width * 1,
                                  dropdownWidth:
                                      MediaQuery.of(context).size.width * 1,
                                  icon: const Icon(
                                    Icons.arrow_drop_down,
                                    size: 24,
                                  ),
                                  value: selectedValue,
                                  dropdownItems: comunicationBy,
                                  onChanged: (value) {
                                    setState(() {
                                      selectedValue = value!;
                                    });
                                  },
                                ),
                              ]),

                          const SizedBox(height: 20),
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Support Category *",
                                    style: GoogleFonts.inter(
                                        fontSize: 18,
                                        color: greyColor,
                                        fontWeight: FontWeight.bold)),
                                const SizedBox(height: 10),
                                TextFormField(
                                  obscureText: true,
                                  style:
                                      GoogleFonts.inter(color: secondaryColor),
                                  decoration: const InputDecoration(
                                    hintText: "Enter Support Category",
                                  ),
                                ),
                              ]),

                          const SizedBox(height: 10),
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Category *",
                                    style: GoogleFonts.inter(
                                        fontSize: 18,
                                        color: greyColor,
                                        fontWeight: FontWeight.bold)),
                                const SizedBox(height: 10),
                                TextFormField(
                                  obscureText: true,
                                  style:
                                      GoogleFonts.inter(color: secondaryColor),
                                  decoration: const InputDecoration(
                                    hintText: "Enter Category",
                                  ),
                                ),
                              ]),

                          const SizedBox(height: 10),
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Notes *",
                                    style: GoogleFonts.inter(
                                        fontSize: 18,
                                        color: greyColor,
                                        fontWeight: FontWeight.bold)),
                                const SizedBox(height: 10),
                                TextField(
                                  maxLines: 8,
                                  keyboardType: TextInputType.multiline,
                                  style:
                                      GoogleFonts.inter(color: secondaryColor),
                                  decoration: const InputDecoration(
                                    hintText: "Enter Notes",
                                  ),
                                ),
                              ]),

                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ],
                )),
            const Card()
          ],
        ),
      ),
    );
  }
}
