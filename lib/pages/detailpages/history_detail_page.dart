import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:helpdesk_skripsi/model/browse_model.dart';
import 'package:helpdesk_skripsi/model/login_model.dart';
import 'package:helpdesk_skripsi/routes/routes.dart';
import 'package:helpdesk_skripsi/style.dart';
import 'package:helpdesk_skripsi/util/appbar.dart';

class HistoryDetailPage extends StatefulWidget {
  const HistoryDetailPage({super.key});

  @override
  State<HistoryDetailPage> createState() => _HistoryDetailPageState();
}

class _HistoryDetailPageState extends State<HistoryDetailPage> {
  // List<BrowseIssue> issueData = allIssue;
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
  String ticketNum = "";
  String repairType = '';
  String supportType = '';

  @override
  Widget build(BuildContext context) {
    ScreenArguments2 data =
        ModalRoute.of(context)!.settings.arguments as ScreenArguments2;
    setState(() {
      this.data = data;
      ticketNum = data.browse.docno.toString();
    });
    return Scaffold(
      appBar: const MyAppBar(title: 'History Detail Ticket', showBackBtn: true),
      backgroundColor: primaryColor,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
                    Text(data.browse.docno,
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          color: primaryColor,
                        )),
                    Divider(
                      color: primaryColor,
                      height: 30,
                      thickness: 1,
                    ),
                    Text(
                      "Description",
                      style: GoogleFonts.inter(
                          fontSize: 15,
                          color: primaryColor,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      data.browse.description,
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        color: primaryColor,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                    Divider(
                      color: primaryColor,
                      height: 30,
                      thickness: 1,
                    ),
                    Text("Request For:",
                        style: GoogleFonts.inter(
                            fontSize: 15,
                            color: primaryColor,
                            fontWeight: FontWeight.bold)),
                    const SizedBox(height: 10),
                    Text('${data.browse.userid} - ${data.browse.username}',
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          color: primaryColor,
                        )),
                    Divider(
                      color: primaryColor,
                      height: 30,
                      thickness: 1,
                    ),
                    Text("File:",
                        style: GoogleFonts.inter(
                            fontSize: 15,
                            color: primaryColor,
                            fontWeight: FontWeight.bold)),
                    const SizedBox(height: 10),
                    // for (int i = 0; i < 5; i++)
                    //   Card(
                    //     elevation: 5,
                    //     color: primaryColor,
                    //     child: GestureDetector(
                    //       onTap: () {
                    //         showDialog(
                    //             context: context,
                    //             builder: (context) => AlertDialog(
                    //                   title: Text("",
                    //                       style: GoogleFonts.inter(
                    //                           fontSize: 14,
                    //                           color: blackColor,
                    //                           fontWeight: FontWeight.bold)),
                    //                   content: Image.asset(
                    //                       "assets/images/iuProfile.jpg"),
                    //                 ));
                    //       },
                    //       child: Padding(
                    //         padding: const EdgeInsets.all(10),
                    //         child: Text("",
                    //             style: GoogleFonts.inter(
                    //                 fontSize: 12,
                    //                 color: secondaryColor,
                    //                 decoration: TextDecoration.underline)),
                    //       ),
                    //     ),
                    //   ),
                    Divider(
                      color: primaryColor,
                      height: 30,
                      thickness: 1,
                    ),
                    Text("Support Category:",
                        style: GoogleFonts.inter(
                            fontSize: 15,
                            color: primaryColor,
                            fontWeight: FontWeight.bold)),
                    const SizedBox(height: 10),
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
                    Text("Category:",
                        style: GoogleFonts.inter(
                            fontSize: 15,
                            color: primaryColor,
                            fontWeight: FontWeight.bold)),
                    const SizedBox(height: 10),
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
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
