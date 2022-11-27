import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:helpdesk_skripsi/routes/routes.dart';
import 'package:helpdesk_skripsi/style.dart';
import 'package:helpdesk_skripsi/util/appbar.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(title: "Profile", showBackBtn: false),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20),
          width: double.infinity,
          // height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              SizedBox(
                // color: primaryColor,
                width: 120,
                height: 120,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: const Image(
                    image: AssetImage("assets/images/iuProfile.jpg"),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                "MM04994",
                style: GoogleFonts.inter(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: blackColor,
                ),
              ),
              const SizedBox(height: 20),
              //CHANGE PHOTO BUTTON
              SizedBox(
                width: 200,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    side: BorderSide(
                      color: secondaryColor,
                      width: 2,
                    ),
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
              ),
              //LOGOUT BUTTON
              const SizedBox(height: 10),
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
