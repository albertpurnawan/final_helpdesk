import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InputFieldWidget extends StatelessWidget {
  final String hintText;

  const InputFieldWidget({
    super.key,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: GoogleFonts.inter(color: Colors.black),
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.black, width: 1.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.black, width: 1.0),
        ),
        hintText: hintText,
        hintStyle: GoogleFonts.inter(
          color: Colors.black,
          fontSize: 14,
        ),
      ),
    );
  }
}
