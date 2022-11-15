import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:helpdesk_skripsi/style.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const MyAppBar({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      automaticallyImplyLeading: false,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Container(
                height: 50,
                padding: const EdgeInsets.all(10),
                child: Icon(
                  Icons.dashboard_outlined,
                  color: secondaryColor,
                ),
                // child: Center(
                //   child: Image.asset(
                //     "assets/images/logo.png",
                //   ),
                // ),
              ),
              Text(
                title,
                style: GoogleFonts.inter(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: secondaryColor,
                ),
              ),
            ],
          ),
          // Container(
          //   padding: const EdgeInsets.all(7),
          //   decoration: const BoxDecoration(
          //     color: Colors.white,
          //     shape: BoxShape.circle,
          //   ),
          //   child: Icon(Icons.person, color: Colors.green[200]),
          // )
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
