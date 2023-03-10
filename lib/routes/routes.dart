import 'package:get/get.dart';
import 'package:helpdesk_skripsi/model/browse_model.dart';
import 'package:helpdesk_skripsi/model/login_model.dart';
import 'package:helpdesk_skripsi/model/showstatus_model.dart';
import 'package:helpdesk_skripsi/model/ticket_pool_model.dart';
import 'package:helpdesk_skripsi/pages/detailpages/browse_detail_page.dart';
import 'package:helpdesk_skripsi/pages/browse_page.dart';
import 'package:helpdesk_skripsi/pages/detailpages/history_detail_page.dart';
import 'package:helpdesk_skripsi/pages/navpages/create_ticket_page.dart';
import 'package:helpdesk_skripsi/pages/dashboard_page.dart';
import 'package:helpdesk_skripsi/pages/navpages/error_page.dart';
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
  static String error = "/error";

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
  static String getErrorRoute() => error;

  static List<GetPage> routes = [
    GetPage(name: login, page: () => const LoginPage()),
    GetPage(
        name: RouteClass.dashboard,
        page: () => const DashboardPage(),
        arguments: User),
    GetPage(
        name: createTicket, page: () => const CreateTicket(), arguments: User),
    GetPage(
        name: RouteClass.ticketPool,
        page: () => const TicketPoolPage(),
        arguments: User),
    GetPage(
        name: RouteClass.home, page: () => const HomePage(), arguments: User),
    GetPage(
        name: RouteClass.main, page: () => const MainPage(), arguments: User),
    GetPage(
        name: RouteClass.masterCategory,
        page: () => const MasterCategoryPage(),
        arguments: User),
    GetPage(name: RouteClass.report, page: () => const ReportPage()),
    GetPage(
        name: RouteClass.browse,
        page: () => const BrowsePage(),
        arguments: User),
    GetPage(
        name: RouteClass.joblist,
        page: () => const JoblistPage(),
        arguments: User),
    GetPage(
        name: '${RouteClass.browsedetail}/:id/:docno',
        page: () => const BrowsesDetailPage(),
        arguments: User),
    GetPage(
        name: RouteClass.showstatus,
        page: () => const ShowStatus(),
        arguments: ScreenArguments),
    GetPage(
        name: RouteClass.error, page: () => const ErrorPage(), arguments: User),
    GetPage(
        name: RouteClass.historydetail,
        page: () => const HistoryDetailPage(),
        arguments: ScreenArguments2),
    GetPage(
        name: RouteClass.review,
        page: () => const ReviewJoblist(),
        arguments: ScreenArguments2),
    GetPage(
        name: '${RouteClass.ticketpooldetail}/:id/:docno',
        page: () => const TicketPoolDetailPage(),
        arguments: User),
  ];
}

class ScreenArguments {
  final User user;
  final List<ShowStatusModel> workflow;

  ScreenArguments(this.user, this.workflow);
}

class ScreenArguments2 {
  final User user;
  final BrowseIssueDetail browse;

  ScreenArguments2(this.user, this.browse);
}
