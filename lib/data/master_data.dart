import 'package:flutter/cupertino.dart';
import 'package:helpdesk_skripsi/model/master_model.dart';
import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:helpdesk_skripsi/util/returnAPI.dart';
import 'package:helpdesk_skripsi/util/utils.dart';
import 'package:http/http.dart' as http;

class getMasterCategory {
  static Future<dataCategoryModel> dataCategory(
      {required BuildContext context,
      required String token,
      required String from,
      required String to}) async {
    late dataCategoryModel modelData;

    try {
      http.Response res = await http.post(
        Uri.parse('$baseURL/search/regiester'),
        body: jsonEncode({
          "topic": "helpdesk.qrh.category.get",
          "message": {},
          "headers": {}
        }),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'x-access-token': token
        },
      );
      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () async {
            print(res.body.toString());
            modelData = dataCategoryModel.fromMap(jsonDecode(res.body));
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }

    return modelData;
  }

  static Future<dataFilterModel> dataFilter(
      {required BuildContext context,
      required String token,
      required String from,
      required String to}) async {
    late dataFilterModel modelData;

    try {
      http.Response res = await http.post(
        Uri.parse('$baseURL/search/regiester'),
        body: jsonEncode(
            {"topic": "helpdesk.settings.get", "message": {}, "headers": {}}),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'x-access-token': token
        },
      );
      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () async {
            print(res.body.toString());
            modelData = dataFilterModel.fromMap(jsonDecode(res.body));
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }

    return modelData;
  }
}
