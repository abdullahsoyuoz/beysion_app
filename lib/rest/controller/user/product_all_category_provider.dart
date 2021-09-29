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
import 'package:beysion/rest/service/product/product_all_service.dart';
import 'package:flutter/material.dart';

class ProductAllCategoryProvider with ChangeNotifier {

  List<MarketCategoryEntity>  _allCategoryList = new List();

  List<MarketCategoryEntity> get allCategoryList => _allCategoryList;

  set allCategoryList(List<MarketCategoryEntity> value) {
    _allCategoryList = value;
  }

  getProductAllCategoriesController() async {
    allCategoryList.clear();
    BaseResponse response = await ProductAllService.operations().allCategories();
    try{
      if (response is OkResponse) {
        if (response.body != null) {
          if (response.body["data"] != null) {
            List<dynamic> dataList = response.body["data"];
            List<MarketCategoryEntity> newDataList = new List();
            MarketCategoryEntity marketCategoryEntityFirst = new MarketCategoryEntity(id: 0,name: "Alle Kategorien");
            newDataList.add(marketCategoryEntityFirst);
            for (var dataStr in dataList) {
              MarketCategoryEntity model = new MarketCategoryEntity.fromJson(dataStr);
              if (model != null) {
                newDataList.add(model);
                //print('Markets Category List Data -- ${model.name}');
              }
            }
            allCategoryList.addAll(newDataList);
            notifyListeners();
          }
        }
      }
    }catch(e){
      print('Exception Market Category -- $e');
    }
  }
}
