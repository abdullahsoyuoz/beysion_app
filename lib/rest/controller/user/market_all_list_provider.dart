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
import 'package:beysion/rest/response_models/base_response.dart';
import 'package:beysion/rest/response_models/ok_response.dart';
import 'package:beysion/rest/service/market/market_category_service.dart';
import 'package:beysion/rest/service/market/markets_service.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MarketAllListProvider with ChangeNotifier {

  List<MarketsAllEntity>  _marketInformationDataList = new List();

  List<MarketsAllEntity> get marketInformationDataList =>
      _marketInformationDataList;

  set marketInformationDataList(List<MarketsAllEntity> value) {
    _marketInformationDataList = value;
  }

  int pageToNumber = 0;


  getMarketAllListController({String search=" ", int pageCount = -1, int orderCount=0, int abholService = 1, int lieferService = 1, bool filterStatus = false}) async {
    if (pageCount== -1){
      pageCount = 0;
      pageToNumber = 0;
      marketInformationDataList.clear();
    }else{
      pageToNumber++;
      pageCount = pageToNumber;
    }
    SharedPreferences sharedPref = await SharedPreferences.getInstance();
    String plzZipCode = "12801";
    if(sharedPref.containsKey("plzZipCode")){
      plzZipCode = sharedPref.getString("plzZipCode");
    }
    if(!filterStatus){
      if(sharedPref.containsKey("abholService")){
        abholService = sharedPref.getInt("abholService");
      }
      if(sharedPref.containsKey("lieferService")){
        lieferService = sharedPref.getInt("lieferService");
      }
    }
    String sessionToken = sharedPref.getString("sessionToken");
    BaseResponse response = await MarketsService.operations().allMarketsListInformation(plzZipCode, search, lieferService, abholService, sessionToken,page: pageCount, order: orderCount);
    try{
      if (response is OkResponse) {
        if (response.body != null) {
          if (response.body["data"] != null) {
            List<dynamic> dataList = response.body["data"];
            List<MarketsAllEntity>  listttt = new List();
            for (var dataStr in dataList) {
              MarketsAllEntity model = new MarketsAllEntity.fromJson(dataStr);
              listttt.add(model);
              if (model != null) {
                if ((marketInformationDataList.singleWhere((it) => it.id == model.id,
                    orElse: () => null)) != null) {
                } else {
                  marketInformationDataList.add(model);
                }
              }
            }

            notifyListeners();
          }else{
            marketInformationDataList.clear();
            notifyListeners();
          }
        }else{
          marketInformationDataList.clear();
          notifyListeners();
        }
      }else{
        marketInformationDataList.clear();
        notifyListeners();
      }
    }catch(e){
      print('Exception get All Market List Data -- $e');
    }
  }
}
