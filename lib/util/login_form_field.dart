import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:helpdesk_skripsi/style.dart';

class LoginFormField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final bool obscureText;
  final String? Function(String?)? validator;
  final Color color;
  final TextEditingController? defaultValue;
  final bool? enable;
  final List<TextInputFormatter>? type;
  const LoginFormField(
      {super.key,
      required this.hintText,
      required this.obscureText,
      required this.icon,
      this.validator,
      required this.color,
      this.defaultValue,
      this.enable,
      this.type});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: enable == null ? false : enable!,
      controller: defaultValue,
      validator: validator,
      obscureText: obscureText,
      inputFormatters: type,
      style: GoogleFonts.inter(color: secondaryColor),
      decoration: InputDecoration(
        prefixIcon: Icon(
          icon,
          color: color,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: color,
            width: 1.0,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: color,
            width: 1.0,
          ),
        ),
        hintText: hintText,
        hintStyle: GoogleFonts.inter(
          color: color.withOpacity(0.5),
          fontSize: 14,
        ),
      ),
    );
  }
}
