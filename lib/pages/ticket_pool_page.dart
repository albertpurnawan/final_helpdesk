import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:helpdesk_skripsi/data/ticketpool_data.dart';
import 'package:helpdesk_skripsi/model/ticket_pool_model.dart';
import 'package:helpdesk_skripsi/style.dart';
import 'package:helpdesk_skripsi/util/appbar.dart';
import 'package:helpdesk_skripsi/util/searchBar.dart';
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
  String token = Get.parameters['token'].toString();
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
        final dataHelp = await getTicketPool.ticket(
            context: context, token: token, search: search, category: '_NEW');
        final dataClose = await getTicketPool.ticket(
            context: context, token: token, search: search, category: '_CLOSE');
        final dataSupp = await getTicketPool.ticket(
            context: context, token: token, search: search, category: '_OPEN');
        print(dataHelp.length);
        print(dataClose.length);
        print(dataSupp.length);
        if (!mounted) return;
        setState(() {
          this.dataHelp = dataHelp;
          this.dataClose = dataClose;
          this.dataSupp = dataSupp;
          dataCurr = dataHelp;
          loading = false;
        });
      });

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: const MyAppBar(title: 'Ticket Pool', showBackBtn: true),
          backgroundColor: primaryColor,
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(children: <Widget>[
                TabBar(
                  physics: const NeverScrollableScrollPhysics(),
                  indicatorColor: blackColor,
                  isScrollable: true,
                  onTap: (int index) {
                    current = index;
                    setState(() {
                      if (current == 0) {
                        isVisible1 = true;
                        isVisible2 = false;
                        isVisible3 = false;
                        dataCurr = dataHelp;
                      } else if (current == 1) {
                        isVisible1 = true;
                        isVisible2 = true;
                        isVisible3 = false;
                        setState(() {
                          dataCurr = dataSupp;
                        });
                      } else if (current == 2) {
                        isVisible1 = true;
                        isVisible2 = true;
                        isVisible3 = true;
                        setState(() {
                          dataCurr = dataClose;
                        });
                      }
                    });
                    print("index is $current");
                  },
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
                ),
              ]),
              buildSearch(),
              if (loading) loadingImage(),
              if (!loading)
                Expanded(
                    child: TabBarView(
                        physics: const NeverScrollableScrollPhysics(),
                        children: [
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: ListView.builder(
                          itemCount: dataCurr.length,
                          itemBuilder: (context, index) {
                            final issue = dataCurr[index];
                            return GestureDetector(
                              child: buildCard(issue),
                              onTap: () {
                                Get.toNamed(
                                    '${RouteClass.ticketpooldetail}/${issue.id}');
                              },
                            );
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: ListView.builder(
                          itemCount: dataCurr.length,
                          itemBuilder: (context, index) {
                            final issue = dataCurr[index];

                            return GestureDetector(
                              child: buildCard(issue),
                              onTap: () {
                                Get.toNamed(
                                    '${RouteClass.ticketpooldetail}/${issue.id}');
                              },
                            );
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: ListView.builder(
                          itemCount: dataCurr.length,
                          itemBuilder: (context, index) {
                            final issue = dataCurr[index];
                            return GestureDetector(
                              child: buildCard(issue),
                              onTap: () {
                                Get.toNamed(
                                    '${RouteClass.ticketpooldetail}/${issue.id}');
                              },
                            );
                          },
                        ),
                      ),
                    ])),
            ],
          ),
        ));
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
                            '${issue.createby} - ${issue.createbyname}',
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
        final dataHelp = await getTicketPool.ticket(
            context: context, token: token, search: search, category: '_NEW');
        final dataSupp = await getTicketPool.ticket(
            context: context, token: token, search: search, category: '_OPEN');
        final dataClose = await getTicketPool.ticket(
            context: context, token: token, search: search, category: '_CLOSE');
        if (!mounted) return;
        setState(() {
          this.search = search;
          this.dataHelp = dataHelp;
          this.dataSupp = dataSupp;
          this.dataClose = dataClose;
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
