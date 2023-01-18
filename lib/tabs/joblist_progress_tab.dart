// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:helpdesk_skripsi/Model/browse_model.dart';
// import 'package:helpdesk_skripsi/data/browse_issue_data.dart';
// import 'package:helpdesk_skripsi/routes/routes.dart';
// import 'package:helpdesk_skripsi/style.dart';

// class JoblistProgress extends StatefulWidget {
//   const JoblistProgress({super.key});

//   @override
//   State<JoblistProgress> createState() => _JoblistProgressState();
// }

// class _JoblistProgressState extends State<JoblistProgress> {
//   List<BrowseIssue> issueData = allIssue;
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(20),
//       child: ListView.builder(
//           itemCount: issueData.length,
//           itemBuilder: (context, index) {
//             final issue = issueData[index];
//             return Card(
//               elevation: 10,
//               color: greyColor,
//               margin: const EdgeInsets.all(5),
//               child: ExpansionTile(
//                 collapsedIconColor: primaryColor,
//                 iconColor: primaryColor,
//                 childrenPadding: const EdgeInsets.all(5),
//                 title: Text(
//                   issue.issueDesc.toString(),
//                   style: GoogleFonts.inter(
//                     fontSize: 12,
//                     color: primaryColor,
//                     // decoration: TextDecoration.underline,
//                   ),
//                   maxLines: 2,
//                   overflow: TextOverflow.ellipsis,
//                 ),
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: [
//                       Container(
//                         width: MediaQuery.of(context).size.width * 0.2,
//                       ),
//                       ElevatedButton.icon(
//                         style: TextButton.styleFrom(
//                           foregroundColor: primaryColor,
//                           backgroundColor: orangeColor,
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//                         ),
//                         onPressed: () {
//                           Get.toNamed(
//                               '${RouteClass.review}/${issue.ticketNum}');
//                         },
//                         icon: const Icon(Icons.app_registration_rounded),
//                         label: Text(
//                           'Review',
//                           style: GoogleFonts.inter(
//                             color: primaryColor,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ),
//                       ElevatedButton.icon(
//                         style: TextButton.styleFrom(
//                           foregroundColor: primaryColor,
//                           backgroundColor: secondaryColor,
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//                         ),
//                         onPressed: () {},
//                         icon: const Icon(Icons.restart_alt_sharp),
//                         label: Text(
//                           'Return',
//                           style: GoogleFonts.inter(
//                             color: primaryColor,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ),
//                     ],
//                   )
//                 ],
//               ),
//             );
//           }),
//     );
//   }
// }
