import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:helpdesk_skripsi/Model/browse_model.dart';
import 'package:helpdesk_skripsi/data/browse_issue_data.dart';
import 'package:helpdesk_skripsi/routes/routes.dart';
import 'package:helpdesk_skripsi/style.dart';

class JoblistHistory extends StatefulWidget {
  const JoblistHistory({super.key});

  @override
  State<JoblistHistory> createState() => _JoblistHistory();
}

class _JoblistHistory extends State<JoblistHistory> {
  List<BrowseIssue> issueData = allIssue;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: ListView.builder(
          itemCount: issueData.length,
          itemBuilder: (context, index) {
            final issue = issueData[index];
            return GestureDetector(
              child: Card(
                elevation: 10,
                color: greyColor,
                margin: const EdgeInsets.all(5),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Text(
                    issue.issueDesc.toString(),
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      color: primaryColor,
                      // decoration: TextDecoration.underline,
                    ),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              onTap: () {
                Get.toNamed('${RouteClass.historydetail}/${issue.ticketNum}');
              },
            );
          }),
    );
  }
}
