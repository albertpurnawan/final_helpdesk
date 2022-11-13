import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:helpdesk_skripsi/style.dart';
import 'package:helpdesk_skripsi/util/appbar.dart';
import 'package:helpdesk_skripsi/util/bottom_navbar.dart';

class MasterCategoryPage extends StatefulWidget {
  const MasterCategoryPage({super.key});

  @override
  State<MasterCategoryPage> createState() => _MasterCategoryPageState();
}

class MasterCategoryData extends DataTableSource {
  final List<Map<String, dynamic>> data = List.generate(
    100,
    (index) => {
      "support_category": "support_category $index",
      "created_by": "created_by $index",
      "created_at": "created_at $index",
      "updated_by": "updated_by $index",
      "updated_at": "updated_at $index",
    },
  );

  @override
  DataRow? getRow(int index) {
    return DataRow(cells: [
      DataCell(Row(
        children: [
          IconButton(
            icon: const Icon(Icons.edit, size: 16),
            onPressed: () {
              print('edit clicked');
            },
          ),
          // const SizedBox(width: 5),
          IconButton(
            icon: const Icon(Icons.delete, size: 16),
            onPressed: () {
              print('delete clicked');
            },
          ),
        ],
      )),
      DataCell(Text(data[index]['support_category'])),
      DataCell(Text(data[index]['created_by'])),
      DataCell(Text(data[index]['created_at'])),
      DataCell(Text(data[index]['updated_by'])),
      DataCell(Text(data[index]['updated_at'])),
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => data.length;

  @override
  int get selectedRowCount => 0;
}

class _MasterCategoryPageState extends State<MasterCategoryPage> {
  List<String> tabItems = [
    "Support Category",
    "Category",
    "Sub Category 1",
    "Sub Category 2"
  ];

  final DataTableSource data = MasterCategoryData();

  int current = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: const MyAppBar(),
      // drawer: const MyDrawer(),
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
                color: secondaryColor,
              ),
            ),
            Divider(
              color: secondaryColor,
              thickness: 1,
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 70,
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
                      width: 140,
                      // height: 50,
                      decoration: BoxDecoration(
                        color:
                            current == index ? Colors.white70 : Colors.white54,
                        borderRadius: current == index
                            ? BorderRadius.circular(15)
                            : BorderRadius.circular(10),
                        border: current == index
                            ? Border.all(
                                color: secondaryColor,
                                width: 2,
                              )
                            : null,
                      ),
                      child: Center(
                        child: Text(
                          tabItems[index],
                          style: GoogleFonts.inter(
                            fontWeight: FontWeight.bold,
                            color: current == index ? blackColor : Colors.grey,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            // MAIN BODY
            // Container(
            //   margin: const EdgeInsets.only(top: 20),
            //   width: double.infinity,
            //   height: 500,
            //   color: Colors.white,
            //   child: Column(
            //     mainAxisAlignment: MainAxisAlignment.center,
            //     children: [
            //       Text(
            //         tabItems[current],
            //       ),
            //     ],
            //   ),
            // ),
            const SizedBox(height: 10),
            PaginatedDataTable(
                columns: const [
                  DataColumn(label: Text("Actions")),
                  DataColumn(label: Text("Support Category")),
                  DataColumn(label: Text("Created By")),
                  DataColumn(label: Text("Created At")),
                  DataColumn(label: Text("Updated By")),
                  DataColumn(label: Text("Updated At")),
                ],
                columnSpacing: 40,
                rowsPerPage: 5,
                // horizontalMargin: 20,
                source: data,
                arrowHeadColor: secondaryColor)
            // SingleChildScrollView(
            //   scrollDirection: Axis.horizontal,
            //   child: DataTable(
            //     decoration: BoxDecoration(
            //       color: Colors.white,
            //       borderRadius: BorderRadius.circular(10),
            //     ),
            //     columns: const [
            //       DataColumn(label: Text("Actions")),
            //       DataColumn(label: Text("Support Category")),
            //       DataColumn(label: Text("Created By")),
            //       DataColumn(label: Text("Created At")),
            //       DataColumn(label: Text("Updated By")),
            //       DataColumn(label: Text("Updated At")),
            //     ],
            //     rows: [
            //       DataRow(
            //         cells: [
            //           DataCell(Row(
            //             children: [
            //               IconButton(
            //                 icon: const Icon(Icons.edit),
            //                 onPressed: () {
            //                   print('edit clicked');
            //                 },
            //               ),
            //               // const SizedBox(width: 5),
            //               IconButton(
            //                 icon: const Icon(Icons.delete),
            //                 onPressed: () {
            //                   print('delete clicked');
            //                 },
            //               ),
            //             ],
            //           )),
            //           const DataCell(Text("Server")),
            //           const DataCell(Text("MM04994")),
            //           const DataCell(Text("7/27/2022, 11:10:04 AM")),
            //           const DataCell(Text("MM04994")),
            //           const DataCell(Text("7/27/2022, 11:10:04 AM")),
            //         ],
            //       ),
            //     ],
            //   ),
            // )
          ],
        ),
      ),
      bottomNavigationBar: const BottomNavbar(),
    );
  }
}
