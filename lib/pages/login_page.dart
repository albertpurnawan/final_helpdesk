// ignore_for_file: unnecessary_brace_in_string_interps

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:helpdesk_skripsi/data/login_data.dart';
import 'package:helpdesk_skripsi/model/login_model.dart';
import 'package:helpdesk_skripsi/routes/routes.dart';
import 'package:helpdesk_skripsi/style.dart';
import 'package:lottie/lottie.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => LoginPageDetail();
}

class LoginPageDetail extends State<LoginPage> {
  static const String routeName = '/loginbeta';
  int current = 0;
  final TextEditingController username = TextEditingController();
  final TextEditingController password = TextEditingController();
  late String token;
  bool loading = false;
  Timer? debouncer;
  @override
  void initState() {
    super.initState();
    loading = false;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            // if (loading) loadingImage(),
            // if (!loading)
            Padding(
              padding: const EdgeInsets.only(
                  top: 100.0, left: 50.0, right: 50.0, bottom: 100.0),
              child: Column(
                children: [
                  Image.asset(
                    "assets/images/logo.png",
                    width: 150,
                    height: 150,
                  ),
                  Text(
                    "Helpdesk Mobile",
                    style: GoogleFonts.inter(
                      color: secondaryColor,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 80,
                  ),
                  TextFormField(
                    controller: username,
                    style: GoogleFonts.inter(color: secondaryColor),
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.person,
                        color: secondaryColor,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: secondaryColor,
                          width: 1.0,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: secondaryColor,
                          width: 1.0,
                        ),
                      ),
                      hintText: 'Username',
                      hintStyle: GoogleFonts.inter(
                        color: secondaryColor,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: password,
                    obscureText: true,
                    style: GoogleFonts.inter(color: secondaryColor),
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.lock,
                        color: secondaryColor,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: secondaryColor,
                          width: 1.0,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: secondaryColor,
                          width: 1.0,
                        ),
                      ),
                      hintText: 'Password',
                      hintStyle: GoogleFonts.inter(
                        color: secondaryColor,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 60,
                  ),
                  Center(
                    // ignore: sized_box_for_whitespace
                    child: Container(
                      width: 295,
                      height: 55,
                      child: TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: secondaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () async => debounce(() async {
                          setState(() {
                            loading = true;
                          });
                          if (username.text != '' && password.text != '') {
                            token = await isLogin.getToken(
                                context: context,
                                password: password.text,
                                username: username.text);
                            if (token != '503' && token != '') {
                              setState(() {
                                loading = false;
                              });
                              Get.toNamed(
                                '${RouteClass.main}/${password.text}/${username.text}/${token}',
                              );
                            } else if (token == '') {
                              setState(() {
                                loading = false;
                              });
                              showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                        title: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            SizedBox(
                                              height: 50,
                                              child: Center(
                                                child: Text("Login Failed",
                                                    style: GoogleFonts.inter(
                                                        fontSize: 25,
                                                        color: secondaryColor,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 50,
                                              child: Center(
                                                child: Lottie.asset(
                                                    "assets/lottie/error.json"),
                                              ),
                                            ),
                                          ],
                                        ),
                                        content: Text(
                                            "Invalid Username or Password",
                                            style: GoogleFonts.inter(
                                                fontSize: 14,
                                                color: blackColor,
                                                fontWeight: FontWeight.bold)),
                                      ));
                            } else {
                              showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                        title: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            SizedBox(
                                              height: 50,
                                              child: Center(
                                                child: Text("Login Failed",
                                                    style: GoogleFonts.inter(
                                                        fontSize: 25,
                                                        color: secondaryColor,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 50,
                                              child: Center(
                                                child: Lottie.asset(
                                                    "assets/lottie/error.json"),
                                              ),
                                            ),
                                          ],
                                        ),
                                        content: Text("Server Unavailable",
                                            style: GoogleFonts.inter(
                                                fontSize: 14,
                                                color: blackColor,
                                                fontWeight: FontWeight.bold)),
                                      ));
                            }
                          }
                        }),
                        child: Text(
                          "SIGN IN",
                          style: GoogleFonts.inter(
                            color: primaryColor,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Copyright \u00a9 Mayora 2022",
                    style: GoogleFonts.inter(
                      color: secondaryColor,
                      fontSize: 14,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget loadingImage() {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 1,
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
