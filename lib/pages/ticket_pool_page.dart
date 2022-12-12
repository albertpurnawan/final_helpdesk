import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:helpdesk_skripsi/data/ticket_pool_data.dart';
import 'package:helpdesk_skripsi/model/ticket_pool_model.dart';
import 'package:helpdesk_skripsi/style.dart';
import 'package:helpdesk_skripsi/util/appbar.dart';
import 'package:helpdesk_skripsi/util/searchBar.dart';
import 'package:intl/intl.dart';

import '../routes/routes.dart';

class TicketPoolPage extends StatefulWidget {
  const TicketPoolPage({super.key});

  @override
  State<TicketPoolPage> createState() => _TicketPoolPageState();
}

class _TicketPoolPageState extends State<TicketPoolPage> {
  List<TicketPool> issueData = allIssue;
  String query = '';

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: const MyAppBar(title: 'Ticket Pool', showBackBtn: true),
          backgroundColor: primaryColor,
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TabBar(
                physics: const BouncingScrollPhysics(),
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
              ),
              buildSearch(),
              Expanded(
                  child: TabBarView(
                      physics: const BouncingScrollPhysics(),
                      children: [
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: ListView.builder(
                        itemCount: issueData.length,
                        itemBuilder: (context, index) {
                          final issue = issueData[index];
                          return GestureDetector(
                            child: buildCard(issue),
                            onTap: () {
                              Get.toNamed(
                                  '${RouteClass.ticketpooldetail}/${issue.ticketNum}');
                            },
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: ListView.builder(
                        itemCount: issueData.length,
                        itemBuilder: (context, index) {
                          final issue = issueData[index];
                          return GestureDetector(
                            child: buildCard(issue),
                            onTap: () {
                              Get.toNamed(
                                  '${RouteClass.ticketpooldetail}/${issue.ticketNum}');
                            },
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: ListView.builder(
                        itemCount: issueData.length,
                        itemBuilder: (context, index) {
                          final issue = issueData[index];
                          return GestureDetector(
                            child: buildCard(issue),
                            onTap: () {
                              Get.toNamed(
                                  '${RouteClass.ticketpooldetail}/${issue.ticketNum}');
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

  Card buildCard(TicketPool issue) {
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
                            issue.ticketNum.toString(),
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
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.3,
                          child: Text(
                            issue.status.toString(),
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
                        "Requester",
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
                            issue.requester.toString(),
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
                        "Requester Email",
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
                            issue.requesterEmail.toString(),
                            style: GoogleFonts.inter(
                              fontSize: 12,
                              color: primaryColor,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
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
                            DateFormat.yMd().format(issue.createdDate),
                            style: GoogleFonts.inter(
                              fontSize: 12,
                              color: primaryColor,
                            ),
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
                            issue.createdBy.toString(),
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
                ],
              ),
            ),
          ),
          // const SizedBox(height: 10),
          Text(
            "Requester's Phone Number",
            style: GoogleFonts.inter(
                fontSize: 15, color: primaryColor, fontWeight: FontWeight.bold),
          ),
          Container(
            padding:
                const EdgeInsets.only(left: 20, right: 20, bottom: 20, top: 10),
            child: Text(
              issue.requesterPhoneNum.toString(),
              style: GoogleFonts.inter(
                fontSize: 12,
                color: primaryColor,
              ),
              textAlign: TextAlign.justify,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildSearch() => SearchWidget(
        text: query,
        hintText: 'Search...',
        onChanged: searchIssue,
      );

  void searchIssue(String query) {
    final tickets = allIssue.where((issue) {
      final ticketNum = issue.ticketNum.toString().toLowerCase();
      final createdBy = issue.createdBy.toLowerCase();
      final requester = issue.requester.toLowerCase();
      final requesterEmail = issue.requesterEmail.toLowerCase();
      final requesterPhoneNum = issue.requesterPhoneNum.toLowerCase();
      final searchLower = query.toLowerCase();

      return ticketNum.contains(searchLower) ||
          createdBy.contains(searchLower) ||
          requester.contains(searchLower) ||
          requesterEmail.contains(searchLower) ||
          requesterPhoneNum.contains(searchLower);
    }).toList();

    setState(() {
      this.query = query;
      issueData = tickets;
    });
  }
}
