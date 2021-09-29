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

import 'package:beysion/rest/entity/user/market/markets_home_entity.dart';
import 'package:beysion/rest/response_models/base_response.dart';
import 'package:beysion/rest/response_models/ok_response.dart';
import 'package:beysion/rest/service/market/markets_home_service.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MarketsHomeProvider with ChangeNotifier {

  List<MarketsHomeEntity>  _marketsHomeEntityList = new List();

  List<MarketsHomeEntity> get marketsHomeEntityList => _marketsHomeEntityList;

  set marketsHomeEntityList(List<MarketsHomeEntity> value) {
    _marketsHomeEntityList = value;
  }

  getMarketsHomeController({int orderCount = 0}) async {
    marketsHomeEntityList.clear();
    SharedPreferences sharedPref = await SharedPreferences.getInstance();
    int abholService = 1;
    int lieferService = 1;
    String plzZipCode = "12801";
    if(sharedPref.containsKey("plzZipCode")){
      plzZipCode = sharedPref.getString("plzZipCode");
    }
    if(sharedPref.containsKey("abholService")){
      abholService = sharedPref.getInt("abholService");
    }
    if(sharedPref.containsKey("lieferService")){
      lieferService = sharedPref.getInt("lieferService");
    }
    BaseResponse response = await MarketsHomeService.operations().marketsHome(plzZipCode, lieferService, abholService ,orderCount);
    try{
      if (response is OkResponse) {
        if (response.body != null) {
          if (response.body["data"] != null) {
            List<dynamic> dataList = response.body["data"];
            List<MarketsHomeEntity> marketDataList = new List();
            for (var dataStr in dataList) {
              MarketsHomeEntity model = new MarketsHomeEntity.fromJson(dataStr);
              if (model != null) {
                marketDataList.add(model);
                //print('Home Markets Data -- ${model.name}');
              }
            }
            marketsHomeEntityList.addAll(marketDataList);
            notifyListeners();
          }
        }
      }
    }catch(e){
      print('Exception Market Home Discount Products -- $e');
    }
  }
}
