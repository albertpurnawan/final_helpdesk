import 'package:get/get.dart';
import 'package:helpdesk_skripsi/pages/detailpages/browse_detail_page.dart';
import 'package:helpdesk_skripsi/pages/browse_page.dart';
import 'package:helpdesk_skripsi/pages/detailpages/history_detail_page.dart';
import 'package:helpdesk_skripsi/pages/navpages/create_ticket_page.dart';
import 'package:helpdesk_skripsi/pages/dashboard_page.dart';
import 'package:helpdesk_skripsi/pages/navpages/home_page.dart';
import 'package:helpdesk_skripsi/pages/joblist_page.dart';
import 'package:helpdesk_skripsi/pages/login_page.dart';
import 'package:helpdesk_skripsi/pages/master_category_page.dart';
import 'package:helpdesk_skripsi/pages/navpages/main_page.dart';
import 'package:helpdesk_skripsi/pages/report_page.dart';
import 'package:helpdesk_skripsi/pages/review_joblist_page.dart';
import 'package:helpdesk_skripsi/pages/show_status_page.dart';
import 'package:helpdesk_skripsi/pages/detailpages/ticket_pool_detail.dart';
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
  static String browsedetail = "/browsedetail";
  static String historydetail = "/historydetail";
  static String showstatus = "/showstatus";
  static String review = "/review";
  static String ticketpooldetail = "/ticketpooldetail";

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
  static String getBrowseDetailRoute() => browsedetail;
  static String getHistoryDetailRoute() => historydetail;
  static String getShowStatus() => showstatus;
  static String getDetailRouteTicket() => ticketpooldetail;

  static List<GetPage> routes = [
    GetPage(name: login, page: () => const LoginPage()),
    GetPage(
        name: '${RouteClass.dashboard}/:token',
        page: () => const DashboardPage()),
    GetPage(
      name: createTicket,
      page: () => const CreateTicket(),
    ),
    GetPage(
        name: '${RouteClass.ticketPool}/:token',
        page: () => const TicketPoolPage()),
    GetPage(
        name: '${RouteClass.home}/:password/:username/:token',
        page: () => const HomePage()),
    GetPage(
        name: '${RouteClass.main}/:password/:username/:token',
        page: () => const MainPage()),
    GetPage(
        name: '${RouteClass.masterCategory}/:token',
        page: () => const MasterCategoryPage()),
    GetPage(
        name: '${RouteClass.report}/:token', page: () => const ReportPage()),
    GetPage(
        name: '${RouteClass.browse}/:token', page: () => const BrowsePage()),
    GetPage(
        name: '${RouteClass.joblist}/:token', page: () => const JoblistPage()),
    GetPage(
        name: '${RouteClass.browsedetail}/:token/:id',
        page: () => const BrowsesDetailPage()),
    GetPage(
        name: '${RouteClass.showstatus}/:token/:docno/:ticket',
        page: () => const ShowStatus()),
    // GetPage(
    //     name: '${RouteClass.historydetail}/:token/:docno',
    //     page: () => const HistoryDetailPage()),
    // GetPage(
    //     name: '${RouteClass.review}/:token/:docno',
    //     page: () => const ReviewJoblist()),
    // GetPage(
    //     name: '${RouteClass.ticketpooldetail}/:token/:docno',
    //     page: () => const TicketPoolDetailPage()),
  ];
}
