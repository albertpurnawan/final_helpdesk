// ignore_for_file: unnecessary_brace_in_string_interps

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:helpdesk_skripsi/controller/controller.dart';
import 'package:helpdesk_skripsi/model/login_model.dart';
import 'package:helpdesk_skripsi/routes/routes.dart';
import 'package:helpdesk_skripsi/style.dart';
import 'package:helpdesk_skripsi/util/login_form_field.dart';
import 'package:lottie/lottie.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => LoginPageDetail();
}

class LoginPageDetail extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  int current = 0;
  final TextEditingController username = TextEditingController();
  final TextEditingController password = TextEditingController();
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
      body: loading
          ? loadingImage()
          : SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 100.0, left: 50.0, right: 50.0, bottom: 100.0),
                    child: Form(
                      key: _formKey,
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
                          LoginFormField(
                            hintText: 'Username',
                            obscureText: false,
                            icon: Icons.person,
                            color: secondaryColor,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter username';
                              } else {
                                setState(() {
                                  username.text = value;
                                });
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          LoginFormField(
                            hintText: 'Password',
                            obscureText: true,
                            icon: Icons.lock,
                            color: secondaryColor,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter password';
                              } else {
                                setState(() {
                                  password.text = value;
                                });
                              }
                              return null;
                            },
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
                                  if (_formKey.currentState!.validate()) {
                                    if (username.text != '' &&
                                        password.text != '') {
                                      setState(() {
                                        loading = true;
                                      });
                                      User user = await controller.Login(
                                          context: context,
                                          username: username.text,
                                          password: password.text);
                                      if (user.username != '') {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              'Login success!',
                                              style: GoogleFonts.inter(
                                                color: primaryColor,
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            backgroundColor: secondaryColor,
                                            duration:
                                                const Duration(seconds: 2),
                                            behavior: SnackBarBehavior.floating,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(24),
                                            ),
                                            // margin: EdgeInsets.only(
                                            //   bottom:
                                            //       MediaQuery.of(context).size.height - 140,
                                            //   right: 20,
                                            //   left: 20,
                                            // ),
                                          ),
                                        );
                                        Get.toNamed(RouteClass.main,
                                            arguments: user);
                                      } else {
                                        setState(() {
                                          loading = false;
                                        });
                                        // Get.toNamed(
                                        //   RouteClass.login,
                                        // );
                                      }
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
