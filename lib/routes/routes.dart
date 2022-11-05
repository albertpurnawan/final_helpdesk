import 'package:get/get.dart';
import 'package:helpdesk_skripsi/pages/create_ticket_page.dart';
import 'package:helpdesk_skripsi/pages/login_page.dart';

class RouteClass {
  static String login = "/login";
  static String createTicket = "/createTicket";

  static String getLoginRoute() => login;
  static String getCreateTicketRoute() => createTicket;

// kalo mau balik ke page sebelumnya di OnTap kasih Get.back()
// kalo mau menuju page selanjutnya di OnTap kasih contoh:
//         Get.toNamed(RouteClass.getCreateTicketRoute());

  static List<GetPage> routes = [
    GetPage(name: login, page: () => const LoginPage()),
    GetPage(
      name: createTicket,
      page: () => const CreateTicket(),
      transition: Transition.fade,
      transitionDuration: const Duration(seconds: 1),
    )
  ];
}
