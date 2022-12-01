import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileTiles extends StatelessWidget {
  final String text;
  final IconData icon;
  final Color color;

  const ProfileTiles({
    super.key,
    required this.text,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          size: 30,
          color: color,
        ),
        const SizedBox(width: 20),
        Text(
          text,
          style: GoogleFonts.inter(
            fontSize: 16,
            // fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    );
  }
}
