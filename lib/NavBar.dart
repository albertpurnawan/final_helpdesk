// ignore: file_names
// ignore: file_names
// ignore: file_names
// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_returning_null_for_void

import 'package:flutter/material.dart';

class NavBar extends StatelessWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text('Welcome, Daniel'),
            accountEmail: Text('MM04994'),
            currentAccountPicture: CircleAvatar(
              child: ClipOval(
                child: Image.asset(
                  'assets/images/avatar.png',
                  fit: BoxFit.cover,
                  width: 80,
                  height: 80,
                ),
              ),
            ),
            decoration: BoxDecoration(
                color: Colors.blue,
                image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage('assets/images/background.jpg'))),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15.0),
            child: Text("Menu",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          ),
          ListTile(
            leading: Icon(Icons.message),
            title: Text('Chat'),
            onTap: () => null,
          ),
          ListTile(
            leading: Icon(Icons.info),
            title: Text('Create Issue'),
            onTap: () => null,
          ),
          ListTile(
            leading: Icon(Icons.view_list),
            title: Text('Issue Pool'),
            onTap: () => null,
          ),
          ListTile(
            leading: Icon(Icons.assignment_rounded),
            title: Text('Detail Issue'),
            onTap: () => null,
          ),
          ListTile(
            leading: Icon(Icons.content_paste_search),
            title: Text('Review Ticket'),
            onTap: () => null,
          ),
          ListTile(
            leading: Icon(Icons.cases),
            title: Text('My Job Ticket'),
            onTap: () => null,
          ),
          ListTile(
            leading: Icon(Icons.star),
            title: Text('Rating Issue'),
            onTap: () => null,
          ),
          ListTile(
            leading: Icon(Icons.search),
            title: Text('Browse'),
            onTap: () => null,
          ),
        ],
      ),
    );
  }
}
