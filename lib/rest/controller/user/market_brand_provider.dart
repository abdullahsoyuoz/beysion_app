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

import 'package:beysion/rest/entity/user/market/market_brand_entity.dart';
import 'package:beysion/rest/entity/user/market/market_category_entity.dart';
import 'package:beysion/rest/response_models/base_response.dart';
import 'package:beysion/rest/response_models/ok_response.dart';
import 'package:beysion/rest/service/market/market_brand_service.dart';
import 'package:beysion/rest/service/market/market_category_service.dart';
import 'package:flutter/material.dart';

class MarketBrandProvider with ChangeNotifier {

  List<MarketBrandEntity>  _marketBrandList = new List();

  List<MarketBrandEntity>  _allMarketBrandsList = new List();

  List<MarketBrandEntity> get allMarketBrandsList => _allMarketBrandsList;

  set allMarketBrandsList(List<MarketBrandEntity> value) {
    _allMarketBrandsList = value;
  }

  List<MarketBrandEntity> get marketBrandList => _marketBrandList;

  set marketBrandList(List<MarketBrandEntity> value) {
    _marketBrandList = value;
  }

  getMarketInBrandsController({int marketId = 1}) async {
    BaseResponse response = await MarketBrandService.operations().marketInBrands(marketId);
    try{
      if (response is OkResponse) {
        if (response.body != null) {
          if (response.body["data"] != null) {
            List<dynamic> dataList = response.body["data"];
            List<MarketBrandEntity> newDataList = new List();
            for (var dataStr in dataList) {
              MarketBrandEntity model = new MarketBrandEntity.fromJson(dataStr);
              if (model != null) {
                model.checkData = false;
                newDataList.add(model);
                print('Markets Brand Data -- ${model.name}');
              }
            }
            marketBrandList.addAll(newDataList);
            notifyListeners();
          }
        }
      }
    }catch(e){
      print('Exception Market Brand -- $e');
    }
  }

  getAllBrandsController() async {
    BaseResponse response = await MarketBrandService.operations().marketBrandsList();
    try{
      if (response is OkResponse) {
        if (response.body != null) {
          if (response.body["data"] != null) {
            List<dynamic> dataList = response.body["data"];
            List<MarketBrandEntity> newDataList = new List();
            for (var dataStr in dataList) {
              MarketBrandEntity model = new MarketBrandEntity.fromJson(dataStr);
              if (model != null) {
                model.checkData = false;
                newDataList.add(model);
                //print('Markets All Brand Data -- ${model.name}');
              }
            }
            allMarketBrandsList.clear();
            allMarketBrandsList.addAll(newDataList);
            notifyListeners();
          }
        }
      }
    }catch(e){
      print('Exception Market Brand -- $e');
    }
  }
}
