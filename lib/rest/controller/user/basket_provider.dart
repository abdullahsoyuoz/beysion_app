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

import 'package:beysion/rest/entity/user/basket/basket_detail_entity.dart';
import 'package:beysion/rest/entity/user/basket/basket_summary_entity.dart';
import 'package:beysion/rest/response_models/base_response.dart';
import 'package:beysion/rest/response_models/ok_response.dart';
import 'package:beysion/rest/service/basket/basket_service.dart';
import 'package:beysion/rest/service/basket/basket_summary_service.dart';
import 'package:flutter/material.dart';
import 'package:beysion/constant/app_configurations.dart' as settingRepo;

class BasketProvider with ChangeNotifier {

  BasketDetailEntity _basketDetailEntity = new BasketDetailEntity();

  BasketDetailEntity get basketDetailEntity => _basketDetailEntity;

  set basketDetailEntity(BasketDetailEntity value) {
    _basketDetailEntity = value;
  }

  BasketSummaryEntity _basketSummaryEntity = new BasketSummaryEntity();

  BasketSummaryEntity get basketSummaryEntity => _basketSummaryEntity;

  set basketSummaryEntity(BasketSummaryEntity value) {
    _basketSummaryEntity = value;
  }

  getBasketDetailDataController() async {
    BaseResponse response = await BasketService.operations().basketGetDetail();
    try{
      if (response is OkResponse) {
        if (response.body != null) {
          BasketDetailEntity model = new BasketDetailEntity.fromJson(response.body);
          if (model != null) {
            basketDetailEntity = model;
            try{
              if(basketDetailEntity.basketMarketDataList.length<1){
                settingRepo.selectBasketItemId.value = Map();
              }
            }catch(e){
              print('Detail Basket Count Exception - $e');
            }
            getBasketSummaryData();
            notifyListeners();
          }
        }else{
          settingRepo.selectBasketItemId.value = Map();
          basketDetailEntity = new BasketDetailEntity();
          notifyListeners();
        }
      }else{
        settingRepo.selectBasketItemId.value = Map();
        basketDetailEntity = new BasketDetailEntity();
        notifyListeners();
      }
    }catch(e){
      print('Exception Basket Detail Data -- $e');
    }
  }

  getBasketSummaryData() async {
    BaseResponse response = await BasketSummaryService.operations().basketSummary();
    try{
      if (response is OkResponse) {
        if (response.body != null) {
          BasketSummaryEntity model = new BasketSummaryEntity.fromJson(response.body);
          if (model != null) {
            basketSummaryEntity = model;
            // print('Summary List Data -- ${model.name}');
            notifyListeners();
          }
        }else{
          basketSummaryEntity = new BasketSummaryEntity();
          notifyListeners();
        }
      }else{
        basketSummaryEntity = new BasketSummaryEntity();
        notifyListeners();
      }
    }catch(e){
      print('Exception Basket Summary data -- $e');
    }
  }
}
