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
import 'package:beysion/rest/response_models/base_response.dart';
import 'package:beysion/rest/response_models/ok_response.dart';
import 'package:beysion/rest/service/market/market_category_service.dart';
import 'package:beysion/rest/service/market/markets_service.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MarketListProvider with ChangeNotifier {

  List<MarketListEntity>  _marketDataList = new List();

  List<MarketListEntity> get marketDataList => _marketDataList;

  set marketDataList(List<MarketListEntity> value) {
    _marketDataList = value;
  }

  getMarketListController() async {
    marketDataList.clear();
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
    BaseResponse response = await MarketsService.operations().allMarketList(plzZipCode, lieferService, abholService);
    try{
      if (response is OkResponse) {
        if (response.body != null) {
          if (response.body["data"] != null) {
            List<dynamic> dataList = response.body["data"];
            List<MarketListEntity> newDataList = new List();
            MarketListEntity marketListNewEntity = new MarketListEntity(id: 0,name: "Alle Märkte");
            newDataList.add(marketListNewEntity);
            for (var dataStr in dataList) {
              MarketListEntity model = new MarketListEntity.fromJson(dataStr);
              if (model != null) {
                newDataList.add(model);
               // print('Markets List Data -- ${model.name}');
              }
            }
            marketDataList.addAll(newDataList);
            notifyListeners();
          }
        }
      }
    }catch(e){
      print('Exception Market List Data -- $e');
    }
  }
}
