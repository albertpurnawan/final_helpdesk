import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:helpdesk_skripsi/style.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

class CategoryTab extends StatefulWidget {
  const CategoryTab({super.key});

  @override
  State<CategoryTab> createState() => _CategoryTabState();
}

class _CategoryTabState extends State<CategoryTab> {
  static List<String> categoryItems = [
    "Server",
    "Cloud",
    "Network Problem",
    "Technical Problem",
    "Application Problem",
    "Incident",
    "Data Center"
  ];

  final List<Map<String, dynamic>> _items = List.generate(
    7,
    (index) => {
      "id": index,
      "title": categoryItems[index],
      "created_by": "MG000$index",
      "created_at": "15/11/2022",
      "updated_by": "MG000$index",
      "updated_at": "15/11/2022",
    },
  );

  void _removeItem(int id) {
    setState(() {
      _items.removeWhere((element) => element['id'] == id);
    });

    // ScaffoldMessenger.of(context).showSnackBar(
    //   SnackBar(
    //     content: Text("Item #$id has been removed"),
    //     duration: const Duration(milliseconds: 500),
    //   ),
    // );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: ListView.builder(
        itemCount: _items.length,
        itemBuilder: (context, index) {
          final item = _items[index];
          return Card(
            key: PageStorageKey(item['id']),
            color: secondaryColor,
            elevation: 2,
            child: ExpansionTile(
              collapsedIconColor: primaryColor,
              iconColor: primaryColor,
              childrenPadding: const EdgeInsets.all(5),
              // expandedCrossAxisAlignment: CrossAxisAlignment.end,
              title: Text(
                item['title'],
                style: TextStyle(color: primaryColor),
              ),
              children: [
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          "Created by: ${item['created_by']}",
                          style: TextStyle(color: primaryColor),
                        ),
                        Text(
                          "Created at: ${item['created_at']}",
                          style: TextStyle(color: primaryColor),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          "Updated by: ${item['updated_by']}",
                          style: TextStyle(color: primaryColor),
                        ),
                        Text(
                          "Updated at: ${item['updated_at']}",
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
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Text(
                                      'Update',
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
                                      onPressed: () {},
                                      icon: Icon(
                                        Icons.add,
                                        color: primaryColor,
                                      ),
                                      label: Text(
                                        "Update Category",
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
                                  const BorderRadius.all(Radius.circular(6)),
                              headerAnimationLoop: false,
                              animType: AnimType.bottomSlide,
                              title: 'Remove',
                              desc:
                                  'Are you sure want to remove this category?',
                              showCloseIcon: true,
                              btnCancel: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: primaryColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(6),
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
                                  style: TextStyle(color: secondaryColor),
                                ),
                              ),
                              btnOk: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: secondaryColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                ),
                                onPressed: () {
                                  _removeItem(index);
                                  Get.back();
                                },
                                child: Text(
                                  "Yes",
                                  style: TextStyle(color: primaryColor),
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
    );
  }
}
