import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:helpdesk_skripsi/model/login_model.dart';
import 'package:helpdesk_skripsi/pages/navpages/create_ticket_page.dart';
import 'package:helpdesk_skripsi/pages/navpages/home_page.dart';
import 'package:helpdesk_skripsi/pages/navpages/profile_page.dart';
import 'package:helpdesk_skripsi/style.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int currentIndex = 0;
  User user = User(
      username: "",
      password: "",
      ua: "",
      email: "",
      image: "",
      name: "",
      groupcode: "",
      empid: "",
      groupname: "");
  List pages = [
    const HomePage(),
    const CreateTicket(),
    const ProfilePage(),
  ];

  void onTap(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    User user = ModalRoute.of(context)!.settings.arguments as User;
    setState(() {
      this.user = user;
    });
    return Scaffold(
      body: pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        // unselectedFontSize: 0,
        // selectedFontSize: 0,
        // type: BottomNavigationBarType.fixed,
        // backgroundColor: secondaryColor,
        onTap: onTap,
        currentIndex: currentIndex,
        selectedItemColor: secondaryColor,
        unselectedItemColor: greyColor.withOpacity(0.4),
        elevation: 0,
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
      ),
    );
  }
}
