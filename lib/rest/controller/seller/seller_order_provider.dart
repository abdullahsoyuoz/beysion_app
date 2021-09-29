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

import 'package:beysion/rest/entity/seller/seller_entity.dart';
import 'package:beysion/rest/entity/seller/seller_order_detail_entity.dart';
import 'package:beysion/rest/response_models/base_response.dart';
import 'package:beysion/rest/response_models/ok_response.dart';
import 'package:beysion/rest/service/seller/seller_service.dart';
import 'package:flutter/material.dart';


class SellerOrderProvider with ChangeNotifier {

  List<SellerOrderData> _sellerOrderList = new List();

  SellerOrderDetailEntity _sellerOrderDetailEntity = new SellerOrderDetailEntity();


  List<SellerOrderData> get sellerOrderList => _sellerOrderList;

  set sellerOrderList(List<SellerOrderData> value) {
    _sellerOrderList = value;
  }


  SellerOrderDetailEntity get sellerOrderDetailEntity =>
      _sellerOrderDetailEntity;

  set sellerOrderDetailEntity(SellerOrderDetailEntity value) {
    _sellerOrderDetailEntity = value;
  }

  int pageCount = 0;

  getSellerOrdersListDataController({int page=0, String orderCode, int status}) async {
    if(page==0){
      pageCount = 0;
      sellerOrderList.clear();
    }else{
      pageCount++;
      page = pageCount;
    }
    BaseResponse response = await SellerService.operations().orderList(page: page, orderCodeSearch: orderCode, status: status);
    try{
      if (response is OkResponse) {
        if (response.body != null) {
          if (response.body["data"] != null) {
            List<dynamic> dataList = response.body["data"]["orders"];
            for (var dataStr in dataList) {
              SellerOrderData model = new SellerOrderData.fromJson(dataStr);
              if (model != null) {
                if ((sellerOrderList.singleWhere((it) => it.ordercode == model.ordercode,
                    orElse: () => null)) != null) {
                } else {
                  sellerOrderList.add(model);
                  notifyListeners();
                }
              }
            }
            notifyListeners();
          }
        }
      }
    }catch(e){
      print('Exception Order List Data -- $e');
    }
  }

  getSellerOrderShowDataController(String orderCode) async {
    sellerOrderDetailEntity=null;
    BaseResponse response = await SellerService.operations().orderInformationData(orderCode);
    try{
      if (response is OkResponse) {
        if (response.body != null) {
          if (response.body["data"] != null) {
            SellerOrderDetailEntity model = new SellerOrderDetailEntity.fromJson(response.body["data"]);
            if (model != null) {
              sellerOrderDetailEntity = model;
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
