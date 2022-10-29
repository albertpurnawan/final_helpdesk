import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:helpdesk_skripsi/util/input_field.dart';

class CreateTicket extends StatelessWidget {
  const CreateTicket({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[50],
      body: SafeArea(
        child: SingleChildScrollView(
          // child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Nav Bar
              Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          height: 60,
                          padding: const EdgeInsets.all(10),
                          // decoration: BoxDecoration(color: Colors.grey[500]),
                          child: Center(
                            child: Image.asset(
                              "assets/images/logo.png",
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text("Help Desk Mobile",
                            style: GoogleFonts.inter(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black)),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.all(7),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(Icons.person, color: Colors.green[200]),
                    )
                  ],
                ),
              ),

              // Create Ticket Card
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Container(
                  // width: 300,
                  padding: const EdgeInsets.all(25),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Create Ticket',
                        style: GoogleFonts.inter(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        '* Please fill all required inputs',
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          // fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const Divider(color: Colors.black),
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
                              backgroundColor: Colors.green[50],
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            onPressed: () {},
                            icon: Icon(
                              Icons.add,
                              color: Colors.green[600],
                            ),
                            label: Text(
                              "Add New File",
                              style: GoogleFonts.inter(
                                color: Colors.green[600],
                                fontSize: 14,
                              ),
                            ),
                          ),
                          TextButton(
                            style: TextButton.styleFrom(
                              backgroundColor: Colors.green[200],
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            onPressed: () {},
                            child: Text(
                              "Submit",
                              style: GoogleFonts.inter(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      // notes
                      Row(
                        children: [
                          const Icon(
                            Icons.info_outline,
                            size: 20,
                            color: Colors.blue,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            "File size must less than 2Mb",
                            style: GoogleFonts.inter(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),

              // file attachment
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Container(
                  // width: 300,
                  padding: const EdgeInsets.all(20),
                  width: 400,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/images/avatar.png",
                        width: 100,
                      ),
                      Text(
                        "No files attached",
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
          // ),
        ),
      ),
    );
  }
}
