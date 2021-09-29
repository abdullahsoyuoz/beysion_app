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
import 'package:beysion/rest/service/product/product_all_service.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:beysion/rest/service/session_create_service.dart';
import 'package:beysion/constant/app_configurations.dart' as settingRepo;

class ProductAllProvider with ChangeNotifier {

  List<ProductEntity> _productAllList = new List();

  int pageToNumber = 1;
  int categoryIdMain=0;
  int orderIdMain=0;

  List<ProductEntity> get productAllList => _productAllList;

  set productAllList(List<ProductEntity> value) {
    _productAllList = value;
  }

  getProductAllList({int categoryId = 0, int pageNumber=1, int orderId = 0, String search =""}) async {
    if(pageNumber==1){
      productAllList.clear();
    }else{
      pageToNumber++;
      pageNumber = pageToNumber;
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
                BaseResponse response = await ProductAllService.operations().allProducts(categoryId,search,plzZipCode,sessionCreateEntity.result.session,lieferService,abholService,page: pageNumber,order: orderId);
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
                            print('Product AllList Data -- ${model.name}');
                          }
                        }

                        productAllList.addAll(newDataList);
                        notifyListeners();
                      }
                    }
                  }
                }catch(e){
                  print('Exception  Product All List -  $e');
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
      print('SESSİON TOKEN - $sessionToken');
      BaseResponse response = await ProductAllService.operations().allProducts(categoryId,search,plzZipCode,sessionToken,lieferService,abholService,page: pageNumber,order: orderId);
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
                  //print('Product All List Data -- ${model.name}');
                }
              }
              productAllList.addAll(newDataList);
              notifyListeners();
            }
          }
        }
      }catch(e){
        print('Exception  Product All List -  $e');
      }
    }
  }
}
