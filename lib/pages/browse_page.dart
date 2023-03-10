import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:helpdesk_skripsi/controller/controller.dart';
import 'package:helpdesk_skripsi/model/login_model.dart';
import 'package:helpdesk_skripsi/style.dart';
import 'package:helpdesk_skripsi/util/appbar.dart';
import 'package:helpdesk_skripsi/util/searchBar.dart';
import 'package:helpdesk_skripsi/util/utils.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

import '../model/browse_model.dart';
import '../routes/routes.dart';

class BrowsePage extends StatefulWidget {
  const BrowsePage({super.key});

  @override
  State<BrowsePage> createState() => _BrowsePageState();
}

class _BrowsePageState extends State<BrowsePage> {
  bool loading = true;
  String search = '';
  List<BrowseIssue> data = [];
  Timer? debouncer;
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
        final data = await controller.Browse(
            context: context,
            groupcode: user.groupcode,
            name: user.name,
            ua: user.ua,
            username: user.username);
        print(data.length);
        if (!mounted) return;
        setState(() {
          this.data = data;
          loading = false;
        });
      });

  @override
  Widget build(BuildContext context) {
    User user = ModalRoute.of(context)!.settings.arguments as User;
    setState(() {
      this.user = user;
    });
    return Scaffold(
      appBar: const MyAppBar(title: 'Browse Ticket', showBackBtn: true),
      backgroundColor: primaryColor,
      body: loading
          ? loadingImage()
          : Column(
              children: <Widget>[
                data.length > 0
                    ? buildSearch()
                    : SizedBox(
                        height: 10,
                      ),
                data.length > 0
                    ? Expanded(
                        child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: ListView.builder(
                              itemCount: data.length,
                              itemBuilder: (context, index) {
                                final id = data[index].id;
                                return buildCard(data[index], id);
                              },
                            )))
                    : Column(
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.35,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: SizedBox(
                                  height: 50,
                                  child: Center(
                                    child: Text("Data Not Found",
                                        style: GoogleFonts.inter(
                                            fontSize: 20,
                                            color: secondaryColor,
                                            fontWeight: FontWeight.bold)),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 50,
                                child: Center(
                                  child:
                                      Lottie.asset("assets/lottie/error.json"),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text("No Data Found in Browse Ticket",
                                  style: GoogleFonts.inter(
                                      fontSize: 14,
                                      color: blackColor,
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ],
                      ),
              ],
            ),
    );
  }

  GestureDetector buildCard(
    BrowseIssue issue,
    String id,
  ) {
    return GestureDetector(
      child: Card(
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
                          child: Text(
                            issue.docno.toString(),
                            style: GoogleFonts.inter(
                              fontSize: 12,
                              color: primaryColor,
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
                              issue.username.toString(),
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
                          "Status",
                          style: GoogleFonts.inter(
                              fontSize: 15,
                              color: primaryColor,
                              fontWeight: FontWeight.bold),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: Text(
                            issue.status.toString(),
                            style: GoogleFonts.inter(
                              fontSize: 12,
                              color: primaryColor,
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
                          child: Text(
                            issue.createdate.toString(),
                            style: GoogleFonts.inter(
                              fontSize: 12,
                              color: primaryColor,
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
                              issue.createby.toString(),
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
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: Text(
                            issue.supportcategory.toString(),
                            style: GoogleFonts.inter(
                              fontSize: 12,
                              color: primaryColor,
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
            Text(
              "Issue Desc",
              style: GoogleFonts.inter(
                  fontSize: 15,
                  color: primaryColor,
                  fontWeight: FontWeight.bold),
            ),
            Container(
              padding: const EdgeInsets.only(
                  left: 20, right: 20, bottom: 20, top: 10),
              child: Text(
                issue.description.toString(),
                style: GoogleFonts.inter(
                  fontSize: 12,
                  color: primaryColor,
                ),
                textAlign: TextAlign.justify,
              ),
            ),
          ],
        ),
      ),
      onTap: () {
        print(issue.id);
        print(issue.docno);
        Get.toNamed('${RouteClass.browsedetail}/${issue.id}/${issue.docno}',
            arguments: user);
      },
    );
  }

  Widget buildSearch() => SearchWidget(
        text: search,
        hintText: 'Search...',
        onChanged: searchData,
      );

  Future searchData(String search) async => debounce(() async {
        setState(() {
          loading = true;
        });
        if (!mounted) return;
        setState(() {
          this.search = search;
          this.data = data.where((issue) {
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
