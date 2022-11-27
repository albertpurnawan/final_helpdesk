import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:helpdesk_skripsi/style.dart';

class InputFieldWidget extends StatelessWidget {
  final String hintText;

  const InputFieldWidget({
    super.key,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: GoogleFonts.inter(color: blackColor),
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: blackColor, width: 1.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: blackColor, width: 1.0),
        ),
        hintText: hintText,
        hintStyle: GoogleFonts.inter(
          color: blackColor,
          fontSize: 12,
        ),
      ),
    );
  }
}
