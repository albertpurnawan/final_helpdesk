import 'package:flutter/material.dart';
import 'package:helpdesk_skripsi/pages/navpages/create_ticket_page.dart';
import 'package:helpdesk_skripsi/pages/navpages/home_page.dart';
import 'package:helpdesk_skripsi/pages/navpages/profile_page.dart';

class BottomNavbar extends StatefulWidget {
  const BottomNavbar({super.key});

  @override
  State<BottomNavbar> createState() => _BottomNavbarState();
}

class _BottomNavbarState extends State<BottomNavbar> {
  // int _selectedIndex = 0;
  // void _onItemTapped(int index) {
  //   setState(() {
  //     _selectedIndex = index;
  //   });
  // }
  List pages = [
    const HomePage(),
    const CreateTicket(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: "Home",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.add),
          label: "Create Ticket",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: "Profile",
        ),
      ],
      // currentIndex: _selectedIndex,
      // onTap: _onItemTapped,
    );
    // return CurvedNavigationBar(
    //   backgroundColor: primaryColor,
    //   color: secondaryColor,
    //   animationDuration: const Duration(milliseconds: 200),
    //   onTap: (index) {
    //     // print(index);
    //     switch (index) {
    //       case 0:
    //         Get.toNamed(RouteClass.getHomeRoute());
    //         break;
    //       case 1:
    //         Get.toNamed(RouteClass.getCreateTicketRoute());
    //         break;
    //       case 2:
    //         // Get.toNamed(RouteClass.getHomeRoute());
    //         print('ke profile page');
    //         break;
    //     }
    //   },
    //   items: [
    //     Icon(
    //       Icons.home,
    //       color: primaryColor,
    //       size: 28,
    //     ),
    //     Icon(
    //       Icons.add_rounded,
    //       color: primaryColor,
    //       size: 28,
    //     ),
    //     Icon(
    //       Icons.person,
    //       color: primaryColor,
    //       size: 28,
    //     ),
    //   ],
    // );
  }
}
