import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:helpdesk_skripsi/routes/routes.dart';
import 'package:helpdesk_skripsi/style.dart';

class FeaturesButton extends StatelessWidget {
  final IconData icon;
  final String featuresText;
  final int index;

  const FeaturesButton({
    super.key,
    required this.icon,
    required this.featuresText,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //icon
        GestureDetector(
          onTap: () {
            switch (index) {
              case 0:
                Get.toNamed(RouteClass.getDashboardRoute());
                break;
              case 1:
                Get.toNamed(RouteClass.getTicketPoolRoute());
                break;
              case 2:
                Get.toNamed(RouteClass.getMasterCategoryRoute());
                break;
              case 3:
                Get.toNamed(RouteClass.getJoblistRoute());
                break;
              case 4:
                Get.toNamed(RouteClass.getReportRoute());
                break;
              case 5:
                Get.toNamed(RouteClass.getBrowseRoute());
                break;
            }
          },
          child: Container(
            height: 50,
            // width: 100,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: whiteColor,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.4),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: Icon(
              icon,
              size: 30,
              color: secondaryColor,
            ),
          ),
        ),
        const SizedBox(height: 10),
        Text(
          featuresText,
          // overflow: TextOverflow.ellipsis,
          style: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: secondaryColor,
          ),
        )
      ],
    );
  }
}
