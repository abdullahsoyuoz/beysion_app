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
import 'dart:convert';
import 'package:beysion/rest/persistent.dart';
import 'package:http/http.dart' as http;

import 'response_models/base_response.dart';
import 'response_models/find_response.dart';

Future<BaseResponse> postRequest (String url, {dynamic model, String bearerToken}) async {
  Map<String,String> headers = new Map();
  headers["Content-Type"] = "application/json";
  if(bearerToken != null){
    headers["Authorization"] = "Bearer $bearerToken";
  }

  //print('URLLL $url');
  if(model!=null){
    Map<String,dynamic> _json = model.toJson();
    String encoded = json.encode(_json);
    return http.post(url,
      headers: headers,
      body: encoded
    ).then((http.Response response) {
      print("${response.statusCode} - Message {${response.body}");
      return FindResponse.control(response);
    });
  }else{
    return http.post(url,
      headers: headers,
    ).then((http.Response response) {
      print(response.statusCode);
      return FindResponse.control(response);
    });
  }


}