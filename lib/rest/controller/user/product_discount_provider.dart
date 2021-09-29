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

import 'package:beysion/rest/entity/user/product_entity.dart';
import 'package:beysion/rest/entity/user/session_create_entity.dart';
import 'package:beysion/rest/response_models/base_response.dart';
import 'package:beysion/rest/response_models/ok_response.dart';
import 'package:beysion/rest/service/product/product_discounted_service.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:beysion/rest/service/session_create_service.dart';
import 'package:beysion/constant/app_configurations.dart' as settingRepo;

class ProductDiscountProvider with ChangeNotifier {

  List<ProductEntity> _productDiscountedList = new List();

  int pageToNumber = 1;
  int categoryIdMain=0;
  int marketIdMain=0;

  List<ProductEntity> get productDiscountedList =>
      _productDiscountedList;

  set productDiscountedList(List<ProductEntity> value) {
    _productDiscountedList = value;
  }

  getProductDiscountController({int categoryId = 0, int marketId=0, int pageNumber=1, int pageUserStatus = 0}) async {
    if(pageNumber==1){
      productDiscountedList.clear();
    }
    if(categoryId!=0 && marketId!=0){
      categoryIdMain = categoryId;
      marketIdMain = marketId;
      marketId = marketIdMain;
      categoryId = categoryIdMain;
    }


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
    if(!sharedPref.containsKey("sessionToken")){
      BaseResponse response = await SessionCreateService.operations().sessionCreate();
      try{
        if (response is OkResponse) {
          if (response.body != null) {
            if (response.body["result"] != null) {
              SessionCreateEntity sessionCreateEntity = new SessionCreateEntity.fromJson(response.body);
              if(sessionCreateEntity!=null){
                sharedPref.setString("sessionToken", sessionCreateEntity.result.session);
                settingRepo.sessionToken.value = sessionCreateEntity.result.session;
                BaseResponse response = await ProductDiscountedService.operations().productDiscounted(plzZipCode, abholService, lieferService, categoryId,marketId, sessionCreateEntity.result.session, page: pageNumber);
                try{
                  if (response is OkResponse) {
                    if (response.body != null) {
                      if (response.body["data"] != null) {
                        List<dynamic> dataList = response.body["data"];
                        List<ProductEntity> newDataList = new List();
                        for (var dataStr in dataList) {
                          ProductEntity model = new ProductEntity.fromJson(dataStr);
                          if (model != null) {
                            newDataList.add(model);
                            //print('Home Product Discount Data -- ${model.name}');
                          }
                        }
                        productDiscountedList.addAll(newDataList);
                        notifyListeners();
                      }
                    }
                  }
                }catch(e){
                  print('Exception  Product Discounted -  $e');
                }
              }
            }
          }
        }
      }catch(e){
        print('Exception Create Session -- $e');
      }
    }else{
      String sessionToken = sharedPref.getString("sessionToken");
      settingRepo.sessionToken.value = sessionToken;
      BaseResponse response = await ProductDiscountedService.operations().productDiscounted(plzZipCode, abholService, lieferService, categoryId,marketId, sessionToken, page: pageNumber);
      try{
        if (response is OkResponse) {
          if (response.body != null) {
            if (response.body["data"] != null) {
              List<dynamic> dataList = response.body["data"];
              List<ProductEntity> newDataList = new List();
              for (var dataStr in dataList) {
                ProductEntity model = new ProductEntity.fromJson(dataStr);
                if (model != null) {
                  newDataList.add(model);
                //  print('ANASAYFA IDD --$noId --> ${model.id}');
                 //print('Home Product Discount Data -- ${model.name} -- idd ${model.id} -- veee favoritee ${model.favStatus}');
                }
              }
              productDiscountedList.addAll(newDataList);
              notifyListeners();
            }
          }
        }
      }catch(e){
        print('Exception  Product Discounted -  $e');
      }
    }
  }
}
