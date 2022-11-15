import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:helpdesk_skripsi/style.dart';
import 'package:helpdesk_skripsi/tabs/category_tab.dart';
import 'package:helpdesk_skripsi/util/appbar.dart';
import 'package:helpdesk_skripsi/util/bottom_navbar.dart';

class MasterCategoryPage extends StatefulWidget {
  const MasterCategoryPage({super.key});

  @override
  State<MasterCategoryPage> createState() => _MasterCategoryPageState();
}

class _MasterCategoryPageState extends State<MasterCategoryPage> {
  List<String> tabItems = [
    "Support Category",
    "Category",
    "Sub Category 1",
    "Sub Category 2"
  ];

  int current = 0;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        backgroundColor: primaryColor,
        appBar: const MyAppBar(title: "Master Category"),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TabBar(
              physics: const BouncingScrollPhysics(),
              indicatorColor: secondaryColor,
              isScrollable: true,
              tabs: [
                Tab(
                  child: Text(
                    "Support Category",
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      color: secondaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Tab(
                  child: Text(
                    "Category",
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      color: secondaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Tab(
                  child: Text(
                    "Sub Category 1",
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      color: secondaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Tab(
                  child: Text(
                    "Sub Category 2",
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      color: secondaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),

            // ADD NEW CATEGORY BUTTON
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 5, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Support Category",
                    style: GoogleFonts.inter(
                      fontSize: 22,
                      color: secondaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  ElevatedButton.icon(
                    style: TextButton.styleFrom(
                      backgroundColor: whiteColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {},
                    icon: Icon(
                      Icons.add,
                      color: secondaryColor,
                    ),
                    label: Text(
                      "Add",
                      style: GoogleFonts.inter(
                        color: secondaryColor,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const Expanded(
              child: TabBarView(
                physics: BouncingScrollPhysics(),
                children: [
                  CategoryTab(),
                  CategoryTab(),
                  CategoryTab(),
                  CategoryTab(),
                ],
              ),
            )
          ],
        ),
        bottomNavigationBar: const BottomNavbar(),
      ),
    );
  }
}
