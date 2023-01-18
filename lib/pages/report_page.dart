import 'dart:async';
import 'dart:io';

import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:helpdesk_skripsi/data/report_data.dart';
import 'package:helpdesk_skripsi/model/report_model.dart';
import 'package:helpdesk_skripsi/style.dart';
import 'package:helpdesk_skripsi/util/appbar.dart';
import 'package:helpdesk_skripsi/util/exportExcel.dart';
import 'package:intl/intl.dart';

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

  bool loading = true;
  bool _showData = false;
  String id = Get.parameters['docno'].toString();
  String ticket = Get.parameters['ticket'].toString();
  String token = Get.parameters['token'].toString();
  List<ReportModel> Data = [];
  Timer? debouncer;

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
                child: ElevatedButton.icon(
                  style: TextButton.styleFrom(
                    backgroundColor: greyColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  onPressed: () async => debounce(() async {
                    DateTime dateTo =
                        DateFormat('dd/MM/yyyy').parse(dateControllerTo.text);
                    DateTime dateFrom =
                        DateFormat('dd/MM/yyyy').parse(dateControllerFrom.text);
                    List<ReportModel> Data = await getDataReport.dataReport(
                        context: context,
                        token: token,
                        from: DateFormat('yyyy-MM-dd').format(dateFrom),
                        to: DateFormat('dd-MMM-yyyy').format(dateTo));
                    if (!mounted) return;
                    setState(() {
                      this.Data = Data;
                      loading = false;
                    });
                    getExcel.export();
                  }),
                  icon: Icon(
                    Icons.file_download_outlined,
                    color: primaryColor,
                  ),
                  label: Text(
                    "Export to Excel",
                    style: GoogleFonts.inter(
                      color: primaryColor,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
