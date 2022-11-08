import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:helpdesk_skripsi/util/drawer.dart';
import 'package:intl/intl.dart';
import '../util/appbar.dart';

class ReportPage extends StatefulWidget {
  const ReportPage({super.key});

  @override
  State<ReportPage> createState() => ReportHeader();
}

class ReportHeader extends State<ReportPage> {
  final List<Map<String, String>> listOfColumns = [
    {"Name": "AAAAAA", "Number": "1", "State": "Yes"},
    {"Name": "BBBBBB", "Number": "2", "State": "no"},
    {"Name": "CCCCCC", "Number": "3", "State": "Yes"}
  ];
  int current = 0;
  TextEditingController dateControllerFrom = TextEditingController();
  TextEditingController dateControllerTo = TextEditingController();
  @override
  void initState() {
    super.initState();
    dateControllerFrom.text = "";
    dateControllerTo.text = "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.green[50],
        appBar: const MyAppBar(),
        drawer: const MyDrawer(),
        body: SizedBox(
          width: double.infinity,
          height: double.infinity,
          // color: Colors.red,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            // Create Ticket Card
            Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
                child: Column(children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const SizedBox(
                          child: Text(
                            "From: ",
                          ),
                        ),
                        SizedBox(
                          width: 135.0,
                          child: TextField(
                              controller:
                                  dateControllerFrom, //editing controller of this TextField
                              decoration: const InputDecoration(
                                  icon: Icon(Icons
                                      .calendar_today), //icon of text field
                                  labelText: "dd/mm/yyyy" //label text of field
                                  ),
                              readOnly: true, // when true user cannot edit text
                              onTap: () async {
                                //when click we have to show the datepicker
                                DateTime? pickedDate = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(2000),
                                    lastDate: DateTime(2100));
                                if (pickedDate != null) {
                                  String formatedDate = DateFormat("dd/MM/yyyy")
                                      .format(pickedDate);
                                  setState(() {
                                    dateControllerFrom.text = formatedDate;
                                  });
                                } else {}
                              }),
                        ),
                        const SizedBox(child: Text("To: ")),
                        SizedBox(
                          width: 135.0,
                          child: TextField(
                              controller:
                                  dateControllerTo, //editing controller of this TextField
                              decoration: const InputDecoration(
                                  icon: Icon(Icons
                                      .calendar_today), //icon of text field
                                  labelText: "dd/mm/yyyy" //label text of field

                                  ),
                              readOnly: true, // when true user cannot edit text
                              onTap: () async {
                                //when click we have to show the datepicker
                                DateTime? pickedDate = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(2000),
                                    lastDate: DateTime(2100));
                                if (pickedDate != null) {
                                  String formatedDate = DateFormat("dd/MM/yyyy")
                                      .format(pickedDate);
                                  setState(() {
                                    dateControllerTo.text = formatedDate;
                                  });
                                } else {}
                              }),
                        ),
                        TextButton(
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.green[200],
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: () {},
                          child: Text(
                            "Export to Excel",
                            style: GoogleFonts.inter(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ]),
                  Padding(
                    padding: const EdgeInsets.only(top: 40),
                    child: Container(
                      width: 700,
                      padding: const EdgeInsets.all(50),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: const Offset(
                                0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        child: DataTable(columns: const [
                          DataColumn(
                            label: Text('Ticket Number'),
                          ),
                          DataColumn(
                            label: Text('Status'),
                          ),
                          DataColumn(
                            label: Text('Username'),
                          ),
                          DataColumn(
                            label: Text('Name'),
                          ),
                          DataColumn(
                            label: Text('Helpdesk Username'),
                          ),
                          DataColumn(
                            label: Text('Helpdesk Name'),
                          ),
                          DataColumn(
                            label: Text('PIC Username'),
                          ),
                          DataColumn(
                            label: Text('Request Date'),
                          ),
                          DataColumn(
                            label: Text('Helpdesk Response Date'),
                          ),
                          DataColumn(
                            label: Text('Get Job Date'),
                          ),
                          DataColumn(
                            label: Text('PIC Close Date'),
                          ),
                          DataColumn(
                            label: Text('Finish Date'),
                          ),
                          DataColumn(
                            label: Text('Duration by helpdesk'),
                          ),
                          DataColumn(
                            label: Text('Duration by PIC'),
                          ),
                          DataColumn(
                            label: Text('Small'),
                          ),
                          DataColumn(
                            label: Text('Communication By'),
                          ),
                          DataColumn(
                            label: Text('Support Category'),
                          ),
                          DataColumn(
                            label: Text('Sub Category 1'),
                          ),
                          DataColumn(
                            label: Text('Sub Category 2'),
                          ),
                          DataColumn(
                            label: Text('Repiar Type'),
                          ),
                          DataColumn(
                            label: Text('Support Type'),
                          ),
                          DataColumn(
                            label: Text('System'),
                          ),
                          DataColumn(
                            label: Text('Application'),
                          ),
                          DataColumn(
                            label: Text('Description'),
                          ),
                          DataColumn(
                            label: Text('Problem Identification'),
                          ),
                          DataColumn(
                            label: Text('Corrective Action'),
                          ),
                          DataColumn(
                            label: Text('Rejected Notes'),
                          ),
                        ], rows: const [
                          DataRow(cells: [
                            DataCell(Text('2201000250005727')),
                            DataCell(Text('REJECT')),
                            DataCell(Text('MG44700')),
                            DataCell(Text('SUBANA')),
                            DataCell(Text('265\$')),
                            DataCell(Text('1')),
                            DataCell(Text('Arshik')),
                            DataCell(Text('5644645')),
                            DataCell(Text('3')),
                            DataCell(Text('265\$')),
                            DataCell(Text('1')),
                            DataCell(Text('Arshik')),
                            DataCell(Text('5644645')),
                            DataCell(Text('3')),
                            DataCell(Text('265\$')),
                            DataCell(Text('1')),
                            DataCell(Text('Arshik')),
                            DataCell(Text('5644645')),
                            DataCell(Text('3')),
                            DataCell(Text('265\$')),
                            DataCell(Text('1')),
                            DataCell(Text('Arshik')),
                            DataCell(Text('5644645')),
                            DataCell(Text('3')),
                            DataCell(Text('265\$')),
                            DataCell(Text('1')),
                            DataCell(Text('Arshik')),
                          ]),
                          DataRow(cells: [
                            DataCell(Text('2201000250005688')),
                            DataCell(Text('REJECT')),
                            DataCell(Text('MG14980')),
                            DataCell(Text('HANDOYO NUGROHO')),
                            DataCell(Text('265\$')),
                            DataCell(Text('1')),
                            DataCell(Text('Arshik')),
                            DataCell(Text('5644645')),
                            DataCell(Text('3')),
                            DataCell(Text('265\$')),
                            DataCell(Text('1')),
                            DataCell(Text('Arshik')),
                            DataCell(Text('5644645')),
                            DataCell(Text('3')),
                            DataCell(Text('265\$')),
                            DataCell(Text('1')),
                            DataCell(Text('Arshik')),
                            DataCell(Text('5644645')),
                            DataCell(Text('3')),
                            DataCell(Text('265\$')),
                            DataCell(Text('1')),
                            DataCell(Text('Arshik')),
                            DataCell(Text('5644645')),
                            DataCell(Text('3')),
                            DataCell(Text('265\$')),
                            DataCell(Text('1')),
                            DataCell(Text('Arshik')),
                          ]),
                          DataRow(cells: [
                            DataCell(Text('2201000250005440')),
                            DataCell(Text('REJECT')),
                            DataCell(Text('MG99528')),
                            DataCell(Text('ADITYA')),
                            DataCell(Text('265\$')),
                            DataCell(Text('1')),
                            DataCell(Text('Arshik')),
                            DataCell(Text('5644645')),
                            DataCell(Text('3')),
                            DataCell(Text('265\$')),
                            DataCell(Text('1')),
                            DataCell(Text('Arshik')),
                            DataCell(Text('5644645')),
                            DataCell(Text('3')),
                            DataCell(Text('265\$')),
                            DataCell(Text('1')),
                            DataCell(Text('Arshik')),
                            DataCell(Text('5644645')),
                            DataCell(Text('3')),
                            DataCell(Text('265\$')),
                            DataCell(Text('1')),
                            DataCell(Text('Arshik')),
                            DataCell(Text('5644645')),
                            DataCell(Text('3')),
                            DataCell(Text('265\$')),
                            DataCell(Text('1')),
                            DataCell(Text('Arshik')),
                          ])
                        ]),
                      ),
                    ),
                  ),
                ]))
          ]),
        ));
  }
}
