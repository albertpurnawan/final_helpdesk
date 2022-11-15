import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:helpdesk_skripsi/routes/routes.dart';
import 'package:helpdesk_skripsi/style.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
              top: 100.0, left: 50.0, right: 50.0, bottom: 100.0),
          child: Column(
            children: [
              Image.asset(
                "assets/images/logo.png",
                width: 150,
                height: 150,
              ),
              Text(
                "Helpdesk Mobile",
                style: GoogleFonts.inter(
                  color: secondaryColor,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 80,
              ),
              TextFormField(
                style: GoogleFonts.inter(color: secondaryColor),
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.person,
                    color: secondaryColor,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: secondaryColor,
                      width: 1.0,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: secondaryColor,
                      width: 1.0,
                    ),
                  ),
                  hintText: 'Username',
                  hintStyle: GoogleFonts.inter(
                    color: secondaryColor,
                    fontSize: 14,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                obscureText: true,
                style: GoogleFonts.inter(color: secondaryColor),
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.lock,
                    color: secondaryColor,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: secondaryColor,
                      width: 1.0,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: secondaryColor,
                      width: 1.0,
                    ),
                  ),
                  hintText: 'Password',
                  hintStyle: GoogleFonts.inter(
                    color: secondaryColor,
                    fontSize: 14,
                  ),
                ),
              ),
              const SizedBox(
                height: 60,
              ),
              Center(
                // ignore: sized_box_for_whitespace
                child: Container(
                  width: 295,
                  height: 55,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: secondaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {
                      Get.toNamed(RouteClass.getHomeRoute());
                    },
                    child: Text(
                      "SIGN IN",
                      style: GoogleFonts.inter(
                        color: primaryColor,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                "Copyright \u00a9 Mayora 2022",
                style: GoogleFonts.inter(
                  color: secondaryColor,
                  fontSize: 14,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
