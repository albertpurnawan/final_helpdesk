import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:helpdesk_skripsi/style.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showBackBtn;

  const MyAppBar({super.key, required this.title, required this.showBackBtn});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      // centerTitle: true,
      backgroundColor: primaryColor,
      automaticallyImplyLeading: showBackBtn,
      title: Text(
        title,
        style: GoogleFonts.inter(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: secondaryColor,
        ),
      ),
      centerTitle: true,
      // title: Row(
      //   mainAxisAlignment: MainAxisAlignment.center,
      //   children: [
      //     Container(
      //       height: 50,
      //       padding: const EdgeInsets.all(10),
      //       child: Icon(
      //         Icons.dashboard_outlined,
      //         color: secondaryColor,
      //       ),
      //     ),
      //     Text(
      //       title,
      // style: GoogleFonts.inter(
      //   fontSize: 20,
      //   fontWeight: FontWeight.bold,
      //   color: secondaryColor,
      // ),
      //     ),
      //   ],
      // ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
