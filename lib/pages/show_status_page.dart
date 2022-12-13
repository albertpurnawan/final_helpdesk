import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:helpdesk_skripsi/style.dart';
import 'package:helpdesk_skripsi/util/appbar.dart';

class ShowStatus extends StatefulWidget {
  const ShowStatus({super.key});

  @override
  State<ShowStatus> createState() => _ShowStatusState();
}

class _ShowStatusState extends State<ShowStatus> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(title: 'Show Status', showBackBtn: true),
      backgroundColor: primaryColor,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Ticket Number: ${Get.parameters['tickteNum']}",
                  style: GoogleFonts.inter(
                      fontSize: 15,
                      color: secondaryColor,
                      fontWeight: FontWeight.bold)),
              const SizedBox(height: 20),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.circle,
                    color: greyColor,
                    size: 17,
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width * 0.05),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Review Helpdesk",
                            style: GoogleFonts.inter(
                                fontSize: 17,
                                color: greyColor,
                                fontWeight: FontWeight.bold)),
                        Card(
                          elevation: 10,
                          color: secondaryColor,
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Workflow Name:",
                                      style: GoogleFonts.inter(
                                          fontSize: 15,
                                          color: primaryColor,
                                          fontWeight: FontWeight.bold)),
                                  Text("Line:",
                                      style: GoogleFonts.inter(
                                          fontSize: 15,
                                          color: primaryColor,
                                          fontWeight: FontWeight.bold)),
                                  Text("Activity:",
                                      style: GoogleFonts.inter(
                                          fontSize: 15,
                                          color: primaryColor,
                                          fontWeight: FontWeight.bold)),
                                  Text("Line Description:",
                                      style: GoogleFonts.inter(
                                          fontSize: 15,
                                          color: primaryColor,
                                          fontWeight: FontWeight.bold)),
                                  Text("PIC:",
                                      style: GoogleFonts.inter(
                                          fontSize: 15,
                                          color: primaryColor,
                                          fontWeight: FontWeight.bold)),
                                  Text("Close Date:",
                                      style: GoogleFonts.inter(
                                          fontSize: 15,
                                          color: primaryColor,
                                          fontWeight: FontWeight.bold)),
                                ]),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
              const SizedBox(height: 20),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.circle,
                    color: greyColor,
                    size: 17,
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width * 0.05),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Superior IT Application Problem Assign Ticket",
                            style: GoogleFonts.inter(
                                fontSize: 17,
                                color: greyColor,
                                fontWeight: FontWeight.bold)),
                        Card(
                          elevation: 10,
                          color: secondaryColor,
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Workflow Name:",
                                      style: GoogleFonts.inter(
                                          fontSize: 15,
                                          color: primaryColor,
                                          fontWeight: FontWeight.bold)),
                                  Text("Line:",
                                      style: GoogleFonts.inter(
                                          fontSize: 15,
                                          color: primaryColor,
                                          fontWeight: FontWeight.bold)),
                                  Text("Activity:",
                                      style: GoogleFonts.inter(
                                          fontSize: 15,
                                          color: primaryColor,
                                          fontWeight: FontWeight.bold)),
                                  Text("Line Description:",
                                      style: GoogleFonts.inter(
                                          fontSize: 15,
                                          color: primaryColor,
                                          fontWeight: FontWeight.bold)),
                                  Text("PIC:",
                                      style: GoogleFonts.inter(
                                          fontSize: 15,
                                          color: primaryColor,
                                          fontWeight: FontWeight.bold)),
                                  Text("Close Date:",
                                      style: GoogleFonts.inter(
                                          fontSize: 15,
                                          color: primaryColor,
                                          fontWeight: FontWeight.bold)),
                                ]),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
              const SizedBox(height: 20),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.circle,
                    color: greyColor,
                    size: 17,
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width * 0.05),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Review Ticket By IT",
                            style: GoogleFonts.inter(
                                fontSize: 17,
                                color: greyColor,
                                fontWeight: FontWeight.bold)),
                        Card(
                          elevation: 10,
                          color: secondaryColor,
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Workflow Name:",
                                      style: GoogleFonts.inter(
                                          fontSize: 15,
                                          color: primaryColor,
                                          fontWeight: FontWeight.bold)),
                                  Text("Line:",
                                      style: GoogleFonts.inter(
                                          fontSize: 15,
                                          color: primaryColor,
                                          fontWeight: FontWeight.bold)),
                                  Text("Activity:",
                                      style: GoogleFonts.inter(
                                          fontSize: 15,
                                          color: primaryColor,
                                          fontWeight: FontWeight.bold)),
                                  Text("Line Description:",
                                      style: GoogleFonts.inter(
                                          fontSize: 15,
                                          color: primaryColor,
                                          fontWeight: FontWeight.bold)),
                                  Text("PIC:",
                                      style: GoogleFonts.inter(
                                          fontSize: 15,
                                          color: primaryColor,
                                          fontWeight: FontWeight.bold)),
                                  Text("Close Date:",
                                      style: GoogleFonts.inter(
                                          fontSize: 15,
                                          color: primaryColor,
                                          fontWeight: FontWeight.bold)),
                                ]),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
              const SizedBox(height: 20),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.circle,
                    color: greyColor,
                    size: 17,
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width * 0.05),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Review Issue by Creator",
                            style: GoogleFonts.inter(
                                fontSize: 17,
                                color: greyColor,
                                fontWeight: FontWeight.bold)),
                        Card(
                          elevation: 10,
                          color: secondaryColor,
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Workflow Name:",
                                      style: GoogleFonts.inter(
                                          fontSize: 15,
                                          color: primaryColor,
                                          fontWeight: FontWeight.bold)),
                                  Text("Line:",
                                      style: GoogleFonts.inter(
                                          fontSize: 15,
                                          color: primaryColor,
                                          fontWeight: FontWeight.bold)),
                                  Text("Activity:",
                                      style: GoogleFonts.inter(
                                          fontSize: 15,
                                          color: primaryColor,
                                          fontWeight: FontWeight.bold)),
                                  Text("Line Description:",
                                      style: GoogleFonts.inter(
                                          fontSize: 15,
                                          color: primaryColor,
                                          fontWeight: FontWeight.bold)),
                                  Text("PIC:",
                                      style: GoogleFonts.inter(
                                          fontSize: 15,
                                          color: primaryColor,
                                          fontWeight: FontWeight.bold)),
                                  Text("Close Date:",
                                      style: GoogleFonts.inter(
                                          fontSize: 15,
                                          color: primaryColor,
                                          fontWeight: FontWeight.bold)),
                                ]),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
