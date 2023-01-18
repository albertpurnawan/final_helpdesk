import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:helpdesk_skripsi/util/utils.dart';
import 'package:http/http.dart' as http;

void httpErrorHandle({
  required http.Response response,
  required BuildContext context,
  required VoidCallback onSuccess,
}) {
  switch (response.statusCode) {
    case 200:
      onSuccess();
      break;
    case 503:
      showSnackBar(context, "503");
      break;
  }
}
