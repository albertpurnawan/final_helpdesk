// import 'package:flutter/gestures.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:helpdesk_skripsi/data_old/browse_issue_data.dart';
// import 'package:helpdesk_skripsi/model_old/browse_model.dart';
// import 'package:helpdesk_skripsi/routes/routes.dart';
// import 'package:helpdesk_skripsi/style.dart';
// import 'package:helpdesk_skripsi/util/appbar.dart';
// import 'package:intl/intl.dart';
// import 'package:url_launcher/url_launcher.dart';

// class ReviewJoblist extends StatefulWidget {
//   const ReviewJoblist({super.key});

//   @override
//   State<ReviewJoblist> createState() => _ReviewJoblistState();
// }

// class _ReviewJoblistState extends State<ReviewJoblist> {
//   List<BrowseIssue> issueData = allIssue;
//   String ticketNum = Get.parameters['tickteNum'].toString();
//   String repairType = '';
//   String supportType = '';

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: const MyAppBar(title: 'Review Ticket', showBackBtn: true),
//       backgroundColor: primaryColor,
//       body: SingleChildScrollView(
//         scrollDirection: Axis.vertical,
//         child: Padding(
//           padding: const EdgeInsets.all(20),
//           child: Column(
//             children: [
//               Row(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Column(
//                     children: [
//                       Icon(
//                         Icons.circle,
//                         size: 17,
//                         color: greyColor,
//                       ),
//                       SizedBox(width: MediaQuery.of(context).size.width * 0.07),
//                       Container(
//                           height: MediaQuery.of(context).size.height * 0.7,
//                           width: 1,
//                           color: greyColor),
//                     ],
//                   ),
//                   SizedBox(height: MediaQuery.of(context).size.height * 0.015),
//                   Column(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text("User Detail",
//                           style: GoogleFonts.inter(
//                               fontSize: 17,
//                               color: greyColor,
//                               fontWeight: FontWeight.bold)),
//                       SizedBox(
//                           height: MediaQuery.of(context).size.height * 0.015),
//                       SizedBox(
//                           width: MediaQuery.of(context).size.width * 0.8,
//                           child: Card(
//                             elevation: 10,
//                             color: secondaryColor,
//                             child: Padding(
//                               padding: const EdgeInsets.all(20),
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text("Request For",
//                                       style: GoogleFonts.inter(
//                                           fontSize: 15,
//                                           color: primaryColor,
//                                           fontWeight: FontWeight.bold)),
//                                   SizedBox(
//                                       height:
//                                           MediaQuery.of(context).size.height *
//                                               0.015),
//                                   Text('Chris Anggawana',
//                                       style: GoogleFonts.inter(
//                                         fontSize: 12,
//                                         color: primaryColor,
//                                       )),
//                                   Divider(
//                                     color: primaryColor,
//                                     height: 30,
//                                     indent: 5,
//                                     endIndent: 5,
//                                     thickness: 1,
//                                   ),
//                                   Text("NIK",
//                                       style: GoogleFonts.inter(
//                                           fontSize: 15,
//                                           color: primaryColor,
//                                           fontWeight: FontWeight.bold)),
//                                   SizedBox(
//                                       height:
//                                           MediaQuery.of(context).size.height *
//                                               0.015),
//                                   Text('MM04996',
//                                       style: GoogleFonts.inter(
//                                         fontSize: 12,
//                                         color: primaryColor,
//                                       )),
//                                   Divider(
//                                     color: primaryColor,
//                                     height: 30,
//                                     indent: 5,
//                                     endIndent: 5,
//                                     thickness: 1,
//                                   ),
//                                   Text("Department",
//                                       style: GoogleFonts.inter(
//                                           fontSize: 15,
//                                           color: primaryColor,
//                                           fontWeight: FontWeight.bold)),
//                                   SizedBox(
//                                       height:
//                                           MediaQuery.of(context).size.height *
//                                               0.015),
//                                   Text('IT',
//                                       style: GoogleFonts.inter(
//                                         fontSize: 12,
//                                         color: primaryColor,
//                                       )),
//                                   Divider(
//                                     color: primaryColor,
//                                     height: 30,
//                                     thickness: 1,
//                                   ),
//                                   Text("Location",
//                                       style: GoogleFonts.inter(
//                                           fontSize: 15,
//                                           color: primaryColor,
//                                           fontWeight: FontWeight.bold)),
//                                   SizedBox(
//                                       height:
//                                           MediaQuery.of(context).size.height *
//                                               0.015),
//                                   Text('[WL99] CNS - Region Sumatera',
//                                       style: GoogleFonts.inter(
//                                         fontSize: 12,
//                                         color: primaryColor,
//                                       )),
//                                   Divider(
//                                     color: primaryColor,
//                                     height: 30,
//                                     thickness: 1,
//                                   ),
//                                   Text("Phone Number/Ext",
//                                       style: GoogleFonts.inter(
//                                           fontSize: 15,
//                                           color: primaryColor,
//                                           fontWeight: FontWeight.bold)),
//                                   SizedBox(
//                                       height:
//                                           MediaQuery.of(context).size.height *
//                                               0.015),
//                                   Text('--',
//                                       style: GoogleFonts.inter(
//                                         fontSize: 12,
//                                         color: primaryColor,
//                                       )),
//                                   Divider(
//                                     color: primaryColor,
//                                     height: 30,
//                                     thickness: 1,
//                                   ),
//                                   Text("Contact Email",
//                                       style: GoogleFonts.inter(
//                                           fontSize: 15,
//                                           color: primaryColor,
//                                           fontWeight: FontWeight.bold)),
//                                   SizedBox(
//                                       height:
//                                           MediaQuery.of(context).size.height *
//                                               0.015),
//                                   Text('chris.anggawana@mayora.co.id',
//                                       style: GoogleFonts.inter(
//                                         fontSize: 12,
//                                         color: primaryColor,
//                                       )),
//                                   Divider(
//                                     color: primaryColor,
//                                     height: 30,
//                                     thickness: 1,
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ))
//                     ],
//                   )
//                 ],
//               ),
//               Row(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Column(
//                     children: [
//                       Icon(
//                         Icons.circle,
//                         size: 17,
//                         color: greyColor,
//                       ),
//                       SizedBox(width: MediaQuery.of(context).size.width * 0.07),
//                       Container(
//                           height: MediaQuery.of(context).size.height * 0.8,
//                           width: 1,
//                           color: greyColor),
//                     ],
//                   ),
//                   SizedBox(height: MediaQuery.of(context).size.height * 0.015),
//                   Column(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text("Problem Detail",
//                           style: GoogleFonts.inter(
//                               fontSize: 17,
//                               color: greyColor,
//                               fontWeight: FontWeight.bold)),
//                       const SizedBox(height: 10),
//                       SizedBox(
//                           width: MediaQuery.of(context).size.width * 0.8,
//                           child: Card(
//                             elevation: 10,
//                             color: secondaryColor,
//                             child: Padding(
//                               padding: const EdgeInsets.all(20),
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text("Ticket Number",
//                                       style: GoogleFonts.inter(
//                                           fontSize: 15,
//                                           color: primaryColor,
//                                           fontWeight: FontWeight.bold)),
//                                   SizedBox(
//                                       height:
//                                           MediaQuery.of(context).size.height *
//                                               0.015),
//                                   Text(ticketNum,
//                                       style: GoogleFonts.inter(
//                                         fontSize: 12,
//                                         color: primaryColor,
//                                       )),
//                                   Divider(
//                                     color: primaryColor,
//                                     height: 30,
//                                     indent: 5,
//                                     endIndent: 5,
//                                     thickness: 1,
//                                   ),
//                                   Text("Created Date",
//                                       style: GoogleFonts.inter(
//                                           fontSize: 15,
//                                           color: primaryColor,
//                                           fontWeight: FontWeight.bold)),
//                                   SizedBox(
//                                       height:
//                                           MediaQuery.of(context).size.height *
//                                               0.015),
//                                   Text(
//                                       DateFormat.yMd()
//                                           .format(issueData[0].createdDate),
//                                       style: GoogleFonts.inter(
//                                         fontSize: 12,
//                                         color: primaryColor,
//                                       )),
//                                   Divider(
//                                     color: primaryColor,
//                                     height: 30,
//                                     indent: 5,
//                                     endIndent: 5,
//                                     thickness: 1,
//                                   ),
//                                   Text("Description",
//                                       style: GoogleFonts.inter(
//                                           fontSize: 15,
//                                           color: primaryColor,
//                                           fontWeight: FontWeight.bold)),
//                                   SizedBox(
//                                       height:
//                                           MediaQuery.of(context).size.height *
//                                               0.015),
//                                   Text(issueData[0].issueDesc,
//                                       style: GoogleFonts.inter(
//                                         fontSize: 12,
//                                         color: primaryColor,
//                                       )),
//                                   Divider(
//                                     color: primaryColor,
//                                     height: 30,
//                                     thickness: 1,
//                                   ),
//                                   Text("Parent Category",
//                                       style: GoogleFonts.inter(
//                                           fontSize: 15,
//                                           color: primaryColor,
//                                           fontWeight: FontWeight.bold)),
//                                   SizedBox(
//                                       height:
//                                           MediaQuery.of(context).size.height *
//                                               0.015),
//                                   Text(issueData[0].supportCategory,
//                                       style: GoogleFonts.inter(
//                                         fontSize: 12,
//                                         color: primaryColor,
//                                       )),
//                                   Divider(
//                                     color: primaryColor,
//                                     height: 30,
//                                     thickness: 1,
//                                   ),
//                                   Text("Category",
//                                       style: GoogleFonts.inter(
//                                           fontSize: 15,
//                                           color: primaryColor,
//                                           fontWeight: FontWeight.bold)),
//                                   SizedBox(
//                                       height:
//                                           MediaQuery.of(context).size.height *
//                                               0.015),
//                                   Text(issueData[0].supportCategory,
//                                       style: GoogleFonts.inter(
//                                         fontSize: 12,
//                                         color: primaryColor,
//                                       )),
//                                   Divider(
//                                     color: primaryColor,
//                                     height: 30,
//                                     thickness: 1,
//                                   ),
//                                   Text("Attachment",
//                                       style: GoogleFonts.inter(
//                                           fontSize: 15,
//                                           color: primaryColor,
//                                           fontWeight: FontWeight.bold)),
//                                   SizedBox(
//                                       height:
//                                           MediaQuery.of(context).size.height *
//                                               0.015),
//                                   for (int i = 0; i < 2; i++)
//                                     Card(
//                                       elevation: 5,
//                                       color: primaryColor,
//                                       child: GestureDetector(
//                                         onTap: () {
//                                           showDialog(
//                                               context: context,
//                                               builder: (context) => AlertDialog(
//                                                     title: Text(
//                                                         issueData[1].createdBy,
//                                                         style:
//                                                             GoogleFonts.inter(
//                                                                 fontSize: 14,
//                                                                 color:
//                                                                     blackColor,
//                                                                 fontWeight:
//                                                                     FontWeight
//                                                                         .bold)),
//                                                     content: Image.asset(
//                                                         "assets/images/iuProfile.jpg"),
//                                                   ));
//                                         },
//                                         child: Padding(
//                                           padding: const EdgeInsets.all(10),
//                                           child: Text(issueData[1].createdBy,
//                                               style: GoogleFonts.inter(
//                                                   fontSize: 12,
//                                                   color: secondaryColor,
//                                                   decoration: TextDecoration
//                                                       .underline)),
//                                         ),
//                                       ),
//                                     ),
//                                 ],
//                               ),
//                             ),
//                           )),
//                     ],
//                   ),
//                 ],
//               ),
//               Row(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Column(
//                     children: [
//                       Icon(
//                         Icons.circle,
//                         size: 17,
//                         color: greyColor,
//                       ),
//                       SizedBox(width: MediaQuery.of(context).size.width * 0.07),
//                     ],
//                   ),
//                   Column(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text("Support Detail",
//                           style: GoogleFonts.inter(
//                               fontSize: 17,
//                               color: greyColor,
//                               fontWeight: FontWeight.bold)),
//                       SizedBox(
//                           height: MediaQuery.of(context).size.height * 0.015),
//                       SizedBox(
//                           width: MediaQuery.of(context).size.width * 0.8,
//                           child: Card(
//                             elevation: 10,
//                             color: secondaryColor,
//                             child: Padding(
//                               padding: const EdgeInsets.all(20),
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text("Task Kanban",
//                                       style: GoogleFonts.inter(
//                                           fontSize: 15,
//                                           color: primaryColor,
//                                           fontWeight: FontWeight.bold)),
//                                   SizedBox(
//                                       height:
//                                           MediaQuery.of(context).size.height *
//                                               0.015),
//                                   Text('ACR - Check batch PBK',
//                                       style: GoogleFonts.inter(
//                                         fontSize: 12,
//                                         color: primaryColor,
//                                       )),
//                                   Divider(
//                                     color: primaryColor,
//                                     height: 30,
//                                     indent: 5,
//                                     endIndent: 5,
//                                     thickness: 1,
//                                   ),
//                                   Text("System",
//                                       style: GoogleFonts.inter(
//                                           fontSize: 15,
//                                           color: primaryColor,
//                                           fontWeight: FontWeight.bold)),
//                                   SizedBox(
//                                       height:
//                                           MediaQuery.of(context).size.height *
//                                               0.015),
//                                   Text('Mayora Portal',
//                                       style: GoogleFonts.inter(
//                                         fontSize: 12,
//                                         color: primaryColor,
//                                       )),
//                                   Divider(
//                                     color: primaryColor,
//                                     height: 30,
//                                     indent: 5,
//                                     endIndent: 5,
//                                     thickness: 1,
//                                   ),
//                                   Text("Application",
//                                       style: GoogleFonts.inter(
//                                           fontSize: 15,
//                                           color: primaryColor,
//                                           fontWeight: FontWeight.bold)),
//                                   SizedBox(
//                                       height:
//                                           MediaQuery.of(context).size.height *
//                                               0.015),
//                                   Text('ERP - SAP',
//                                       style: GoogleFonts.inter(
//                                         fontSize: 12,
//                                         color: primaryColor,
//                                       )),
//                                   Divider(
//                                     color: primaryColor,
//                                     height: 30,
//                                     thickness: 1,
//                                   ),
//                                   Text("Sub Category 1",
//                                       style: GoogleFonts.inter(
//                                           fontSize: 15,
//                                           color: primaryColor,
//                                           fontWeight: FontWeight.bold)),
//                                   SizedBox(
//                                       height:
//                                           MediaQuery.of(context).size.height *
//                                               0.015),
//                                   Text('IT',
//                                       style: GoogleFonts.inter(
//                                         fontSize: 12,
//                                         color: primaryColor,
//                                       )),
//                                   Divider(
//                                     color: primaryColor,
//                                     height: 30,
//                                     thickness: 1,
//                                   ),
//                                   Text("Sub Category 2",
//                                       style: GoogleFonts.inter(
//                                           fontSize: 15,
//                                           color: primaryColor,
//                                           fontWeight: FontWeight.bold)),
//                                   SizedBox(
//                                       height:
//                                           MediaQuery.of(context).size.height *
//                                               0.015),
//                                   Text('IT',
//                                       style: GoogleFonts.inter(
//                                         fontSize: 12,
//                                         color: primaryColor,
//                                       )),
//                                   Divider(
//                                     color: primaryColor,
//                                     height: 30,
//                                     thickness: 1,
//                                   ),
//                                   Text("Repair Type",
//                                       style: GoogleFonts.inter(
//                                           fontSize: 15,
//                                           color: primaryColor,
//                                           fontWeight: FontWeight.bold)),
//                                   SizedBox(
//                                       height:
//                                           MediaQuery.of(context).size.height *
//                                               0.015),
//                                   Text('Internal',
//                                       style: GoogleFonts.inter(
//                                         fontSize: 12,
//                                         color: primaryColor,
//                                       )),
//                                   Divider(
//                                     color: primaryColor,
//                                     height: 30,
//                                     thickness: 1,
//                                   ),
//                                   Text("Support Type",
//                                       style: GoogleFonts.inter(
//                                           fontSize: 15,
//                                           color: primaryColor,
//                                           fontWeight: FontWeight.bold)),
//                                   SizedBox(
//                                       height:
//                                           MediaQuery.of(context).size.height *
//                                               0.015),
//                                   Text('Remote',
//                                       style: GoogleFonts.inter(
//                                         fontSize: 12,
//                                         color: primaryColor,
//                                       )),
//                                   Divider(
//                                     color: primaryColor,
//                                     height: 30,
//                                     thickness: 1,
//                                   ),
//                                   Text("Problem Identification",
//                                       style: GoogleFonts.inter(
//                                           fontSize: 15,
//                                           color: primaryColor,
//                                           fontWeight: FontWeight.bold)),
//                                   SizedBox(
//                                       height:
//                                           MediaQuery.of(context).size.height *
//                                               0.015),
//                                   TextField(
//                                       maxLines: 2,
//                                       style: TextStyle(color: primaryColor),
//                                       decoration: InputDecoration(
//                                         enabledBorder: OutlineInputBorder(
//                                           borderRadius:
//                                               BorderRadius.circular(10),
//                                           borderSide: BorderSide(
//                                             color: primaryColor,
//                                             width: 1.0,
//                                           ),
//                                         ),
//                                         focusedBorder: OutlineInputBorder(
//                                           borderRadius:
//                                               BorderRadius.circular(10),
//                                           borderSide: BorderSide(
//                                             color: primaryColor,
//                                             width: 1.0,
//                                           ),
//                                         ),
//                                         hintText: "Type your text",
//                                         hintStyle: GoogleFonts.inter(
//                                           color: primaryColor,
//                                           fontSize: 12,
//                                         ),
//                                       )),
//                                   SizedBox(
//                                       height:
//                                           MediaQuery.of(context).size.height *
//                                               0.025),
//                                   Text("Corrective Action",
//                                       style: GoogleFonts.inter(
//                                           fontSize: 15,
//                                           color: primaryColor,
//                                           fontWeight: FontWeight.bold)),
//                                   SizedBox(
//                                       height:
//                                           MediaQuery.of(context).size.height *
//                                               0.015),
//                                   TextField(
//                                       maxLines: 2,
//                                       style: TextStyle(color: primaryColor),
//                                       decoration: InputDecoration(
//                                         enabledBorder: OutlineInputBorder(
//                                           borderRadius:
//                                               BorderRadius.circular(10),
//                                           borderSide: BorderSide(
//                                             color: primaryColor,
//                                             width: 1.0,
//                                           ),
//                                         ),
//                                         focusedBorder: OutlineInputBorder(
//                                           borderRadius:
//                                               BorderRadius.circular(10),
//                                           borderSide: BorderSide(
//                                             color: primaryColor,
//                                             width: 1.0,
//                                           ),
//                                         ),
//                                         hintText: "Type your text",
//                                         hintStyle: GoogleFonts.inter(
//                                           color: primaryColor,
//                                           fontSize: 12,
//                                         ),
//                                       ))
//                                 ],
//                               ),
//                             ),
//                           )),
//                     ],
//                   ),
//                 ],
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(10),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceAround,
//                   children: [
//                     Icon(
//                       Icons.info_outline,
//                       color: greyColor,
//                       size: 24,
//                     ),
//                     SizedBox(
//                       width: MediaQuery.of(context).size.width * 0.7,
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text.rich(
//                             textAlign: TextAlign.justify,
//                             TextSpan(
//                               text:
//                                   "You must done the task in your kanban before closing the ticket. ",
//                               style: GoogleFonts.inter(
//                                 fontSize: 14,
//                                 color: greyColor,
//                               ),
//                               children: [
//                                 TextSpan(
//                                   text: "Go to your Kanban",
//                                   style: GoogleFonts.inter(
//                                     fontSize: 15,
//                                     color: greyColor,
//                                     fontWeight: FontWeight.bold,
//                                     decoration: TextDecoration.underline,
//                                   ),
//                                   recognizer: TapGestureRecognizer()
//                                     ..onTap = () {
//                                       launchUrl(
//                                         Uri.parse(
//                                             'https://portal.mayora.co.id/Portal/Dashboard/IT/Kanban'),
//                                       );
//                                     },
//                                 )
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               const SizedBox(height: 20),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceAround,
//                 children: [
//                   ElevatedButton.icon(
//                       style: TextButton.styleFrom(
//                         foregroundColor: primaryColor,
//                         backgroundColor: toscaColor,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                       ),
//                       onPressed: null,
//                       icon: Icon(Icons.app_registration_rounded,
//                           color: primaryColor),
//                       label: Text('Close',
//                           style: GoogleFonts.inter(
//                               color: primaryColor,
//                               fontWeight: FontWeight.bold))),
//                   ElevatedButton.icon(
//                       style: TextButton.styleFrom(
//                         foregroundColor: primaryColor,
//                         backgroundColor: orangeColor,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                       ),
//                       onPressed: () {},
//                       icon: const Icon(Icons.restart_alt_sharp),
//                       label: Text('Return',
//                           style: GoogleFonts.inter(
//                               color: primaryColor,
//                               fontWeight: FontWeight.bold))),
//                   ElevatedButton.icon(
//                       style: TextButton.styleFrom(
//                         foregroundColor: primaryColor,
//                         backgroundColor: secondaryColor,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                       ),
//                       onPressed: () {
//                         Get.toNamed(RouteClass.joblist);
//                       },
//                       icon: const Icon(Icons.cancel_outlined),
//                       label: Text('Cancel',
//                           style: GoogleFonts.inter(
//                               color: primaryColor,
//                               fontWeight: FontWeight.bold))),
//                 ],
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
