import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dropdown_button2/custom_dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:helpdesk_skripsi/style.dart';
import 'package:helpdesk_skripsi/tabs/category_tab.dart';
import 'package:helpdesk_skripsi/util/appbar.dart';

class MasterCategoryPage extends StatefulWidget {
  const MasterCategoryPage({super.key});

  @override
  State<MasterCategoryPage> createState() => _MasterCategoryPageState();
}

class _MasterCategoryPageState extends State<MasterCategoryPage> {
  final List<String> dropdownList = [
    'Item1',
    'Item2',
    'Item3',
    'Item4',
    'Item5',
    'Item6',
    'Item7',
    'Item8',
  ];

  final textController = TextEditingController();

  List<String> tabItems = [
    "Support Category",
    "Category",
    "Sub Category 1",
    "Sub Category 2"
  ];

  int current = 0;

  bool isVisible1 = false;
  bool isVisible2 = false;
  bool isVisible3 = false;

  String? selectedValue1;
  String? selectedValue2;
  String? selectedValue3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(title: "Master Category", showBackBtn: true),
      body: DefaultTabController(
        length: 4,
        child: Column(
          children: [
            TabBar(
              physics: const BouncingScrollPhysics(),
              indicatorColor: blackColor,
              isScrollable: true,
              onTap: (int index) {
                current = index;
                if (current == 1) {
                  isVisible1 = true;
                  isVisible2 = false;
                  isVisible3 = false;
                } else if (current == 2) {
                  isVisible1 = true;
                  isVisible2 = true;
                  isVisible3 = false;
                } else if (current == 3) {
                  isVisible1 = true;
                  isVisible2 = true;
                  isVisible3 = true;
                } else {
                  isVisible1 = false;
                  isVisible2 = false;
                  isVisible3 = false;
                }
                print("index is $current");
                setState(() {});
              },
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
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        tabItems[current],
                        style: GoogleFonts.inter(
                          fontSize: 20,
                          color: blackColor,
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
                  const SizedBox(height: 8),
                  Visibility(
                    visible: isVisible1,
                    child: CustomDropdownButton2(
                      hint: 'Support Category *',
                      buttonWidth: MediaQuery.of(context).size.width * 0.7,
                      dropdownWidth: MediaQuery.of(context).size.width * 0.7,
                      icon: const Icon(
                        Icons.arrow_drop_down,
                        size: 24,
                      ),
                      value: selectedValue1,
                      dropdownItems: dropdownList,
                      onChanged: (value) {
                        setState(() {
                          selectedValue1 = value;
                        });
                      },
                    ),
                  ),
                  const SizedBox(height: 8),
                  Visibility(
                    visible: isVisible2,
                    child: CustomDropdownButton2(
                      hint: 'Category *',
                      buttonWidth: MediaQuery.of(context).size.width * 0.7,
                      dropdownWidth: MediaQuery.of(context).size.width * 0.7,
                      icon: const Icon(
                        Icons.arrow_drop_down,
                        size: 24,
                      ),
                      value: selectedValue2,
                      dropdownItems: dropdownList,
                      onChanged: (value) {
                        setState(() {
                          selectedValue2 = value;
                        });
                      },
                    ),
                  ),
                  const SizedBox(height: 8),
                  Visibility(
                    visible: isVisible3,
                    child: CustomDropdownButton2(
                      hint: 'Sub Category 1 *',
                      buttonWidth: MediaQuery.of(context).size.width * 0.7,
                      dropdownWidth: MediaQuery.of(context).size.width * 0.7,
                      icon: const Icon(
                        Icons.arrow_drop_down,
                        size: 24,
                      ),
                      value: selectedValue3,
                      dropdownItems: dropdownList,
                      onChanged: (value) {
                        setState(() {
                          selectedValue3 = value;
                        });
                      },
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
            ),
          ],
        ),
      ),
    );
  }
}
