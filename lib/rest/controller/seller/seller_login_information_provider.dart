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

import 'dart:convert';

import 'package:beysion/rest/entity/seller/seller_login_entity.dart';
import 'package:beysion/rest/response_models/base_response.dart';
import 'package:beysion/rest/response_models/ok_response.dart';
import 'package:beysion/rest/service/seller/seller_service.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:beysion/constant/app_configurations.dart' as settingRepo;


class SellerLoginInformationProvider with ChangeNotifier {

  getSellerLoginController(String email, String password) async {
    BaseResponse response = await SellerService.operations().sellerLoginService(email, password);
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    try{
      if (response is OkResponse) {
        if (response.body != null) {
          if (response.body["response"] == "success") {
            if (response.body["result"] != null) {
              SellerLoginEntity tokenEntity = new SellerLoginEntity.fromJson(response.body["result"]);
              if(tokenEntity!=null){
                sharedPreferences.setString("sellerLoginEntity", json.encode(tokenEntity.toJson()));
                settingRepo.sellerLoginInformationEntity.value = tokenEntity;
              }
            }
          }
        }
      }
    }catch(e){
      print('Exception Create Session -- $e');
    }
  }
}
