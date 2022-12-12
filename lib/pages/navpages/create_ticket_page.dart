// ignore_for_file: sized_box_for_whitespace, avoid_print

import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:helpdesk_skripsi/style.dart';
import 'package:helpdesk_skripsi/util/appbar.dart';
import 'package:helpdesk_skripsi/util/input_field.dart';
import 'package:lottie/lottie.dart';

class CreateTicket extends StatefulWidget {
  const CreateTicket({super.key});

  @override
  State<CreateTicket> createState() => _CreateTicketState();
}

class _CreateTicketState extends State<CreateTicket> {
  String _fileText = "";

  void selectMultipleFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      // allowedExtensions: ['jpg', 'pdf', 'doc'],
      allowMultiple: true,
    );

    if (result != null) {
      List<File> files = result.paths.map((path) => File(path!)).toList();
      setState(() {
        _fileText = files.toString();
      });
    } else {
      // user canceled the picker
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      // drawer: const MyDrawer(),
      appBar: const MyAppBar(title: "Create Ticket", showBackBtn: false),
      body: SingleChildScrollView(
        // child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Create Ticket Card
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Container(
                  // width: 300,
                  padding: const EdgeInsets.all(25),
                  decoration: BoxDecoration(
                    color: whiteColor,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset:
                            const Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Create Ticket',
                        style: GoogleFonts.inter(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: secondaryColor,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        '* Please fill all required inputs',
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          color: secondaryColor,
                        ),
                      ),
                      Divider(
                        color: secondaryColor,
                        thickness: 2,
                      ),
                      const SizedBox(height: 20),
                      const InputFieldWidget(hintText: "Request For *"),
                      const SizedBox(height: 20),
                      const InputFieldWidget(hintText: "Email"),
                      const SizedBox(height: 20),
                      const InputFieldWidget(hintText: "Phone Number"),
                      const SizedBox(height: 20),
                      const InputFieldWidget(hintText: "Description *"),
                      const SizedBox(height: 20),

                      // Add file and submit btn
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton.icon(
                            style: TextButton.styleFrom(
                              backgroundColor: greyColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            onPressed: () {
                              selectMultipleFile();
                            },
                            icon: Icon(
                              Icons.add,
                              color: primaryColor,
                            ),
                            label: Text(
                              "Add New File",
                              style: GoogleFonts.inter(
                                color: primaryColor,
                                fontSize: 14,
                              ),
                            ),
                          ),
                          ElevatedButton(
                            style: TextButton.styleFrom(
                              backgroundColor: secondaryColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            onPressed: () {
                              AwesomeDialog(
                                context: context,
                                animType: AnimType.scale,
                                headerAnimationLoop: true,
                                dialogType: DialogType.success,
                                title: 'Succes',
                                desc: 'Successfully create ticket',
                                btnOkOnPress: () {},
                                btnOkIcon: Icons.check_circle,
                              ).show();
                            },
                            child: Text(
                              "Submit",
                              style: GoogleFonts.inter(
                                color: primaryColor,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      // notes
                      Row(
                        children: [
                          Icon(
                            Icons.info_outline,
                            size: 20,
                            color: secondaryColor,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            "File size must less than 2Mb",
                            style: GoogleFonts.inter(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: secondaryColor),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),

              // file attachment card
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Container(
                  padding: const EdgeInsets.all(20),
                  width: 400,
                  decoration: BoxDecoration(
                    color: whiteColor,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset:
                            const Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Text(_fileText),
                      Container(
                        width: 100,
                        child: Lottie.asset("assets/lottie/sleep.json"),
                      ),
                      Text(
                        "No files attached",
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: blackColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
        // ),
      ),
      // bottomNavigationBar: const BottomNavbar(),
    );
  }
}