import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:helpdesk_skripsi/style.dart';

class FAQ extends StatelessWidget {
  final String title;
  final String desc;
  const FAQ({super.key, required this.title, required this.desc});

  @override
  Widget build(BuildContext context) {
    return Card(
      // key: PageStorageKey(item['id']),
      color: greyColor,
      elevation: 2,
      child: ExpansionTile(
        collapsedIconColor: primaryColor,
        iconColor: primaryColor,
        childrenPadding: const EdgeInsets.all(5),
        // expandedCrossAxisAlignment: CrossAxisAlignment.end,
        title: Text(
          title,
          style: GoogleFonts.inter(
            color: primaryColor,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
          // textAlign: TextAlign.start,
        ),
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: Text(
                    "$desc\n",
                    style: GoogleFonts.inter(
                      color: primaryColor,
                      fontSize: 14,
                    ),
                    // textAlign: TextAlign.justify,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
