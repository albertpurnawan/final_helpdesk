import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:file_saver/file_saver.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:helpdesk_skripsi/controller/controller.dart';
import 'package:helpdesk_skripsi/model/browse_model.dart';
import 'package:helpdesk_skripsi/model/login_model.dart';
import 'package:helpdesk_skripsi/model/showstatus_model.dart';
import 'package:helpdesk_skripsi/routes/routes.dart';
import 'package:helpdesk_skripsi/style.dart';
import 'package:helpdesk_skripsi/util/appbar.dart';

import 'package:lottie/lottie.dart';

import '../../util/statusCode.dart';

class BrowsesDetailPage extends StatefulWidget {
  const BrowsesDetailPage({super.key});

  @override
  State<BrowsesDetailPage> createState() => _BrowseDetailPageState();
}

class _BrowseDetailPageState extends State<BrowsesDetailPage> {
  bool loading = true;
  String search = '';
  List<BrowseIssueDetail> data = [];
  List<ShowStatusModel> workflow = [];
  Timer? debouncer;
  String docno = Get.parameters['docno'].toString();
  String id = Get.parameters['id'].toString();
  User user = User(
      username: "",
      password: "",
      ua: "",
      email: "",
      image: "",
      name: "",
      groupcode: "",
      empid: "",
      groupname: "");
  ScreenArguments argu = ScreenArguments(
      User(
          username: "",
          password: "",
          ua: "",
          email: "",
          image: "",
          name: "",
          groupcode: "",
          empid: "",
          groupname: ""),
      []);
  var status = "--";
  var createdDate = "--";
  var req = "--";
  var createdBy = "--";
  var handleBY = "--";
  var desc = '--';
  var attachment = 'No Attachment';
  List<dynamic> att = [];
  List<dynamic> attpathtemp = [];
  List<File> attpath = [];
  var notes = 'No Notes';
  var corrective = '--';
  var length = 1;
  var length2 = 1;
  @override
  void initState() {
    super.initState();
    loading = true;

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

  void downloadFile(att, bytes) async => debounce(() async {
        Uint8List data = await bytes.readAsBytes();
        List<String> splitString = att
            .toString()
            .replaceAll("File: ", "")
            .replaceAll("'", "")
            .split(".");
        print("ini length ${splitString[splitString.length - 1]}");
        MimeType type = MimeType.OTHER;
        if (splitString.length > 1) {
          String typeFile = splitString[splitString.length - 1];
          if (typeFile.toLowerCase() == "pdf") {
            type = MimeType.PDF;
          } else if (typeFile.toLowerCase() == "xls" ||
              typeFile.toLowerCase() == "xlsx") {
            type = MimeType.MICROSOFTEXCEL;
          } else if (typeFile.toLowerCase() == "docx" ||
              typeFile.toLowerCase() == "doc") {
            type = MimeType.MICROSOFTWORD;
          } else if (typeFile.toLowerCase() == "jpeg" ||
              typeFile.toLowerCase() == "jpg") {
            type = MimeType.JPEG;
          } else if (typeFile.toLowerCase() == "png") {
            type = MimeType.PNG;
          } else if (typeFile.toLowerCase() == "gif") {
            type = MimeType.GIF;
          } else if (typeFile.toLowerCase() == "ppt" ||
              typeFile.toLowerCase() == "pptx") {
            type = MimeType.MICROSOFTPRESENTATION;
          } else if (typeFile.toLowerCase() == "txt") {
            type = MimeType.TEXT;
          }
          String path = await FileSaver.instance.saveAs(
              att.toString().replaceAll("File: ", "").replaceAll("'", ""),
              data,
              "",
              type);
          print(" ini contoh path = $path");
        } else {
          showSnackBar(context, "Failed", "Failed to download file");
        }
      });

  Future init() async => debounce(() async {
        print("id = $id");
        print("docno = $docno");
        final data = await controller.BrowseDetail(
            docno: docno, context: context, id: id);
        final workflow =
            await controller.Showstatus(docno: docno, context: context);
        final argu = ScreenArguments(user, workflow);
        if (data.id != "") {
          setState(() {
            this.argu = argu;
            this.workflow = workflow;
            this.data.add(data);
            if (data.status != '') {
              status = data.status;
            }
            if (data.createdate != '') {
              createdDate = data.createdate;
            }
            if (data.userid != '' || data.username != '') {
              req = "${data.userid} - ${data.username}";
            }
            if (data.createby != '') {
              createdBy = data.createby;
            }
            if (data.assigned != '') {
              handleBY = data.assigned;
            }
            if (data.description != '') {
              desc = data.description;
            }
            if (data.attachments != '[]') {
              attpathtemp = data.attachments
                  .replaceAll('[', '')
                  .replaceAll(']', '')
                  .trim()
                  .split(',');
              for (int i = 0; i < attpathtemp.length; i++) {
                attpath.add(File(attpathtemp[i]));
                att.add(attpathtemp[i].toString().split(
                    '/')[attpathtemp[i].toString().split('/').length - 1]);
              }
              length2 = att.length;
              print(length2);
            }
            // if (data.d_comment != '[]') {
            //   comment = jsonDecode(data.d_comment);
            //   length = comment.length;
            //   print(length);
            // }
            if (data.notes != '') {
              notes = data.notes;
            }
            if (data.correctiveaction != '') {
              corrective = data.correctiveaction;
            }
            if (!mounted) return;

            loading = false;
          });
        }
      });

  @override
  Widget build(BuildContext context) {
    User user = ModalRoute.of(context)!.settings.arguments as User;
    setState(() {
      this.user = user;
    });
    return Scaffold(
        appBar: const MyAppBar(title: 'Detail Ticket', showBackBtn: true),
        backgroundColor: primaryColor,
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              loading
                  ? loadingImage()
                  : Column(
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
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
                                Get.toNamed(RouteClass.showstatus,
                                    arguments: argu);
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
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.4,
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
                                      width: MediaQuery.of(context).size.width *
                                          0.8,
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
                                                    fontWeight:
                                                        FontWeight.bold),
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
                                                                FontWeight
                                                                    .bold)),
                                                    const SizedBox(height: 10),
                                                    ListView.separated(
                                                      shrinkWrap: true,
                                                      itemCount: length2,
                                                      separatorBuilder:
                                                          (_, __) =>
                                                              const Divider(),
                                                      itemBuilder:
                                                          (context, index) {
                                                        if (att.isNotEmpty &&
                                                            data[0].attachments !=
                                                                '[]') {
                                                          return Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Card(
                                                                elevation: 5,
                                                                color:
                                                                    primaryColor,
                                                                child: SizedBox(
                                                                  width: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width *
                                                                      1,
                                                                  child:
                                                                      GestureDetector(
                                                                    onTap: () {
                                                                      downloadFile(
                                                                          att[
                                                                              index],
                                                                          attpath[
                                                                              index]);
                                                                    },
                                                                    child:
                                                                        Padding(
                                                                      padding:
                                                                          const EdgeInsets.all(
                                                                              10),
                                                                      child: Text(
                                                                          att[
                                                                              index],
                                                                          style: GoogleFonts.inter(
                                                                              fontSize: 12,
                                                                              color: secondaryColor,
                                                                              decoration: TextDecoration.underline)),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
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
                                              // Divider(
                                              //   color: primaryColor,
                                              //   height: 30,
                                              //   indent: 5,
                                              //   endIndent: 5,
                                              //   thickness: 1,
                                              // ),
                                              // SingleChildScrollView(
                                              //     child: Column(
                                              //         crossAxisAlignment:
                                              //             CrossAxisAlignment.start,
                                              //         children: [
                                              //       Text("Messages/Comments",
                                              //           style: GoogleFonts.inter(
                                              //               fontSize: 15,
                                              //               color: primaryColor,
                                              //               fontWeight:
                                              //                   FontWeight.bold)),
                                              //       const SizedBox(height: 10),
                                              //       ListView.separated(
                                              //         shrinkWrap: true,
                                              //         itemCount: length,
                                              //         separatorBuilder: (_, __) =>
                                              //             const Divider(),
                                              //         itemBuilder:
                                              //             (context, index) {
                                              //           if (comment.isNotEmpty) {
                                              //             return Text(
                                              //                 comment[index]
                                              //                     .toString(),
                                              //                 style:
                                              //                     GoogleFonts.inter(
                                              //                   fontSize: 12,
                                              //                   color: primaryColor,
                                              //                 ));
                                              //           } else {
                                              //             return Text(
                                              //                 "No Messages/Comments",
                                              //                 style:
                                              //                     GoogleFonts.inter(
                                              //                   fontSize: 12,
                                              //                   color: primaryColor,
                                              //                 ));
                                              //           }
                                              //         },
                                              //       ),
                                              //     ])),
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
                                                    fontWeight:
                                                        FontWeight.bold),
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
                    ),
            ],
          ), //stop
        ));
  }

  Widget loadingImage() {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.7,
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
