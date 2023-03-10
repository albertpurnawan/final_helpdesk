import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dropdown_button2/custom_dropdown_button2.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:file_saver/file_saver.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:helpdesk_skripsi/controller/controller.dart';
import 'package:helpdesk_skripsi/model/login_model.dart';
import 'package:helpdesk_skripsi/model/showstatus_model.dart';
import 'package:helpdesk_skripsi/model/ticket_pool_model.dart';
import 'package:helpdesk_skripsi/routes/routes.dart';
import 'package:helpdesk_skripsi/style.dart';
import 'package:helpdesk_skripsi/util/appbar.dart';
import 'package:helpdesk_skripsi/util/statusCode.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

class TicketPoolDetailPage extends StatefulWidget {
  const TicketPoolDetailPage({super.key});

  @override
  State<TicketPoolDetailPage> createState() => _TicketPoolDetailPageState();
}

class _TicketPoolDetailPageState extends State<TicketPoolDetailPage> {
  bool loading = true;
  bool getjob = false;
  String search = '';
  List<TicketPoolModel> data = [];
  List<ShowStatusModel> workflow = [];
  Timer? debouncer;
  String docno = Get.parameters['docno'].toString();
  String id = Get.parameters['id'].toString();
  String ua = "";
  String currentLines = "";
  final TextEditingController notesCon = TextEditingController();
  final TextEditingController taskCon = TextEditingController();
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
  var attachment = 'No Attachment';
  List<String> comment = [];
  List<String> att = [];
  List<dynamic> attpathtemp = [];
  List<File> attpath = [];
  var notes = 'No Notes';

  var length = 1;
  var length2 = 1;
  TicketPoolModel issue = TicketPoolModel(
      closeticketdate: "",
      userratedate: "",
      updatedate: "",
      createdate: "",
      scheduledate: "",
      email: "",
      createby: "",
      isquickresponsehelpdesk: "",
      subcategory2: "",
      title: "",
      subcategory1: "",
      problemidentification: "",
      docno: "",
      description: "",
      updateby: "",
      supportcategory: "",
      attachments: "",
      category: "",
      worklocationcode: "",
      correctiveaction: "",
      id: "",
      notes: "",
      assigned: "",
      userid: "",
      modulecode: "",
      system: "",
      status: "",
      supporttype: "",
      username: "",
      type: "",
      communicationby: "",
      updatectr: "",
      repairtype: "",
      application: "",
      phonenumber: "",
      t_ticket_id: "",
      rate: "",
      assignedname: "",
      createbyname: "",
      requestforworklocation: "",
      d_comment: "",
      task: "");

  List<String> comunicationBy = ['Email', 'Whatsapp'];
  List<String> supportCategory = [];
  List<String> category = [];
  String comu = "";
  String supp = "";
  String cate = "";
  bool isEnable = false;
  List<String> listpic = [];
  String system = '';
  bool checkgroupcode = false;
  String app = '';

  String pic = '';
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

  Future init() async => debounce(() async {
        print("id = $id");
        print("docno = $docno");
        final data = await controller.TicketPoolDetail(
            docno: docno, context: context, id: id);
        final workflow =
            await controller.Showstatus(docno: docno, context: context);
        final argu = ScreenArguments(user, workflow);
        final filterData = await controller.filterMaster(
            context: context, supp: supp, category: cate, sub1: "");
        final pic = await controller.pic(
            context: context, ua: 'it', groupcode: 'IT004');
        final checkgroupcode = await controller.checkgroupcode(
            context: context, username: user.username, docno: docno);
        if (data.id != "") {
          setState(() {
            this.checkgroupcode = checkgroupcode;
            this.argu = argu;
            this.workflow = workflow;
            this.data.add(data);
            listpic = pic;
            if (data.notes != 'null') {
              notesCon.text = data.notes;
            }
            issue = data;
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
            if (!mounted) return;
            ua = user.ua;
            for (int i = 0; i < workflow.length; i++) {
              if (workflow[i].currentlines == '1') {
                currentLines =
                    '${workflow[i].workflowid} - ${workflow[i].workflowlinesid}';
              }
            }
            if (supp == "") {
              supportCategory = filterData;
              isEnable = false;
            } else if (supp != "") {
              category = filterData;
              isEnable = true;
            }
            loading = false;
          });
        }
      });

  void downloadFile(att, bytes) async => debounce(() async {
        print(att);
        print(bytes);
        Uint8List data = await bytes.readAsBytes();
        print("ini att = $att");
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

  @override
  Widget build(BuildContext context) {
    User user = ModalRoute.of(context)!.settings.arguments as User;
    print(issue.docno);
    setState(() {
      this.user = user;
    });
    return Scaffold(
      appBar: const MyAppBar(title: 'Review Ticket', showBackBtn: true),
      backgroundColor: primaryColor,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        scrollDirection: Axis.vertical,
        child: loading
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
                              padding:
                                  const EdgeInsets.only(left: 10, right: 10),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Icon(Icons.info_outline_rounded,
                                      color: primaryColor),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10),
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
                          Get.toNamed(RouteClass.showstatus, arguments: argu);
                        },
                      )),
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
                          Text(issue.status,
                              style: GoogleFonts.inter(
                                fontSize: 12,
                                color: primaryColor,
                              )),
                          Divider(
                            color: primaryColor,
                            height: 30,
                            thickness: 1,
                          ),
                          Text("Requester:",
                              style: GoogleFonts.inter(
                                  fontSize: 15,
                                  color: primaryColor,
                                  fontWeight: FontWeight.bold)),
                          const SizedBox(height: 10),
                          Text('${issue.userid} - ${issue.username}',
                              style: GoogleFonts.inter(
                                fontSize: 12,
                                color: primaryColor,
                              )),
                          Divider(
                            color: primaryColor,
                            height: 30,
                            thickness: 1,
                          ),
                          Text("Requester Email:",
                              style: GoogleFonts.inter(
                                  fontSize: 15,
                                  color: primaryColor,
                                  fontWeight: FontWeight.bold)),
                          const SizedBox(height: 10),
                          Text(issue.email,
                              style: GoogleFonts.inter(
                                fontSize: 12,
                                color: primaryColor,
                              )),
                          Divider(
                            color: primaryColor,
                            height: 30,
                            thickness: 1,
                          ),
                          Text("Requester's Phone Number:",
                              style: GoogleFonts.inter(
                                  fontSize: 15,
                                  color: primaryColor,
                                  fontWeight: FontWeight.bold)),
                          const SizedBox(height: 10),
                          Text(issue.phonenumber,
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
                          Text(issue.createby,
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
                          Text(issue.createdate,
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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
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
                                              0.35,
                                      width: 1,
                                      color: blackColor),
                                ],
                              ),
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
                                                issue.description,
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
                                              const SizedBox(height: 10),
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
                                              Divider(
                                                color: primaryColor,
                                                height: 30,
                                                indent: 5,
                                                endIndent: 5,
                                                thickness: 1,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),

                              const SizedBox(height: 10),
                            ],
                          ),
                          const SizedBox(height: 20),
                          checkgroupcode
                              ? Padding(
                                  padding: const EdgeInsets.all(0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      // icon dan garis
                                      Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text("Communication By",
                                                style: GoogleFonts.inter(
                                                    fontSize: 18,
                                                    color: greyColor,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            const SizedBox(height: 10),
                                            DropdownSearch<String>(
                                              enabled: issue.communicationby ==
                                                          'null' ||
                                                      issue.communicationby ==
                                                          ''
                                                  ? true
                                                  : false,
                                              popupProps: const PopupProps.menu(
                                                showSearchBox: true,
                                                showSelectedItems: true,
                                              ),
                                              items: comunicationBy,
                                              dropdownDecoratorProps:
                                                  const DropDownDecoratorProps(
                                                dropdownSearchDecoration:
                                                    InputDecoration(
                                                  labelText:
                                                      "Select Communication By",
                                                ),
                                              ),
                                              onChanged: (value) async {
                                                setState(() {
                                                  comu = value!;
                                                });
                                              },
                                              selectedItem: issue
                                                              .communicationby ==
                                                          'null' ||
                                                      issue.communicationby ==
                                                          ''
                                                  ? comu
                                                  : issue.communicationby,
                                            ),
                                          ]),

                                      const SizedBox(height: 20),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Support Category *",
                                            style: GoogleFonts.inter(
                                                fontSize: 18,
                                                color: greyColor,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          const SizedBox(height: 10),
                                          DropdownSearch<String>(
                                            enabled: issue.supportcategory ==
                                                        'null' ||
                                                    issue.supportcategory == ''
                                                ? true
                                                : false,
                                            popupProps: const PopupProps.menu(
                                              showSearchBox: true,
                                              showSelectedItems: true,
                                            ),
                                            items: supportCategory,
                                            dropdownDecoratorProps:
                                                const DropDownDecoratorProps(
                                              dropdownSearchDecoration:
                                                  InputDecoration(
                                                labelText:
                                                    "Select Support Category",
                                              ),
                                            ),
                                            onChanged: (value) async {
                                              print(value);
                                              setState(() {
                                                cate = "";
                                                supp = value!;
                                                isEnable = true;
                                                if (value ==
                                                    "Technical Problem") {
                                                  getjob = true;
                                                }
                                              });
                                              final filterData =
                                                  await controller.filterMaster(
                                                      context: context,
                                                      supp: supp,
                                                      category: cate,
                                                      sub1: "");
                                              setState(() {
                                                category = filterData;
                                              });
                                            },
                                            selectedItem: issue
                                                            .supportcategory ==
                                                        'null' ||
                                                    issue.supportcategory == ''
                                                ? supp
                                                : issue.supportcategory,
                                          ),
                                        ],
                                      ),

                                      const SizedBox(height: 10),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Category *",
                                            style: GoogleFonts.inter(
                                                fontSize: 18,
                                                color: greyColor,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          const SizedBox(height: 10),
                                          DropdownSearch<String>(
                                            enabled: issue.category == 'null' ||
                                                    issue.category == ''
                                                ? true
                                                : false,
                                            popupProps: const PopupProps.menu(
                                              showSearchBox: true,
                                              showSelectedItems: true,
                                            ),
                                            items: category,
                                            dropdownDecoratorProps:
                                                const DropDownDecoratorProps(
                                              dropdownSearchDecoration:
                                                  InputDecoration(
                                                labelText: "Select Category",
                                              ),
                                            ),
                                            onChanged: (value) async {
                                              setState(() {
                                                cate = value!;
                                              });
                                            },
                                            selectedItem:
                                                issue.category == 'null' ||
                                                        issue.category == ''
                                                    ? cate
                                                    : issue.category,
                                          ),
                                        ],
                                      ),
                                      (issue.communicationby != '' ||
                                                  issue.communicationby ==
                                                      'null') &&
                                              (issue.supportcategory != '' ||
                                                  issue.supportcategory ==
                                                      'null') &&
                                              (issue.category != '' ||
                                                  issue.category == 'null') &&
                                              issue.status == 'Open'
                                          ? Column(
                                              children: [
                                                const SizedBox(height: 10),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "System *",
                                                      style: GoogleFonts.inter(
                                                          fontSize: 18,
                                                          color: greyColor,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    const SizedBox(height: 10),
                                                    DropdownSearch<String>(
                                                      // enabled: isEnable,
                                                      popupProps:
                                                          const PopupProps.menu(
                                                        showSearchBox: true,
                                                        showSelectedItems: true,
                                                      ),
                                                      items: const [
                                                        'Mayora Portal'
                                                      ],
                                                      dropdownDecoratorProps:
                                                          const DropDownDecoratorProps(
                                                        dropdownSearchDecoration:
                                                            InputDecoration(
                                                          labelText:
                                                              "Select System",
                                                        ),
                                                      ),
                                                      onChanged: (value) async {
                                                        setState(() {
                                                          system = value!;
                                                        });
                                                      },
                                                      selectedItem: system,
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(height: 10),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "Application *",
                                                      style: GoogleFonts.inter(
                                                          fontSize: 18,
                                                          color: greyColor,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    const SizedBox(height: 10),
                                                    DropdownSearch<String>(
                                                      // enabled: isEnable,
                                                      popupProps:
                                                          const PopupProps.menu(
                                                        showSearchBox: true,
                                                        showSelectedItems: true,
                                                      ),
                                                      items: const [
                                                        'ERP - SAP'
                                                      ],
                                                      dropdownDecoratorProps:
                                                          const DropDownDecoratorProps(
                                                        dropdownSearchDecoration:
                                                            InputDecoration(
                                                          labelText:
                                                              "Select Application",
                                                        ),
                                                      ),
                                                      onChanged: (value) async {
                                                        setState(() {
                                                          app = value!;
                                                        });
                                                      },
                                                      selectedItem: app,
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(height: 10),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "Assigned PIC *",
                                                      style: GoogleFonts.inter(
                                                          fontSize: 18,
                                                          color: greyColor,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    const SizedBox(height: 10),
                                                    DropdownSearch<String>(
                                                      // enabled: isEnable,
                                                      popupProps:
                                                          const PopupProps.menu(
                                                        showSearchBox: true,
                                                        showSelectedItems: true,
                                                      ),
                                                      items: listpic,
                                                      dropdownDecoratorProps:
                                                          const DropDownDecoratorProps(
                                                        dropdownSearchDecoration:
                                                            InputDecoration(
                                                          labelText:
                                                              "Select Assigned PIC",
                                                        ),
                                                      ),
                                                      onChanged: (value) async {
                                                        setState(() {
                                                          pic = value!;
                                                        });
                                                      },
                                                      selectedItem: cate,
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(height: 10),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "Task *",
                                                      style: GoogleFonts.inter(
                                                          fontSize: 18,
                                                          color: greyColor,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    const SizedBox(height: 10),
                                                    TextFormField(
                                                      controller: taskCon,
                                                      keyboardType:
                                                          TextInputType
                                                              .multiline,
                                                      style: GoogleFonts.inter(
                                                          color: blackColor),
                                                      decoration:
                                                          const InputDecoration(
                                                        hintText: "Enter Task",
                                                        enabledBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                                  width: 0.5),
                                                        ),
                                                        focusedBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                                  width: 0.5),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            )
                                          : const SizedBox(height: 10),

                                      const SizedBox(height: 10),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Notes *",
                                            style: GoogleFonts.inter(
                                                fontSize: 18,
                                                color: greyColor,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          const SizedBox(height: 10),
                                          TextFormField(
                                            readOnly: issue.notes == 'null' ||
                                                    issue.notes == ''
                                                ? false
                                                : true,
                                            controller: notesCon,
                                            maxLines: 8,
                                            keyboardType:
                                                TextInputType.multiline,
                                            style: GoogleFonts.inter(
                                                color: blackColor),
                                            decoration: const InputDecoration(
                                              hintText: "Enter Notes",
                                              enabledBorder: OutlineInputBorder(
                                                borderSide:
                                                    BorderSide(width: 0.5),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide:
                                                    BorderSide(width: 0.5),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),

                                      const SizedBox(height: 20),
                                      issue.communicationby != '' &&
                                              issue.supportcategory != '' &&
                                              issue.category != '' &&
                                              issue.status == 'Open'
                                          // ? Row(
                                          //     mainAxisAlignment:
                                          //         MainAxisAlignment.spaceEvenly,
                                          //     children: [
                                          //       Padding(
                                          //         padding: const EdgeInsets.only(
                                          //             right: 8.0),
                                          //         child: ElevatedButton(
                                          //             style: TextButton.styleFrom(
                                          //               backgroundColor:
                                          //                   const Color.fromARGB(
                                          //                       255, 38, 255, 0),
                                          //               shape: RoundedRectangleBorder(
                                          //                 borderRadius:
                                          //                     BorderRadius.circular(
                                          //                         10),
                                          //               ),
                                          //             ),
                                          //             onPressed: () async {
                                          //               var acc = await controller
                                          //                   .review2Ticketpool(
                                          //                       context: context,
                                          //                       system: system,
                                          //                       username:
                                          //                           user.username,
                                          //                       app: app,
                                          //                       pic: pic,
                                          //                       id: id,
                                          //                       docno: docno,
                                          //                       task: taskCon.text);
                                          //               if (acc == "true") {
                                          //                 AwesomeDialog(
                                          //                   context: context,
                                          //                   animType: AnimType.scale,
                                          //                   headerAnimationLoop: true,
                                          //                   dialogType:
                                          //                       DialogType.success,
                                          //                   title: 'Success',
                                          //                   desc:
                                          //                       'Successfully Review ticket',
                                          //                   btnOkOnPress: () {
                                          //                     Get.back();
                                          //                   },
                                          //                   btnOkIcon:
                                          //                       Icons.check_circle,
                                          //                 ).show();
                                          //               }
                                          //             },
                                          //             child: Text(
                                          //               "Process",
                                          //               style: GoogleFonts.inter(
                                          //                 color: primaryColor,
                                          //                 fontSize: 14,
                                          //               ),
                                          //             )),
                                          //       ),
                                          //       Padding(
                                          //         padding: const EdgeInsets.only(
                                          //             right: 8.0),
                                          //         child: ElevatedButton(
                                          //             style: TextButton.styleFrom(
                                          //               backgroundColor:
                                          //                   secondaryColor,
                                          //               shape: RoundedRectangleBorder(
                                          //                 borderRadius:
                                          //                     BorderRadius.circular(
                                          //                         10),
                                          //               ),
                                          //             ),
                                          //             onPressed: () async {
                                          //               var acc = await controller
                                          //                   .returnTicketpool(
                                          //                       context: context,
                                          //                       docno: docno,
                                          //                       username:
                                          //                           user.username);
                                          //               if (acc == "true") {
                                          //                 AwesomeDialog(
                                          //                   context: context,
                                          //                   animType: AnimType.scale,
                                          //                   headerAnimationLoop: true,
                                          //                   dialogType:
                                          //                       DialogType.success,
                                          //                   title: 'Success',
                                          //                   desc:
                                          //                       'Successfully Return ticket',
                                          //                   btnOkOnPress: () {
                                          //                     Get.back();
                                          //                   },
                                          //                   btnOkIcon:
                                          //                       Icons.check_circle,
                                          //                 ).show();
                                          //               }
                                          //             },
                                          //             child: Text(
                                          //               "Return",
                                          //               style: GoogleFonts.inter(
                                          //                 color: primaryColor,
                                          //                 fontSize: 14,
                                          //               ),
                                          //             )),
                                          //       ),
                                          //     ],
                                          //   )
                                          ? Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                ElevatedButton.icon(
                                                    style: TextButton.styleFrom(
                                                      foregroundColor:
                                                          primaryColor,
                                                      backgroundColor:
                                                          toscaColor,
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                      ),
                                                    ),
                                                    onPressed: () async {
                                                      var acc = await controller
                                                          .review2Ticketpool(
                                                              context: context,
                                                              system: system,
                                                              username:
                                                                  user.username,
                                                              app: app,
                                                              pic: pic,
                                                              id: id,
                                                              docno: docno,
                                                              task:
                                                                  taskCon.text);
                                                      if (acc == "true") {
                                                        AwesomeDialog(
                                                          context: context,
                                                          animType:
                                                              AnimType.scale,
                                                          headerAnimationLoop:
                                                              true,
                                                          dialogType: DialogType
                                                              .success,
                                                          title: 'Success',
                                                          desc:
                                                              'Successfully Review ticket',
                                                          btnOkOnPress: () {
                                                            Get.back();
                                                          },
                                                          btnOkIcon: Icons
                                                              .check_circle,
                                                        ).show();
                                                      }
                                                    },
                                                    icon: Icon(
                                                        Icons
                                                            .app_registration_rounded,
                                                        color: primaryColor),
                                                    label: Text('Process',
                                                        style: GoogleFonts.inter(
                                                            color: primaryColor,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold))),
                                                ElevatedButton.icon(
                                                    style: TextButton.styleFrom(
                                                      foregroundColor:
                                                          primaryColor,
                                                      backgroundColor:
                                                          orangeColor,
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                      ),
                                                    ),
                                                    onPressed: () async {
                                                      var acc = await controller
                                                          .returnTicketpool(
                                                              context: context,
                                                              docno: docno,
                                                              username: user
                                                                  .username);
                                                      if (acc == "true") {
                                                        AwesomeDialog(
                                                          context: context,
                                                          animType:
                                                              AnimType.scale,
                                                          headerAnimationLoop:
                                                              true,
                                                          dialogType: DialogType
                                                              .success,
                                                          title: 'Success',
                                                          desc:
                                                              'Successfully Return ticket',
                                                          btnOkOnPress: () {
                                                            Get.back();
                                                          },
                                                          btnOkIcon: Icons
                                                              .check_circle,
                                                        ).show();
                                                      }
                                                    },
                                                    icon: const Icon(Icons
                                                        .restart_alt_sharp),
                                                    label: Text('Return',
                                                        style: GoogleFonts.inter(
                                                            color: primaryColor,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold))),
                                                // ElevatedButton.icon(
                                                //     style: TextButton.styleFrom(
                                                //       foregroundColor: primaryColor,
                                                //       backgroundColor: secondaryColor,
                                                //       shape: RoundedRectangleBorder(
                                                //         borderRadius:
                                                //             BorderRadius.circular(10),
                                                //       ),
                                                //     ),
                                                //     onPressed: () {
                                                //       Get.toNamed(RouteClass.joblist);
                                                //     },
                                                //     icon: const Icon(
                                                //         Icons.cancel_outlined),
                                                //     label: Text('Cancel',
                                                //         style: GoogleFonts.inter(
                                                //             color: primaryColor,
                                                //             fontWeight:
                                                //                 FontWeight.bold))),
                                              ],
                                            )
                                          // : Row(
                                          //     mainAxisAlignment:
                                          //         MainAxisAlignment.spaceEvenly,
                                          //     children: [
                                          //       Padding(
                                          //         padding: const EdgeInsets.only(
                                          //             right: 8.0),
                                          //         child: ElevatedButton(
                                          //             style: TextButton.styleFrom(
                                          //               backgroundColor:
                                          //                   const Color.fromARGB(
                                          //                       255, 38, 255, 0),
                                          //               shape: RoundedRectangleBorder(
                                          //                 borderRadius:
                                          //                     BorderRadius.circular(
                                          //                         10),
                                          //               ),
                                          //             ),
                                          //             onPressed: () async {
                                          //               var acc = await controller
                                          //                   .reviewTicketpool(
                                          //                       context: context,
                                          //                       supportcategory: supp,
                                          //                       username:
                                          //                           user.username,
                                          //                       category: cate,
                                          //                       notes: notesCon.text,
                                          //                       id: id,
                                          //                       docno: docno,
                                          //                       comu: comu);
                                          //               if (acc == "true") {
                                          //                 AwesomeDialog(
                                          //                   context: context,
                                          //                   animType: AnimType.scale,
                                          //                   headerAnimationLoop: true,
                                          //                   dialogType:
                                          //                       DialogType.success,
                                          //                   title: 'Succes',
                                          //                   desc:
                                          //                       'Successfully Review ticket',
                                          //                   btnOkOnPress: () {
                                          //                     Get.back();
                                          //                   },
                                          //                   btnOkIcon:
                                          //                       Icons.check_circle,
                                          //                 ).show();
                                          //               }
                                          //             },
                                          //             child: Text(
                                          //               "Accept",
                                          //               style: GoogleFonts.inter(
                                          //                 color: primaryColor,
                                          //                 fontSize: 14,
                                          //               ),
                                          //             )),
                                          //       ),
                                          //       Padding(
                                          //         padding: const EdgeInsets.only(
                                          //             right: 8.0),
                                          //         child: ElevatedButton(
                                          //             style: TextButton.styleFrom(
                                          //               backgroundColor:
                                          //                   secondaryColor,
                                          //               shape: RoundedRectangleBorder(
                                          //                 borderRadius:
                                          //                     BorderRadius.circular(
                                          //                         10),
                                          //               ),
                                          //             ),
                                          //             onPressed: () async {
                                          //               var acc = await controller
                                          //                   .rejectTicketpool(
                                          //                       context: context,
                                          //                       docno: docno,
                                          //                       username:
                                          //                           user.username);
                                          //               if (acc == "true") {
                                          //                 AwesomeDialog(
                                          //                   context: context,
                                          //                   animType: AnimType.scale,
                                          //                   headerAnimationLoop: true,
                                          //                   dialogType:
                                          //                       DialogType.success,
                                          //                   title: 'Succes',
                                          //                   desc:
                                          //                       'Successfully Reject ticket',
                                          //                   btnOkOnPress: () {
                                          //                     Get.back();
                                          //                   },
                                          //                   btnOkIcon:
                                          //                       Icons.check_circle,
                                          //                 ).show();
                                          //               }
                                          //             },
                                          //             child: Text(
                                          //               "Reject",
                                          //               style: GoogleFonts.inter(
                                          //                 color: primaryColor,
                                          //                 fontSize: 14,
                                          //               ),
                                          //             )),
                                          //       ),
                                          //       Padding(
                                          //         padding: const EdgeInsets.only(
                                          //             right: 8.0),
                                          //         child: ElevatedButton(
                                          //             style: TextButton.styleFrom(
                                          //               backgroundColor:
                                          //                   Color(0xff0096FF),
                                          //               shape: RoundedRectangleBorder(
                                          //                 borderRadius:
                                          //                     BorderRadius.circular(
                                          //                         10),
                                          //               ),
                                          //             ),
                                          //             onPressed: getjob
                                          //                 ? () async {
                                          //                     var acc = await controller
                                          //                         .reviewTicketpool(
                                          //                             context:
                                          //                                 context,
                                          //                             supportcategory:
                                          //                                 supp,
                                          //                             username: user
                                          //                                 .username,
                                          //                             category: cate,
                                          //                             notes: notesCon
                                          //                                 .text,
                                          //                             id: id,
                                          //                             docno: docno,
                                          //                             comu: comu);
                                          //                     if (acc == "true") {
                                          //                       AwesomeDialog(
                                          //                         context: context,
                                          //                         animType:
                                          //                             AnimType.scale,
                                          //                         headerAnimationLoop:
                                          //                             true,
                                          //                         dialogType:
                                          //                             DialogType
                                          //                                 .success,
                                          //                         title: 'Succes',
                                          //                         desc:
                                          //                             'Successfully Get Job ticket',
                                          //                         btnOkOnPress: () {
                                          //                           Get.back();
                                          //                         },
                                          //                         btnOkIcon: Icons
                                          //                             .check_circle,
                                          //                       ).show();
                                          //                     }
                                          //                   }
                                          //                 : null,
                                          //             child: Text(
                                          //               "Get Job",
                                          //               style: GoogleFonts.inter(
                                          //                 color: primaryColor,
                                          //                 fontSize: 14,
                                          //               ),
                                          //             )),
                                          //       )
                                          //     ],
                                          //   )

                                          : Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                  ElevatedButton.icon(
                                                      style:
                                                          TextButton.styleFrom(
                                                        foregroundColor:
                                                            primaryColor,
                                                        backgroundColor:
                                                            toscaColor,
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                        ),
                                                      ),
                                                      onPressed: () async {
                                                        print(notesCon.text);
                                                        print(supp);
                                                        print(user.username);
                                                        print(cate);
                                                        print(id);
                                                        print(docno);
                                                        print(comu);

                                                        var acc = await controller
                                                            .reviewTicketpool(
                                                                context:
                                                                    context,
                                                                supportcategory:
                                                                    supp,
                                                                username: user
                                                                    .username,
                                                                category: cate,
                                                                notes: notesCon
                                                                    .text,
                                                                id: id,
                                                                docno: docno,
                                                                comu: comu);
                                                        if (acc == "true") {
                                                          AwesomeDialog(
                                                            context: context,
                                                            animType:
                                                                AnimType.scale,
                                                            headerAnimationLoop:
                                                                true,
                                                            dialogType:
                                                                DialogType
                                                                    .success,
                                                            title: 'Succes',
                                                            desc:
                                                                'Successfully Review ticket',
                                                            btnOkOnPress: () {
                                                              Get.back();
                                                            },
                                                            btnOkIcon: Icons
                                                                .check_circle,
                                                          ).show();
                                                        }
                                                      },
                                                      icon: Icon(
                                                          Icons
                                                              .app_registration_rounded,
                                                          color: primaryColor),
                                                      label: Text('Assign',
                                                          style: GoogleFonts.inter(
                                                              color:
                                                                  primaryColor,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold))),
                                                  ElevatedButton.icon(
                                                      style:
                                                          TextButton.styleFrom(
                                                        foregroundColor:
                                                            primaryColor,
                                                        backgroundColor:
                                                            secondaryColor,
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                        ),
                                                      ),
                                                      onPressed: () async {
                                                        var acc = await controller
                                                            .rejectTicketpool(
                                                                context:
                                                                    context,
                                                                docno: docno,
                                                                username: user
                                                                    .username);
                                                        if (acc == "true") {
                                                          AwesomeDialog(
                                                            context: context,
                                                            animType:
                                                                AnimType.scale,
                                                            headerAnimationLoop:
                                                                true,
                                                            dialogType:
                                                                DialogType
                                                                    .success,
                                                            title: 'Succes',
                                                            desc:
                                                                'Successfully Reject ticket',
                                                            btnOkOnPress: () {
                                                              Get.back();
                                                            },
                                                            btnOkIcon: Icons
                                                                .check_circle,
                                                          ).show();
                                                        }
                                                      },
                                                      icon: const Icon(Icons
                                                          .cancel_outlined),
                                                      label: Text('Reject',
                                                          style: GoogleFonts.inter(
                                                              color:
                                                                  primaryColor,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold))),
                                                  ElevatedButton.icon(
                                                      style:
                                                          TextButton.styleFrom(
                                                        foregroundColor:
                                                            primaryColor,
                                                        backgroundColor:
                                                            Colors.blueGrey,
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                        ),
                                                      ),
                                                      onPressed: getjob
                                                          ? () async {
                                                              var acc = await controller.reviewTicketpool(
                                                                  context:
                                                                      context,
                                                                  supportcategory:
                                                                      supp,
                                                                  username: user
                                                                      .username,
                                                                  category:
                                                                      cate,
                                                                  notes:
                                                                      notesCon
                                                                          .text,
                                                                  id: id,
                                                                  docno: docno,
                                                                  comu: comu);
                                                              if (acc ==
                                                                  "true") {
                                                                AwesomeDialog(
                                                                  context:
                                                                      context,
                                                                  animType:
                                                                      AnimType
                                                                          .scale,
                                                                  headerAnimationLoop:
                                                                      true,
                                                                  dialogType:
                                                                      DialogType
                                                                          .success,
                                                                  title:
                                                                      'Succes',
                                                                  desc:
                                                                      'Successfully Get Job ticket',
                                                                  btnOkOnPress:
                                                                      () {
                                                                    Get.back();
                                                                  },
                                                                  btnOkIcon: Icons
                                                                      .check_circle,
                                                                ).show();
                                                              }
                                                            }
                                                          : null,
                                                      icon: const Icon(
                                                          Icons.work),
                                                      label: Text('Get Job',
                                                          style: GoogleFonts.inter(
                                                              color:
                                                                  primaryColor,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold)))
                                                ]),
                                    ],
                                  ),
                                )
                              : const SizedBox(
                                  height: 10,
                                )
                        ],
                      )),
                  const Card()
                ],
              ),
      ),
    );
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
