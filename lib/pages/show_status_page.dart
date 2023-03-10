import 'dart:async';
import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:helpdesk_skripsi/controller/controller.dart';
import 'package:helpdesk_skripsi/model/login_model.dart';
import 'package:helpdesk_skripsi/model/showstatus_model.dart';
import 'package:helpdesk_skripsi/routes/routes.dart';
import 'package:helpdesk_skripsi/style.dart';
import 'package:helpdesk_skripsi/util/appbar.dart';
import 'package:helpdesk_skripsi/util/searchBar.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

import '../model/browse_model.dart';

class ShowStatus extends StatefulWidget {
  const ShowStatus({super.key});

  @override
  State<ShowStatus> createState() => _BrowsePageState();
}

class _BrowsePageState extends State<ShowStatus> {
  bool loading = true;
  bool _showData = false;
  List<ShowStatusModel> data = [];
  Timer? debouncer;

  var iscurrentlines = const Color.fromARGB(255, 56, 251, 3);
  var isdone = const Color(0xff0096FF);
  var isreject = const Color.fromARGB(255, 252, 0, 0);
  var isreturn = Color.fromARGB(255, 115, 82, 0);
  var colorText = Color.fromARGB(255, 117, 117, 117);
  @override
  void initState() {
    super.initState();
    loading = true;
    _showData = false;
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

  @override
  Widget build(BuildContext context) {
    ScreenArguments argu =
        ModalRoute.of(context)!.settings.arguments as ScreenArguments;
    setState(() {
      this.data = argu.workflow;

      loading = false;
    });
    return Scaffold(
      appBar: const MyAppBar(title: 'Show Status', showBackBtn: true),
      backgroundColor: primaryColor,
      body: loading
          ? loadingImage()
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 20, top: 20),
                  child: Text("Ticket Number: ${data[0].docno}",
                      style: GoogleFonts.inter(
                          fontSize: 15,
                          color: secondaryColor,
                          fontWeight: FontWeight.bold)),
                ),
                const SizedBox(height: 20),
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: GroupedListView<ShowStatusModel, String>(
                    elements: data,
                    groupBy: (element) =>
                        '${element.workflowid}${element.workflowlinesid}${element.desclines}',
                    groupComparator: (value1, value2) =>
                        value2.compareTo(value1),
                    itemComparator: (item1, item2) =>
                        '${item1.workflowid}${item1.workflowlinesid}'.compareTo(
                            '${item2.workflowid}${item2.workflowlinesid}'),
                    order: GroupedListOrder.DESC,
                    useStickyGroupSeparators: false,
                    groupSeparatorBuilder: (String value) => Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 5),
                              child: Icon(
                                Icons.circle,
                                color: greyColor,
                                size: 17,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 15),
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width * 0.8,
                                child: Text(value.substring(2, value.length),
                                    softWrap: true,
                                    maxLines: 5,
                                    overflow: TextOverflow.fade,
                                    style: GoogleFonts.inter(
                                        fontSize: 17,
                                        color: greyColor,
                                        fontWeight: FontWeight.bold)),
                              ),
                            ),
                          ]),
                    ),
                    itemBuilder: (c, element) {
                      return body(element);
                    },
                  ),
                )),
              ],
            ),
    );
  }

  Column body(
    ShowStatusModel dataSub,
  ) {
    if (dataSub.isdone == '1') {
      colorText = isdone;
    } else if (dataSub.isreject == '1') {
      colorText = isreject;
    } else if (dataSub.currentlines == '1') {
      colorText = iscurrentlines;
    } else if (dataSub.isreturn == '1') {
      colorText = isreturn;
    } else {
      colorText = greyColor;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.45,
          child: Card(
            elevation: 10,
            // color: primaryColor,
            shape: RoundedRectangleBorder(
              side: BorderSide(
                color: colorText,
              ),
              borderRadius: BorderRadius.circular(20.0), //<-- SEE HERE
            ),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: const Color.fromARGB(255, 255, 255, 255),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Workflow Name: ",
                              style: GoogleFonts.inter(
                                  fontSize: 15,
                                  color: colorText,
                                  fontWeight: FontWeight.bold)),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 1,
                            child: Text(dataSub.workflowname,
                                softWrap: true,
                                maxLines: 5,
                                overflow: TextOverflow.fade,
                                style: GoogleFonts.inter(
                                    fontSize: 13,
                                    color: colorText,
                                    fontWeight: FontWeight.normal)),
                          ),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Line: ",
                              style: GoogleFonts.inter(
                                  fontSize: 15,
                                  color: colorText,
                                  fontWeight: FontWeight.bold)),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 1,
                            child: Text(
                                '${dataSub.workflowid}.${dataSub.workflowlinesid} ',
                                softWrap: true,
                                maxLines: 5,
                                overflow: TextOverflow.fade,
                                style: GoogleFonts.inter(
                                    fontSize: 13,
                                    color: colorText,
                                    fontWeight: FontWeight.normal)),
                          ),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Activity: ",
                              style: GoogleFonts.inter(
                                  fontSize: 15,
                                  color: colorText,
                                  fontWeight: FontWeight.bold)),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 1,
                            child: Text(dataSub.activity,
                                softWrap: true,
                                maxLines: 5,
                                overflow: TextOverflow.fade,
                                style: GoogleFonts.inter(
                                    fontSize: 13,
                                    color: colorText,
                                    fontWeight: FontWeight.normal)),
                          ),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Line Description: ",
                              style: GoogleFonts.inter(
                                  fontSize: 15,
                                  color: colorText,
                                  fontWeight: FontWeight.bold)),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 1,
                            child: Text(dataSub.desclines,
                                softWrap: true,
                                maxLines: 5,
                                overflow: TextOverflow.fade,
                                style: GoogleFonts.inter(
                                    fontSize: 13,
                                    color: colorText,
                                    fontWeight: FontWeight.normal)),
                          ),
                        ],
                      ),
                      Text("PIC:",
                          style: GoogleFonts.inter(
                              fontSize: 15,
                              color: colorText,
                              fontWeight: FontWeight.bold)),
                      Expanded(
                        child: ListView.builder(
                          itemCount: dataSub.displayPIC.length,
                          itemBuilder: (context, index) {
                            final id = dataSub.displayPIC[index].id;
                            return Text(
                                "${dataSub.displayPIC[index].username} - ${dataSub.displayPIC[index].name}",
                                style: GoogleFonts.inter(
                                    fontSize: 13,
                                    color: colorText,
                                    fontWeight: FontWeight.normal));
                          },
                        ),
                      ),
                      if (dataSub.closedate != "" && dataSub.rejectdate == "")
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Close Date: ",
                                style: GoogleFonts.inter(
                                    fontSize: 15,
                                    color: colorText,
                                    fontWeight: FontWeight.bold)),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 1,
                              child: Text(dataSub.closedate,
                                  softWrap: true,
                                  maxLines: 5,
                                  overflow: TextOverflow.fade,
                                  style: GoogleFonts.inter(
                                      fontSize: 13,
                                      color: colorText,
                                      fontWeight: FontWeight.normal)),
                            ),
                          ],
                        ),
                      if (dataSub.closedate == "" && dataSub.rejectdate != "")
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Reject Date: ",
                                style: GoogleFonts.inter(
                                    fontSize: 15,
                                    color: colorText,
                                    fontWeight: FontWeight.bold)),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 1,
                              child: Text(dataSub.rejectdate,
                                  softWrap: true,
                                  maxLines: 5,
                                  overflow: TextOverflow.fade,
                                  style: GoogleFonts.inter(
                                      fontSize: 13,
                                      color: colorText,
                                      fontWeight: FontWeight.normal)),
                            ),
                          ],
                        ),
                    ]),
              ),
            ),
          ),
        ),
        data[data.length - 1] == dataSub
            ? Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("GREEN: Current",
                        style: GoogleFonts.inter(
                            fontSize: 15,
                            color: iscurrentlines,
                            fontWeight: FontWeight.bold)),
                    Text("BLUE: Done",
                        style: GoogleFonts.inter(
                            fontSize: 15,
                            color: isdone,
                            fontWeight: FontWeight.bold)),
                    Text("RED: Reject",
                        style: GoogleFonts.inter(
                            fontSize: 15,
                            color: isreject,
                            fontWeight: FontWeight.bold)),
                    Text("BROWN: Return",
                        style: GoogleFonts.inter(
                            fontSize: 15,
                            color: isreturn,
                            fontWeight: FontWeight.bold)),
                    Text("GREY: Waiting",
                        style: GoogleFonts.inter(
                            fontSize: 15,
                            color: greyColor,
                            fontWeight: FontWeight.bold)),
                  ],
                ),
              )
            : const SizedBox(height: 10),
      ],
    );
  }

  Widget loadingImage() {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.8,
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
