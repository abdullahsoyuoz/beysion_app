/*
 *  DO NOT ALTER OR REMOVE COPYRIGHT NOTICES OR THIS FILE HEADER.
 *
 *  Copyright (C) 2021 Rich Design - All Rights Reserved
 *  Unauthorized copying of this file, via any medium is strictly prohibited
 *  Proprietary and confidential.
 *
 *  Written by Yakup Zengin <yakup@designsrich.com>, March 2021
 *
 */


import 'package:http/http.dart' as http;
import 'dart:convert';

import 'bad_response.dart';
import 'base_response.dart';
import 'http_status_family.dart';
import 'ok_response.dart';

class FindResponse {
  static BaseResponse control(http.Response response) {
    int statusCode = response.statusCode;
    Map<String, dynamic> _jsonMap;
    if (response.body != null && response.body.isNotEmpty) {
      _jsonMap = json.decode(response.body);
    }
    String message = "";
    if (statusCode >= 100 && statusCode < 200) {
      message = HttpStatusFamily.INFORMATIONAL.toString();
    } else if (statusCode >= 200 && statusCode < 300) {
      message = HttpStatusFamily.SUCCESSFUL.toString();
    } else if (statusCode >= 300 && statusCode < 400) {
      message = HttpStatusFamily.REDIRECTION.toString();
    } else if (statusCode >= 400 && statusCode < 500) {
      message = HttpStatusFamily.CLIENT_ERROR.toString();
    } else if (statusCode >= 500 && statusCode < 600) {
      message = HttpStatusFamily.SERVER_ERROR.toString();
    } else {
      message = HttpStatusFamily.OTHER.toString();
    }

    if (statusCode < 200 || statusCode >= 400 || json == null) {
      BaseResponse responseBad = new BadResponse();
      if (_jsonMap != null && _jsonMap.isNotEmpty) {
        print(_jsonMap.toString());
        responseBad.body = _jsonMap;
      }
      responseBad.message = message;
      responseBad.statusCode = response.statusCode;
      return responseBad;
    } else {
      OkResponse responseOk = new OkResponse();
      if (_jsonMap != null && _jsonMap.isNotEmpty) {
        responseOk.body = _jsonMap;
      }
      responseOk.message = message;
      responseOk.statusCode = response.statusCode;
      return responseOk;
    }
  }
}
