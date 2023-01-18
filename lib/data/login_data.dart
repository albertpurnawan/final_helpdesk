// ignore_for_file: unnecessary_brace_in_string_interps

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:helpdesk_skripsi/model/home_model.dart';

import 'package:helpdesk_skripsi/routes/routes.dart';
import 'package:http/http.dart' as http;

import '../model/login_model.dart';
import '../util/returnAPI.dart';
import '../util/utils.dart';

class isLogin {
  static Future<String> getToken({
    required BuildContext context,
    required String username,
    required String password,
  }) async {
    String token = "";
    try {
      http.Response res = await http.post(
        Uri.parse('$baseURL/loginbeta'),
        body: jsonEncode({
          'username': username.toUpperCase(),
          'password': password,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
      );

      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () async {
            token = jsonDecode(res.body)['token'].toString();
          });
    } catch (e) {
      showSnackBar(context, e.toString());
      token = e.toString();
    }
    return token;
  }

  static Future<String> loginUser(
      {required BuildContext context,
      required String password,
      required String username}) async {
    String dataUser = "";
    String name = "";
    UserProfile data = UserProfile(
        username: "",
        password: "",
        name: "",
        empId: "",
        email: "",
        groupCode: "",
        isDeleted: false,
        usingLDAP: false);
    try {
      http.Response res = await http.post(
        Uri.parse('https://portal.mayora.co.id/MOA/Login'),
        body: jsonEncode({
          'username': username,
          'password': password,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
      );
      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () async {
            dataUser = jsonDecode(res.body)['UserLogin'].toString();

            data = UserProfile.fromMap(jsonDecode(dataUser)['user']);
            name = data.name;
            // dataMap = ;
            // getImage(
            //     context: context,
            //     password: password,
            //     username: username.toUpperCase(),
            //     token: token,
            //     dataUser: dataMap);
          });
    } catch (e) {
      showSnackBar(context, e.toString());
      name = e.toString();
    }
    return name;
  }

  static Future<String> getImage(
      {required BuildContext context,
      required String password,
      required String username,
      required String token,
      required Future<String> dataUser}) async {
    String image = "";
    try {
      http.Response res3 = await http.get(
        Uri.parse('$baseURL/loginbeta/photo'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'x-access-token': token
        },
      );
      httpErrorHandle(
          response: res3,
          context: context,
          onSuccess: () async {
            image = res3.body.toString();
            print(image);
            // homeData = Home(token: token, dataUser: dataUser, image: image);
          });
    } catch (e) {
      showSnackBar(context, e.toString());
      image = e.toString();
    }
    return image;
  }
}




// Future<Home> loginUser({
//   required BuildContext context,
//   required String username,
//   required String password,
//   required String token,
// }) async {
//   String token = "";
//   String dataUser = "";
//   String image = "";
//   Future<Home> user;
//   UserProfile dataMap = UserProfile(
//     username: '',
//     password: '',
//     name: '',
//     empId: '',
//     email: '',
//     groupCode: '',
//     isDeleted: false,
//     usingLDAP: false,
//   );
//   try {
//     http.Response res1 = await http.post(
//       Uri.parse('$baseURL/loginbeta'),
//       body: jsonEncode({
//         'username': username.toUpperCase(),
//         'password': password,
//       }),
//       headers: <String, String>{
//         'Content-Type': 'application/json',
//       },
//     );
//     httpErrorHandle(
//       response: res1,
//       context: context,
//       onSuccess: () async {
//         token = jsonDecode(res1.body)['token'].toString();
//         print(token);
//         http.Response res2 = await http.post(
//           Uri.parse('https://portal.mayora.co.id/MOA/Login'),
//           body: jsonEncode({
//             'username': username,
//             'password': password,
//           }),
//           headers: <String, String>{
//             'Content-Type': 'application/json',
//           },
//         );
//         httpErrorHandle(
//             response: res2,
//             context: context,
//             onSuccess: () async {
//               dataUser = jsonDecode(res2.body)['UserLogin'].toString();
//               print(dataUser);
//               dataMap = await UserProfile.fromMap(jsonDecode(dataUser)['user']);
//               http.Response res3 = await http.get(
//                 Uri.parse('$baseURL/loginbeta/photo'),
//                 headers: <String, String>{
//                   'Content-Type': 'application/json',
//                   'x-access-token': token
//                 },
//               );
//               httpErrorHandle(
//                   response: res3,
//                   context: context,
//                   onSuccess: () async {
//                     image = res3.body.toString();
//                     print(image);
//                     Get.toNamed(
//                       '${RouteClass.home}/$token/$password/$username',
//                     );
//                   });
//             });
//       },
//     );
//   } catch (e) {
//     showSnackBar(context, e.toString());
//     Get.toNamed(
//       '${RouteClass.login}/${e}',
//     );
//   }

//   return Home(token: token, dataUser: dataMap, image: image);
// }
