import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:helpdesk_skripsi/util/bottom_navbar.dart';
import 'package:intl/intl.dart';

import '../util/appbar.dart';

class TicketPoolPage extends StatefulWidget {
  const TicketPoolPage({super.key});
  @override
  State<TicketPoolPage> createState() => TicketPoolBody();
}

class TicketPoolBody extends State<TicketPoolPage> {
  final DataTableSource _dataIssue = MyData();

  int current = 0;
  List<String> tabItems = [
    "Ticket Open Helpdesk",
    "Ticket Open PIC Support",
    "Close"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[50],
      appBar: const MyAppBar(),
      body: Container(
        margin: const EdgeInsets.all(20),
        width: double.infinity,
        height: double.infinity,
        // color: Colors.red,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "List Of Ticket",
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
          ],
        ),
      ),
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
      label: Text('Created Date', style: GoogleFonts.inter()),
    ),
    DataColumn(
      label: Text('Description', style: GoogleFonts.inter()),
    ),
    DataColumn(
      label: Text('Request For', style: GoogleFonts.inter()),
    ),
    DataColumn(
      label: Text('Created By', style: GoogleFonts.inter()),
    ),
    DataColumn(
      label: Text('Support Category', style: GoogleFonts.inter()),
    ),
    /*DataColumn(
      label: Text('Request Date', style: GoogleFonts.inter()),
    ),
    DataColumn(
      label: Text('Helpdesk Username', style: GoogleFonts.inter()),
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
    */
  ];
}

class MyData extends DataTableSource {
  final List<Map<String, dynamic>> _dataIssue = List.generate(
      100,
      (index) => {
            'TicketNumber': 2201000250005727,
            'CreatedDate': 'REJECT',
            'Description': 'MG44700',
            'RequestFor': 'SUBANA',
            'CreatedBy': '265\$',
            'SupportCategory': '1',
            /*'PICUsername': 'Arshik',
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
            'RejectedNotes': 'Open',*/
          });

  @override
  DataRow? getRow(int index) {
    return DataRow(cells: [
      DataCell(Text(
        _dataIssue[index]['TicketNumber'].toString(),
        style: GoogleFonts.inter(),
      )),
      DataCell(Text(
        _dataIssue[index]['CreatedDate'].toString(),
        style: GoogleFonts.inter(),
      )),
      DataCell(Text(
        _dataIssue[index]['Description'].toString(),
        style: GoogleFonts.inter(),
      )),
      DataCell(Text(
        _dataIssue[index]['RequestFor'].toString(),
        style: GoogleFonts.inter(),
      )),
      DataCell(Text(
        _dataIssue[index]['CreatedBy'].toString(),
        style: GoogleFonts.inter(),
      )),
      DataCell(Text(
        _dataIssue[index]['SupportCategory'].toString(),
        style: GoogleFonts.inter(),
      )),
      /*DataCell(Text(
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
      ))*/
    ]);
  }

  bool get isRowCountApproximate => false;

  int get rowCount => _dataIssue.length;

  int get selectedRowCount => 0;
}
