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
import 'package:beysion/rest/entity/user/user_address_entity.dart';
import 'package:beysion/rest/entity/user/user_favorite_entity.dart';
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


class UserFavoriteProvider with ChangeNotifier {

  List<UserFavoriteEntity> _userFavoriteList = new List();

  List<UserFavoriteEntity> get userFavoriteList => _userFavoriteList;

  set userFavoriteList(List<UserFavoriteEntity> value) {
    _userFavoriteList = value;
  }

  getUserFavoriteListDataController() async {
    userFavoriteList.clear();
    BaseResponse response = await UserService.operations().userFavoriteAll();
    try{
      if (response is OkResponse) {
        if (response.body != null) {
          if (response.body["data"] != null) {
            List<dynamic> dataList = response.body["data"];
            List<UserFavoriteEntity> newDataList = new List();
            for (var dataStr in dataList) {
              UserFavoriteEntity model = new UserFavoriteEntity.fromJson(dataStr);
              if (model != null) {
                newDataList.add(model);
                // print('Markets List Data -- ${model.name}');
              }
            }
            userFavoriteList.addAll(newDataList);
            notifyListeners();
          }
        }
      }
    }catch(e){
      print('Exception User Favorite List Data -- $e');
    }
  }
}
