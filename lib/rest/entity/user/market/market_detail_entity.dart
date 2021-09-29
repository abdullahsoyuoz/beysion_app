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

class MarketDetailEntity  extends Persistent{
  MarketDetailEntity({
    this.logo,
    this.name,
    this.address,
    this.mapUrl,
    this.phone,
    this.point1,
    this.point2,
    this.point3,
    this.avgScore,
    this.firstPage,
    this.deliveryType,
    this.preparingTime,
    this.minimumSellPrice,
    this.workingStatus,
    this.workingTimeNow,
    this.today,
    this.workingDays,
  });

  String logo;
  String name;
  String address;
  String mapUrl;
  String phone;
  String point1;
  String point2;
  String point3;
  int avgScore;
  int firstPage;
  String deliveryType;
  String preparingTime;
  String minimumSellPrice;
  int workingStatus;
  String workingTimeNow;
  String today;
  String workingDays;

  factory MarketDetailEntity.fromJson(Map<String, dynamic> json) => MarketDetailEntity(
    logo: json["logo"] == null ? null : json["logo"],
    name: json["name"] == null ? null : json["name"],
    address: json["address"] == null ? null : json["address"],
    mapUrl: json["mapUrl"] == null ? null : json["mapUrl"],
    phone: json["phone"] == null ? null : json["phone"],
    point1: json["point1"] == null ? null : json["point1"],
    point2: json["point2"] == null ? null : json["point2"],
    point3: json["point3"] == null ? null : json["point3"],
    avgScore: json["avgScore"] == null ? null : json["avgScore"],
    firstPage: json["firstPage"] == null ? null : json["firstPage"],
    deliveryType: json["deliveryType"] == null ? null : json["deliveryType"],
    preparingTime: json["preparingTime"] == null ? null : json["preparingTime"],
    minimumSellPrice: json["minimumSellPrice"] == null ? null : json["minimumSellPrice"],
    workingStatus: json["workingStatus"] == null ? null : json["workingStatus"],
    workingTimeNow: json["workingTimeNow"] == null ? null : json["workingTimeNow"],
    today: json["today"] == null ? null : json["today"],
    workingDays: json["workingDays"] == null ? null : json["workingDays"],
  );

  Map<String, dynamic> toJson() => {
    "logo": logo == null ? null : logo,
    "name": name == null ? null : name,
    "address": address == null ? null : address,
    "mapUrl": mapUrl == null ? null : mapUrl,
    "phone": phone == null ? null : phone,
    "point1": point1 == null ? null : point1,
    "point2": point2 == null ? null : point2,
    "point3": point3 == null ? null : point3,
    "avgScore": avgScore == null ? null : avgScore,
    "firstPage": firstPage == null ? null : firstPage,
    "deliveryType": deliveryType == null ? null : deliveryType,
    "preparingTime": preparingTime == null ? null : preparingTime,
    "minimumSellPrice": minimumSellPrice == null ? null : minimumSellPrice,
    "workingStatus": workingStatus == null ? null : workingStatus,
    "workingTimeNow": workingTimeNow == null ? null : workingTimeNow,
    "today": today == null ? null : today,
    "workingDays": workingDays == null ? null : workingDays,
  };
}
