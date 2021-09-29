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
import '../rest/response_models/base_response.dart';
import 'package:http/http.dart' as http;

import 'response_models/find_response.dart';

Future<BaseResponse> getRequest (String url, {String bearerToken}) async {
  Map<String,String> headers = new Map();
  headers["Content-Type"] = "application/json";

  if(bearerToken != null){
    headers["Authorization"] = "Bearer $bearerToken";
  }

  return http.get(url,
    headers: headers
  ).then((http.Response response) {
    return FindResponse.control(response);
  });
}