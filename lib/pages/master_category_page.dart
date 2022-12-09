import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:helpdesk_skripsi/style.dart';
import 'package:helpdesk_skripsi/tabs/category_tab.dart';
import 'package:helpdesk_skripsi/util/appbar.dart';
import 'package:helpdesk_skripsi/util/input_field.dart';

class MasterCategoryPage extends StatefulWidget {
  const MasterCategoryPage({super.key});

  @override
  State<MasterCategoryPage> createState() => _MasterCategoryPageState();
}

class _MasterCategoryPageState extends State<MasterCategoryPage> {
  final textController = TextEditingController();

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
        appBar: const MyAppBar(title: "Master Category", showBackBtn: true),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TabBar(
              physics: const BouncingScrollPhysics(),
              indicatorColor: blackColor,
              isScrollable: true,
              tabs: [
                Tab(
                  child: Text(
                    "Support Category",
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      color: blackColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Tab(
                  child: Text(
                    "Category",
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      color: blackColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Tab(
                  child: Text(
                    "Sub Category 1",
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      color: blackColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Tab(
                  child: Text(
                    "Sub Category 2",
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      color: blackColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),

            // ADD NEW CATEGORY BUTTON
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 5, right: 20),
              child: Column(
                children: [
                  Row(
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
                          backgroundColor: blackColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () {
                          AwesomeDialog(
                            context: context,
                            animType: AnimType.scale,
                            headerAnimationLoop: false,
                            showCloseIcon: true,
                            dialogType: DialogType.info,
                            keyboardAware: true,
                            body: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Text(
                                    'Add',
                                    style:
                                        Theme.of(context).textTheme.headline6,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Material(
                                    elevation: 0,
                                    color: Colors.blueGrey.withAlpha(40),
                                    child: TextFormField(
                                      autofocus: false,
                                      minLines: 1,
                                      decoration: const InputDecoration(
                                        border: InputBorder.none,
                                        labelText: 'Title',
                                        prefixIcon: Icon(Icons.text_fields),
                                      ),
                                      controller: textController,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),

                                  //ADD BUTTON
                                  ElevatedButton.icon(
                                    style: TextButton.styleFrom(
                                      backgroundColor: secondaryColor,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        Get.back();
                                      });
                                    },
                                    icon: Icon(
                                      Icons.add,
                                      color: primaryColor,
                                    ),
                                    label: Text(
                                      "Add New Category",
                                      style: GoogleFonts.inter(
                                        color: primaryColor,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ).show();
                        },
                        icon: Icon(
                          Icons.add,
                          color: primaryColor,
                        ),
                        label: Text(
                          "Add",
                          style: GoogleFonts.inter(
                            color: primaryColor,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: const [
                      Visibility(
                        visible: true,
                        child: SizedBox(
                            // color: Colors.amber,
                            width: 200,
                            height: 100,
                            child: InputFieldWidget(hintText: "test")),
                      ),
                    ],
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
        // bottomNavigationBar: const BottomNavbar(),
      ),
    );
  }
}
