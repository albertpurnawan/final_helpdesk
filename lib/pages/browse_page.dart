import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:helpdesk_skripsi/style.dart';
import 'package:helpdesk_skripsi/util/appbar.dart';
import 'package:helpdesk_skripsi/util/bottom_navbar.dart';

class BrowsePage extends StatefulWidget {
  const BrowsePage({super.key});

  @override
  State<BrowsePage> createState() => _BrowsePageState();
}

class _BrowsePageState extends State<BrowsePage> {
  final DataTableSource _dataIssue = MyData();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(),
      backgroundColor: primaryColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Browse List Issue",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: secondaryColor,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const SizedBox(
                width: 200,
                height: 30,
                child: TextField(
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(),
                    hintText: "Search...",
                    contentPadding: EdgeInsets.all(5),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              PaginatedDataTable(
                columns: _createColumns(),
                source: _dataIssue,
                columnSpacing: 40,
                horizontalMargin: 20,
                rowsPerPage: 5,
                arrowHeadColor: secondaryColor,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const BottomNavbar(),
      // drawer: const MyDrawer(),
    );
  }
}

List<DataColumn> _createColumns() {
  return [
    DataColumn(
        label: Text(
      'Actions',
      style: GoogleFonts.inter(),
    )),
    DataColumn(
        label: Text(
      'Ticket Number',
      style: GoogleFonts.inter(),
    )),
    DataColumn(
        label: Text(
      'Created Date',
      style: GoogleFonts.inter(),
    )),
    DataColumn(
        label: Text(
      'Issue Desc',
      style: GoogleFonts.inter(),
    )),
    DataColumn(
        label: Text(
      'Request For',
      style: GoogleFonts.inter(),
    )),
    DataColumn(
        label: Text(
      'Created By',
      style: GoogleFonts.inter(),
    )),
    DataColumn(
        label: Text(
      'Status',
      style: GoogleFonts.inter(),
    )),
    DataColumn(
        label: Text(
      'Support Category',
      style: GoogleFonts.inter(),
    ))
  ];
}

class MyData extends DataTableSource {
  final List<Map<String, dynamic>> _dataIssue = [
    {
      'Ticket_Num': 102,
      'CreatedDate': '01-11-2022',
      'Issue': 'Gak bisa buka',
      'RequestFor': 'MM04996 - Chris Anggawana',
      'CreatedBy': 'MM04994 - Daniel',
      'Status': 'Open',
      'SupportCat': 'Technical Problem'
    },
    {
      'Ticket_Num': 101,
      'CreatedDate': '01-11-2022',
      'Issue': 'Gak bisa buka',
      'RequestFor': 'MM04996 - Chris Anggawana',
      'CreatedBy': 'MM04994 - Daniel',
      'Status': 'Open',
      'SupportCat': 'Technical Problem'
    },
    {
      'Ticket_Num': 100,
      'CreatedDate': '01-11-2022',
      'Issue': 'Gak bisa buka',
      'RequestFor': 'MM04996 - Chris Anggawana',
      'CreatedBy': 'MM04994 - Daniel',
      'Status': 'Open',
      'SupportCat': 'Technical Problem'
    },
    {
      'Ticket_Num': 103,
      'CreatedDate': '01-11-2022',
      'Issue': 'Gak bisa buka',
      'RequestFor': 'MM04996-Chris Anggawana',
      'CreatedBy': 'MM04994 - Daniel',
      'Status': 'Open',
      'SupportCat': 'Technical Problem'
    },
    {
      'Ticket_Num': 104,
      'CreatedDate': '01-11-2022',
      'Issue': 'Gak bisa buka',
      'RequestFor': 'MM04996-Chris Anggawana',
      'CreatedBy': 'MM04994 - Daniel',
      'Status': 'Open',
      'SupportCat': 'Technical Problem'
    },
    {
      'Ticket_Num': 105,
      'CreatedDate': '01-11-2022',
      'Issue': 'Gak bisa buka',
      'RequestFor': 'MM04996-Chris Anggawana',
      'CreatedBy': 'MM04994 - Daniel',
      'Status': 'Open',
      'SupportCat': 'Technical Problem'
    },
    {
      'Ticket_Num': 106,
      'CreatedDate': '01-11-2022',
      'Issue': 'Gak bisa buka',
      'RequestFor': 'MM04996-Chris Anggawana',
      'CreatedBy': 'MM04994 - Daniel',
      'Status': 'Open',
      'SupportCat': 'Technical Problem'
    },
    {
      'Ticket_Num': 107,
      'CreatedDate': '01-11-2022',
      'Issue': 'Gak bisa buka',
      'RequestFor': 'MM04996-Chris Anggawana',
      'CreatedBy': 'MM04994 - Daniel',
      'Status': 'Open',
      'SupportCat': 'Technical Problem'
    },
    {
      'Ticket_Num': 108,
      'CreatedDate': '01-11-2022',
      'Issue': 'Gak bisa buka',
      'RequestFor': 'MM04996-Chris Anggawana',
      'CreatedBy': 'MM04994 - Daniel',
      'Status': 'Open',
      'SupportCat': 'Technical Problem'
    },
    {
      'Ticket_Num': 109,
      'CreatedDate': '01-11-2022',
      'Issue': 'Gak bisa buka',
      'RequestFor': 'MM04996-Chris Anggawana',
      'CreatedBy': 'MM04994 - Daniel',
      'Status': 'Open',
      'SupportCat': 'Technical Problem'
    },
    {
      'Ticket_Num': 110,
      'CreatedDate': '01-11-2022',
      'Issue': 'Gak bisa buka',
      'RequestFor': 'MM04996-Chris Anggawana',
      'CreatedBy': 'MM04994 - Daniel',
      'Status': 'Open',
      'SupportCat': 'Technical Problem'
    },
    {
      'Ticket_Num': 111,
      'CreatedDate': '01-11-2022',
      'Issue': 'Gak bisa buka',
      'RequestFor': 'MM04996-Chris Anggawana',
      'CreatedBy': 'MM04994 - Daniel',
      'Status': 'Open',
      'SupportCat': 'Technical Problem'
    },
    {
      'Ticket_Num': 112,
      'CreatedDate': '01-11-2022',
      'Issue': 'Gak bisa buka',
      'RequestFor': 'MM04996-Chris Anggawana',
      'CreatedBy': 'MM04994 - Daniel',
      'Status': 'Open',
      'SupportCat': 'Technical Problem'
    },
    {
      'Ticket_Num': 113,
      'CreatedDate': '01-11-2022',
      'Issue': 'Gak bisa buka',
      'RequestFor': 'MM04996-Chris Anggawana',
      'CreatedBy': 'MM04994 - Daniel',
      'Status': 'Open',
      'SupportCat': 'Technical Problem'
    },
    {
      'Ticket_Num': 114,
      'CreatedDate': '01-11-2022',
      'Issue': 'Gak bisa buka',
      'RequestFor': 'MM04996-Chris Anggawana',
      'CreatedBy': 'MM04994 - Daniel',
      'Status': 'Open',
      'SupportCat': 'Technical Problem'
    },
    {
      'Ticket_Num': 115,
      'CreatedDate': '01-11-2022',
      'Issue': 'Gak bisa buka',
      'RequestFor': 'MM04996-Chris Anggawana',
      'CreatedBy': 'MM04994 - Daniel',
      'Status': 'Open',
      'SupportCat': 'Technical Problem'
    }
  ];

  @override
  DataRow? getRow(int index) {
    return DataRow(cells: [
      DataCell(Row(
        children: [
          IconButton(
            icon: const Icon(Icons.density_small_rounded, size: 20),
            onPressed: () {
              print('delete clicked');
            },
          ),
        ],
      )),
      DataCell(Text(
        _dataIssue[index]['Ticket_Num'].toString(),
        style: GoogleFonts.inter(),
      )),
      DataCell(Text(
        _dataIssue[index]['CreatedDate'],
        style: GoogleFonts.inter(),
      )),
      DataCell(Text(
        _dataIssue[index]['Issue'],
        style: GoogleFonts.inter(),
      )),
      DataCell(Text(
        _dataIssue[index]['RequestFor'],
        style: GoogleFonts.inter(),
      )),
      DataCell(Text(
        _dataIssue[index]['CreatedBy'],
        style: GoogleFonts.inter(),
      )),
      DataCell(Text(
        _dataIssue[index]['Status'],
        style: GoogleFonts.inter(),
      )),
      DataCell(Text(
        _dataIssue[index]['SupportCat'],
        style: GoogleFonts.inter(),
      ))
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => _dataIssue.length;

  @override
  int get selectedRowCount => 0;
}
