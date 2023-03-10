import 'dart:async';
import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:helpdesk_skripsi/controller/controller.dart';
import 'package:helpdesk_skripsi/model/browse_model.dart';
import 'package:helpdesk_skripsi/model/login_model.dart';
import 'package:helpdesk_skripsi/routes/routes.dart';
import 'package:helpdesk_skripsi/style.dart';
import 'package:helpdesk_skripsi/util/appbar.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class ReviewJoblist extends StatefulWidget {
  const ReviewJoblist({super.key});

  @override
  State<ReviewJoblist> createState() => _ReviewJoblistState();
}

class _ReviewJoblistState extends State<ReviewJoblist> {
  ScreenArguments2 data = ScreenArguments2(
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
      BrowseIssueDetail(
          docno: "",
          description: "",
          username: "",
          createby: "",
          status: "",
          supportcategory: "",
          id: "",
          isquickresponsehelpdesk: "",
          createdate: "",
          wl: "",
          closeticketdate: "",
          userratedate: "",
          updatedate: "",
          scheduledate: "",
          email: "",
          subcategory2: "",
          title: "",
          subcategory1: "",
          problemidentification: "",
          updateby: "",
          category: "",
          attachments: "",
          worklocationcode: "",
          correctiveaction: "",
          notes: "",
          assigned: "",
          userid: "",
          modulecode: "",
          systemcode: "",
          supporttype: "",
          type: "",
          communicationby: "",
          updatectr: "",
          repairtype: "",
          applicationcode: "",
          phonenumber: "",
          pic_ticket_docno: "",
          d_comment: "",
          task: ""));

  List<BrowseIssueDetail> reloadData = [];
  String ticketNum = "";
  String repairType = '';
  String supportType = '';
  List<dynamic> att = [];
  List<dynamic> attpathtemp = [];
  List<File> attpath = [];
  var length2 = 1;
  final TextEditingController problemidentification = TextEditingController();
  final TextEditingController correctiveaction = TextEditingController();
  Timer? debouncer;
  bool loading = true;
  String category = "";
  String sub1 = "";
  String supp = "";
  List<String> listsub1 = [];
  List<String> listsub2 = [];
  String SelectedValue = "";
  bool enablesub2 = false;
  String repair = "";
  String support = "";
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
        final filterData = await controller.filterMaster(
            context: context, supp: supp, category: category, sub1: sub1);
        print(supp);
        print(category);
        print(sub1);
        if (!mounted) return;
        setState(() {
          for (int i = 0; i < filterData.length; i++) {
            listsub1.add(filterData[i]);
          }
          loading = false;
        });
      });

  @override
  Widget build(BuildContext context) {
    ScreenArguments2 data =
        ModalRoute.of(context)!.settings.arguments as ScreenArguments2;
    setState(() {
      att = [];
      this.data = data;
      ticketNum = data.browse.docno.toString();
      if (data.browse.attachments != '[]') {
        attpathtemp = data.browse.attachments
            .replaceAll('[', '')
            .replaceAll(']', '')
            .trim()
            .split(',');
        for (int i = 0; i < attpathtemp.length; i++) {
          attpath.add(File(attpathtemp[i]));
          att.add(attpathtemp[i]
              .toString()
              .split('/')[attpathtemp[i].toString().split('/').length - 1]);
        }
        supp = data.browse.supportcategory;
        category = data.browse.category;
        length2 = att.length;
        print(length2);
      }
    });
    return Scaffold(
      appBar: const MyAppBar(title: 'Review Ticket', showBackBtn: true),
      backgroundColor: primaryColor,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      Icon(
                        Icons.circle,
                        size: 17,
                        color: greyColor,
                      ),
                      SizedBox(width: MediaQuery.of(context).size.width * 0.07),
                      Container(
                          height: MediaQuery.of(context).size.height * 0.6,
                          width: 1,
                          color: greyColor),
                    ],
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.020),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("User Detail",
                          style: GoogleFonts.inter(
                              fontSize: 17,
                              color: greyColor,
                              fontWeight: FontWeight.bold)),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.020),
                      SizedBox(
                          width: MediaQuery.of(context).size.width * 0.8,
                          child: Card(
                            elevation: 10,
                            color: secondaryColor,
                            child: Padding(
                              padding: const EdgeInsets.all(20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Request For",
                                      style: GoogleFonts.inter(
                                          fontSize: 15,
                                          color: primaryColor,
                                          fontWeight: FontWeight.bold)),
                                  SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.020),
                                  Text(data.browse.username,
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
                                  Text("NIK",
                                      style: GoogleFonts.inter(
                                          fontSize: 15,
                                          color: primaryColor,
                                          fontWeight: FontWeight.bold)),
                                  SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.020),
                                  Text(data.browse.userid,
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
                                  Text("Department",
                                      style: GoogleFonts.inter(
                                          fontSize: 15,
                                          color: primaryColor,
                                          fontWeight: FontWeight.bold)),
                                  SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.020),
                                  Text('IT',
                                      style: GoogleFonts.inter(
                                        fontSize: 12,
                                        color: primaryColor,
                                      )),
                                  Divider(
                                    color: primaryColor,
                                    height: 30,
                                    thickness: 1,
                                  ),
                                  Text("Location",
                                      style: GoogleFonts.inter(
                                          fontSize: 15,
                                          color: primaryColor,
                                          fontWeight: FontWeight.bold)),
                                  SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.020),
                                  Text('[WL99] CNS - Region Sumatera',
                                      style: GoogleFonts.inter(
                                        fontSize: 12,
                                        color: primaryColor,
                                      )),
                                  Divider(
                                    color: primaryColor,
                                    height: 30,
                                    thickness: 1,
                                  ),
                                  Text("Phone Number/Ext",
                                      style: GoogleFonts.inter(
                                          fontSize: 15,
                                          color: primaryColor,
                                          fontWeight: FontWeight.bold)),
                                  SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.020),
                                  Text(data.browse.phonenumber,
                                      style: GoogleFonts.inter(
                                        fontSize: 12,
                                        color: primaryColor,
                                      )),
                                  Divider(
                                    color: primaryColor,
                                    height: 30,
                                    thickness: 1,
                                  ),
                                  Text("Contact Email",
                                      style: GoogleFonts.inter(
                                          fontSize: 15,
                                          color: primaryColor,
                                          fontWeight: FontWeight.bold)),
                                  SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.020),
                                  Text(data.browse.email,
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
                          ))
                    ],
                  )
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      Icon(
                        Icons.circle,
                        size: 17,
                        color: greyColor,
                      ),
                      SizedBox(width: MediaQuery.of(context).size.width * 0.07),
                      Container(
                          height: MediaQuery.of(context).size.height * 0.55,
                          width: 1,
                          color: greyColor),
                    ],
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.020),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Problem Detail",
                          style: GoogleFonts.inter(
                              fontSize: 17,
                              color: greyColor,
                              fontWeight: FontWeight.bold)),
                      const SizedBox(height: 10),
                      SizedBox(
                          width: MediaQuery.of(context).size.width * 0.8,
                          child: Card(
                            elevation: 10,
                            color: secondaryColor,
                            child: Padding(
                              padding: const EdgeInsets.all(20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Ticket Number",
                                      style: GoogleFonts.inter(
                                          fontSize: 15,
                                          color: primaryColor,
                                          fontWeight: FontWeight.bold)),
                                  SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.020),
                                  Text(ticketNum,
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
                                  Text("Created Date",
                                      style: GoogleFonts.inter(
                                          fontSize: 15,
                                          color: primaryColor,
                                          fontWeight: FontWeight.bold)),
                                  SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.020),
                                  Text(data.browse.createdate,
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
                                  Text("Description",
                                      style: GoogleFonts.inter(
                                          fontSize: 15,
                                          color: primaryColor,
                                          fontWeight: FontWeight.bold)),
                                  SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.020),
                                  Text(data.browse.description,
                                      style: GoogleFonts.inter(
                                        fontSize: 12,
                                        color: primaryColor,
                                      )),
                                  Divider(
                                    color: primaryColor,
                                    height: 30,
                                    thickness: 1,
                                  ),
                                  Text("Parent Category",
                                      style: GoogleFonts.inter(
                                          fontSize: 15,
                                          color: primaryColor,
                                          fontWeight: FontWeight.bold)),
                                  SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.020),
                                  Text(data.browse.supportcategory,
                                      style: GoogleFonts.inter(
                                        fontSize: 12,
                                        color: primaryColor,
                                      )),
                                  Divider(
                                    color: primaryColor,
                                    height: 30,
                                    thickness: 1,
                                  ),
                                  Text("Category",
                                      style: GoogleFonts.inter(
                                          fontSize: 15,
                                          color: primaryColor,
                                          fontWeight: FontWeight.bold)),
                                  SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.020),
                                  Text(data.browse.category,
                                      style: GoogleFonts.inter(
                                        fontSize: 12,
                                        color: primaryColor,
                                      )),
                                  Divider(
                                    color: primaryColor,
                                    height: 30,
                                    thickness: 1,
                                  ),
                                  SingleChildScrollView(
                                      child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                        Text("Attachments",
                                            style: GoogleFonts.inter(
                                                fontSize: 15,
                                                color: primaryColor,
                                                fontWeight: FontWeight.bold)),
                                        const SizedBox(height: 10),
                                        ListView.separated(
                                          shrinkWrap: true,
                                          itemCount: length2,
                                          separatorBuilder: (_, __) =>
                                              const Divider(),
                                          itemBuilder: (context, index) {
                                            if (att.isNotEmpty &&
                                                data.browse.attachments !=
                                                    '[]') {
                                              return Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Card(
                                                    elevation: 5,
                                                    color: primaryColor,
                                                    child: SizedBox(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              1,
                                                      child: GestureDetector(
                                                        onTap: () {
                                                          // downloadFile(
                                                          //     att[index],
                                                          //     attpath[index]);
                                                        },
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(10),
                                                          child: Text(
                                                              att[index],
                                                              style: GoogleFonts.inter(
                                                                  fontSize: 12,
                                                                  color:
                                                                      secondaryColor,
                                                                  decoration:
                                                                      TextDecoration
                                                                          .underline)),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              );
                                            } else {
                                              return Text("No Attachment",
                                                  style: GoogleFonts.inter(
                                                    fontSize: 12,
                                                    color: primaryColor,
                                                  ));
                                            }
                                          },
                                        ),
                                      ])),
                                  // for (int i = 0; i < 2; i++)
                                  //   Card(
                                  //     elevation: 5,
                                  //     color: primaryColor,
                                  //     child: GestureDetector(
                                  //       onTap: () {
                                  //         showDialog(
                                  //             context: context,
                                  //             builder: (context) => AlertDialog(
                                  //                   title: Text(
                                  //                       data.browse
                                  //                           .attachments,
                                  //                       style:
                                  //                           GoogleFonts.inter(
                                  //                               fontSize: 14,
                                  //                               color:
                                  //                                   blackColor,
                                  //                               fontWeight:
                                  //                                   FontWeight
                                  //                                       .bold)),
                                  //                   content: Image.asset(
                                  //                       "assets/images/iuProfile.jpg"),
                                  //                 ));
                                  //       },
                                  //       child: Padding(
                                  //         padding: const EdgeInsets.all(10),
                                  //         child: Text(
                                  //             data.browse.attachments,
                                  //             style: GoogleFonts.inter(
                                  //                 fontSize: 12,
                                  //                 color: secondaryColor,
                                  //                 decoration: TextDecoration
                                  //                     .underline)),
                                  //       ),
                                  //     ),
                                  //   ),
                                ],
                              ),
                            ),
                          )),
                    ],
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      Icon(
                        Icons.circle,
                        size: 17,
                        color: greyColor,
                      ),
                      SizedBox(width: MediaQuery.of(context).size.width * 0.07),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Support Detail",
                          style: GoogleFonts.inter(
                              fontSize: 17,
                              color: greyColor,
                              fontWeight: FontWeight.bold)),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.020),
                      SizedBox(
                          width: MediaQuery.of(context).size.width * 0.8,
                          child: Card(
                            elevation: 10,
                            color: secondaryColor,
                            child: Padding(
                              padding: const EdgeInsets.all(20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Task Kanban",
                                      style: GoogleFonts.inter(
                                          fontSize: 15,
                                          color: primaryColor,
                                          fontWeight: FontWeight.bold)),
                                  SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.020),
                                  Text(data.browse.task,
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
                                  Text("System",
                                      style: GoogleFonts.inter(
                                          fontSize: 15,
                                          color: primaryColor,
                                          fontWeight: FontWeight.bold)),
                                  SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.020),
                                  Text(data.browse.systemcode,
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
                                  Text("Application",
                                      style: GoogleFonts.inter(
                                          fontSize: 15,
                                          color: primaryColor,
                                          fontWeight: FontWeight.bold)),
                                  SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.020),
                                  Text(data.browse.applicationcode,
                                      style: GoogleFonts.inter(
                                        fontSize: 12,
                                        color: primaryColor,
                                      )),
                                  SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.020),
                                  Divider(
                                    color: primaryColor,
                                    height: 0,
                                    thickness: 1,
                                  ),
                                  // SizedBox(
                                  //     height:
                                  //         MediaQuery.of(context).size.height *
                                  //             0.010),
                                  DropdownSearch<String>(
                                    enabled: true,
                                    popupProps: const PopupProps.menu(
                                      showSearchBox: true,
                                      showSelectedItems: true,
                                    ),
                                    items: listsub1,
                                    dropdownDecoratorProps:
                                        const DropDownDecoratorProps(
                                      baseStyle: TextStyle(
                                          color: Colors.white,
                                          // fontStyle: Padding(padding: top,) Padding(padding: ),
                                          fontSize: 12),
                                      dropdownSearchDecoration: InputDecoration(
                                        labelStyle: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                        border: InputBorder.none,
                                        labelText: "Sub Category 1",
                                      ),
                                    ),
                                    onChanged: (value) async {
                                      setState(() {
                                        sub1 = value!;
                                        SelectedValue = value;
                                      });
                                      final filterData =
                                          await controller.filterMaster(
                                              context: context,
                                              supp: supp,
                                              category: category,
                                              sub1: sub1);
                                      print(supp);
                                      print(category);
                                      print(sub1);
                                      if (!mounted) return;
                                      setState(() {
                                        for (int i = 0;
                                            i < filterData.length;
                                            i++) {
                                          listsub2.add(filterData[i]);
                                        }
                                        loading = false;
                                        enablesub2 = true;
                                      });
                                    },
                                    selectedItem: SelectedValue,
                                  ),
                                  SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.005),
                                  Divider(
                                    color: primaryColor,
                                    height: 0,
                                    thickness: 1,
                                  ),
                                  DropdownSearch<String>(
                                    enabled: enablesub2,
                                    popupProps: const PopupProps.menu(
                                      showSearchBox: true,
                                      showSelectedItems: true,
                                    ),
                                    items: listsub1,
                                    dropdownDecoratorProps:
                                        const DropDownDecoratorProps(
                                      baseStyle: TextStyle(
                                          color: Colors.white,
                                          // fontStyle: Padding(padding: top,) Padding(padding: ),
                                          fontSize: 12),
                                      dropdownSearchDecoration: InputDecoration(
                                        labelStyle: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                        border: InputBorder.none,
                                        labelText: "Sub Category 2",
                                      ),
                                    ),
                                    onChanged: (value) async {
                                      final emailCurr =
                                          await controller.getEmail(
                                              context: context,
                                              username: value!.split(" - ")[0]);
                                      setState(() {
                                        print(value);
                                        // req.text = value;
                                        // selectedValue = value;
                                        // email.text = emailCurr;
                                      });
                                    },
                                    selectedItem: SelectedValue,
                                  ),
                                  // Text("Sub Category 1",
                                  //     style: GoogleFonts.inter(
                                  //         fontSize: 15,
                                  //         color: primaryColor,
                                  //         fontWeight: FontWeight.bold)),
                                  // SizedBox(
                                  //     height:
                                  //         MediaQuery.of(context).size.height *
                                  //             0.020),
                                  Divider(
                                    color: primaryColor,
                                    // height: 30,
                                    thickness: 1,
                                  ),
                                  Text("Repair Type",
                                      style: GoogleFonts.inter(
                                          fontSize: 15,
                                          color: primaryColor,
                                          fontWeight: FontWeight.bold)),
                                  SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.020),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      RadioListTile(
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                horizontal: 0),
                                        title: Text("Internal",
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: primaryColor)),
                                        value: "Internal",
                                        groupValue: repair,
                                        onChanged: (value) {
                                          setState(() {
                                            repair = value.toString();
                                          });
                                        },
                                      ),
                                      RadioListTile(
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                horizontal: 0),
                                        title: Text("External",
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: primaryColor)),
                                        value: "External",
                                        groupValue: repair,
                                        onChanged: (value) {
                                          setState(() {
                                            repair = value.toString();
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                                  Divider(
                                    color: primaryColor,
                                    height: 30,
                                    thickness: 1,
                                  ),
                                  Text("Support Type",
                                      style: GoogleFonts.inter(
                                          fontSize: 15,
                                          color: primaryColor,
                                          fontWeight: FontWeight.bold)),
                                  SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.020),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      RadioListTile(
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                horizontal: 0),
                                        title: Text("Remote",
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: primaryColor)),
                                        value: "Remote",
                                        groupValue: support,
                                        onChanged: (value) {
                                          setState(() {
                                            support = value.toString();
                                          });
                                        },
                                      ),
                                      RadioListTile(
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                horizontal: 0),
                                        title: Text("Onsite",
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: primaryColor)),
                                        value: "Onsite",
                                        groupValue: support,
                                        onChanged: (value) {
                                          setState(() {
                                            support = value.toString();
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                                  Divider(
                                    color: primaryColor,
                                    height: 30,
                                    thickness: 1,
                                  ),
                                  Text("Problem Identification",
                                      style: GoogleFonts.inter(
                                          fontSize: 15,
                                          color: primaryColor,
                                          fontWeight: FontWeight.bold)),
                                  SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.020),
                                  TextField(
                                      controller: problemidentification,
                                      maxLines: 2,
                                      style: TextStyle(color: primaryColor),
                                      decoration: InputDecoration(
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: BorderSide(
                                            color: primaryColor,
                                            width: 1.0,
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: BorderSide(
                                            color: primaryColor,
                                            width: 1.0,
                                          ),
                                        ),
                                        hintText: "Type your text",
                                        hintStyle: GoogleFonts.inter(
                                          color: primaryColor,
                                          fontSize: 12,
                                        ),
                                      )),
                                  SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.025),
                                  Text("Corrective Action",
                                      style: GoogleFonts.inter(
                                          fontSize: 15,
                                          color: primaryColor,
                                          fontWeight: FontWeight.bold)),
                                  SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.020),
                                  TextField(
                                      controller: correctiveaction,
                                      maxLines: 2,
                                      style: TextStyle(color: primaryColor),
                                      decoration: InputDecoration(
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: BorderSide(
                                            color: primaryColor,
                                            width: 1.0,
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: BorderSide(
                                            color: primaryColor,
                                            width: 1.0,
                                          ),
                                        ),
                                        hintText: "Type your text",
                                        hintStyle: GoogleFonts.inter(
                                          color: primaryColor,
                                          fontSize: 12,
                                        ),
                                      ))
                                ],
                              ),
                            ),
                          )),
                    ],
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Icon(
                      Icons.info_outline,
                      color: greyColor,
                      size: 24,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.7,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text.rich(
                            textAlign: TextAlign.justify,
                            TextSpan(
                              text:
                                  "You must done the task in your kanban before closing the ticket. ",
                              style: GoogleFonts.inter(
                                fontSize: 14,
                                color: greyColor,
                              ),
                              children: [
                                TextSpan(
                                  text: "Go to your Kanban",
                                  style: GoogleFonts.inter(
                                    fontSize: 15,
                                    color: greyColor,
                                    fontWeight: FontWeight.bold,
                                    decoration: TextDecoration.underline,
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      launchUrl(
                                        Uri.parse(
                                            'https://portal.mayora.co.id/Portal/Dashboard/IT/Kanban'),
                                      );
                                    },
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton.icon(
                      style: TextButton.styleFrom(
                        foregroundColor: primaryColor,
                        backgroundColor: toscaColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () async {
                        final result = await controller.review3Ticketpool(
                            context: context,
                            username: data.user.username,
                            correctiveaction: correctiveaction.text,
                            id: data.browse.id,
                            docno: data.browse.docno,
                            problemidentification: problemidentification.text,
                            repair: repair,
                            support: support);
                        if (result == "true") {
                          AwesomeDialog(
                            context: context,
                            animType: AnimType.scale,
                            headerAnimationLoop: true,
                            dialogType: DialogType.success,
                            title: 'Success',
                            desc: 'Successfully Review ticket',
                            btnOkOnPress: () async {
                              // data.browse.remove(data.browse);
                              final reloadData = await controller.joblist(
                                  context: context,
                                  username: data.user.username,
                                  type: 'progress');
                              setState(() {
                                this.reloadData = reloadData;
                                // data.browse.add(reloadData[0]);
                              });
                              Get.back();
                            },
                            btnOkIcon: Icons.check_circle,
                          ).show();
                        }
                      },
                      icon: Icon(Icons.app_registration_rounded,
                          color: primaryColor),
                      label: Text('Close Ticket',
                          style: GoogleFonts.inter(
                              color: primaryColor,
                              fontWeight: FontWeight.bold))),
                  ElevatedButton.icon(
                      style: TextButton.styleFrom(
                        foregroundColor: primaryColor,
                        backgroundColor: orangeColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () async {
                        final result = await controller.returnTicketpool(
                          context: context,
                          username: data.user.username,
                          docno: data.browse.docno,
                        );
                        if (result == "true") {
                          AwesomeDialog(
                            context: context,
                            animType: AnimType.scale,
                            headerAnimationLoop: true,
                            dialogType: DialogType.success,
                            title: 'Success',
                            desc: 'Successfully Return ticket',
                            btnOkOnPress: () async {
                              // data.browse.remove(data.browse[0]);
                              final reloadData = await controller.joblist(
                                  context: context,
                                  username: data.user.username,
                                  type: 'progress');
                              setState(() {
                                this.reloadData = reloadData;
                                // data.browse.add(reloadData[0]);
                              });
                              Get.back();
                            },
                            btnOkIcon: Icons.check_circle,
                          ).show();
                        }
                      },
                      icon: const Icon(Icons.restart_alt_sharp),
                      label: Text('Return',
                          style: GoogleFonts.inter(
                              color: primaryColor,
                              fontWeight: FontWeight.bold))),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
