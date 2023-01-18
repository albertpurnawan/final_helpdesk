import 'dart:async';
import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

import 'package:helpdesk_skripsi/model/showstatus_model.dart';

import 'package:helpdesk_skripsi/util/returnAPI.dart';
import 'package:helpdesk_skripsi/util/utils.dart';
import 'package:http/http.dart' as http;

class AllShowStatus {
  static Future<List<ShowStatusModel>> dataAll(
      {required BuildContext context,
      required String id,
      required String token}) async {
    List<ShowStatusModel> modelData = [];

    try {
      http.Response res = await http.post(
        Uri.parse('https://api.mayora.co.id/v1/myrapi/Joblist/GetShowStatus'),
        body: jsonEncode({
          "docno": id,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
      );
      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () async {
            modelData = (json.decode(res.body) as List)
                .map((i) => ShowStatusModel.fromMap(i))
                .toList();
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }

    return modelData;
  }

  static Future<ShowStatusModel> dataUsername(
      {required BuildContext context,
      required String id,
      required String token,
      required String username}) async {
    String data = "";

    try {
      http.Response res = await http.get(
        Uri.parse(
            'https://api.mayora.co.id/qas/master/user?username=$username'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'x-access-token': token
        },
      );
      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () async {
            data = res.body.toString();
            print(data);
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return ShowStatusModel.fromMap(json.decode(data)['data']);
  }

  static Future<List<ShowStatusModel>> dataCurrent(
      {required BuildContext context,
      required String id,
      required String token}) async {
    List<ShowStatusModel> modelData = [];

    try {
      http.Response res = await http.post(
        Uri.parse('https://api.mayora.co.id/v1/myrapi/Joblist/GetCurrentLines'),
        body: jsonEncode({
          "docno": id,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
      );
      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () async {
            modelData = (json.decode(res.body) as List)
                .map((i) => ShowStatusModel.fromMap(i))
                .toList();
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return modelData;
  }
}
