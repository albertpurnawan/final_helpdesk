import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:helpdesk_skripsi/util/appbar.dart';
import 'package:helpdesk_skripsi/util/features_button.dart';
import 'package:helpdesk_skripsi/style.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: const MyAppBar(title: "Help Desk Mobile", showBackBtn: false),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: secondaryColor,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.4),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              height: 150,
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: SizedBox(
                        height: 80,
                        child: Icon(
                          Icons.account_circle,
                          size: 80,
                          color: primaryColor,
                        ),
                      ),
                    ),
                    Text(
                      "Good Evening, Admin",
                      style: GoogleFonts.inter(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ),
          ),
          //OUR FEATURES TITLE
          const SizedBox(height: 30),
          Container(
            width: 120,
            height: 30,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: secondaryColor,
            ),
            child: Text(
              "Our Features",
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
          ),
          //MAIN FEATURES
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: SizedBox(
              height: 200,
              // color: Colors.red,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //row1
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: const [
                        FeaturesButton(
                          icon: Icons.dashboard,
                          featuresText: "Dasboard",
                          index: 0,
                        ),
                        FeaturesButton(
                          icon: Icons.list,
                          featuresText: "Ticket",
                          index: 1,
                        ),
                        FeaturesButton(
                          icon: Icons.settings,
                          featuresText: "Master",
                          index: 2,
                        ),
                      ],
                    ),
                    //row2
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: const [
                        FeaturesButton(
                          icon: Icons.cases_sharp,
                          featuresText: "Joblist",
                          index: 3,
                        ),
                        FeaturesButton(
                          icon: Icons.bar_chart,
                          featuresText: "Report",
                          index: 4,
                        ),
                        FeaturesButton(
                          icon: Icons.search,
                          featuresText: "Browse",
                          index: 5,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
