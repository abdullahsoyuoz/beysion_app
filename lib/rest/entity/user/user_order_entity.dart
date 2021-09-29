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


import 'dart:convert';

import '../../persistent.dart';



class UserOrderEntity extends Persistent{
  UserOrderEntity({
    this.ordercode,
    this.createdAt,
    this.name,
    this.deliveryType,
    this.deliveryTime,
    this.deliveryTime2,
    this.totalItem,
    this.total,
    this.status,
    this.cargoPrice,
  });

  String ordercode;
  DateTime createdAt;
  String name;
  int deliveryType;
  DateTime deliveryTime;
  String deliveryTime2;
  int totalItem;
  String total;
  int status;
  String cargoPrice;

  factory UserOrderEntity.fromJson(Map<String, dynamic> json) => UserOrderEntity(
    ordercode: json["ordercode"] == null ? null : json["ordercode"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    name: json["name"] == null ? null : json["name"],
    deliveryType: json["deliveryType"] == null ? null : json["deliveryType"],
    deliveryTime: json["deliveryTime"] == null ? null : DateTime.parse(json["deliveryTime"]),
    deliveryTime2: json["deliveryTime2"] == null ? null : json["deliveryTime2"],
    totalItem: json["totalItem"] == null ? null : json["totalItem"],
    total: json["total"] == null ? null : json["total"],
    status: json["status"] == null ? null : json["status"],
    cargoPrice: json["cargoPrice"] == null ? null : json["cargoPrice"],
  );

  Map<String, dynamic> toJson() => {
    "ordercode": ordercode == null ? null : ordercode,
    "created_at": createdAt == null ? null : createdAt.toIso8601String(),
    "name": name == null ? null : name,
    "deliveryType": deliveryType == null ? null : deliveryType,
    "deliveryTime": deliveryTime == null ? null : deliveryTime.toIso8601String(),
    "deliveryTime2": deliveryTime2 == null ? null : deliveryTime2,
    "totalItem": totalItem == null ? null : totalItem,
    "total": total == null ? null : total,
    "status": status == null ? null : status,
    "cargoPrice": cargoPrice == null ? null : cargoPrice,
  };
}
