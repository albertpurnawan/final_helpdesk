import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:helpdesk_skripsi/util/appbar.dart';
import 'package:helpdesk_skripsi/style.dart';
import 'package:helpdesk_skripsi/util/features_button.dart';

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
                color: blackColor,
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 80,
                      height: 80,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: const Image(
                          image: AssetImage("assets/images/iuProfile.jpg"),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
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
          Text(
            "Our Features",
            // textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: secondaryColor,
            ),
          ),
          Divider(
            thickness: 2,
            indent: 60,
            endIndent: 60,
            color: blackColor,
          ),
          //MAIN FEATURES
          SizedBox(
            height: 250,
            // color: Colors.amberAccent,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                //column 1
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    FeaturesButton(
                      icon: Icons.dashboard,
                      featuresText: "Dashboard",
                      index: 0,
                    ),
                    SizedBox(height: 30),
                    FeaturesButton(
                      icon: Icons.cases_sharp,
                      featuresText: "Joblist",
                      index: 3,
                    )
                  ],
                ),
                const SizedBox(width: 30),
                //column 2
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    FeaturesButton(
                      icon: Icons.list,
                      featuresText: "Ticket Pool",
                      index: 1,
                    ),
                    SizedBox(height: 30),
                    FeaturesButton(
                      icon: Icons.bar_chart,
                      featuresText: "Report",
                      index: 4,
                    )
                  ],
                ),
                const SizedBox(width: 30),
                //column 3
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    FeaturesButton(
                      icon: Icons.settings,
                      featuresText: "Master",
                      index: 2,
                    ),
                    SizedBox(height: 30),
                    FeaturesButton(
                      icon: Icons.search,
                      featuresText: "Browse",
                      index: 5,
                    )
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
