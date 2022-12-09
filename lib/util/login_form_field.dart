import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:helpdesk_skripsi/style.dart';

class LoginFormField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final bool obscureText;
  final String? Function(String?)? validator;

  const LoginFormField({
    super.key,
    required this.hintText,
    required this.obscureText,
    required this.icon,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      obscureText: obscureText,
      style: GoogleFonts.inter(color: greyColor),
      decoration: InputDecoration(
        prefixIcon: Icon(
          icon,
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
        hintText: hintText,
        hintStyle: GoogleFonts.inter(
          color: greyColor.withOpacity(0.5),
          fontSize: 14,
        ),
      ),
    );
  }
}
