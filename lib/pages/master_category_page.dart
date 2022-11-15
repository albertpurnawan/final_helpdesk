import 'package:flutter/material.dart';
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
        appBar: const MyAppBar(),
        // drawer: const MyDrawer(),
        body: Column(
          children: [
            TabBar(
              physics: const BouncingScrollPhysics(),
              indicatorColor: secondaryColor,
              isScrollable: true,
              tabs: [
                Tab(
                  child: Text(
                    "Support Category",
                    style: TextStyle(
                      color: secondaryColor,
                    ),
                  ),
                ),
                Tab(
                  child: Text(
                    "Category",
                    style: TextStyle(
                      color: secondaryColor,
                    ),
                  ),
                ),
                Tab(
                  child: Text(
                    "Sub Category 1",
                    style: TextStyle(
                      color: secondaryColor,
                    ),
                  ),
                ),
                Tab(
                  child: Text(
                    "Sub Category 2",
                    style: TextStyle(
                      color: secondaryColor,
                    ),
                  ),
                ),
              ],
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
