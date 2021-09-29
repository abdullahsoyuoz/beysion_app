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

import 'dart:async';
import 'package:http/http.dart' as http;

import 'response_models/base_response.dart';
import 'response_models/find_response.dart';

Future<BaseResponse> putRequest (String url) async {

  Map<String,String> headers = new Map();
  headers["Content-Type"] = "application/json";

  return http.put(url,
    headers: headers,
  ).then((http.Response response) {
    print(response.statusCode);
    return FindResponse.control(response);
  });
}