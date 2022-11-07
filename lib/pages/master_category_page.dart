import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:helpdesk_skripsi/util/appbar.dart';
import 'package:helpdesk_skripsi/util/drawer.dart';

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
    return Scaffold(
      backgroundColor: Colors.green[50],
      appBar: const MyAppBar(),
      drawer: const MyDrawer(),
      body: Container(
        margin: const EdgeInsets.all(20),
        width: double.infinity,
        height: double.infinity,
        // color: Colors.red,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Manage Master Category",
              style: GoogleFonts.inter(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.green[900]),
            ),
            Divider(
              color: Colors.green.shade900,
              thickness: 1,
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 60,
              width: double.infinity,
              child: ListView.builder(
                itemCount: tabItems.length,
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        current = index;
                      });
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      margin: const EdgeInsets.all(5),
                      width: 120,
                      // height: 50,
                      decoration: BoxDecoration(
                        color:
                            current == index ? Colors.white70 : Colors.white54,
                        borderRadius: current == index
                            ? BorderRadius.circular(15)
                            : BorderRadius.circular(10),
                        border: current == index
                            ? Border.all(
                                color: Colors.green.shade600,
                                width: 2,
                              )
                            : null,
                      ),
                      child: Center(
                        child: Text(
                          tabItems[index],
                          style: GoogleFonts.inter(
                              fontWeight: FontWeight.bold,
                              color: current == index
                                  ? Colors.black
                                  : Colors.grey),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            // MAIN BODY
            Container(
              margin: const EdgeInsets.only(top: 20),
              width: double.infinity,
              height: 500,
              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    tabItems[current],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
