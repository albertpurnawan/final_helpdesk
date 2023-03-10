import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:helpdesk_skripsi/model/login_model.dart';
import 'package:helpdesk_skripsi/routes/routes.dart';
import 'package:helpdesk_skripsi/style.dart';

class FeaturesButton extends StatelessWidget {
  final IconData icon;
  final String featuresText;
  final int index;
  final User user;

  const FeaturesButton({
    super.key,
    required this.icon,
    required this.featuresText,
    required this.index,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //icon
        GestureDetector(
          onTap: () {
            if (user.ua == 'helpdesk') {
              switch (index) {
                case 0:
                  Get.toNamed(RouteClass.getDashboardRoute(), arguments: user);
                  break;
                case 1:
                  Get.toNamed(RouteClass.getTicketPoolRoute(), arguments: user);
                  break;
                case 2:
                  Get.toNamed(RouteClass.getMasterCategoryRoute(),
                      arguments: user);
                  break;
                case 3:
                  Get.toNamed(RouteClass.getJoblistRoute(), arguments: user);
                  break;
                case 4:
                  Get.toNamed(RouteClass.getReportRoute(), arguments: user);
                  break;
                case 5:
                  Get.toNamed(RouteClass.getBrowseRoute(), arguments: user);
                  // listBrowseData();

                  break;
              }
            } else if (user.ua == 'picsupport' || user.ua == 'itsupport') {
              switch (index) {
                case 0:
                  Get.toNamed(RouteClass.getErrorRoute(), arguments: user);
                  break;
                case 1:
                  Get.toNamed(RouteClass.getTicketPoolRoute(), arguments: user);
                  break;
                case 2:
                  Get.toNamed(RouteClass.getErrorRoute(), arguments: user);
                  break;
                case 3:
                  Get.toNamed(RouteClass.getJoblistRoute(), arguments: user);
                  break;
                case 4:
                  Get.toNamed(RouteClass.getReportRoute(), arguments: user);
                  break;
                case 5:
                  Get.toNamed(RouteClass.getBrowseRoute(), arguments: user);
                  // listBrowseData();

                  break;
              }
            } else {
              switch (index) {
                case 0:
                  Get.toNamed(RouteClass.getErrorRoute(), arguments: user);
                  break;
                case 1:
                  Get.toNamed(RouteClass.getErrorRoute(), arguments: user);
                  break;
                case 2:
                  Get.toNamed(RouteClass.getErrorRoute(), arguments: user);
                  break;
                case 3:
                  Get.toNamed(RouteClass.getJoblistRoute(), arguments: user);
                  break;
                case 4:
                  Get.toNamed(RouteClass.getErrorRoute(), arguments: user);
                  break;
                case 5:
                  Get.toNamed(RouteClass.getBrowseRoute(), arguments: user);
                  break;
              }
            }
          },
          child: Column(
            children: [
              Container(
                height: 50,
                // width: 100,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: secondaryColor,
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
                  color: primaryColor,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                featuresText,
                // overflow: TextOverflow.ellipsis,
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: blackColor,
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
