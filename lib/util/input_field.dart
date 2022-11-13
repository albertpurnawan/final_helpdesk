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
      style: GoogleFonts.inter(color: secondaryColor),
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: secondaryColor, width: 1.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: secondaryColor, width: 1.0),
        ),
        hintText: hintText,
        hintStyle: GoogleFonts.inter(
          color: secondaryColor,
          fontSize: 12,
        ),
      ),
    );
  }
}
