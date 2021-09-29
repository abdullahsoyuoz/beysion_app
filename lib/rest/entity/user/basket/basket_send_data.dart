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

import 'package:beysion/rest/persistent.dart';

class BasketSendData extends Persistent{
  BasketSendData({
    this.token,
    this.lieferService,
    this.abholService,
    this.plz,
    this.addressType1,
    this.addressType2,
    this.paymentType,
    this.basketSelect,
  });

  String token;
  int lieferService;
  int abholService;
  int plz;
  int addressType1;
  int addressType2;
  int paymentType;
  List<BasketProductSelect> basketSelect;

  factory BasketSendData.fromJson(Map<String, dynamic> json) => BasketSendData(
    basketSelect: json["basketSelect"] == null ? null : List<BasketProductSelect>.from(json["basketSelect"].map((x) => BasketProductSelect.fromJson(x))),
    token: json["_token"] == null ? null : json["_token"],
    lieferService: json["lieferservice"] == null ? null : json["lieferservice"],
    abholService: json["abholservice"] == null ? null : json["abholservice"],
    plz: json["plz"] == null ? null : json["plz"],
    addressType1: json["addressType1"] == null ? null : json["addressType1"],
    addressType2: json["addressType2"] == null ? null : json["addressType2"],
    paymentType: json["paymentType"] == null ? null : json["paymentType"],
  );

  Map<String, dynamic> toJson() => {
    "basketSelect": basketSelect == null ? null : List<dynamic>.from(basketSelect.map((x) => x.toJson())),
    "_token": token == null ? null : token,
    "lieferservice": lieferService == null ? null : lieferService,
    "abholservice": abholService == null ? null : abholService,
    "plz": plz == null ? null : plz,
    "addressType1": addressType1 == null ? null : addressType1,
    "addressType2": addressType2 == null ? null : addressType2,
    "paymentType": paymentType == null ? null : paymentType,
  };
}

class BasketProductSelect {
  BasketProductSelect({
    this.mid,
    this.serviceType,
    this.time,
  });

  int mid;
  int serviceType;
  String time;

  factory BasketProductSelect.fromJson(Map<String, dynamic> json) => BasketProductSelect(
    mid: json["mid"] == null ? null : json["mid"],
    serviceType: json["serviceType"] == null ? null : json["serviceType"],
    time: json["time"] == null ? null : json["time"],
  );

  Map<String, dynamic> toJson() => {
    "mid": mid == null ? null : mid,
    "serviceType": serviceType == null ? null : serviceType,
    "time": time == null ? null : time,
  };
}