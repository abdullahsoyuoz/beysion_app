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
import 'package:beysion/rest/service/market/market_category_service.dart';
import 'package:beysion/rest/service/product/product_all_service.dart';
import 'package:flutter/material.dart';

class ProductAllBrandsProvider with ChangeNotifier {

  List<MarketBrandEntity>  _allBrandsList = new List();

  List<MarketBrandEntity> get allBrandsList => _allBrandsList;

  set allBrandsList(List<MarketBrandEntity> value) {
    _allBrandsList = value;
  }

  getProductAllBrandsController() async {
    allBrandsList.clear();
    BaseResponse response = await ProductAllService.operations().allBrands();
    try{
      if (response is OkResponse) {
        if (response.body != null) {
          if (response.body["data"] != null) {
            List<dynamic> dataList = response.body["data"];
            List<MarketBrandEntity> newDataList = new List();
            MarketBrandEntity entityFirst = new MarketBrandEntity(id: 0,name: "Alle Kategorien");
            newDataList.add(entityFirst);
            for (var dataStr in dataList) {
              MarketBrandEntity model = new MarketBrandEntity.fromJson(dataStr);
              if (model != null) {
                newDataList.add(model);
                //print('Markets Category List Data -- ${model.name}');
              }
            }
            allBrandsList.addAll(newDataList);
            notifyListeners();
          }
        }
      }
    }catch(e){
      print('Exception Market Category -- $e');
    }
  }
}
