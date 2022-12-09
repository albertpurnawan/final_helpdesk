import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:helpdesk_skripsi/routes/routes.dart';
import 'package:helpdesk_skripsi/style.dart';
import 'package:helpdesk_skripsi/util/appbar.dart';
import 'package:helpdesk_skripsi/util/profile_tiles.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String? imagePath;

// Get from Camera
  void pickFromGallery() async {
    XFile? file = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxHeight: 120,
      maxWidth: 120,
    );
    if (file != null) {
      imagePath = file.path;
      setState(() {});
    }
  }

  // Get from Camera
  void pickFromCamera() async {
    XFile? file = await ImagePicker().pickImage(
      source: ImageSource.camera,
      maxHeight: 120,
      maxWidth: 120,
    );
    if (file != null) {
      imagePath = file.path;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: const MyAppBar(title: "Profile", showBackBtn: false),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              //header
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: secondaryColor,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    (imagePath != null)
                        ? Container(
                            width: 120,
                            height: 120,
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(100),
                              ),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: Image.file(
                                File(imagePath!),
                                fit: BoxFit.cover,
                              ),
                            ),
                          )
                        : SizedBox(
                            width: 120,
                            height: 120,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: Image.asset("assets/images/iuProfile.jpg"),
                            ),
                          ),
                    Column(
                      children: [
                        Text(
                          "DANIEL",
                          style: GoogleFonts.inter(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "MM04994",
                          style: GoogleFonts.inter(
                            fontSize: 16,
                            color: primaryColor,
                          ),
                        ),
                        const SizedBox(height: 10),
                        ElevatedButton(
                          onPressed: () {
                            showModalBottomSheet(
                              context: context,
                              builder: ((context) {
                                return SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.2,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      ElevatedButton.icon(
                                        onPressed: () {
                                          pickFromCamera();
                                          Get.back();
                                        },
                                        icon: Icon(
                                          Icons.camera,
                                          color: greyColor,
                                        ),
                                        label: Text(
                                          "Choose From Camera",
                                          style: GoogleFonts.inter(
                                            fontSize: 14,
                                            color: greyColor,
                                          ),
                                        ),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: primaryColor,
                                          side: BorderSide(
                                            color: greyColor,
                                            width: 1,
                                          ),
                                        ),
                                      ),
                                      ElevatedButton.icon(
                                        onPressed: () {
                                          pickFromGallery();
                                          Get.back();
                                        },
                                        icon: Icon(
                                          Icons.photo,
                                          color: secondaryColor,
                                        ),
                                        label: Text(
                                          "Choose From Gallery",
                                          style: GoogleFonts.inter(
                                            fontSize: 14,
                                            color: secondaryColor,
                                          ),
                                        ),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: primaryColor,
                                          side: BorderSide(
                                            color: secondaryColor,
                                            width: 1,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              }),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: primaryColor,
                          ),
                          child: Text(
                            "Change Photo",
                            style: GoogleFonts.inter(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: secondaryColor,
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(height: 40),
              //body
              Container(
                // color: Colors.redAccent,
                padding: const EdgeInsets.all(30),
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "INFORMATION DATA",
                      style: GoogleFonts.inter(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: secondaryColor,
                      ),
                    ),
                    const Divider(thickness: 2),
                    const SizedBox(height: 10),
                    ProfileTiles(
                      text: "70004994",
                      icon: Icons.person,
                      color: greyColor,
                    ),
                    const SizedBox(height: 10),
                    ProfileTiles(
                      text: "daniel@mayora.co.id",
                      icon: Icons.mail,
                      color: greyColor,
                    ),
                    const SizedBox(height: 10),
                    ProfileTiles(
                      text: "IT INTERN",
                      icon: Icons.badge,
                      color: greyColor,
                    ),
                    const SizedBox(height: 10),
                    ProfileTiles(
                      text: "PT Mayora Indah Tbk",
                      icon: Icons.location_city,
                      color: greyColor,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 60),
              //logout button
              SizedBox(
                width: 200,
                child: ElevatedButton.icon(
                  style: TextButton.styleFrom(
                    backgroundColor: secondaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  onPressed: () {
                    Get.toNamed(RouteClass.getLoginRoute());
                  },
                  icon: Icon(
                    Icons.logout,
                    color: primaryColor,
                  ),
                  label: Text(
                    "Log Out",
                    style: GoogleFonts.inter(
                        color: primaryColor,
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
