import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:helpdesk_skripsi/style.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
              const SizedBox(
                width: 10,
              ),
              Text(
                "Help Desk Mobile",
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
