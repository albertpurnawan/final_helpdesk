import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:helpdesk_skripsi/pages/login_page.dart';
import 'package:helpdesk_skripsi/routes/routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(useMaterial3: true),
        home: const LoginPage(),
        initialRoute: RouteClass.getLoginRoute(),
        getPages: RouteClass.routes);
  }
}
