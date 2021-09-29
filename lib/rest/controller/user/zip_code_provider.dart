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
import 'package:beysion/rest/entity/user/zip_code_entity.dart';
import 'package:beysion/rest/response_models/base_response.dart';
import 'package:beysion/rest/response_models/ok_response.dart';
import 'package:beysion/rest/service/market/market_category_service.dart';
import 'package:beysion/rest/service/market/markets_service.dart';
import 'package:beysion/rest/service/zip_code_service.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class ZipCodeProvider with ChangeNotifier {

  List<ZipCodeEntity>  _zipCodeList = new List();

  List<ZipCodeEntity> get zipCodeList => _zipCodeList;

  set zipCodeList(List<ZipCodeEntity> value) {
    _zipCodeList = value;
  }

  getAllZipCodeListController(String search) async {
    _zipCodeList.clear();
    try{
      BaseResponse response = await ZipCodeService.operations().zipCodeSearch(search);
      if (response is OkResponse) {
        if (response.body != null) {
          if (response.body["data"] != null) {
            List<dynamic> dataList = response.body["data"];
            List<ZipCodeEntity> newDataList = new List();
            for (var dataStr in dataList) {
              ZipCodeEntity model = new ZipCodeEntity.fromJson(dataStr);
              if (model != null) {
                newDataList.add(model);
              }
            }
            zipCodeList.addAll(newDataList);
            notifyListeners();
          }
        }
      }
    }catch(e){
      print('Exception get Zip Code List Data -- $e');
    }
  }
}
