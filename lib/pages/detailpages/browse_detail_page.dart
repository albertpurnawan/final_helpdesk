import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:helpdesk_skripsi/model/browse_model.dart';
import 'package:helpdesk_skripsi/data/browse_issue_data.dart';
import 'package:helpdesk_skripsi/routes/routes.dart';
import 'package:helpdesk_skripsi/style.dart';
import 'package:helpdesk_skripsi/util/appbar.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

class BrowsesDetailPage extends StatefulWidget {
  const BrowsesDetailPage({super.key});

  @override
  State<BrowsesDetailPage> createState() => _BrowseDetailPageState();
}

class _BrowseDetailPageState extends State<BrowsesDetailPage> {
  String token = Get.parameters['token'].toString();
  String id = Get.parameters['id'].toString();
  late Future<List<BrowseIssueDetail>> browseDetail =
      getBrowseData.browseDetailData(context: context, token: token, id: id);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const MyAppBar(title: 'Detail Ticket', showBackBtn: true),
        backgroundColor: primaryColor,
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          scrollDirection: Axis.vertical,
          child: FutureBuilder<List<BrowseIssueDetail>>(
              future: browseDetail,
              builder: (context, snapshot) {
                if (snapshot.data == null) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: Lottie.asset("assets/lottie/loading.json"),
                      ),
                    ],
                  );
                } else {
                  var docno = "--";
                  var status = "--";
                  var createdDate = "--";
                  var req = "--";
                  var createdBy = "--";
                  var handleBY = "--";
                  var desc = '--';
                  var attachment = 'No Attachment';
                  List<dynamic> comment = [];
                  List<dynamic> att = [];
                  var notes = 'No Notes';
                  var corrective = '--';
                  var length = 1;
                  var length2 = 1;
                  if (snapshot.data![0].docno != '') {
                    docno = snapshot.data![0].docno;
                  }

                  if (snapshot.data![0].status != '') {
                    if (snapshot.data![0].status == 'O') {
                      status = 'OPEN';
                    } else if (snapshot.data![0].status == 'P') {
                      status = 'PENDING';
                    } else if (snapshot.data![0].status == 'C') {
                      status = 'CLOSE';
                    } else if (snapshot.data![0].status == 'R') {
                      status = 'REJECT';
                    }
                  }
                  if (snapshot.data![0].createdate != '') {
                    DateTime date =
                        DateTime.parse(snapshot.data![0].createdate);
                    createdDate = DateFormat('dd-MMM-yyyy').format(date);
                    print(createdDate);
                  }
                  if (snapshot.data![0].userid != '' ||
                      snapshot.data![0].username != '') {
                    req =
                        "${snapshot.data![0].userid} - ${snapshot.data![0].username}";
                  }
                  if (snapshot.data![0].createby != '') {
                    createdBy = snapshot.data![0].createby;
                  }
                  if (snapshot.data![0].assigned != '') {
                    handleBY = snapshot.data![0].assigned;
                  }
                  if (snapshot.data![0].description != '') {
                    desc = snapshot.data![0].description;
                  }
                  if (snapshot.data![0].attachments != '[]') {
                    att = jsonDecode(snapshot.data![0].attachments);
                    length2 = att.length;
                  }
                  if (snapshot.data![0].d_comment.isNotEmpty) {
                    comment = snapshot.data![0].d_comment;
                    length = comment.length;
                  }
                  if (snapshot.data![0].notes != '') {
                    notes = snapshot.data![0].notes;
                  }
                  if (snapshot.data![0].correctiveaction != '') {
                    corrective = snapshot.data![0].correctiveaction;
                  }
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10),
                      SizedBox(
                          height: 50,
                          child: GestureDetector(
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width * 0.45,
                              child: Card(
                                elevation: 10,
                                color: greyColor,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 10),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Icon(Icons.info_outline_rounded,
                                          color: primaryColor),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 10),
                                        child: Text("Show Status",
                                            style: GoogleFonts.inter(
                                                fontSize: 15,
                                                color: primaryColor,
                                                fontWeight: FontWeight.bold)),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            onTap: () {
                              Get.toNamed(
                                '${RouteClass.showstatus}/$token/$id/$docno',
                              );
                            },
                          )
                          // ElevatedButton.icon(
                          //     style: TextButton.styleFrom(
                          //       foregroundColor: primaryColor,
                          //       backgroundColor: greyColor,
                          //       shape: RoundedRectangleBorder(
                          //         borderRadius: BorderRadius.circular(10),
                          //       ),
                          //     ),
                          //     onPressed: () {
                          //       Get.toNamed(
                          //         '${RouteClass.showstatus}/$token/$id',
                          //       );
                          //     },
                          //     icon: const Icon(Icons.info_outline_rounded),
                          //     label: Text('Show Status',
                          //         style: GoogleFonts.inter(
                          //             color: primaryColor,
                          //             height: 10,
                          //             fontWeight: FontWeight.bold))),
                          ),
                      const SizedBox(height: 10),
                      //  Top card
                      Card(
                        elevation: 20,
                        color: secondaryColor,
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Ticket Number:",
                                  style: GoogleFonts.inter(
                                      fontSize: 15,
                                      color: primaryColor,
                                      fontWeight: FontWeight.bold)),
                              const SizedBox(height: 10),
                              Text(docno,
                                  style: GoogleFonts.inter(
                                    fontSize: 12,
                                    color: primaryColor,
                                  )),
                              Divider(
                                color: primaryColor,
                                height: 30,
                                thickness: 1,
                              ),
                              Text("Status:",
                                  style: GoogleFonts.inter(
                                      fontSize: 15,
                                      color: primaryColor,
                                      fontWeight: FontWeight.bold)),
                              const SizedBox(height: 10),
                              Text(status,
                                  style: GoogleFonts.inter(
                                    fontSize: 12,
                                    color: primaryColor,
                                  )),
                              Divider(
                                color: primaryColor,
                                height: 30,
                                thickness: 1,
                              ),
                              Text("Created Date:",
                                  style: GoogleFonts.inter(
                                      fontSize: 15,
                                      color: primaryColor,
                                      fontWeight: FontWeight.bold)),
                              const SizedBox(height: 10),
                              Text(createdDate,
                                  style: GoogleFonts.inter(
                                    fontSize: 12,
                                    color: primaryColor,
                                  )),
                              Divider(
                                color: primaryColor,
                                height: 30,
                                thickness: 1,
                              ),
                              Text("Request For:",
                                  style: GoogleFonts.inter(
                                      fontSize: 15,
                                      color: primaryColor,
                                      fontWeight: FontWeight.bold)),
                              const SizedBox(height: 10),
                              Text(req,
                                  style: GoogleFonts.inter(
                                    fontSize: 12,
                                    color: primaryColor,
                                  )),
                              Divider(
                                color: primaryColor,
                                height: 30,
                                thickness: 1,
                              ),
                              Text("Created By:",
                                  style: GoogleFonts.inter(
                                      fontSize: 15,
                                      color: primaryColor,
                                      fontWeight: FontWeight.bold)),
                              const SizedBox(height: 10),
                              Text(createdBy,
                                  style: GoogleFonts.inter(
                                    fontSize: 12,
                                    color: primaryColor,
                                  )),
                              Divider(
                                color: primaryColor,
                                height: 30,
                                thickness: 1,
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      // Bottom Card
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // icon dan garis
                            Column(
                              children: [
                                Icon(
                                  Icons.circle,
                                  size: 17,
                                  color: blackColor,
                                ),
                                const SizedBox(width: 10),
                                Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.7,
                                    width: 1,
                                    color: blackColor),
                              ],
                            ),
                            // card problem detail
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Problem Detail",
                                      style: GoogleFonts.inter(
                                          fontSize: 18,
                                          color: greyColor,
                                          fontWeight: FontWeight.bold)),
                                  const SizedBox(height: 10),
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.8,
                                    child: Card(
                                      elevation: 10,
                                      color: secondaryColor,
                                      child: Padding(
                                        padding: const EdgeInsets.all(20),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text("On Handled By",
                                                style: GoogleFonts.inter(
                                                    fontSize: 15,
                                                    color: primaryColor,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            const SizedBox(height: 10),
                                            Text(handleBY,
                                                style: GoogleFonts.inter(
                                                  fontSize: 12,
                                                  color: primaryColor,
                                                )),
                                            Divider(
                                              color: primaryColor,
                                              height: 30,
                                              indent: 5,
                                              endIndent: 5,
                                              thickness: 1,
                                            ),
                                            Text(
                                              "Description",
                                              style: GoogleFonts.inter(
                                                  fontSize: 15,
                                                  color: primaryColor,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            const SizedBox(height: 10),
                                            Text(
                                              desc,
                                              style: GoogleFonts.inter(
                                                fontSize: 12,
                                                color: primaryColor,
                                              ),
                                              textAlign: TextAlign.justify,
                                            ),
                                            Divider(
                                              color: primaryColor,
                                              height: 30,
                                              indent: 5,
                                              endIndent: 5,
                                              thickness: 1,
                                            ),
                                            SingleChildScrollView(
                                                child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                  Text("Attachments",
                                                      style: GoogleFonts.inter(
                                                          fontSize: 15,
                                                          color: primaryColor,
                                                          fontWeight:
                                                              FontWeight.bold)),
                                                  const SizedBox(height: 10),
                                                  ListView.separated(
                                                    shrinkWrap: true,
                                                    itemCount: length2,
                                                    separatorBuilder: (_, __) =>
                                                        const Divider(),
                                                    itemBuilder:
                                                        (context, index) {
                                                      if (att.isNotEmpty) {
                                                        return Card(
                                                          elevation: 5,
                                                          color: primaryColor,
                                                          child:
                                                              GestureDetector(
                                                            onTap: () {
                                                              showDialog(
                                                                  context:
                                                                      context,
                                                                  builder:
                                                                      (context) =>
                                                                          AlertDialog(
                                                                            title:
                                                                                Text(attachment, style: GoogleFonts.inter(fontSize: 14, color: blackColor, fontWeight: FontWeight.bold)),
                                                                            content:
                                                                                Image.network("https://portal.mayora.co.id/upload/HelpDesk/" + att[index]),
                                                                          ));
                                                            },
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(10),
                                                              child: Text(
                                                                  att[index],
                                                                  style: GoogleFonts.inter(
                                                                      fontSize:
                                                                          12,
                                                                      color:
                                                                          secondaryColor,
                                                                      decoration:
                                                                          TextDecoration
                                                                              .underline)),
                                                            ),
                                                          ),
                                                        );
                                                      } else {
                                                        return Text(
                                                            "No Attachment",
                                                            style: GoogleFonts
                                                                .inter(
                                                              fontSize: 12,
                                                              color:
                                                                  primaryColor,
                                                            ));
                                                      }
                                                    },
                                                  ),
                                                ])),
                                            Divider(
                                              color: primaryColor,
                                              height: 30,
                                              indent: 5,
                                              endIndent: 5,
                                              thickness: 1,
                                            ),
                                            SingleChildScrollView(
                                                child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                  Text("Messages/Comments",
                                                      style: GoogleFonts.inter(
                                                          fontSize: 15,
                                                          color: primaryColor,
                                                          fontWeight:
                                                              FontWeight.bold)),
                                                  const SizedBox(height: 10),
                                                  ListView.separated(
                                                    shrinkWrap: true,
                                                    itemCount: length,
                                                    separatorBuilder: (_, __) =>
                                                        const Divider(),
                                                    itemBuilder:
                                                        (context, index) {
                                                      if (comment.isNotEmpty) {
                                                        return Text(
                                                            comment[index]
                                                                .toString(),
                                                            style: GoogleFonts
                                                                .inter(
                                                              fontSize: 12,
                                                              color:
                                                                  primaryColor,
                                                            ));
                                                      } else {
                                                        return Text(
                                                            "No Messages/Comments",
                                                            style: GoogleFonts
                                                                .inter(
                                                              fontSize: 12,
                                                              color:
                                                                  primaryColor,
                                                            ));
                                                      }
                                                    },
                                                  ),
                                                ])),
                                            Divider(
                                              color: primaryColor,
                                              height: 30,
                                              indent: 5,
                                              endIndent: 5,
                                              thickness: 1,
                                            ),
                                            Text(
                                              "Helpdesk notes",
                                              style: GoogleFonts.inter(
                                                  fontSize: 15,
                                                  color: primaryColor,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            const SizedBox(height: 10),
                                            Text(
                                              notes,
                                              style: GoogleFonts.inter(
                                                fontSize: 12,
                                                color: primaryColor,
                                              ),
                                              textAlign: TextAlign.justify,
                                            ),
                                            Divider(
                                              color: primaryColor,
                                              height: 30,
                                              indent: 5,
                                              endIndent: 5,
                                              thickness: 1,
                                            ),
                                            if (status == 'CLOSED')
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "Corrective Action",
                                                    style: GoogleFonts.inter(
                                                        fontSize: 15,
                                                        color: primaryColor,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  const SizedBox(height: 10),
                                                  Text(
                                                    corrective,
                                                    style: GoogleFonts.inter(
                                                      fontSize: 12,
                                                      color: primaryColor,
                                                    ),
                                                    textAlign:
                                                        TextAlign.justify,
                                                  ),
                                                  Divider(
                                                    color: primaryColor,
                                                    height: 30,
                                                    indent: 5,
                                                    endIndent: 5,
                                                    thickness: 1,
                                                  ),
                                                ],
                                              ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 10),
                          ],
                        ),
                      ),
                      const Card()
                    ],
                  );
                }
              }), //stop
        ));
  }
}
