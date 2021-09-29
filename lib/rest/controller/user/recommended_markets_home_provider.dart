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
import 'package:beysion/rest/service/market/recommended_markets_service.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RecommendedMarketsHomeProvider with ChangeNotifier {

  List<MarketsHomeEntity>  _recommendedMarketsHomeEntityList = new List();

  List<MarketsHomeEntity> get recommendedMarketsHomeEntityList =>
      _recommendedMarketsHomeEntityList;

  set recommendedMarketsHomeEntityList(List<MarketsHomeEntity> value) {
    _recommendedMarketsHomeEntityList = value;
  }

  getRecommendedMarketsHomeController() async {
    SharedPreferences sharedPref = await SharedPreferences.getInstance();
    int abholService = 1;
    int lieferService = 1;
    recommendedMarketsHomeEntityList.clear();
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
    BaseResponse response = await RecommendedMarketsService.operations().marketsRecommended(plzZipCode, lieferService, abholService);
    try{
      if (response is OkResponse) {
        if (response.body != null) {
          if (response.body["data"] != null) {
            List<dynamic> dataList = response.body["data"];
            List<MarketsHomeEntity> newDataList = new List();
            for (var dataStr in dataList) {
              MarketsHomeEntity model = new MarketsHomeEntity.fromJson(dataStr);
              if (model != null) {
                newDataList.add(model);
                //print('Home Recommended Markets Data -- ${model.name}');
              }
            }
            recommendedMarketsHomeEntityList.addAll(newDataList);
            notifyListeners();
          }
        }
      }
    }catch(e){
      print('Exception Home Recommended Markets -- $e');
    }
  }
}
