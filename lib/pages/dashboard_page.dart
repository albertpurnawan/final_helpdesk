import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:helpdesk_skripsi/style.dart';
import 'package:helpdesk_skripsi/util/appbar.dart';
import 'package:helpdesk_skripsi/util/dashboard_tiles.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(title: "Dashboard", showBackBtn: true),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              DashboardTiles(
                ticket: 10,
                desc: "Tiket masuk hari ini",
                icon: Icons.info_outline,
                bgColor: secondaryColor,
                color: primaryColor,
                iconBgColor: Colors.red.shade600,
                iconColor: primaryColor,
              ),
              const SizedBox(height: 10),
              DashboardTiles(
                ticket: 20,
                desc: "Tiket pending hari ini",
                icon: Icons.question_mark,
                bgColor: Colors.red.shade100,
                color: blackColor,
                iconBgColor: Colors.red.shade200,
                iconColor: blackColor,
              ),
              const SizedBox(height: 10),
              DashboardTiles(
                ticket: 8,
                desc: "Tiket yang selesai hari ini",
                icon: Icons.check_box_rounded,
                bgColor: primaryColor,
                color: blackColor,
                iconBgColor: greyColor,
                iconColor: blackColor,
              ),
              const SizedBox(height: 30),
              Container(
                height: 400,
                decoration: BoxDecoration(
                  // borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade400,
                      spreadRadius: 2,
                      blurRadius: 2,
                      offset: const Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: SfCartesianChart(
                  title: ChartTitle(
                    text: "Total tiket per Support Category",
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
                      dataSource: getColumnData(),
                      xValueMapper: (DashboardData dashboard, _) => dashboard.x,
                      yValueMapper: (DashboardData dashboard, _) => dashboard.y,
                      dataLabelSettings: const DataLabelSettings(
                        isVisible: true,
                        labelAlignment: ChartDataLabelAlignment.middle,
                      ),
                      pointColorMapper: (DashboardData dashboard, _) =>
                          dashboard.color,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
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

dynamic getColumnData() {
  List<DashboardData> columnData = <DashboardData>[
    DashboardData("Application Problem", 10, tealColor),
    DashboardData("Cloud", 2, darkGreenColor),
    DashboardData("Data Center", 5, toscaColor),
    DashboardData("Incident", 4, darkTealColor),
    DashboardData("Maintenance", 6, secondaryColor),
    DashboardData("Network Problem", 9, Colors.amberAccent),
    DashboardData("Technical Problem", 30, Colors.purple.shade100),
    DashboardData("Server", 1, Colors.pinkAccent),
  ];

  return columnData;
}
