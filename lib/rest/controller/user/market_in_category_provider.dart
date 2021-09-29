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
import 'package:beysion/rest/response_models/base_response.dart';
import 'package:beysion/rest/response_models/ok_response.dart';
import 'package:beysion/rest/service/market/market_category_service.dart';
import 'package:flutter/material.dart';

class MarketInCategoryProvider with ChangeNotifier {

  List<MarketCategoryEntity>  _marketCategoryList = new List();

  List<MarketCategoryEntity>  _marketNotAlleList = new List();

  List<MarketCategoryEntity> get marketNotAlleList => _marketNotAlleList;

  set marketNotAlleList(List<MarketCategoryEntity> value) {
    _marketNotAlleList = value;
  }

  List<MarketCategoryEntity> get marketCategoryList => _marketCategoryList;

  set marketCategoryList(List<MarketCategoryEntity> value) {
    _marketCategoryList = value;
  }

  getMarketInCategoryListController(int marketId) async {
    marketCategoryList.clear();
    marketNotAlleList.clear();
    BaseResponse response = await MarketCategoryService.operations().marketInCategories(marketId);
    try{
      if (response is OkResponse) {
        if (response.body != null) {
          if (response.body["data"] != null) {
            List<dynamic> dataList = response.body["data"];
            List<MarketCategoryEntity> newDataList = new List();
            List<MarketCategoryEntity> newNotAlleList = new List();
            MarketCategoryEntity marketCategoryEntityFirst = new MarketCategoryEntity(id: 0,name: "Alle Kategorien");
            newDataList.add(marketCategoryEntityFirst);
            for (var dataStr in dataList) {
              MarketCategoryEntity model = new MarketCategoryEntity.fromJson(dataStr);
              if (model != null) {
                newDataList.add(model);
                //print('Markets Category List Data -- ${model.name}');
              }
            }

            for (var dataStr in dataList) {
              MarketCategoryEntity modelAlleNot = new MarketCategoryEntity.fromJson(dataStr);
              if (modelAlleNot != null) {
                newNotAlleList.add(modelAlleNot);
                //print('Markets Category List Data -- ${model.name}');
              }
            }
            marketNotAlleList.addAll(newNotAlleList);
            marketCategoryList.addAll(newDataList);
            notifyListeners();
          }
        }
      }
    }catch(e){
      print('Exception Market Category -- $e');
    }
  }
}
