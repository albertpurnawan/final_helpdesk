import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:helpdesk_skripsi/controller/controller.dart';
import 'package:helpdesk_skripsi/model/login_model.dart';
import 'package:helpdesk_skripsi/style.dart';
import 'package:helpdesk_skripsi/util/appbar.dart';
import 'package:helpdesk_skripsi/util/dashboard_tiles.dart';
import 'package:lottie/lottie.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});
  @override
  State<DashboardPage> createState() => _DashboardPagePageState();
}

class _DashboardPagePageState extends State<DashboardPage> {
  bool loading = true;
  Timer? debouncer;
  List<String> data = [];
  List<String> filter = ['Day', 'Week', 'Month'];
  List<DashboardData> datas = [];
  String selected = "Day";
  String pending = "";
  String close = "";
  String reject = "";
  String filterIndo = "hari";
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
        final data =
            await controller.topdashboard(context: context, filter: selected);

        final datas = await controller.dashboard(
          context: context,
          filter: selected,
        );

        print(datas);
        if (!mounted) return;
        setState(() {
          this.data = data;

          this.datas = datas;
          loading = false;
        });
      });
  @override
  Widget build(BuildContext context) {
    User user = ModalRoute.of(context)!.settings.arguments as User;
    setState(() {
      this.user = user;
    });
    return Scaffold(
        appBar: const MyAppBar(title: "Dashboard", showBackBtn: true),
        body: loading
            ? loadingImage()
            : data.length > 0
                ? SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const SizedBox(height: 10),
                          DashboardTiles(
                            ticket: int.parse(data[0].split(" / ")[1] == ""
                                ? '0'
                                : data[0].split(" / ")[1]),
                            desc:
                                "${data[0].split(" / ")[0]} Tiket $filterIndo ",
                            icon: Icons.checklist,
                            bgColor: greyColor,
                            color: primaryColor,
                            iconBgColor: secondaryColor,
                            iconColor: primaryColor,
                          ),
                          // const SizedBox(height: 10),
                          // DashboardTiles(
                          //   ticket: int.parse(data[1].split(" / ")[1] == ""
                          //       ? '0'
                          //       : data[1].split(" / ")[1]),
                          //   desc:
                          //       "${data[1].split(" / ")[0]} Tiket $filterIndo ",
                          //   icon: Icons.keyboard_return_rounded,
                          //   bgColor: secondaryColor,
                          //   color: primaryColor,
                          //   iconBgColor: greyColor,
                          //   iconColor: primaryColor,
                          // ),
                          const SizedBox(height: 30),
                          DropdownButton<String>(
                            value: selected,
                            icon: const Icon(Icons.keyboard_arrow_down),
                            elevation: 16,
                            onChanged: (String? value) {
                              setState(() {
                                selected = value!;
                                if (selected == 'Day') {
                                  filterIndo = "hari";
                                } else if (selected == 'Week') {
                                  filterIndo = "minggu";
                                } else {
                                  filterIndo = "bulan";
                                }
                              });
                            },
                            items: filter
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                          Container(
                            height: 400,
                            decoration: BoxDecoration(
                              // borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.shade400,
                                  spreadRadius: 2,
                                  blurRadius: 2,
                                  offset: const Offset(
                                      0, 3), // changes position of shadow
                                ),
                              ],
                            ),
                            child: SfCartesianChart(
                              title: ChartTitle(
                                text: "Total tiket",
                                textStyle: GoogleFonts.inter(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              // legend: Legend(isVisible: true),
                              primaryXAxis: CategoryAxis(labelRotation: 45),
                              primaryYAxis: NumericAxis(),
                              backgroundColor: primaryColor,
                              series: [
                                ColumnSeries(
                                  dataSource: datas,
                                  xValueMapper: (DashboardData dashboard, _) =>
                                      dashboard.x,
                                  yValueMapper: (DashboardData dashboard, _) =>
                                      dashboard.y,
                                  dataLabelSettings: const DataLabelSettings(
                                    isVisible: true,
                                    labelAlignment:
                                        ChartDataLabelAlignment.middle,
                                  ),
                                  pointColorMapper:
                                      (DashboardData dashboard, _) =>
                                          dashboard.color,
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                : Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.4,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: SizedBox(
                              height: 50,
                              child: Center(
                                child: Text("Data Not Found",
                                    style: GoogleFonts.inter(
                                        fontSize: 20,
                                        color: secondaryColor,
                                        fontWeight: FontWeight.bold)),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 50,
                            child: Center(
                              child: Lottie.asset("assets/lottie/error.json"),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text("No Data Found In Dashboard",
                              style: GoogleFonts.inter(
                                  fontSize: 14,
                                  color: blackColor,
                                  fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ],
                  )
        // AlertDialog(
        //     title: Row(
        //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //       crossAxisAlignment: CrossAxisAlignment.center,
        //       children: [
        //         SizedBox(
        //           height: 50,
        //           child: Center(
        //             child: Text("Data Not Found",
        //                 style: GoogleFonts.inter(
        //                     fontSize: 20,
        //                     color: secondaryColor,
        //                     fontWeight: FontWeight.bold)),
        //           ),
        //         ),
        //         SizedBox(
        //           width: 50,
        //           child: Center(
        //             child: Lottie.asset("assets/lottie/error.json"),
        //           ),
        //         ),
        //       ],
        //     ),
        //     content: Column(
        //       crossAxisAlignment: CrossAxisAlignment.center,
        //       children: [
        //         Text("No Data Found In Helpdesk Category",
        //             style: GoogleFonts.inter(
        //                 fontSize: 14,
        //                 color: blackColor,
        //                 fontWeight: FontWeight.bold)),
        //       ],
        //     ),
        //   ),
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

class DashboardData {
  String x;
  double y;
  Color color;

  DashboardData(this.x, this.y, this.color);
}
