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

import 'package:beysion/rest/entity/user/basket/basket_send_data.dart';
import 'package:beysion/rest/entity/user/user_address_entity.dart';
import 'package:beysion/rest/entity/user/user_login_entity.dart';
import 'package:beysion/rest/persistent.dart';
import 'package:beysion/rest/post_request.dart';
import 'package:beysion/rest/response_models/base_response.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:beysion/constant/app_configurations.dart' as settingRepo;

import '../get_request.dart';
import 'crud_service.dart';

class UserAddressService extends CrudService<UserAddressEntity>{

  static UserAddressService operations(){
    return new UserAddressService();
  }


  Future<BaseResponse> addressShowData(int addressId) async {
    String bearerToken = settingRepo.currentUserTokenEntity.value.token;
    return await getRequest("$apiURL/client/address/show/$addressId", bearerToken: bearerToken);
  }

  Future<BaseResponse> addressAllData() async {
    String bearerToken = settingRepo.currentUserTokenEntity.value.token;
    return await getRequest("$apiURL/client/address/all", bearerToken: bearerToken);
  }

  Future<BaseResponse> updateAddress(UpdateAddressEntity addressEntity) async {
    String bearerToken = settingRepo.currentUserTokenEntity.value.token;
    return await postRequest("$apiURL/client/address/update", bearerToken: bearerToken, model: addressEntity);
  }

  Future<BaseResponse> addAddress(AddedAddressEntity addressEntity) async {
    String bearerToken = settingRepo.currentUserTokenEntity.value.token;
    return await postRequest("$apiURL/client/address/add", bearerToken: bearerToken,model: addressEntity);
  }

  Future<BaseResponse> deleteAddress(int addressId) async {
    String bearerToken = settingRepo.currentUserTokenEntity.value.token;
    return await postRequest("$apiURL/client/address/delete?id=$addressId", bearerToken: bearerToken);
  }

}

class UpdateAddressEntity extends Persistent{
  UpdateAddressEntity({
    this.addressId,
    this.address,
    this.name,
    this.firstname,
    this.lastname,
    this.phone,
    this.zipcode,
    this.defaultData,
  });

  int addressId;
  String name;
  String firstname;
  String lastname;
  String address;
  String phone;
  int zipcode;
  int defaultData;

  factory UpdateAddressEntity.fromJson(Map<String, dynamic> json) => UpdateAddressEntity(
    addressId: json["addressid"] == null ? null : json["addressid"],
    name: json["name"] == null ? null : json["name"],
    firstname: json["firstname"] == null ? null : json["firstname"],
    lastname: json["lastname"] == null ? null : json["lastname"],
    phone: json["phone"] == null ? null : json["phone"],
    address: json["address"] == null ? null : json["address"],
    zipcode: json["zipCode"] == null ? null : json["zipCode"],
    defaultData: json["default"] == null ? null : json["default"],
  );

  Map<String, dynamic> toJson() => {
    "addressid": addressId == null ? null : addressId,
    "name": name == null ? null : name,
    "firstname": firstname == null ? null : firstname,
    "lastname": lastname == null ? null : lastname,
    "phone": phone == null ? null : phone,
    "address": address == null ? null : address,
    "zipCode": zipcode == null ? null : zipcode,
    "default": defaultData == null ? null : defaultData,
  };
}

class AddedAddressEntity extends Persistent{
  AddedAddressEntity({
    this.address,
    this.name,
    this.firstname,
    this.lastname,
    this.phone,
    this.zipcode,
    this.defaultData,
  });

  String name;
  String firstname;
  String lastname;
  String address;
  String phone;
  int zipcode;
  int defaultData;

  factory AddedAddressEntity.fromJson(Map<String, dynamic> json) => AddedAddressEntity(
    name: json["name"] == null ? null : json["name"],
    firstname: json["firstname"] == null ? null : json["firstname"],
    lastname: json["lastname"] == null ? null : json["lastname"],
    phone: json["phone"] == null ? null : json["phone"],
    address: json["address"] == null ? null : json["address"],
    zipcode: json["zipCode"] == null ? null : json["zipCode"],
    defaultData: json["default"] == null ? null : json["default"],
  );

  Map<String, dynamic> toJson() => {
    "name": name == null ? null : name,
    "firstname": firstname == null ? null : firstname,
    "lastname": lastname == null ? null : lastname,
    "phone": phone == null ? null : phone,
    "address": address == null ? null : address,
    "zipCode": zipcode == null ? null : zipcode,
    "default": defaultData == null ? null : defaultData,
  };
}