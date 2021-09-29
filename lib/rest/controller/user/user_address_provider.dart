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

import 'package:beysion/rest/entity/user/user_address_entity.dart';
import 'package:beysion/rest/response_models/base_response.dart';
import 'package:beysion/rest/response_models/ok_response.dart';
import 'package:beysion/rest/service/user_address_service.dart';
import 'package:flutter/material.dart';


class UserAddressProvider with ChangeNotifier {

  UserAddressEntity _getUserAddressData = new UserAddressEntity();

  List<UserAddressEntity> _userAddressList = new List();

  UserAddressEntity get getUserAddressData => _getUserAddressData;

  set getUserAddressData(UserAddressEntity value) {
    _getUserAddressData = value;
  }

  List<UserAddressEntity> get userAddressList => _userAddressList;

  set userAddressList(List<UserAddressEntity> value) {
    _userAddressList = value;
  }

  getUserAddressAllDataController() async {
    BaseResponse response = await UserAddressService.operations().addressAllData();
    try{
      if (response is OkResponse) {
        if (response.body != null) {
          if (response.body["data"] != null) {
            List<dynamic> dataList = response.body["data"];
            List<UserAddressEntity> newDataList = new List();
            for (var dataStr in dataList) {
              UserAddressEntity model = new UserAddressEntity.fromJson(dataStr);
              if (model != null) {
                newDataList.add(model);
                //print('MODEEEE ${model.id}');
              }
            }
            userAddressList.clear();
            userAddressList.addAll(newDataList);
            notifyListeners();
          }
        }
      }
    }catch(e){
      print('Exception UserAdressController Data -- $e');

    }
  }

  getUserAddressShowData(int addressId) async {
    getUserAddressData=null;
    BaseResponse response = await UserAddressService.operations().addressShowData(addressId);
    try{
      if (response is OkResponse) {
        if (response.body != null) {
          if (response.body["data"] != null) {
            UserAddressEntity model = new UserAddressEntity.fromJson(response.body["data"]);
            if (model != null) {
              getUserAddressData = model;
              notifyListeners();
            }
          }
        }
      }
    }catch(e){
      print('Exception User Address Data -- $e');
    }
  }
}
