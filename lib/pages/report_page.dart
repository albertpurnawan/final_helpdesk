// import 'dart:async';
// import 'dart:convert';
// import 'dart:io';

// import 'package:csv/csv.dart';
// import 'package:file_picker/file_picker.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:permission_handler/permission_handler.dart';

// // import 'csv_to_list.dart';

// class ReportPage extends StatefulWidget {
//   const ReportPage({Key? key}) : super(key: key);

//   @override
//   ReportBody createState() => ReportBody();
// }

// class ReportBody extends State<ReportPage> {
//   late List<List<dynamic>> employeeData;

//   @override
//   initState() {
//     //create an element rows of type list of list. All the above data set are stored in associate list
// //Let associate be a model class with attributes name,gender and age and associateList be a list of associate model class.

//     employeeData = List<List<dynamic>>.empty(growable: true);
//     for (int i = 0; i < 5; i++) {
// //row refer to each column of a row in csv file and rows refer to each row in a file
//       List<dynamic> row = List.empty(growable: true);
//       row.add("Employee Name $i");
//       row.add((i % 2 == 0) ? "Male" : "Female");
//       row.add(" Experience : ${i * 5}");
//       employeeData.add(row);
//     }
//   }

//   getCsv() async {
//     if (await Permission.storage.request().isGranted) {
// //store file in documents folder

//       String dir = (await getExternalStorageDirectory())!.path + "/mycsv.csv";
//       String file = "$dir";

//       File f = new File(file);

// // convert rows to String and write as csv file

//       String csv = const ListToCsvConverter().convert(employeeData);
//       f.writeAsString(csv);
//     } else {
//       Map<Permission, PermissionStatus> statuses = await [
//         Permission.storage,
//       ].request();
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         // Here we take the value from the MyHomePage object that was created by
//         // the App.build method, and use it to set our appbar title.
//         title: Text("Flutter CSV Upload"),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: <Widget>[
//             ListView.builder(
//                 shrinkWrap: true,
//                 itemCount: employeeData.length,
//                 itemBuilder: (context, index) {
//                   return Card(
//                     child: Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(employeeData[index][0]),
//                           Text(employeeData[index][1]),
//                           Text(employeeData[index][2]),
//                         ],
//                       ),
//                     ),
//                   );
//                 }),
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Container(
//                 color: Colors.green,
//                 height: 30,
//                 child: TextButton(
//                   child: Text(
//                     "Export to CSV",
//                     style: TextStyle(color: Colors.white),
//                   ),
//                   onPressed: getCsv,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),

//       // This trailing comma makes auto-formatting nicer for build methods.
//     );
//   }
// }

import 'dart:async';
import 'dart:io';

import 'package:excel/excel.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:helpdesk_skripsi/controller/controller.dart';
import 'package:helpdesk_skripsi/model/report_model.dart';
import 'package:helpdesk_skripsi/style.dart';
import 'package:helpdesk_skripsi/util/appbar.dart';
import 'package:helpdesk_skripsi/util/exportExcel.dart';
import 'package:intl/intl.dart';
import 'package:file_saver/file_saver.dart';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:file_saver/file_saver.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart' as x;
import 'package:to_csv/to_csv.dart' as exportCSV;

class ReportPage extends StatefulWidget {
  const ReportPage({super.key});

  @override
  State<ReportPage> createState() => ReportBody();
}

class ReportBody extends State<ReportPage> {
  // final DataTableSource _dataIssue = MyData();
  int current = 0;
  TextEditingController dateControllerFrom = TextEditingController();
  TextEditingController dateControllerTo = TextEditingController();
  TextEditingController textEditingController = TextEditingController();
  bool loading = true;
  bool _showData = false;
  String id = Get.parameters['docno'].toString();
  String ticket = Get.parameters['ticket'].toString();
  String token = Get.parameters['token'].toString();
  List<ReportModel> Data = [];
  Timer? debouncer;
  int _counter = 0;
  List<String> header = [];
  List<List<String>> listOfLists = [];

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

  @override
  void initState() {
    super.initState();
    dateControllerFrom.text = "";
    dateControllerTo.text = "";
    loading = true;
    _showData = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: const MyAppBar(title: "Report Helpdesk", showBackBtn: true),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Container(
          height: 300,
          decoration: BoxDecoration(
            color: primaryColor,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 3,
                blurRadius: 3,
                offset: const Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Select the report period",
                style: GoogleFonts.inter(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: greyColor,
                ),
              ),
              Divider(thickness: 2, color: greyColor.withOpacity(0.5)),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    child: Text(
                      "From: ",
                      style: GoogleFonts.inter(
                        color: greyColor,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 120,
                    height: 65,
                    child: TextField(
                        style: TextStyle(
                          fontSize: 15.0,
                          height: 1,
                          color: greyColor,
                        ),
                        controller: dateControllerFrom,
                        //editing controller of this TextField
                        decoration: InputDecoration(
                          icon: Icon(
                            Icons.calendar_today,
                            size: 15.0,
                            color: greyColor,
                          ), //icon of text field
                          labelText: "dd/mm/yyyy", //label text of field
                          labelStyle: GoogleFonts.inter(
                            fontSize: 14,
                            color: greyColor,
                          ),
                        ),
                        readOnly: true, // when true user cannot edit text
                        onTap: () async {
                          //when click we have to show the datepicker
                          DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime.now(),
                          );
                          if (pickedDate != null) {
                            String formatedDate =
                                DateFormat("dd/MM/yyyy").format(pickedDate);
                            setState(() {
                              dateControllerFrom.text = formatedDate;
                            });
                          } else {}
                        }),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    child: Text(
                      "To: ",
                      style: GoogleFonts.inter(
                        color: greyColor,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 120,
                    height: 65,
                    child: TextField(
                        style: TextStyle(
                          fontSize: 15.0,
                          height: 1,
                          color: greyColor,
                        ),
                        controller: dateControllerTo,
                        //editing controller of this TextField
                        decoration: InputDecoration(
                          //icon of text field
                          icon: Icon(
                            Icons.calendar_today,
                            size: 15.0,
                            color: greyColor,
                          ),
                          //label text of field
                          labelText: "dd/mm/yyyy",
                          labelStyle: GoogleFonts.inter(
                            fontSize: 14,
                            color: greyColor,
                          ),
                          // enabledBorder: OutlineInputBorder(
                          //   borderSide: const BorderSide(
                          //     color: Colors.white,
                          //     width: 2.0,
                          //   ),
                          //   borderRadius: BorderRadius.circular(10),
                          // )
                          // focusedBorder: OutlineInputBorder(
                          //   borderSide: const BorderSide(
                          //     color: Colors.white,
                          //     width: 2.0,
                          //   ),
                          //   borderRadius: BorderRadius.circular(10),
                          // ),
                        ),
                        readOnly: true, // when true user cannot edit text
                        onTap: () async {
                          //when click we have to show the datepicker
                          DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime.now(),
                          );
                          if (pickedDate != null) {
                            String formatedDate =
                                DateFormat("dd/MM/yyyy").format(pickedDate);
                            setState(() {
                              dateControllerTo.text = formatedDate;
                            });
                          } else {}
                        }),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: 200,
                child: Column(
                  children: [
                    ElevatedButton(
                        style: TextButton.styleFrom(
                          backgroundColor: greyColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        onPressed: () async => debounce(
                              () async {
                                DateTime dateTo = DateFormat('dd/MM/yyyy')
                                    .parse(dateControllerTo.text);
                                DateTime dateFrom = DateFormat('dd/MM/yyyy')
                                    .parse(dateControllerFrom.text);

                                header.add('Ticket Number');
                                header.add('Status');
                                header.add('Username');
                                header.add('Username Worklocation	Name');
                                header.add('Helpdesk Name');
                                header.add('PIC Username');
                                header.add('PIC Name');
                                header.add('PIC Worklocation');
                                header.add('Request Date');
                                header.add('Helpdesk Response Date');
                                header.add('Get Job Date');
                                header.add('PIC Close Date');
                                header.add('Finish Date');
                                header.add('Duration by Helpdesk');
                                header.add('Duration by PIC');
                                header.add('Small');
                                header.add('Communication By');
                                header.add('Support Category');
                                header.add('Category');
                                header.add('Sub Category 1');
                                header.add('Sub Category 2');
                                header.add('Repair Type');
                                header.add('Support Type');
                                header.add('System');
                                header.add('Application');
                                header.add('Description');
                                header.add('Problem Identification');
                                header.add('Corrective Action');
                                header.add('Second');
                                header.add('Minute');
                                header.add('Hour');
                                header.add('Day');
                                header.add('Rejected Notes');
                                listOfLists.add(header);

                                List<ReportModel> Data =
                                    await controller.Report(
                                        context: context,
                                        from: DateFormat('dd/MMM/yyyy')
                                            .format(dateFrom),
                                        to: DateFormat('dd/MMM/yyyy')
                                            .format(dateTo));
                                print('ini length data ${Data.length}');
                                for (int i = 0; i < Data.length; i++) {
                                  List<String> datacsv = [];
                                  datacsv.add(Data[i].TicketNumber);
                                  datacsv.add(Data[i].Status);
                                  datacsv.add(Data[i].Username);
                                  datacsv.add(Data[i].worklocation);
                                  datacsv.add(Data[i].Name);
                                  datacsv.add(Data[i].HelpdeskUsername);
                                  datacsv.add(Data[i].HelpdeskName);
                                  datacsv.add(Data[i].PICUsername);
                                  datacsv.add(Data[i].PICName);
                                  datacsv.add(Data[i].PICworklocation);
                                  datacsv.add(Data[i].RequestDate);
                                  datacsv.add(Data[i].HelpdeskResponseDate);
                                  datacsv.add(Data[i].GetJobDate);
                                  datacsv.add(Data[i].PICCloseDate);
                                  datacsv.add(Data[i].FinishDate);
                                  datacsv.add(Data[i].DurationbyHelpdesk);
                                  datacsv.add(Data[i].DurationbyPIC);
                                  datacsv.add(Data[i].Small);
                                  datacsv.add(Data[i].CommunicationBy);
                                  datacsv.add(Data[i].SupportCategory);
                                  datacsv.add(Data[i].Category);
                                  datacsv.add(Data[i].SubCategory1);
                                  datacsv.add(Data[i].SubCategory2);
                                  datacsv.add(Data[i].RepairType);
                                  datacsv.add(Data[i].SupportType);
                                  datacsv.add(Data[i].System);
                                  datacsv.add(Data[i].Application);
                                  datacsv.add(Data[i].Description);
                                  datacsv.add(Data[i].ProblemIdentification);
                                  datacsv.add(Data[i].CorrectiveAction);
                                  datacsv.add(Data[i].Second);
                                  datacsv.add(Data[i].Minute);
                                  datacsv.add(Data[i].Hour);
                                  datacsv.add(Data[i].Day);
                                  datacsv.add(Data[i].RejectedNotes);
                                  listOfLists.add(datacsv);
                                }
                                exportCSV.myCSV(header, listOfLists);
                                setState(() {
                                  header = [];
                                  listOfLists = [];
                                });
                              },
                            ),
                        child: const Text(
                          "Export",
                          style: TextStyle(color: Colors.white),
                        )),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:to_csv/to_csv.dart' as exportCSV;

// // void main() {
// //   runApp(const MyApp());
// // }

// // class MyApp extends StatelessWidget {
// //   const MyApp({super.key});

// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       title: 'Flutter Demo',
// //       theme: ThemeData(
// //         primarySwatch: Colors.blue,
// //       ),
// //       home: const MyHomePage(title: 'Flutter Demo Home Page'),
// //     );
// //   }
// // }

// class ReportPage extends StatefulWidget {
//   const ReportPage({super.key});

//   @override
//   State<ReportPage> createState() => _ReportPageState();
// }

// class _ReportPageState extends State<ReportPage> {
//   int _counter = 0;
//   List<String> header = []; //Header list variable
//   List<List<String>> listOfLists = [];
//   List<String> data1 = [
//     '1',
//     'Bilal Saeed',
//     '1374934',
//     '912839812'
//   ]; //Inner list which contains Data i.e Row
//   List<String> data2 = [
//     '2',
//     'Ahmar',
//     '21341234',
//     '192834821'
//   ]; //Inner list which contains Data i.e Row//Outter List which contains the data List
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();

//     header.add('Ticket Number');
//     header.add('Status');
//     header.add('Username');
//     header.add('Username Worklocation	Name');
//     header.add('Helpdesk Name');
//     header.add('PIC Username');
//     header.add('PIC Name');
//     header.add('PIC Worklocation');
//     header.add('Request Date');
//     header.add('Helpdesk Response Date');
//     header.add('Get Job Date');
//     header.add('PIC Close Date');
//     header.add('Finish Date');
//     header.add('Duration by Helpdesk');
//     header.add('Duration by PIC');
//     header.add('Small');
//     header.add('Communication By');
//     header.add('Support Category');
//     header.add('Category');
//     header.add('Sub Category 1');
//     header.add('Sub Category 2');
//     header.add('Repair Type');
//     header.add('Support Type');
//     header.add('System');
//     header.add('Application');
//     header.add('Description');
//     header.add('Problem Identification');
//     header.add('Corrective Action');
//     header.add('Second');
//     header.add('Minute');
//     header.add('Hour');
//     header.add('Day');
//     header.add('Rejected Notes');

//     listOfLists.add(header);
//     listOfLists.add(data1);
//     listOfLists.add(data2);
//   }

//   Widget HeaderRow() {
//     return Padding(
//       padding: const EdgeInsets.only(left: 17, top: 12.0),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceAround,
//         children: [
//           Text(
//             header[0],
//             style: const TextStyle(
//               fontSize: 14,
//               color: Colors.black87,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           Text(
//             header[1],
//             style: const TextStyle(
//               fontSize: 14,
//               color: Colors.black87,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           Text(
//             header[2],
//             style: const TextStyle(
//               fontSize: 14,
//               color: Colors.black87,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           Text(
//             header[3],
//             style: const TextStyle(
//               fontSize: 14,
//               color: Colors.black87,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("test"),
//       ),
//       body: SingleChildScrollView(
//         child: Container(
//           child: Column(
//             children: [
//               HeaderRow(),
//               Divider(),
//               Container(
//                 height: MediaQuery.of(context).size.height,
//                 width: MediaQuery.of(context).size.width,
//                 child: ListView(
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.only(top: 12.0),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceAround,
//                         children: [
//                           Text(
//                             data1[0],
//                             style: const TextStyle(
//                               fontSize: 14,
//                               color: Colors.black87,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                           Text(
//                             data1[1],
//                             style: const TextStyle(
//                               fontSize: 14,
//                               color: Colors.black87,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                           Text(
//                             data1[2],
//                             style: const TextStyle(
//                               fontSize: 14,
//                               color: Colors.black87,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                           Text(
//                             data1[3],
//                             style: const TextStyle(
//                               fontSize: 14,
//                               color: Colors.black87,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.only(top: 12.0),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceAround,
//                         children: [
//                           Text(
//                             data2[0],
//                             style: const TextStyle(
//                               fontSize: 14,
//                               color: Colors.black87,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                           Text(
//                             data2[1],
//                             style: const TextStyle(
//                               fontSize: 14,
//                               color: Colors.black87,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                           Text(
//                             data2[2],
//                             style: const TextStyle(
//                               fontSize: 14,
//                               color: Colors.black87,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                           Text(
//                             data2[3],
//                             style: const TextStyle(
//                               fontSize: 14,
//                               color: Colors.black87,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//       floatingActionButton: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Container(
//             width: 130,
//             decoration: BoxDecoration(
//                 color: Colors.blue, borderRadius: BorderRadius.circular(12)),
//             child: TextButton(
//               child: const Text(
//                 'Export CV',
//                 style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold),
//               ),
//               onPressed: () {
//                 exportCSV.myCSV(header, listOfLists);
//               },
//             ),
//           )), // This trailing comma makes auto-formatting nicer for build methods.
//     );
//   }
// }
