import 'package:flutter/cupertino.dart';
import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:helpdesk_skripsi/model/ticket_pool_model.dart';
import 'package:helpdesk_skripsi/util/returnAPI.dart';
import 'package:helpdesk_skripsi/util/utils.dart';
import 'package:http/http.dart' as http;

class getTicketPool {
  static Future<List<TicketPoolModel>> ticket(
      {required BuildContext context,
      required String token,
      required String search,
      required String category}) async {
    String data = "";
    try {
      http.Response res = await http.post(
        Uri.parse('$baseURL/search/register'),
        body: jsonEncode({
          "topic": "helpdesk.issue.list",
          "message": {
            "supportcategory": category,
            "__viewall": true,
            "issue_pool_filter": []
          },
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
            print(category);
            data = res.body;
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }

    return (json.decode(data)[category] as List)
        .map((i) => TicketPoolModel.fromMap(i))
        .where((issue) {
      final docno = issue.docno.toString().toLowerCase();
      final createby = issue.createby.toString().toLowerCase();
      final createdate = issue.createdate.toString().toLowerCase();
      final description = issue.description.toString().toLowerCase();
      final status = issue.status.toString().toLowerCase();
      final supportcategory = issue.supportcategory.toString().toLowerCase();
      final searchLower = search.toLowerCase();

      return docno.contains(searchLower) ||
          createby.contains(searchLower) ||
          createdate.contains(searchLower) ||
          description.contains(searchLower) ||
          status.contains(searchLower) ||
          supportcategory.contains(searchLower);
    }).toList();
  }
}
