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

import 'package:beysion/rest/entity/user/user_oder_detail_entity.dart';
import 'package:beysion/rest/entity/user/user_order_entity.dart';
import 'package:beysion/rest/response_models/base_response.dart';
import 'package:beysion/rest/response_models/ok_response.dart';
import 'package:beysion/rest/service/user_service.dart';
import 'package:flutter/material.dart';


class UserOrderProvider with ChangeNotifier {

  List<UserOrderEntity> _userOrderList = new List();

  UserOrderDetailEntity _userOrderDetailEntity = new UserOrderDetailEntity();

  List<UserOrderEntity> get userOrderList => _userOrderList;

  set userOrderList(List<UserOrderEntity> value) {
    _userOrderList = value;
  }

  UserOrderDetailEntity get userOrderDetailEntity => _userOrderDetailEntity;

  set userOrderDetailEntity(UserOrderDetailEntity value) {
    _userOrderDetailEntity = value;
  }

  int pageCount = 0;

  getOrdersListDataController({int page=0}) async {
    if(page==0){
      pageCount=0;
      userOrderList.clear();
    }else{
      pageCount++;
      page = pageCount;
    }
    BaseResponse response = await UserService.operations().orderList(page: page,perPage: 5);
    try{
      if (response is OkResponse) {
        if (response.body != null) {
          if (response.body["data"] != null) {
            List<dynamic> dataList = response.body["data"]["orders"];
            List<UserOrderEntity> newDataList = new List();
            for (var dataStr in dataList) {
              UserOrderEntity model = new UserOrderEntity.fromJson(dataStr);
              if (model != null) {
                newDataList.add(model);
              }
            }
            userOrderList.addAll(newDataList);
            notifyListeners();
          }
        }
      }
    }catch(e){
      print('Exception Order List Data -- $e');
    }
  }

  getUserOrderShowDataController(String orderCode) async {
    userOrderDetailEntity=null;
    BaseResponse response = await UserService.operations().orderInformationData(orderCode);
    try{
      if (response is OkResponse) {
        if (response.body != null) {
          if (response.body["data"] != null) {
            UserOrderDetailEntity model = new UserOrderDetailEntity.fromJson(response.body["data"]);
            if (model != null) {
              userOrderDetailEntity = model;
              notifyListeners();
            }
          }
        }
      }
    }catch(e){
      print('Exception Order Show Data -- $e');
    }
  }
}
