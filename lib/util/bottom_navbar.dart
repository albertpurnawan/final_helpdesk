import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:helpdesk_skripsi/routes/routes.dart';

class BottomNavbar extends StatefulWidget {
  const BottomNavbar({super.key});

  @override
  State<BottomNavbar> createState() => _BottomNavbarState();
}

class _BottomNavbarState extends State<BottomNavbar> {
  @override
  Widget build(BuildContext context) {
    return CurvedNavigationBar(
      backgroundColor: Colors.green.shade50,
      color: Colors.green.shade100,
      animationDuration: const Duration(milliseconds: 200),
      onTap: (index) {
        // print(index);
        switch (index) {
          case 0:
            Get.toNamed(RouteClass.getHomeRoute());
            break;
          case 1:
            Get.toNamed(RouteClass.getCreateTicketRoute());
            break;
          case 2:
            // Get.toNamed(RouteClass.getHomeRoute());
            print('ke profile page');
            break;
        }
      },
      items: [
        Icon(
          Icons.home,
          color: Colors.green[800],
          size: 28,
        ),
        Icon(
          Icons.add_rounded,
          color: Colors.green[800],
          size: 28,
        ),
        Icon(
          Icons.person,
          color: Colors.green[800],
          size: 28,
        ),
      ],
    );

    // return Container(
    //   color: Colors.green.shade100,
    //   child: Padding(
    //     padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
    //     child: GNav(

    //       padding: const EdgeInsets.all(16),
    //       backgroundColor: Colors.green.shade100,
    //       activeColor: Colors.green.shade800,
    //       tabBackgroundColor: Colors.green.shade300,
    //       color: Colors.green.shade800,
    //       gap: 15,
    //       onTabChange: (index) {
    //         print(index);
    //       },
    //       tabs: const [
    //         GButton(icon: Icons.home, text: 'Home'),
    //         GButton(icon: Icons.add, text: 'Create Ticket'),
    //         GButton(icon: Icons.person, text: 'Profile'),
    //       ],
    //     ),
    //   ),
    // );
  }
}
