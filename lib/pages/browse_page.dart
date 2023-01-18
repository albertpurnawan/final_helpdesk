import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:helpdesk_skripsi/data/browse_issue_data.dart';
import 'package:helpdesk_skripsi/style.dart';
import 'package:helpdesk_skripsi/util/appbar.dart';
import 'package:helpdesk_skripsi/util/searchBar.dart';
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
  String token = Get.parameters['token'].toString();
  List<BrowseIssue> data = [];
  Timer? debouncer;
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
        final data = await getBrowseData.browseData(
            context: context, token: token, search: search);
        if (!mounted) return;
        setState(() {
          this.data = data;
          loading = false;
        });
      });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(title: 'Browse Ticket', showBackBtn: true),
      backgroundColor: primaryColor,
      body: Column(
        children: <Widget>[
          buildSearch(),
          if (loading) loadingImage(),
          if (!loading)
            Expanded(
                child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        final id = data[index].id;
                        return buildCard(data[index], id);
                      },
                    ))),
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
        print(token);
        print(id);
        Get.toNamed('${RouteClass.browsedetail}/$token/$id');
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

        print(search);
        final data = await getBrowseData.browseData(
            context: context, token: token, search: search);
        if (!mounted) return;
        setState(() {
          this.search = search;
          this.data = data;
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
