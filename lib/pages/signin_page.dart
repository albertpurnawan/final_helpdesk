import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(
            top: 100.0, left: 50.0, right: 50.0, bottom: 100.0),
        child: Column(
          children: [
            Image.asset(
              "assets/images/logo.png",
              width: 150,
              height: 150,
            ),
            const SizedBox(
              height: 80,
            ),
            TextFormField(
              style: GoogleFonts.openSans(color: Colors.black),
              decoration: InputDecoration(
                  prefixIcon: const Icon(
                    Icons.person,
                    color: Colors.red,
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                          const BorderSide(color: Colors.red, width: 1.0)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                          const BorderSide(color: Colors.red, width: 1.0)),
                  hintText: 'Username',
                  hintStyle: GoogleFonts.openSans(
                      color: const Color.fromARGB(255, 16, 16, 16),
                      fontSize: 14)),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              obscureText: true,
              style: GoogleFonts.openSans(color: Colors.black),
              decoration: InputDecoration(
                prefixIcon: const Icon(
                  Icons.lock,
                  color: Colors.red,
                ),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide:
                        const BorderSide(color: Colors.red, width: 1.0)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide:
                        const BorderSide(color: Colors.red, width: 1.0)),
                hintText: 'Password',
                hintStyle: GoogleFonts.openSans(
                    color: const Color(0xff6F7075), fontSize: 14),
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
                        backgroundColor: Colors.red,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                    onPressed: () {},
                    child: Text(
                      "SIGN IN",
                      style: GoogleFonts.openSans(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w600),
                    )),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Copyright \u00a9 Mayora 2022",
            )
          ],
        ),
      ),
    );
  }
}
