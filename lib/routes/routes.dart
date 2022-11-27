import 'package:get/get.dart';
// import 'package:helpdesk_skripsi/pages/Detail_page.dart';
import 'package:helpdesk_skripsi/pages/browse_page.dart';
import 'package:helpdesk_skripsi/pages/navpages/create_ticket_page.dart';
import 'package:helpdesk_skripsi/pages/dashboard_page.dart';
import 'package:helpdesk_skripsi/pages/navpages/home_page.dart';
import 'package:helpdesk_skripsi/pages/joblist_page.dart';
import 'package:helpdesk_skripsi/pages/login_page.dart';
import 'package:helpdesk_skripsi/pages/master_category_page.dart';
import 'package:helpdesk_skripsi/pages/navpages/main_page.dart';
import 'package:helpdesk_skripsi/pages/report_page.dart';
import 'package:helpdesk_skripsi/pages/ticket_pool_page.dart';

class RouteClass {
  static String login = "/login";
  static String dashboard = "/dashboard";
  static String createTicket = "/createTicket";
  static String ticketPool = "/ticketPool";
  static String home = "/home";
  static String main = "/main";
  static String masterCategory = "/masterCategory";
  static String report = "/report";
  static String browse = "/browse";
  static String joblist = "/joblist";
  static String detail = "/detail";

  static String getLoginRoute() => login;
  static String getDashboardRoute() => dashboard;
  static String getCreateTicketRoute() => createTicket;
  static String getTicketPoolRoute() => ticketPool;
  static String getHomeRoute() => home;
  static String getMainPageRoute() => main;
  static String getMasterCategoryRoute() => masterCategory;
  static String getReportRoute() => report;
  static String getBrowseRoute() => browse;
  static String getJoblistRoute() => joblist;
  static String getDetailRoute() => detail;

  static List<GetPage> routes = [
    GetPage(name: login, page: () => const LoginPage()),
    GetPage(name: dashboard, page: () => const DashboardPage()),
    GetPage(
      name: createTicket,
      page: () => const CreateTicket(),
      // transition: Transition.fade,
      // transitionDuration: const Duration(seconds: 1),
    ),
    GetPage(name: ticketPool, page: () => const TicketPoolPage()),
    GetPage(name: home, page: () => const HomePage()),
    GetPage(name: main, page: () => const MainPage()),
    GetPage(name: masterCategory, page: () => const MasterCategoryPage()),
    GetPage(name: report, page: () => const ReportPage()),
    GetPage(name: browse, page: () => const BrowsePage()),
    GetPage(name: joblist, page: () => const JoblistPage()),
    // GetPage(
    //     name: '${RouteClass.detail}/:tickteNum',
    //     page: () => const DetailPage()),
  ];
}
