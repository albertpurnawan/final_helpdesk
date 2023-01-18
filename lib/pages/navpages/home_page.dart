import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:helpdesk_skripsi/data/login_data.dart';
import 'package:helpdesk_skripsi/model/home_model.dart';
import 'package:helpdesk_skripsi/model/login_model.dart';
import 'package:helpdesk_skripsi/util/appbar.dart';
import 'package:helpdesk_skripsi/style.dart';
import 'package:helpdesk_skripsi/util/features_button.dart';
import 'package:lottie/lottie.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String username = Get.parameters['username'].toString();
  String password = Get.parameters['password'].toString();
  String token = Get.parameters['token'].toString();

  Widget build(BuildContext context) {
    late Future<String> dataUser = isLogin.loginUser(
        context: context, password: password, username: username);
    ;
    late Future<String> image = isLogin.getImage(
        context: context,
        password: password,
        username: username,
        token: token,
        dataUser: dataUser);
    ;
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: const MyAppBar(title: "Help Desk Mobile", showBackBtn: false),
      body: FutureBuilder(
        future: Future.wait([dataUser, image]),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.data == null) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Lottie.asset("assets/lottie/loading.json"),
                ),
              ],
            );
          } else {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: blackColor,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.4),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset:
                              const Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
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
                                imageUrl: '${snapshot.data![1]}',
                                imageBuilder: (context, imageProvider) =>
                                    Container(
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
                            "Good Evening, ${snapshot.data![0]}",
                            style: GoogleFonts.inter(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          const SizedBox(height: 10),
                        ],
                      ),
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
                            token: token,
                          ),
                          SizedBox(height: 30),
                          FeaturesButton(
                            icon: Icons.cases_sharp,
                            featuresText: "Joblist",
                            index: 3,
                            token: token,
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
                            token: token,
                          ),
                          SizedBox(height: 30),
                          FeaturesButton(
                            icon: Icons.bar_chart,
                            featuresText: "Report",
                            index: 4,
                            token: token,
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
                            token: token,
                          ),
                          SizedBox(height: 30),
                          FeaturesButton(
                            icon: Icons.search,
                            featuresText: "Browse",
                            index: 5,
                            token: token,
                          )
                        ],
                      ),
                    ],
                  ),
                )
              ],
            );
          }
        },
      ),
      // bottomNavigationBar: const BottomNavbar(),
    );
  }
}
