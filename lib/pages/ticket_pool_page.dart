import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:helpdesk_skripsi/controller/controller.dart';
import 'package:helpdesk_skripsi/model/login_model.dart';
import 'package:helpdesk_skripsi/model/ticket_pool_model.dart';
import 'package:helpdesk_skripsi/style.dart';
import 'package:helpdesk_skripsi/util/appbar.dart';
import 'package:helpdesk_skripsi/util/searchBar.dart';
import 'package:helpdesk_skripsi/util/statusCode.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

import '../routes/routes.dart';

class TicketPoolPage extends StatefulWidget {
  const TicketPoolPage({super.key});

  @override
  State<TicketPoolPage> createState() => _TicketPoolPageState();
}

class _TicketPoolPageState extends State<TicketPoolPage> {
  bool loading = true;
  String search = '';
  List<TicketPoolModel> dataHelp = [];
  List<TicketPoolModel> dataClose = [];
  List<TicketPoolModel> dataSupp = [];
  List<TicketPoolModel> dataCurr = [];
  Timer? debouncer;
  int current = 0;
  bool isVisible1 = false;
  bool isVisible2 = false;
  bool isVisible3 = false;
  String? selectedValue1;
  String? selectedValue2;
  String? selectedValue3;
  User user = User(
      username: '',
      password: '',
      ua: '',
      email: '',
      image: '',
      name: '',
      groupcode: '',
      empid: "",
      groupname: "");

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
        final dataHelp = await controller.TicketPool(
            context: context, search: search, category: '_NEW');
        if (!mounted) return;
        setState(() {
          if (user.groupcode == 'IT001' || user.groupcode == 'IT003') {
            this.dataHelp = [];
            dataCurr = dataHelp;
          } else {
            this.dataHelp = dataHelp;
            dataCurr = dataHelp;
          }
          loading = false;
        });
      });

  @override
  Widget build(BuildContext context) {
    User user = ModalRoute.of(context)!.settings.arguments as User;
    print(user.ua);
    setState(() {
      this.user = user;
    });
    return WillPopScope(
      onWillPop: () {
        // _onBackPressed();
        //   desc.text = "";
        //   req.text = "";
        //   email.text = "";
        //   listPath = [];
        //   listFile = [];
        //   phone.text = "";
        Navigator.pushReplacementNamed(context, RouteClass.home);
        return Future.value(false);
      },
      child: DefaultTabController(
          length: 3,
          child: Scaffold(
            appBar: MyAppBar(
              title: 'Ticket Pool',
              showBackBtn: false,
              leading: IconButton(
                icon: Icon(Icons.chevron_left),
                onPressed: () => Navigator.pop(context, false),
              ),
            ),
            backgroundColor: primaryColor,
            body: loading
                ? loadingImage()
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Column(children: <Widget>[
                        TabBar(
                          // physics: const NeverScrollableScrollPhysics(),
                          indicatorColor: blackColor,
                          isScrollable: true,
                          tabs: [
                            Tab(
                              child: Text(
                                "Ticket Open Helpdesk",
                                style: GoogleFonts.inter(
                                  fontSize: 14,
                                  color: blackColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Tab(
                              child: Text(
                                "Ticket Open PIC Support",
                                style: GoogleFonts.inter(
                                  fontSize: 14,
                                  color: blackColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Tab(
                              child: Text(
                                "Close",
                                style: GoogleFonts.inter(
                                  fontSize: 14,
                                  color: blackColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                          onTap: (int indexNow) async {
                            setState(() {
                              loading = true;
                              current = indexNow;
                            });
                            if (current == 0) {
                              if (user.groupcode == 'IT001' ||
                                  user.groupcode == 'IT003') {
                                setState(() {
                                  this.dataHelp = [];
                                  loading = false;
                                });
                                print(dataHelp.isEmpty);
                              } else {
                                isVisible1 = true;
                                isVisible2 = false;
                                isVisible3 = false;
                                final dataHelp = await controller.TicketPool(
                                    context: context,
                                    search: search,
                                    category: '_NEW');
                                print(dataHelp.length);
                                setState(() {
                                  this.dataHelp = dataHelp;
                                  dataCurr = dataHelp;
                                  loading = false;
                                });
                              }
                            } else if (current == 1) {
                              isVisible1 = true;
                              isVisible2 = true;
                              isVisible3 = false;
                              final dataSupp = await controller.TicketPool(
                                  context: context,
                                  search: search,
                                  category: '_OPEN');
                              print(dataSupp.length);
                              setState(() {
                                this.dataSupp = dataSupp;
                                dataCurr = dataSupp;
                                loading = false;
                              });
                            } else if (current == 2) {
                              isVisible1 = true;
                              isVisible2 = true;
                              isVisible3 = true;
                              final dataClose = await controller.TicketPool(
                                  context: context,
                                  search: search,
                                  category: '_CLOSE');
                              print(dataClose.length);
                              setState(() {
                                this.dataClose = dataClose;
                                dataCurr = dataClose;
                                loading = false;
                              });
                            }

                            print("index is $current");
                          },
                        ),
                        buildSearch()
                      ]),
                      Expanded(
                          child: loading
                              ? loadingImage()
                              : TabBarView(
                                  physics: const NeverScrollableScrollPhysics(),
                                  children: [
                                      Padding(
                                        padding: const EdgeInsets.all(20),
                                        child: dataHelp.isEmpty
                                            ? Column(
                                                children: [
                                                  SizedBox(
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.25,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                right: 10),
                                                        child: SizedBox(
                                                          height: 50,
                                                          child: Center(
                                                            child: Text(
                                                                "Data Not Found",
                                                                style: GoogleFonts.inter(
                                                                    fontSize:
                                                                        20,
                                                                    color:
                                                                        secondaryColor,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold)),
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 50,
                                                        child: Center(
                                                          child: Lottie.asset(
                                                              "assets/lottie/error.json"),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                          "No Data Found In Open Helpdesk Category",
                                                          style: GoogleFonts.inter(
                                                              fontSize: 14,
                                                              color: blackColor,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold)),
                                                    ],
                                                  ),
                                                ],
                                              )
                                            : ListView.builder(
                                                itemCount: dataHelp.length,
                                                itemBuilder: (context, index) {
                                                  final issue = dataHelp[index];
                                                  return GestureDetector(
                                                    child: buildCard(issue),
                                                    onTap: () {
                                                      Get.toNamed(
                                                          '${RouteClass.ticketpooldetail}/${issue.id}/${issue.docno}',
                                                          arguments: user);
                                                    },
                                                  );
                                                },
                                              ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(20),
                                        child: dataSupp.isEmpty
                                            ? Column(
                                                children: [
                                                  SizedBox(
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.25,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                right: 10),
                                                        child: SizedBox(
                                                          height: 50,
                                                          child: Center(
                                                            child: Text(
                                                                "Data Not Found",
                                                                style: GoogleFonts.inter(
                                                                    fontSize:
                                                                        20,
                                                                    color:
                                                                        secondaryColor,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold)),
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 50,
                                                        child: Center(
                                                          child: Lottie.asset(
                                                              "assets/lottie/error.json"),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                          "No Data Found In Open PIC Category",
                                                          style: GoogleFonts.inter(
                                                              fontSize: 14,
                                                              color: blackColor,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold)),
                                                    ],
                                                  ),
                                                ],
                                              )
                                            : ListView.builder(
                                                itemCount: dataSupp.length,
                                                itemBuilder: (context, index) {
                                                  final issue = dataSupp[index];
                                                  return GestureDetector(
                                                    child: buildCard(issue),
                                                    onTap: () {
                                                      Get.toNamed(
                                                          '${RouteClass.ticketpooldetail}/${issue.id}/${issue.docno}',
                                                          arguments: user);
                                                    },
                                                  );
                                                },
                                              ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(20),
                                        child: dataClose.isEmpty
                                            ? Column(
                                                children: [
                                                  SizedBox(
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.25,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                right: 10),
                                                        child: SizedBox(
                                                          height: 50,
                                                          child: Center(
                                                            child: Text(
                                                                "Data Not Found",
                                                                style: GoogleFonts.inter(
                                                                    fontSize:
                                                                        20,
                                                                    color:
                                                                        secondaryColor,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold)),
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 50,
                                                        child: Center(
                                                          child: Lottie.asset(
                                                              "assets/lottie/error.json"),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                          "No Data Found In Close Category",
                                                          style: GoogleFonts.inter(
                                                              fontSize: 14,
                                                              color: blackColor,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold)),
                                                    ],
                                                  ),
                                                ],
                                              )
                                            : ListView.builder(
                                                itemCount: dataClose.length,
                                                itemBuilder: (context, index) {
                                                  final issue =
                                                      dataClose[index];
                                                  return GestureDetector(
                                                    child: buildCard(issue),
                                                    onTap: () {
                                                      Get.toNamed(
                                                          '${RouteClass.ticketpooldetail}/${issue.id}/${issue.docno}',
                                                          arguments: user);
                                                    },
                                                  );
                                                },
                                              ),
                                      ),
                                    ])),
                    ],
                  ),
          )),
    );
  }

  Card buildCard(TicketPoolModel issue) {
    return Card(
      elevation: 10,
      color: secondaryColor,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // COLUMN KIRI
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Ticket Number",
                        style: GoogleFonts.inter(
                            fontSize: 15,
                            color: primaryColor,
                            fontWeight: FontWeight.bold),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.3,
                          child: Text(
                            issue.docno.toString(),
                            style: GoogleFonts.inter(
                              fontSize: 12,
                              color: primaryColor,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                      Text(
                        "Description",
                        style: GoogleFonts.inter(
                            fontSize: 15,
                            color: primaryColor,
                            fontWeight: FontWeight.bold),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.3,
                          child: Text(
                            issue.description.toString(),
                            style: GoogleFonts.inter(
                              fontSize: 12,
                              color: primaryColor,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                      Text(
                        "Created By",
                        style: GoogleFonts.inter(
                            fontSize: 15,
                            color: primaryColor,
                            fontWeight: FontWeight.bold),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.3,
                          child: Text(
                            '${issue.createby}',
                            style: GoogleFonts.inter(
                              fontSize: 12,
                              color: primaryColor,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                      if (current == 2)
                        Text(
                          "Closed Date",
                          style: GoogleFonts.inter(
                              fontSize: 15,
                              color: primaryColor,
                              fontWeight: FontWeight.bold),
                        ),
                      if (current == 2)
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.3,
                            child: Text(
                              issue.closeticketdate,
                              style: GoogleFonts.inter(
                                fontSize: 12,
                                color: primaryColor,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                    ],
                  ),
                  VerticalDivider(
                    thickness: 2,
                    color: primaryColor,
                  ),
                  // COLUMN KANAN
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Created Date",
                        style: GoogleFonts.inter(
                            fontSize: 15,
                            color: primaryColor,
                            fontWeight: FontWeight.bold),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.3,
                          child: Text(
                            issue.createdate,
                            style: GoogleFonts.inter(
                              fontSize: 12,
                              color: primaryColor,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                      Text(
                        "Request For",
                        style: GoogleFonts.inter(
                            fontSize: 15,
                            color: primaryColor,
                            fontWeight: FontWeight.bold),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.3,
                          child: Text(
                            '${issue.userid} - ${issue.username}',
                            style: GoogleFonts.inter(
                              fontSize: 12,
                              color: primaryColor,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                      Text(
                        "Support Category",
                        style: GoogleFonts.inter(
                            fontSize: 15,
                            color: primaryColor,
                            fontWeight: FontWeight.bold),
                      ),
                      if (issue.supportcategory.toString() == 'null')
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.3,
                            child: Text(
                              '',
                              style: GoogleFonts.inter(
                                fontSize: 12,
                                color: primaryColor,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      if (issue.supportcategory.toString() != 'null')
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.3,
                            child: Text(
                              issue.supportcategory.toString(),
                              style: GoogleFonts.inter(
                                fontSize: 12,
                                color: primaryColor,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      if (current == 2)
                        Text(
                          "Status",
                          style: GoogleFonts.inter(
                              fontSize: 15,
                              color: primaryColor,
                              fontWeight: FontWeight.bold),
                        ),
                      if (current == 2)
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.3,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (issue.status.toString() == 'O')
                                  Text(
                                    'OPEN',
                                    style: GoogleFonts.inter(
                                      fontSize: 12,
                                      color: primaryColor,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                if (issue.status.toString() == 'C')
                                  Text(
                                    'CLOSE',
                                    style: GoogleFonts.inter(
                                      fontSize: 12,
                                      color: primaryColor,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                              ],
                            ),
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          // const SizedBox(height: 10),
          if (current == 2)
            Text(
              "Rate",
              style: GoogleFonts.inter(
                  fontSize: 15,
                  color: primaryColor,
                  fontWeight: FontWeight.bold),
            ),
          if (current == 2)
            Container(
              padding: const EdgeInsets.only(
                  left: 20, right: 20, bottom: 20, top: 10),
              child: Column(
                children: [
                  if (issue.rate.toString() == 'null')
                    Text(
                      'Not rated',
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        color: primaryColor,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                  if (issue.rate.toString() != 'null')
                    Text(
                      issue.rate.toString(),
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        color: primaryColor,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget buildSearch() => SearchWidget(
        text: search,
        hintText: 'Search...',
        onChanged: searchData,
      );

  Future searchData(String search) async => debounce(() async {
        print(search);
        print(current);
        setState(() {
          loading = true;
        });
        if (!mounted) return;
        setState(() {
          this.search = search;
          this.dataHelp = dataHelp.where((issue) {
            final docno = issue.docno.toString().toLowerCase();
            final createby = issue.createby.toString().toLowerCase();
            final createdate = issue.createdate.toString().toLowerCase();
            final description = issue.description.toString().toLowerCase();
            final status = issue.status.toString().toLowerCase();
            final supportcategory =
                issue.supportcategory.toString().toLowerCase();
            final searchLower = search.toLowerCase();

            return docno.contains(searchLower) ||
                createby.contains(searchLower) ||
                createdate.contains(searchLower) ||
                description.contains(searchLower) ||
                status.contains(searchLower) ||
                supportcategory.contains(searchLower);
          }).toList();

          this.dataSupp = dataSupp.where((issue) {
            final docno = issue.docno.toString().toLowerCase();
            final createby = issue.createby.toString().toLowerCase();
            final createdate = issue.createdate.toString().toLowerCase();
            final description = issue.description.toString().toLowerCase();
            final status = issue.status.toString().toLowerCase();
            final supportcategory =
                issue.supportcategory.toString().toLowerCase();
            final searchLower = search.toLowerCase();

            return docno.contains(searchLower) ||
                createby.contains(searchLower) ||
                createdate.contains(searchLower) ||
                description.contains(searchLower) ||
                status.contains(searchLower) ||
                supportcategory.contains(searchLower);
          }).toList();

          this.dataClose = dataClose.where((issue) {
            final docno = issue.docno.toString().toLowerCase();
            final createby = issue.createby.toString().toLowerCase();
            final createdate = issue.createdate.toString().toLowerCase();
            final description = issue.description.toString().toLowerCase();
            final status = issue.status.toString().toLowerCase();
            final supportcategory =
                issue.supportcategory.toString().toLowerCase();
            final searchLower = search.toLowerCase();

            return docno.contains(searchLower) ||
                createby.contains(searchLower) ||
                createdate.contains(searchLower) ||
                description.contains(searchLower) ||
                status.contains(searchLower) ||
                supportcategory.contains(searchLower);
          }).toList();

          if (current == 0) {
            dataCurr = dataHelp;
          } else if (current == 1) {
            dataCurr = dataSupp;
          } else if (current == 2) {
            dataCurr = dataClose;
          }
          loading = false;
        });
      });

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
