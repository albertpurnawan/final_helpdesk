import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../util/appbar.dart';
import '../util/bottom_navbar.dart';

class ReportPage extends StatefulWidget {
  const ReportPage({super.key});

  @override
  State<ReportPage> createState() => ReportBody();
}

class ReportBody extends State<ReportPage> {
  final DataTableSource _dataIssue = MyData();

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
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            const SizedBox(
                              child: Text(
                                "From: ",
                                style: TextStyle(fontSize: 10),
                              ),
                            ),
                            SizedBox(
                              width: 90,
                              height: 25,
                              child: TextField(
                                  style: const TextStyle(
                                      fontSize: 10.0,
                                      height: 0.0,
                                      color: Colors.black),
                                  controller:
                                      dateControllerFrom, //editing controller of this TextField
                                  decoration: const InputDecoration(
                                      icon: Icon(
                                        Icons.calendar_today,
                                        size: 15.0,
                                      ), //icon of text field
                                      labelText:
                                          "dd/mm/yyyy" //label text of field
                                      ),
                                  readOnly:
                                      true, // when true user cannot edit text
                                  onTap: () async {
                                    //when click we have to show the datepicker
                                    DateTime? pickedDate = await showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime(2000),
                                        lastDate: DateTime(2100));
                                    if (pickedDate != null) {
                                      String formatedDate =
                                          DateFormat("dd/MM/yyyy")
                                              .format(pickedDate);
                                      setState(() {
                                        dateControllerFrom.text = formatedDate;
                                      });
                                    } else {}
                                  }),
                            ),
                            const SizedBox(child: Text("To: ")),
                            SizedBox(
                              width: 90,
                              height: 15,
                              child: TextField(
                                  style: const TextStyle(
                                      fontSize: 10.0,
                                      height: 2.0,
                                      color: Colors.black),
                                  controller:
                                      dateControllerTo, //editing controller of this TextField
                                  decoration: const InputDecoration(
                                    icon: Icon(
                                      Icons.calendar_today,
                                      size: 15.0,
                                    ), //icon of text field
                                    labelText: "dd/mm/yyyy",
                                    //label text of field
                                  ),
                                  readOnly:
                                      true, // when true user cannot edit text
                                  onTap: () async {
                                    //when click we have to show the datepicker
                                    DateTime? pickedDate = await showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime(2000),
                                        lastDate: DateTime(2100));
                                    if (pickedDate != null) {
                                      String formatedDate =
                                          DateFormat("dd/MM/yyyy")
                                              .format(pickedDate);
                                      setState(() {
                                        dateControllerTo.text = formatedDate;
                                      });
                                    } else {}
                                  }),
                            ),
                          ],
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
                  const SizedBox(
                    height: 20,
                  ),
                  PaginatedDataTable(
                    columns: _createColumns(),
                    source: _dataIssue,
                    columnSpacing: 40,
                    horizontalMargin: 25,
                    rowsPerPage: 8,
                    arrowHeadColor: Colors.green,
                  ),
                ]))
          ])),
      bottomNavigationBar: const BottomNavbar(),
    );
  }
}

List<DataColumn> _createColumns() {
  return [
    DataColumn(
      label: Text('Ticket Number', style: GoogleFonts.inter()),
    ),
    DataColumn(
      label: Text('Status', style: GoogleFonts.inter()),
    ),
    DataColumn(
      label: Text('Username', style: GoogleFonts.inter()),
    ),
    DataColumn(
      label: Text('Name', style: GoogleFonts.inter()),
    ),
    DataColumn(
      label: Text('Helpdesk Username', style: GoogleFonts.inter()),
    ),
    DataColumn(
      label: Text('Helpdesk Name', style: GoogleFonts.inter()),
    ),
    DataColumn(
      label: Text('PIC Username', style: GoogleFonts.inter()),
    ),
    DataColumn(
      label: Text('Request Date', style: GoogleFonts.inter()),
    ),
    DataColumn(
      label: Text('Helpdesk Response Date', style: GoogleFonts.inter()),
    ),
    DataColumn(
      label: Text('Get Job Date', style: GoogleFonts.inter()),
    ),
    DataColumn(
      label: Text('PIC Close Date', style: GoogleFonts.inter()),
    ),
    DataColumn(
      label: Text('Finish Date', style: GoogleFonts.inter()),
    ),
    DataColumn(
      label: Text('Duration by helpdesk', style: GoogleFonts.inter()),
    ),
    DataColumn(
      label: Text('Durationby PIC', style: GoogleFonts.inter()),
    ),
    DataColumn(
      label: Text('Small', style: GoogleFonts.inter()),
    ),
    DataColumn(
      label: Text('Communication By', style: GoogleFonts.inter()),
    ),
    DataColumn(
      label: Text('Support Category', style: GoogleFonts.inter()),
    ),
    DataColumn(
      label: Text('SubCategory 1', style: GoogleFonts.inter()),
    ),
    DataColumn(
      label: Text('SubCategory 2', style: GoogleFonts.inter()),
    ),
    DataColumn(
      label: Text('Repair Type', style: GoogleFonts.inter()),
    ),
    DataColumn(
      label: Text('Support Type', style: GoogleFonts.inter()),
    ),
    DataColumn(
      label: Text('System', style: GoogleFonts.inter()),
    ),
    DataColumn(
      label: Text('Application', style: GoogleFonts.inter()),
    ),
    DataColumn(
      label: Text('Description', style: GoogleFonts.inter()),
    ),
    DataColumn(
      label: Text('Problem Identification', style: GoogleFonts.inter()),
    ),
    DataColumn(
      label: Text('Corrective Action', style: GoogleFonts.inter()),
    ),
    DataColumn(
      label: Text('Rejected Notes', style: GoogleFonts.inter()),
    )
  ];
}

class MyData extends DataTableSource {
  final List<Map<String, dynamic>> _dataIssue = [
    {
      'TicketNumber': 2201000250005727,
      'Status': 'REJECT',
      'Username': 'MG44700',
      'Name': 'SUBANA',
      'HelpdeskUsername': '265\$',
      'HelpdeskName': '1',
      'PICUsername': 'Arshik',
      'RequestDate': '5644645',
      'HelpdeskResponseDate': '3',
      'GetJobDate': 'MM04996 - Chris Anggawana',
      'PICCloseDate': 'MM04994 - Daniel',
      'FinishDate': 'Open',
      'Durationbyhelpdesk': '01-11-2022',
      'DurationbyPIC': 'Gak bisa buka',
      'Small': 'MM04996 - Chris Anggawana',
      'CommunicationBy': 'MM04994 - Daniel',
      'SupportCategory': 'Open',
      'SubCategory1': '01-11-2022',
      'SubCategory2': 'Gak bisa buka',
      'RepairType': 'MM04996 - Chris Anggawana',
      'SupportType': 'MM04994 - Daniel',
      'System': 'Open',
      'Application': '01-11-2022',
      'Description': 'Gak bisa buka',
      'ProblemIdentification': 'MM04996 - Chris Anggawana',
      'CorrectiveAction': 'MM04994 - Daniel',
      'RejectedNotes': 'Open',
    },
    {
      'TicketNumber': 2201000250005727,
      'Status': 'REJECT',
      'Username': 'MG44700',
      'Name': 'SUBANA',
      'HelpdeskUsername': '265\$',
      'HelpdeskName': '1',
      'PICUsername': 'Arshik',
      'RequestDate': '5644645',
      'HelpdeskResponseDate': '3',
      'GetJobDate': 'MM04996 - Chris Anggawana',
      'PICCloseDate': 'MM04994 - Daniel',
      'FinishDate': 'Open',
      'Durationbyhelpdesk': '01-11-2022',
      'DurationbyPIC': 'Gak bisa buka',
      'Small': 'MM04996 - Chris Anggawana',
      'CommunicationBy': 'MM04994 - Daniel',
      'SupportCategory': 'Open',
      'SubCategory1': '01-11-2022',
      'SubCategory2': 'Gak bisa buka',
      'RepairType': 'MM04996 - Chris Anggawana',
      'SupportType': 'MM04994 - Daniel',
      'System': 'Open',
      'Application': '01-11-2022',
      'Description': 'Gak bisa buka',
      'ProblemIdentification': 'MM04996 - Chris Anggawana',
      'CorrectiveAction': 'MM04994 - Daniel',
      'RejectedNotes': 'Open',
    },
    {
      'TicketNumber': 2201000250005727,
      'Status': 'REJECT',
      'Username': 'MG44700',
      'Name': 'SUBANA',
      'HelpdeskUsername': '265\$',
      'HelpdeskName': '1',
      'PICUsername': 'Arshik',
      'RequestDate': '5644645',
      'HelpdeskResponseDate': '3',
      'GetJobDate': 'MM04996 - Chris Anggawana',
      'PICCloseDate': 'MM04994 - Daniel',
      'FinishDate': 'Open',
      'Durationbyhelpdesk': '01-11-2022',
      'DurationbyPIC': 'Gak bisa buka',
      'Small': 'MM04996 - Chris Anggawana',
      'CommunicationBy': 'MM04994 - Daniel',
      'SupportCategory': 'Open',
      'SubCategory1': '01-11-2022',
      'SubCategory2': 'Gak bisa buka',
      'RepairType': 'MM04996 - Chris Anggawana',
      'SupportType': 'MM04994 - Daniel',
      'System': 'Open',
      'Application': '01-11-2022',
      'Description': 'Gak bisa buka',
      'ProblemIdentification': 'MM04996 - Chris Anggawana',
      'CorrectiveAction': 'MM04994 - Daniel',
      'RejectedNotes': 'Open',
    },
    {
      'TicketNumber': 2201000250005727,
      'Status': 'REJECT',
      'Username': 'MG44700',
      'Name': 'SUBANA',
      'HelpdeskUsername': '265\$',
      'HelpdeskName': '1',
      'PICUsername': 'Arshik',
      'RequestDate': '5644645',
      'HelpdeskResponseDate': '3',
      'GetJobDate': 'MM04996 - Chris Anggawana',
      'PICCloseDate': 'MM04994 - Daniel',
      'FinishDate': 'Open',
      'Durationbyhelpdesk': '01-11-2022',
      'DurationbyPIC': 'Gak bisa buka',
      'Small': 'MM04996 - Chris Anggawana',
      'CommunicationBy': 'MM04994 - Daniel',
      'SupportCategory': 'Open',
      'SubCategory1': '01-11-2022',
      'SubCategory2': 'Gak bisa buka',
      'RepairType': 'MM04996 - Chris Anggawana',
      'SupportType': 'MM04994 - Daniel',
      'System': 'Open',
      'Application': '01-11-2022',
      'Description': 'Gak bisa buka',
      'ProblemIdentification': 'MM04996 - Chris Anggawana',
      'CorrectiveAction': 'MM04994 - Daniel',
      'RejectedNotes': 'Open',
    },
    {
      'TicketNumber': 2201000250005727,
      'Status': 'REJECT',
      'Username': 'MG44700',
      'Name': 'SUBANA',
      'HelpdeskUsername': '265\$',
      'HelpdeskName': '1',
      'PICUsername': 'Arshik',
      'RequestDate': '5644645',
      'HelpdeskResponseDate': '3',
      'GetJobDate': 'MM04996 - Chris Anggawana',
      'PICCloseDate': 'MM04994 - Daniel',
      'FinishDate': 'Open',
      'Durationbyhelpdesk': '01-11-2022',
      'DurationbyPIC': 'Gak bisa buka',
      'Small': 'MM04996 - Chris Anggawana',
      'CommunicationBy': 'MM04994 - Daniel',
      'SupportCategory': 'Open',
      'SubCategory1': '01-11-2022',
      'SubCategory2': 'Gak bisa buka',
      'RepairType': 'MM04996 - Chris Anggawana',
      'SupportType': 'MM04994 - Daniel',
      'System': 'Open',
      'Application': '01-11-2022',
      'Description': 'Gak bisa buka',
      'ProblemIdentification': 'MM04996 - Chris Anggawana',
      'CorrectiveAction': 'MM04994 - Daniel',
      'RejectedNotes': 'Open',
    },
    {
      'TicketNumber': 2201000250005727,
      'Status': 'REJECT',
      'Username': 'MG44700',
      'Name': 'SUBANA',
      'HelpdeskUsername': '265\$',
      'HelpdeskName': '1',
      'PICUsername': 'Arshik',
      'RequestDate': '5644645',
      'HelpdeskResponseDate': '3',
      'GetJobDate': 'MM04996 - Chris Anggawana',
      'PICCloseDate': 'MM04994 - Daniel',
      'FinishDate': 'Open',
      'Durationbyhelpdesk': '01-11-2022',
      'DurationbyPIC': 'Gak bisa buka',
      'Small': 'MM04996 - Chris Anggawana',
      'CommunicationBy': 'MM04994 - Daniel',
      'SupportCategory': 'Open',
      'SubCategory1': '01-11-2022',
      'SubCategory2': 'Gak bisa buka',
      'RepairType': 'MM04996 - Chris Anggawana',
      'SupportType': 'MM04994 - Daniel',
      'System': 'Open',
      'Application': '01-11-2022',
      'Description': 'Gak bisa buka',
      'ProblemIdentification': 'MM04996 - Chris Anggawana',
      'CorrectiveAction': 'MM04994 - Daniel',
      'RejectedNotes': 'Open',
    },
    {
      'TicketNumber': 2201000250005727,
      'Status': 'REJECT',
      'Username': 'MG44700',
      'Name': 'SUBANA',
      'HelpdeskUsername': '265\$',
      'HelpdeskName': '1',
      'PICUsername': 'Arshik',
      'RequestDate': '5644645',
      'HelpdeskResponseDate': '3',
      'GetJobDate': 'MM04996 - Chris Anggawana',
      'PICCloseDate': 'MM04994 - Daniel',
      'FinishDate': 'Open',
      'Durationbyhelpdesk': '01-11-2022',
      'DurationbyPIC': 'Gak bisa buka',
      'Small': 'MM04996 - Chris Anggawana',
      'CommunicationBy': 'MM04994 - Daniel',
      'SupportCategory': 'Open',
      'SubCategory1': '01-11-2022',
      'SubCategory2': 'Gak bisa buka',
      'RepairType': 'MM04996 - Chris Anggawana',
      'SupportType': 'MM04994 - Daniel',
      'System': 'Open',
      'Application': '01-11-2022',
      'Description': 'Gak bisa buka',
      'ProblemIdentification': 'MM04996 - Chris Anggawana',
      'CorrectiveAction': 'MM04994 - Daniel',
      'RejectedNotes': 'Open',
    },
    {
      'TicketNumber': 2201000250005727,
      'Status': 'REJECT',
      'Username': 'MG44700',
      'Name': 'SUBANA',
      'HelpdeskUsername': '265\$',
      'HelpdeskName': '1',
      'PICUsername': 'Arshik',
      'RequestDate': '5644645',
      'HelpdeskResponseDate': '3',
      'GetJobDate': 'MM04996 - Chris Anggawana',
      'PICCloseDate': 'MM04994 - Daniel',
      'FinishDate': 'Open',
      'Durationbyhelpdesk': '01-11-2022',
      'DurationbyPIC': 'Gak bisa buka',
      'Small': 'MM04996 - Chris Anggawana',
      'CommunicationBy': 'MM04994 - Daniel',
      'SupportCategory': 'Open',
      'SubCategory1': '01-11-2022',
      'SubCategory2': 'Gak bisa buka',
      'RepairType': 'MM04996 - Chris Anggawana',
      'SupportType': 'MM04994 - Daniel',
      'System': 'Open',
      'Application': '01-11-2022',
      'Description': 'Gak bisa buka',
      'ProblemIdentification': 'MM04996 - Chris Anggawana',
      'CorrectiveAction': 'MM04994 - Daniel',
      'RejectedNotes': 'Open',
    },
    {
      'TicketNumber': 2201000250005727,
      'Status': 'REJECT',
      'Username': 'MG44700',
      'Name': 'SUBANA',
      'HelpdeskUsername': '265\$',
      'HelpdeskName': '1',
      'PICUsername': 'Arshik',
      'RequestDate': '5644645',
      'HelpdeskResponseDate': '3',
      'GetJobDate': 'MM04996 - Chris Anggawana',
      'PICCloseDate': 'MM04994 - Daniel',
      'FinishDate': 'Open',
      'Durationbyhelpdesk': '01-11-2022',
      'DurationbyPIC': 'Gak bisa buka',
      'Small': 'MM04996 - Chris Anggawana',
      'CommunicationBy': 'MM04994 - Daniel',
      'SupportCategory': 'Open',
      'SubCategory1': '01-11-2022',
      'SubCategory2': 'Gak bisa buka',
      'RepairType': 'MM04996 - Chris Anggawana',
      'SupportType': 'MM04994 - Daniel',
      'System': 'Open',
      'Application': '01-11-2022',
      'Description': 'Gak bisa buka',
      'ProblemIdentification': 'MM04996 - Chris Anggawana',
      'CorrectiveAction': 'MM04994 - Daniel',
      'RejectedNotes': 'Open',
    },
  ];

  @override
  DataRow? getRow(int index) {
    return DataRow(cells: [
      DataCell(Text(
        _dataIssue[index]['TicketNumber'].toString(),
        style: GoogleFonts.inter(),
      )),
      DataCell(Text(
        _dataIssue[index]['Status'].toString(),
        style: GoogleFonts.inter(),
      )),
      DataCell(Text(
        _dataIssue[index]['Username'].toString(),
        style: GoogleFonts.inter(),
      )),
      DataCell(Text(
        _dataIssue[index]['Name'].toString(),
        style: GoogleFonts.inter(),
      )),
      DataCell(Text(
        _dataIssue[index]['HelpdeskUsername'].toString(),
        style: GoogleFonts.inter(),
      )),
      DataCell(Text(
        _dataIssue[index]['HelpdeskName'].toString(),
        style: GoogleFonts.inter(),
      )),
      DataCell(Text(
        _dataIssue[index]['PICUsername'].toString(),
        style: GoogleFonts.inter(),
      )),
      DataCell(Text(
        _dataIssue[index]['RequestDate'].toString(),
        style: GoogleFonts.inter(),
      )),
      DataCell(Text(
        _dataIssue[index]['HelpdeskResponseDate'].toString(),
        style: GoogleFonts.inter(),
      )),
      DataCell(Text(
        _dataIssue[index]['GetJobDate'].toString(),
        style: GoogleFonts.inter(),
      )),
      DataCell(Text(
        _dataIssue[index]['PICCloseDate'].toString(),
        style: GoogleFonts.inter(),
      )),
      DataCell(Text(
        _dataIssue[index]['FinishDate'].toString(),
        style: GoogleFonts.inter(),
      )),
      DataCell(Text(
        _dataIssue[index]['Durationbyhelpdesk'].toString(),
        style: GoogleFonts.inter(),
      )),
      DataCell(Text(
        _dataIssue[index]['DurationbyPIC'].toString(),
        style: GoogleFonts.inter(),
      )),
      DataCell(Text(
        _dataIssue[index]['Small'].toString(),
        style: GoogleFonts.inter(),
      )),
      DataCell(Text(
        _dataIssue[index]['CommunicationBy'].toString(),
        style: GoogleFonts.inter(),
      )),
      DataCell(Text(
        _dataIssue[index]['SupportCategory'].toString(),
        style: GoogleFonts.inter(),
      )),
      DataCell(Text(
        _dataIssue[index]['SubCategory1'].toString(),
        style: GoogleFonts.inter(),
      )),
      DataCell(Text(
        _dataIssue[index]['SubCategory2'].toString(),
        style: GoogleFonts.inter(),
      )),
      DataCell(Text(
        _dataIssue[index]['RepairType'].toString(),
        style: GoogleFonts.inter(),
      )),
      DataCell(Text(
        _dataIssue[index]['SupportType'].toString(),
        style: GoogleFonts.inter(),
      )),
      DataCell(Text(
        _dataIssue[index]['System'].toString(),
        style: GoogleFonts.inter(),
      )),
      DataCell(Text(
        _dataIssue[index]['Application'].toString(),
        style: GoogleFonts.inter(),
      )),
      DataCell(Text(
        _dataIssue[index]['Description'].toString(),
        style: GoogleFonts.inter(),
      )),
      DataCell(Text(
        _dataIssue[index]['ProblemIdentification'].toString(),
        style: GoogleFonts.inter(),
      )),
      DataCell(Text(
        _dataIssue[index]['CorrectiveAction'].toString(),
        style: GoogleFonts.inter(),
      )),
      DataCell(Text(
        _dataIssue[index]['RejectedNotes'].toString(),
        style: GoogleFonts.inter(),
      ))
    ]);
  }

  bool get isRowCountApproximate => false;

  int get rowCount => _dataIssue.length;

  int get selectedRowCount => 0;
}
