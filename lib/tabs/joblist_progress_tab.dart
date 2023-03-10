import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:helpdesk_skripsi/controller/controller.dart';
import 'package:helpdesk_skripsi/model/browse_model.dart';
import 'package:helpdesk_skripsi/model/login_model.dart';
import 'package:helpdesk_skripsi/routes/routes.dart';
import 'package:helpdesk_skripsi/style.dart';
import 'package:lottie/lottie.dart';

class JoblistProgress extends StatefulWidget {
  const JoblistProgress({super.key});

  @override
  State<JoblistProgress> createState() => _JoblistProgressState();
}

class _JoblistProgressState extends State<JoblistProgress> {
  String supp = "";
  String category = "";
  String sub1 = "";
  String sub2 = "";
  bool loading = true;
  String search = '';
  bool enable1 = false;
  bool enable2 = false;
  List<BrowseIssueDetail> data = [];
  List<String> listsupp = [];
  List<String> listcate = [];
  List<String> listsub1 = [];
  Timer? debouncer;
  User user = User(
      username: '',
      password: '',
      ua: '',
      email: '',
      image: '',
      name: '',
      groupcode: '',
      empid: "",
      groupname: "");
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
        final data = await controller.joblist(
            context: context, username: user.username, type: 'progress');
        if (!mounted) return;
        setState(() {
          this.data = data;
          loading = false;
        });
      });
  @override
  Widget build(BuildContext context) {
    User user = ModalRoute.of(context)!.settings.arguments as User;
    setState(() {
      this.user = user;
    });
    return loading
        ? loadingImage()
        : Padding(
            padding: const EdgeInsets.all(20),
            child: ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  final issue = data[index];
                  return GestureDetector(
                    child: Card(
                      elevation: 10,
                      color: greyColor,
                      margin: const EdgeInsets.all(5),
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Text(
                          issue.description.toString(),
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
                      Get.toNamed(RouteClass.review,
                          arguments: ScreenArguments2(user, issue));
                    },
                  );
                }),
          );
  }

  Widget loadingImage() {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.8,
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
