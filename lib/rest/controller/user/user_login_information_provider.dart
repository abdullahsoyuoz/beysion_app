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

import 'package:beysion/rest/entity/user/market/market_category_entity.dart';
import 'package:beysion/rest/entity/user/market/market_list_entity.dart';
import 'package:beysion/rest/entity/user/market/markets_all_entity.dart';
import 'package:beysion/rest/entity/user/user_login_entity.dart';
import 'package:beysion/rest/entity/user/zip_code_entity.dart';
import 'package:beysion/rest/response_models/base_response.dart';
import 'package:beysion/rest/response_models/ok_response.dart';
import 'package:beysion/rest/service/market/market_category_service.dart';
import 'package:beysion/rest/service/market/markets_service.dart';
import 'package:beysion/rest/service/user_service.dart';
import 'package:beysion/rest/service/zip_code_service.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class UserLoginInformationProvider with ChangeNotifier {

  UserLoginInformationEntity _userLoginInformationEntity = new UserLoginInformationEntity();

  UserLoginInformationEntity get userLoginInformationEntity =>
      _userLoginInformationEntity;

  set userLoginInformationEntity(UserLoginInformationEntity value) {
    _userLoginInformationEntity = value;
  }

  getUserInformationDataController() async {
    try{
      BaseResponse response = await UserService.operations().userInformationShow();
      if (response is OkResponse) {
        if (response.body != null) {
          if(response.body['status']){
            if (response.body["data"] != null) {
              UserLoginInformationEntity model = new UserLoginInformationEntity.fromJson(response.body["data"]);
              if (model != null) {
                //print('USER LOGİN INFORMATİON --- ${model.name} ${model.surname}');
                userLoginInformationEntity = model;
                notifyListeners();
              }
            }
          }
        }
      }
    }catch(e){
      print('Exception User Information Data -- $e');
    }
  }
}
