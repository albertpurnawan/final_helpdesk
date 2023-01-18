import 'dart:async';
import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:helpdesk_skripsi/data/showstatus_data.dart';
import 'package:helpdesk_skripsi/model/showstatus_model.dart';
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
  String id = Get.parameters['docno'].toString();
  String ticket = Get.parameters['ticket'].toString();
  String token = Get.parameters['token'].toString();
  List<ShowStatusModel> data = [];
  Timer? debouncer;
  @override
  void initState() {
    super.initState();
    loading = true;
    _showData = false;
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
        List<ShowStatusModel> rawData =
            await AllShowStatus.dataAll(context: context, id: id, token: token);
        List<String> dataUsernameTemp = [];
        List<ShowStatusModel> data = [];
        for (int i = 0; i < rawData.length; i++) {
          List<ShowStatusModel> dataUsername = [];
          if (!rawData[i].username.contains("#")) {
            ShowStatusModel data2 = await AllShowStatus.dataUsername(
                context: context,
                id: id,
                token: token,
                username: rawData[i].username);
            dataUsername.add(data2);
          }
          rawData[i].displayPIC = dataUsername;
        }
        var seen = Set<String>();
        data = rawData
            .where((showstatus) => seen
                .add('${showstatus.workflowid}${showstatus.workflowlinesid}'))
            .toList();

        for (int i = 0; i < data.length; i++) {
          List<ShowStatusModel> data3 = await AllShowStatus.dataCurrent(
              context: context, id: id, token: token);
          if (data3.isNotEmpty) {
            if ('${data[i].workflowid}${data[i].workflowlinesid}' ==
                '${data3[0].workflowid}${data3[0].workflowlinesid}') {
              for (int j = 0; j < data3.length; j++) {
                data[i].assigngroup = data3[j].assigngroup;
                data[i].assignedpic = data3[j].assignedpic;
                data[i].webname = data3[j].webname;
                data[i].creatorname = data3[j].creatorname;
                data[i].createddate = data3[j].createddate;
                data[i].lastdate = data3[j].lastdate;
                data[i].creatorname = data3[j].creatorname;
                data[i].lastapprove = data3[j].lastapprove;
              }
            }
          }
        }
        print(data);
        // groupBy(data, data)

        if (!mounted) return;
        setState(() {
          this.data = data;

          loading = false;
        });
      });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(title: 'Show Status', showBackBtn: true),
      backgroundColor: primaryColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 20, top: 20),
            child: Text("Ticket Number: $ticket",
                style: GoogleFonts.inter(
                    fontSize: 15,
                    color: secondaryColor,
                    fontWeight: FontWeight.bold)),
          ),
          const SizedBox(height: 20),
          if (loading) loadingImage(),
          if (!loading)
            Expanded(
                child: Padding(
              padding: const EdgeInsets.all(20),
              child: GroupedListView<ShowStatusModel, String>(
                elements: data,
                groupBy: (element) =>
                    '${element.workflowid}${element.workflowlinesid}${element.desclines}',
                groupComparator: (value1, value2) => value2.compareTo(value1),
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
    ShowStatusModel data,
  ) {
    return Column(
      children: [
        SizedBox(width: MediaQuery.of(context).size.width * 0.05),
        SizedBox(
          width: MediaQuery.of(context).size.width * 1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 1,
                child: Card(
                  elevation: 10,
                  color: secondaryColor,
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
                                      color: primaryColor,
                                      fontWeight: FontWeight.bold)),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 1,
                                child: Text(data.workflowname,
                                    softWrap: true,
                                    maxLines: 5,
                                    overflow: TextOverflow.fade,
                                    style: GoogleFonts.inter(
                                        fontSize: 13,
                                        color: primaryColor,
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
                                      color: primaryColor,
                                      fontWeight: FontWeight.bold)),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 1,
                                child: Text(
                                    '${data.workflowid}.${data.workflowlinesid} ',
                                    softWrap: true,
                                    maxLines: 5,
                                    overflow: TextOverflow.fade,
                                    style: GoogleFonts.inter(
                                        fontSize: 13,
                                        color: primaryColor,
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
                                      color: primaryColor,
                                      fontWeight: FontWeight.bold)),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 1,
                                child: Text(data.workflowname,
                                    softWrap: true,
                                    maxLines: 5,
                                    overflow: TextOverflow.fade,
                                    style: GoogleFonts.inter(
                                        fontSize: 13,
                                        color: primaryColor,
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
                                      color: primaryColor,
                                      fontWeight: FontWeight.bold)),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 1,
                                child: Text(data.desclines,
                                    softWrap: true,
                                    maxLines: 5,
                                    overflow: TextOverflow.fade,
                                    style: GoogleFonts.inter(
                                        fontSize: 13,
                                        color: primaryColor,
                                        fontWeight: FontWeight.normal)),
                              ),
                            ],
                          ),

                          GestureDetector(
                              onTap: () {
                                print(
                                    '${data.workflowid}.${data.workflowlinesid}');
                                setState(
                                  () {
                                    _showData = !_showData;
                                  },
                                );
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("PIC:",
                                      style: GoogleFonts.inter(
                                          fontSize: 15,
                                          color: primaryColor,
                                          fontWeight: FontWeight.bold)),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.7,
                                            child: Text(
                                                "${data.displayPIC[0].username} - ${data.displayPIC[0].name}",
                                                softWrap: true,
                                                maxLines: 5,
                                                overflow: TextOverflow.fade,
                                                style: GoogleFonts.inter(
                                                    fontSize: 13,
                                                    color: primaryColor,
                                                    fontWeight:
                                                        FontWeight.normal)),
                                          ),
                                        ],
                                      ),
                                      Icon(
                                        Icons.keyboard_arrow_down,
                                        color: primaryColor,
                                      ),
                                    ],
                                  )
                                ],
                              )),
                          // this is the company card which is toggling based upon the bool
                          _showData
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: data.displayPIC.map((e) {
                                    // make changes in the UI here for your company card
                                    return Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 10),
                                          child: Text(e.username,
                                              softWrap: true,
                                              maxLines: 5,
                                              overflow: TextOverflow.fade,
                                              style: GoogleFonts.inter(
                                                  fontSize: 13,
                                                  color: primaryColor,
                                                  backgroundColor:
                                                      secondaryColor,
                                                  fontWeight:
                                                      FontWeight.normal)),
                                        ),
                                        Text("-",
                                            softWrap: true,
                                            maxLines: 5,
                                            overflow: TextOverflow.fade,
                                            style: GoogleFonts.inter(
                                                fontSize: 13,
                                                color: primaryColor,
                                                backgroundColor: secondaryColor,
                                                fontWeight: FontWeight.normal)),
                                        Text(e.name,
                                            softWrap: true,
                                            maxLines: 5,
                                            overflow: TextOverflow.fade,
                                            style: GoogleFonts.inter(
                                                fontSize: 13,
                                                color: primaryColor,
                                                backgroundColor: secondaryColor,
                                                fontWeight: FontWeight.normal)),
                                      ],
                                    );
                                  }).toList())
                              : const SizedBox(), // else blank

                          // Expanded(
                          //     child: Padding(
                          //         padding: const EdgeInsets.all(20),
                          //         child: ListView.builder(
                          //           itemCount: data.length,
                          //           itemBuilder: (context, index) {
                          //             final id = data[index].id;
                          //             String closeDate = "";
                          //             String rejectDate = "";
                          //             if (data.showStatusData[index]
                          //                     .closedate !=
                          //                 "") {
                          //               DateTime date = DateTime.parse(data
                          //                   .showStatusData[index].closedate);
                          //               closeDate = DateFormat('dd-MMM-yyyy')
                          //                   .format(date);
                          //             }
                          //             if (data.showStatusData[index]
                          //                     .rejectdate !=
                          //                 "") {
                          //               DateTime date = DateTime.parse(data
                          //                   .showStatusData[index].rejectdate);
                          //               rejectDate = DateFormat('dd-MMM-yyyy')
                          //                   .format(date);
                          //             }
                          //             final dataBefore;
                          //             final indexNow = index;
                          //             if (index == 0) {
                          //               dataBefore = data.showStatusData[index];
                          //             } else {
                          //               dataBefore =
                          //                   data.showStatusData[index - 1];
                          //               if ('${data.showStatusData[index].workflowid}${data.showStatusData[index].workflowlinesid}' ==
                          //                   '${data.showStatusData[index - 1].workflowid}${data.showStatusData[index - 1].workflowlinesid}') {}
                          //             }
                          //             return Column(
                          //               crossAxisAlignment:
                          //                   CrossAxisAlignment.start,
                          //               children: [
                          //                 Text("PIC:",
                          //                     style: GoogleFonts.inter(
                          //                         fontSize: 15,
                          //                         color: primaryColor,
                          //                         fontWeight: FontWeight.bold)),
                          //                 Row(
                          //                   crossAxisAlignment:
                          //                       CrossAxisAlignment.center,
                          //                   mainAxisAlignment:
                          //                       MainAxisAlignment.spaceBetween,
                          //                   children: [
                          //                     Row(
                          //                       mainAxisAlignment:
                          //                           MainAxisAlignment.start,
                          //                       children: [
                          //                         if (listUsername.name == '')
                          //                           SizedBox(
                          //                             width:
                          //                                 MediaQuery.of(context)
                          //                                         .size
                          //                                         .width *
                          //                                     0.5,
                          //                             child: Text(data.username,
                          //                                 softWrap: true,
                          //                                 maxLines: 5,
                          //                                 overflow:
                          //                                     TextOverflow.fade,
                          //                                 style: GoogleFonts.inter(
                          //                                     fontSize: 13,
                          //                                     color:
                          //                                         primaryColor,
                          //                                     fontWeight:
                          //                                         FontWeight
                          //                                             .normal)),
                          //                           ),
                          //                         if (listUsername.name != '')
                          //                           SizedBox(
                          //                             width:
                          //                                 MediaQuery.of(context)
                          //                                         .size
                          //                                         .width *
                          //                                     0.7,
                          //                             child: Text(
                          //                                 "${data.username} - ${listUsername.name}",
                          //                                 softWrap: true,
                          //                                 maxLines: 5,
                          //                                 overflow:
                          //                                     TextOverflow.fade,
                          //                                 style: GoogleFonts.inter(
                          //                                     fontSize: 13,
                          //                                     color:
                          //                                         primaryColor,
                          //                                     fontWeight:
                          //                                         FontWeight
                          //                                             .normal)),
                          //                           ),
                          //                       ],
                          //                     ),
                          //                     Icon(
                          //                       Icons.keyboard_arrow_down,
                          //                       color: primaryColor,
                          //                     ),
                          //                   ],
                          //                 )
                          //               ],
                          //             );
                          //           },
                          //         ))),
                          if (data.closedate != "" && data.rejectdate == "")
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Close Date: ",
                                    style: GoogleFonts.inter(
                                        fontSize: 15,
                                        color: primaryColor,
                                        fontWeight: FontWeight.bold)),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width * 1,
                                  child: Text(
                                      DateFormat('dd-MMM-yyyy').format(
                                          DateTime.parse(data.closedate)),
                                      softWrap: true,
                                      maxLines: 5,
                                      overflow: TextOverflow.fade,
                                      style: GoogleFonts.inter(
                                          fontSize: 13,
                                          color: primaryColor,
                                          fontWeight: FontWeight.normal)),
                                ),
                              ],
                            ),
                          if (data.closedate == "" && data.rejectdate != "")
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Reject Date: ",
                                    style: GoogleFonts.inter(
                                        fontSize: 15,
                                        color: primaryColor,
                                        fontWeight: FontWeight.bold)),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width * 1,
                                  child: Text(
                                      DateFormat('dd-MMM-yyyy').format(
                                          DateTime.parse(data.rejectdate)),
                                      softWrap: true,
                                      maxLines: 5,
                                      overflow: TextOverflow.fade,
                                      style: GoogleFonts.inter(
                                          fontSize: 13,
                                          color: primaryColor,
                                          fontWeight: FontWeight.normal)),
                                ),
                              ],
                            ),
                        ]),
                  ),
                ),
              )
            ],
          ),
        )
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
