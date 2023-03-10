import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:helpdesk_skripsi/style.dart';
import 'package:lottie/lottie.dart';

void showSnackBar(BuildContext context, String title, String message) {
  showDialog(
      context: context,
      builder: (context) => AlertDialog(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 50,
                  child: Center(
                    child: Text(title,
                        style: GoogleFonts.inter(
                            fontSize: 20,
                            color: secondaryColor,
                            fontWeight: FontWeight.bold)),
                  ),
                ),
                SizedBox(
                  width: 50,
                  child: Center(
                    child: Lottie.asset("assets/lottie/error.json"),
                  ),
                ),
              ],
            ),
            content: Text(message,
                style: GoogleFonts.inter(
                    fontSize: 14,
                    color: blackColor,
                    fontWeight: FontWeight.bold)),
          ));
}
