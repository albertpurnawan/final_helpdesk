import 'package:flutter/cupertino.dart';
import 'package:helpdesk_skripsi/model/report_model.dart';
import 'dart:async';
import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:helpdesk_skripsi/util/returnAPI.dart';
import 'package:helpdesk_skripsi/util/utils.dart';
import 'package:http/http.dart' as http;

class getDataReport {
  static Future<List<ReportModel>> dataReport(
      {required BuildContext context,
      required String token,
      required String from,
      required String to}) async {
    List<ReportModel> modelData = [];

    try {
      http.Response res = await http.post(
        Uri.parse('$baseURL/search/regiester'),
        body: jsonEncode(
          {
            "topic": "helpdesk.report.get",
            "message": {
              "from": "2023-01-11",
              "to": "2023-01-11",
              "viewall": true
            },
            "headers": {}
          },
        ),
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
            modelData = (json.decode(res.body) as List)
                .map((i) => ReportModel.fromMap(i))
                .toList();
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }

    return modelData;
  }
}
