import 'dart:async';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dropdown_button2/custom_dropdown_button2.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:helpdesk_skripsi/controller/controller.dart';
import 'package:helpdesk_skripsi/model/login_model.dart';
import 'package:helpdesk_skripsi/model/master_model.dart';
import 'package:helpdesk_skripsi/routes/routes.dart';
import 'package:helpdesk_skripsi/style.dart';
import 'package:helpdesk_skripsi/util/appbar.dart';
import 'package:lottie/lottie.dart';

class MasterCategoryPage extends StatefulWidget {
  const MasterCategoryPage({super.key});

  @override
  State<MasterCategoryPage> createState() => _MasterCategoryPageState();
}

class _MasterCategoryPageState extends State<MasterCategoryPage> {
  String supp = "";
  String category = "";
  String sub1 = "";
  String sub2 = "";
  bool loading = true;
  String search = '';
  bool enable1 = false;
  bool enable2 = false;
  List<CategoryModel> data = [];
  List<String> listsupp = [];
  List<String> listcate = [];
  List<String> listsub1 = [];
  Timer? debouncer;
  User user = User(
      username: '',
      password: '',
      ua: '',
      email: '',
      image: '',
      name: '',
      groupcode: '',
      empid: "",
      groupname: "");
  @override
  void initState() {
    super.initState();
    loading = true;

    init();
  }

  @override
  void dispose() {
    debouncer?.cancel();
    super.dispose();
  }

  void debounce(
    VoidCallback callBack, {
    Duration duration = const Duration(milliseconds: 1000),
  }) {
    if (debouncer != null) {
      debouncer!.cancel();
    }
    debouncer = Timer(duration, callBack);
  }

  void dataLoaded() {
    setState(() {
      loading = false;
    });
  }

  Future init() async => debounce(() async {
        final data = await controller.master(
            context: context, category: category, sub1: sub1, supp: supp);
        final filterData = await controller.filterMaster(
            context: context, supp: supp, category: category, sub1: sub1);
        print(supp);
        print(category);
        print(sub1);
        if (!mounted) return;
        setState(() {
          for (int i = 0; i < filterData.length; i++) {
            listsupp.add(filterData[i]);
          }
          this.data = data;
          loading = false;
        });
      });

  final textController = TextEditingController();
  final textController2 = TextEditingController();
  @override
  Widget build(BuildContext context) {
    User user = ModalRoute.of(context)!.settings.arguments as User;
    setState(() {
      this.user = user;
    });
    return Scaffold(
      appBar: const MyAppBar(title: "Master Category", showBackBtn: true),
      body: loading
          ? loadingImage()
          : Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.9,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Master Category",
                          style: GoogleFonts.inter(
                            fontSize: 20,
                            color: secondaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        ElevatedButton.icon(
                          style: TextButton.styleFrom(
                            backgroundColor: secondaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: () {
                            setState(() {
                              textController.text = "";
                            });
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
                                    const Text(
                                      'Add',
                                      style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold,
                                      ),
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
                                          labelText: '',
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
                                          borderRadius:
                                              BorderRadius.circular(6),
                                        ),
                                      ),
                                      onPressed: () async {
                                        print("masuk");

                                        setState(() {
                                          if (supp == "" &&
                                              category == "" &&
                                              sub1 == "" &&
                                              sub2 == "") {
                                            supp = textController.text;
                                          } else if (supp != "" &&
                                              category == "" &&
                                              sub1 == "" &&
                                              sub2 == "") {
                                            category = textController.text;
                                          } else if (supp != "" &&
                                              category != "" &&
                                              sub1 == "" &&
                                              sub2 == "") {
                                            sub1 = textController.text;
                                          } else if (supp != "" &&
                                              category != "" &&
                                              sub1 != "" &&
                                              sub2 == "") {
                                            sub2 = textController.text;
                                          }
                                        });
                                        final insert =
                                            await controller.createMaster(
                                                context: context,
                                                supportcategory: supp,
                                                username: user.username,
                                                category: category,
                                                subcategory1: sub1,
                                                subcategory2: sub2);
                                        print(insert);
                                        if (insert == "true") {
                                          setState(() {
                                            if (supp != "" &&
                                                category == "" &&
                                                sub1 == "") {
                                              supp = "";
                                            } else if (supp != "" &&
                                                category != "" &&
                                                sub1 == "") {
                                              category = "";
                                            } else if (supp != "" &&
                                                category != "" &&
                                                sub1 != "") {
                                              sub1 = "";
                                            }
                                          });
                                          // final filterData =
                                          //     await controller.filterMaster(
                                          //         context: context,
                                          //         supp: supp,
                                          //         category: category,
                                          //         sub1: sub1);
                                          final data = await controller.master(
                                              context: context,
                                              category: category,
                                              sub1: sub1,
                                              supp: supp);
                                          setState(() {
                                            // listsupp = [];
                                            // listcate = [];
                                            // listsub1 = [];
                                            // for (int i = 0;
                                            //     i < filterData.length;
                                            //     i++) {
                                            //   if (filterData[i] != "") {
                                            //     if (supp == "" &&
                                            //         category == "" &&
                                            //         sub1 == "") {
                                            //       listsupp.add(filterData[i]);
                                            //     } else if (supp != "" &&
                                            //         category == "" &&
                                            //         sub1 == "") {
                                            //       listcate.add(filterData[i]);
                                            //     } else if (supp != "" &&
                                            //         category != "" &&
                                            //         sub1 == "") {
                                            //       listsub1.add(filterData[i]);
                                            //     }
                                            //   }
                                            // }
                                            this.data = data;
                                          });
                                          Get.back();
                                          AwesomeDialog(
                                            context: context,
                                            animType: AnimType.scale,
                                            headerAnimationLoop: true,
                                            dialogType: DialogType.success,
                                            title: 'Succes',
                                            desc: 'Successfully add category',
                                            btnOkOnPress: () {
                                              return;
                                            },
                                            btnOkIcon: Icons.check_circle,
                                          ).show();
                                        }
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
                    const SizedBox(height: 10),
                    DropdownSearch<String>(
                      enabled: true,
                      popupProps: const PopupProps.menu(
                        showSearchBox: true,
                        showSelectedItems: true,
                      ),
                      items: listsupp,
                      dropdownDecoratorProps: const DropDownDecoratorProps(
                        dropdownSearchDecoration: InputDecoration(
                          labelText: "Support Category *",
                        ),
                      ),
                      // onBeforePopupOpening: (value) async {
                      //   setState(() {
                      //     supp = "";
                      //   });
                      //   final filterData = await controller.filterMaster(
                      //       context: context,
                      //       supp: supp,
                      //       category: category,
                      //       sub1: sub1);
                      //   setState(() {
                      //     listsupp = [];
                      //     for (int i = 0; i < filterData.length; i++) {
                      //       if (filterData[i] != "") {
                      //         listsupp.add(filterData[i]);
                      //       }
                      //     }
                      //   });
                      // },
                      onChanged: (value) async {
                        print(value);
                        setState(() {
                          supp = value!;
                          category = "";
                          sub1 = "";
                          listcate = [];
                        });
                        final filterData = await controller.filterMaster(
                            context: context,
                            supp: supp,
                            category: category,
                            sub1: sub1);
                        final data = await controller.master(
                            context: context,
                            category: category,
                            sub1: sub1,
                            supp: supp);
                        setState(() {
                          this.data = data;
                          enable1 = true;
                          for (int i = 0; i < filterData.length; i++) {
                            if (filterData[i] != "") {
                              listcate.add(filterData[i]);
                            }
                          }
                        });
                      },
                      selectedItem: supp,
                    ),
                    const SizedBox(height: 10),
                    DropdownSearch<String>(
                      enabled: enable1,
                      popupProps: const PopupProps.menu(
                        showSearchBox: true,
                        showSelectedItems: true,
                      ),
                      items: listcate,
                      dropdownDecoratorProps: const DropDownDecoratorProps(
                        dropdownSearchDecoration: InputDecoration(
                          labelText: "Category *",
                        ),
                      ),
                      onChanged: (value) async {
                        setState(() {
                          category = value!;
                          sub1 = "";
                          listsub1 = [];
                        });
                        final filterData = await controller.filterMaster(
                            context: context,
                            supp: supp,
                            category: category,
                            sub1: sub1);
                        final data = await controller.master(
                            context: context,
                            category: category,
                            sub1: sub1,
                            supp: supp);

                        setState(() {
                          this.data = data;
                          enable2 = true;
                          for (int i = 0; i < filterData.length; i++) {
                            if (filterData[i] != "") {
                              listsub1.add(filterData[i]);
                            }
                          }
                        });
                      },
                      selectedItem: category,
                    ),
                    const SizedBox(height: 10),
                    DropdownSearch<String>(
                      enabled: enable2,
                      popupProps: const PopupProps.menu(
                        showSearchBox: true,
                        showSelectedItems: true,
                      ),
                      items: listsub1,
                      dropdownDecoratorProps: const DropDownDecoratorProps(
                        dropdownSearchDecoration: InputDecoration(
                          labelText: "Sub Category 1 *",
                        ),
                      ),
                      onChanged: (value) async {
                        setState(() {
                          sub1 = value!;
                        });
                        final data = await controller.master(
                            context: context,
                            category: category,
                            sub1: sub1,
                            supp: supp);
                        setState(() {
                          this.data = data;
                        });
                      },
                      selectedItem: sub1,
                    ),
                    // CustomDropdownButton2(
                    //   hint: 'Support Category *',
                    //   buttonWidth: MediaQuery.of(context).size.width,
                    //   dropdownWidth: MediaQuery.of(context).size.width * 0.9,
                    //   icon: const Icon(
                    //     Icons.arrow_drop_down,
                    //     size: 24,
                    //   ),
                    //   value: supp,
                    //   dropdownItems: listsupp,
                    //   onChanged: (value) {
                    //     setState(() {
                    //       supp = value!;
                    //     });
                    //   },
                    // ),
                    // const SizedBox(height: 10),
                    // CustomDropdownButton2(
                    //   hint: 'Category *',
                    //   buttonWidth: MediaQuery.of(context).size.width,
                    //   dropdownWidth: MediaQuery.of(context).size.width * 0.9,
                    //   icon: const Icon(
                    //     Icons.arrow_drop_down,
                    //     size: 24,
                    //   ),
                    //   value: category,
                    //   dropdownItems: listcate,
                    //   onChanged: (value) {
                    //     setState(() {
                    //       category = value!;
                    //     });
                    //   },
                    // ),
                    // const SizedBox(height: 10),
                    // CustomDropdownButton2(
                    //   hint: 'Sub Category 1 *',
                    //   buttonWidth: MediaQuery.of(context).size.width,
                    //   dropdownWidth: MediaQuery.of(context).size.width * 0.9,
                    //   icon: const Icon(
                    //     Icons.arrow_drop_down,
                    //     size: 24,
                    //   ),
                    //   value: sub1,
                    //   dropdownItems: listsub1,
                    //   onChanged: (value) {
                    //     setState(() {
                    //       sub1 = value!;
                    //     });
                    //   },
                    // ),
                    const SizedBox(height: 10),

                    Expanded(
                      child: ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          final item = data[index];
                          print(item.supportcategory);
                          String title = "";
                          if (supp == "" && category == "" && sub1 == "") {
                            title = item.supportcategory;
                          }
                          if (supp != "" && category == "" && sub1 == "") {
                            title = item.category;
                          }
                          if (supp != "" && category != "" && sub1 == "") {
                            title = item.subcategory1;
                          }
                          if (supp != "" && category != "" && sub1 != "") {
                            title = item.subcategory2;
                          }
                          return Card(
                            key: PageStorageKey(item.id),
                            color: greyColor,
                            elevation: 2,
                            child: ExpansionTile(
                              collapsedIconColor: primaryColor,
                              iconColor: primaryColor,
                              childrenPadding: const EdgeInsets.all(5),
                              // expandedCrossAxisAlignment: CrossAxisAlignment.end,
                              title: Text(
                                title,
                                style: TextStyle(color: primaryColor),
                              ),
                              children: [
                                Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(
                                          "Created by: ${item.createdby}",
                                          style: TextStyle(color: primaryColor),
                                        ),
                                        Text(
                                          "Created at: ${item.createddate}",
                                          style: TextStyle(color: primaryColor),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(
                                          "Updated by: ${item.updatedby}",
                                          style: TextStyle(color: primaryColor),
                                        ),
                                        Text(
                                          "Updated at: ${item.updateddate}",
                                          style: TextStyle(color: primaryColor),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        // BUTTON EDIT
                                        IconButton(
                                          onPressed: () {
                                            AwesomeDialog(
                                              context: context,
                                              animType: AnimType.scale,
                                              headerAnimationLoop: false,
                                              showCloseIcon: true,
                                              dialogType: DialogType.info,
                                              keyboardAware: true,
                                              body: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Column(
                                                  children: [
                                                    const Text(
                                                      'Update',
                                                      style: TextStyle(
                                                        fontSize: 22,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 10,
                                                    ),
                                                    Material(
                                                      elevation: 0,
                                                      color: Colors.blueGrey
                                                          .withAlpha(40),
                                                      child: TextFormField(
                                                        autofocus: false,
                                                        controller:
                                                            textController2,
                                                        minLines: 1,
                                                        decoration:
                                                            const InputDecoration(
                                                          border:
                                                              InputBorder.none,
                                                          labelText: '',
                                                          prefixIcon: Icon(Icons
                                                              .text_fields),
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 10,
                                                    ),
                                                    //ADD BUTTON
                                                    ElevatedButton.icon(
                                                      style:
                                                          TextButton.styleFrom(
                                                        backgroundColor:
                                                            secondaryColor,
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(6),
                                                        ),
                                                      ),
                                                      onPressed: () async {
                                                        print("masuk");
                                                        setState(() {
                                                          if (supp == "" &&
                                                              category == "" &&
                                                              sub1 == "" &&
                                                              sub2 == "") {
                                                            supp =
                                                                textController2
                                                                    .text;
                                                          } else if (supp !=
                                                                  "" &&
                                                              category == "" &&
                                                              sub1 == "" &&
                                                              sub2 == "") {
                                                            category =
                                                                textController2
                                                                    .text;
                                                          } else if (supp !=
                                                                  "" &&
                                                              category != "" &&
                                                              sub1 == "" &&
                                                              sub2 == "") {
                                                            sub1 =
                                                                textController2
                                                                    .text;
                                                          } else if (supp !=
                                                                  "" &&
                                                              category != "" &&
                                                              sub1 != "" &&
                                                              sub2 == "") {
                                                            sub2 =
                                                                textController2
                                                                    .text;
                                                          }
                                                        });
                                                        var update = await controller
                                                            .updateMaster(
                                                                context:
                                                                    context,
                                                                supportcategory:
                                                                    supp,
                                                                username: user
                                                                    .username,
                                                                category:
                                                                    category,
                                                                subcategory1:
                                                                    sub1,
                                                                subcategory2:
                                                                    sub2,
                                                                id: item.id);
                                                        print(update);
                                                        if (update == "true") {
                                                          setState(() {
                                                            if (supp != "" &&
                                                                category ==
                                                                    "" &&
                                                                sub1 == "") {
                                                              supp = "";
                                                            } else if (supp !=
                                                                    "" &&
                                                                category !=
                                                                    "" &&
                                                                sub1 == "") {
                                                              category = "";
                                                            } else if (supp !=
                                                                    "" &&
                                                                category !=
                                                                    "" &&
                                                                sub1 != "") {
                                                              sub1 = "";
                                                            }
                                                          });
                                                          final data =
                                                              await controller
                                                                  .master(
                                                                      context:
                                                                          context,
                                                                      category:
                                                                          category,
                                                                      sub1:
                                                                          sub1,
                                                                      supp:
                                                                          supp);
                                                          setState(() {
                                                            this.data = data;
                                                            textController2
                                                                .text = "";
                                                          });
                                                          Get.back();
                                                          AwesomeDialog(
                                                            context: context,
                                                            animType:
                                                                AnimType.scale,
                                                            headerAnimationLoop:
                                                                true,
                                                            dialogType:
                                                                DialogType
                                                                    .success,
                                                            title: 'Succes',
                                                            desc:
                                                                'Successfully update category',
                                                            btnOkOnPress: () {
                                                              return;
                                                            },
                                                            btnOkIcon: Icons
                                                                .check_circle,
                                                          ).show();
                                                        }
                                                      },
                                                      icon: Icon(
                                                        Icons.add,
                                                        color: primaryColor,
                                                      ),
                                                      label: Text(
                                                        "Update Category",
                                                        style:
                                                            GoogleFonts.inter(
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
                                            Icons.edit,
                                            color: primaryColor,
                                          ),
                                        ),
                                        // BUTTON DELETE
                                        IconButton(
                                          onPressed: () {
                                            AwesomeDialog(
                                              context: context,
                                              dismissOnTouchOutside: false,
                                              dialogType: DialogType.error,
                                              buttonsBorderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(6)),
                                              headerAnimationLoop: false,
                                              animType: AnimType.bottomSlide,
                                              title: 'Remove',
                                              titleTextStyle: const TextStyle(
                                                fontSize: 22,
                                                fontWeight: FontWeight.bold,
                                              ),
                                              desc:
                                                  'Are you sure want to remove this category?',
                                              showCloseIcon: true,
                                              btnCancel: ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor: primaryColor,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            6),
                                                    side: BorderSide(
                                                      color: secondaryColor,
                                                      width: 2,
                                                    ),
                                                  ),
                                                ),
                                                onPressed: () {
                                                  Get.back();
                                                },
                                                child: Text(
                                                  "Cancel",
                                                  style: TextStyle(
                                                      color: secondaryColor),
                                                ),
                                              ),
                                              btnOk: ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor:
                                                      secondaryColor,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            6),
                                                  ),
                                                ),
                                                onPressed: () async {
                                                  var update = await controller
                                                      .deleteMaster(
                                                          context: context,
                                                          id: item.id);
                                                  print(update);
                                                  if (update == "true") {
                                                    final data =
                                                        await controller.master(
                                                            context: context,
                                                            category: category,
                                                            sub1: sub1,
                                                            supp: supp);
                                                    setState(() {
                                                      this.data = data;
                                                    });
                                                    Get.back();
                                                    AwesomeDialog(
                                                      context: context,
                                                      animType: AnimType.scale,
                                                      headerAnimationLoop: true,
                                                      dialogType:
                                                          DialogType.success,
                                                      title: 'Succes',
                                                      desc:
                                                          'Successfully update category',
                                                      btnOkOnPress: () {
                                                        return;
                                                      },
                                                      btnOkIcon:
                                                          Icons.check_circle,
                                                    ).show();
                                                  }
                                                },
                                                child: Text(
                                                  "Yes",
                                                  style: TextStyle(
                                                      color: primaryColor),
                                                ),
                                              ),
                                            ).show();
                                          },
                                          icon: Icon(
                                            Icons.delete,
                                            color: primaryColor,
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                )
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  Widget loadingImage() {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.7,
      width: MediaQuery.of(context).size.width * 1,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Lottie.asset("assets/lottie/loading.json"),
          ),
        ],
      ),
    );
  }
}
