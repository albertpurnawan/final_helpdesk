import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:helpdesk_skripsi/model/login_model.dart';
import 'package:helpdesk_skripsi/util/appbar.dart';
import 'package:helpdesk_skripsi/style.dart';
import 'package:helpdesk_skripsi/util/faq.dart';
import 'package:helpdesk_skripsi/util/features_button.dart';
import 'package:lottie/lottie.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    User user = ModalRoute.of(context)!.settings.arguments as User;
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: const MyAppBar(title: "Help Desk Mobile", showBackBtn: false),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: blackColor,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.4),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                width: MediaQuery.of(context).size.width * 0.7,
                height: MediaQuery.of(context).size.height * 0.25,
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 80,
                        height: 80,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          // child: Image(
                          //   image: NetworkImageWithRetry(
                          //       "${snapshot.data![1]}"),
                          //   fit: BoxFit.cover,
                          //   height: double.infinity,
                          //   width: double.infinity,
                          //   alignment: Alignment.center,
                          // ),
                          child: CachedNetworkImage(
                            imageUrl: user.image,
                            imageBuilder: (context, imageProvider) => Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: imageProvider,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            placeholder: (context, url) =>
                                const CircularProgressIndicator(),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "Welcome back, \n ${user.name}",
                        style: GoogleFonts.inter(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
              ),
              //OUR FEATURES TITLE
              const SizedBox(height: 30),
              Text(
                "Our Features",
                // textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: secondaryColor,
                ),
              ),
              Divider(
                thickness: 2,
                indent: 60,
                endIndent: 60,
                color: blackColor,
              ),
              //MAIN FEATURES
              SizedBox(
                height: 250,
                // color: Colors.amberAccent,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    //column 1
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FeaturesButton(
                          icon: Icons.dashboard,
                          featuresText: "Dashboard",
                          index: 0,
                          user: user,
                        ),
                        const SizedBox(height: 30),
                        FeaturesButton(
                          icon: Icons.cases_sharp,
                          featuresText: "Joblist",
                          index: 3,
                          user: user,
                        )
                      ],
                    ),
                    const SizedBox(width: 30),
                    //column 2
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FeaturesButton(
                          icon: Icons.list,
                          featuresText: "Ticket Pool",
                          index: 1,
                          user: user,
                        ),
                        const SizedBox(height: 30),
                        FeaturesButton(
                          icon: Icons.bar_chart,
                          featuresText: "Report",
                          index: 4,
                          user: user,
                        )
                      ],
                    ),
                    const SizedBox(width: 30),
                    //column 3
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FeaturesButton(
                          icon: Icons.settings,
                          featuresText: "Master",
                          index: 2,
                          user: user,
                        ),
                        const SizedBox(height: 30),
                        FeaturesButton(
                          icon: Icons.search,
                          featuresText: "Browse",
                          index: 5,
                          user: user,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Text(
                "Frequenly Asked Questions",
                style: GoogleFonts.inter(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: secondaryColor,
                ),
              ),
              Divider(
                thickness: 2,
                indent: 50,
                endIndent: 50,
                color: blackColor,
              ),
              const SizedBox(height: 10),
              const FAQ(
                title: "How to create ticket?",
                desc: "1. Open create tiket menu. \n"
                    "2. Fill all the needs field. \n"
                    "3. You can upload file if it's needed (optional). \n"
                    "4. Press the submit button.",
              ),
              const FAQ(
                title: "How to track the progress of my ticket?",
                desc: "1. Open browse menu. \n"
                    "2. Search the ticket by using ticket number. \n"
                    "3. Press the card ticket. \n"
                    "4. Press the show status button.",
              ),
              const FAQ(
                title: "Can I contact the IT Helpdesk team?",
                desc:
                    "Yes you can, by sending an email to it.helpdesk@mayora.co.id or via whatsapp at 0811-9455-111.",
              ),
              const FAQ(
                title: "What types of problems can be handled?",
                desc:
                    "In this Helpdesk Quick Response, we can only handle technical and application problems.",
              ),
            ],
          ),
        ),
      ),
      // bottomNavigationBar: const BottomNavbar(),
    );
  }
}
