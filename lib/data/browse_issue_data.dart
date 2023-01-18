import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:helpdesk_skripsi/routes/routes.dart';
import 'package:helpdesk_skripsi/util/returnAPI.dart';
import 'package:helpdesk_skripsi/util/utils.dart';
import 'package:http/http.dart' as http;

import '../model/browse_model.dart';

class getBrowseData {
  static Future<List<BrowseIssue>> browseData(
      {required BuildContext context,
      required String token,
      required String search}) async {
    String data = "";
    try {
      http.Response res = await http.post(
        Uri.parse('$baseURL/search/register'),
        body: jsonEncode({
          "topic": "helpdesk.browse.get",
          "message": {"_viewall": true},
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
            data = res.body;
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }

    return (json.decode(data) as List)
        .map((i) => BrowseIssue.fromMap(i))
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

  static Future<List<BrowseIssueDetail>> browseDetailData(
      {required BuildContext context,
      required String token,
      required String id}) async {
    String data = "";
    try {
      http.Response res = await http.post(
        Uri.parse('$baseURL/search/register'),
        body: jsonEncode({
          "topic": "helpdesk.issue.search",
          "message": {"id": id},
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
            data = res.body.toString();
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }

    return (json.decode(data) as List)
        .map((i) => BrowseIssueDetail.fromMap(i))
        .toList();
  }

  static Future<String> browseData2(
      {required BuildContext context, required String token}) async {
    String data = "";
    try {
      http.Response res = await http.post(
        Uri.parse('$baseURL/search/register'),
        body: jsonEncode({
          "topic": "helpdesk.browse.get",
          "message": {"_viewall": true},
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
            data = res.body;
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }

    return data;
  }
}
