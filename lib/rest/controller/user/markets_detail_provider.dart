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

import 'package:beysion/rest/entity/user/market/market_detail_entity.dart';
import 'package:beysion/rest/response_models/base_response.dart';
import 'package:beysion/rest/response_models/ok_response.dart';
import 'package:beysion/rest/service/market/market_detail_service.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MarketDetailProvider with ChangeNotifier {

  MarketDetailEntity  _marketsDetailEntity = new MarketDetailEntity();

  MarketDetailEntity get marketsDetailEntity => _marketsDetailEntity;

  set marketsDetailEntity(MarketDetailEntity value) {
    _marketsDetailEntity = value;
  }

  getMarketDetailController(int marketId) async {
    marketsDetailEntity = null;
    notifyListeners();
    SharedPreferences sharedPref = await SharedPreferences.getInstance();
    int abholService = 1;
    int lieferService = 1;
    if(sharedPref.containsKey("abholService")){
      abholService = sharedPref.getInt("abholService");
    }
    if(sharedPref.containsKey("lieferService")){
      lieferService = sharedPref.getInt("lieferService");
    }
    try{
      BaseResponse response = await MarketDetailService.operations().marketDetail(marketId, lieferService, abholService);
      if (response is OkResponse) {
        if (response.body != null) {
          if (response.body["data"] != null) {
            MarketDetailEntity model = new MarketDetailEntity.fromJson(response.body["data"]);
            if (model != null) {
              marketsDetailEntity = model;
              notifyListeners();
            }
          }
        }
      }
    }catch(e){
      print('Exception Market Home Discount Products dETAİL -- $e');
    }
  }
}
