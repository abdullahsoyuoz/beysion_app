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

// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

class UserOrderDetailEntity extends Persistent{
  UserOrderDetailEntity({
    this.detail,
    this.products,
    this.marktdetails,
    this.couponDetails,
    this.orderPoints,
  });

  Detail detail;
  List<Product> products;
  Marktdetails marktdetails;
  dynamic couponDetails;
  dynamic orderPoints;

  factory UserOrderDetailEntity.fromJson(Map<String, dynamic> json) => UserOrderDetailEntity(
    detail: json["detail"] == null ? null : Detail.fromJson(json["detail"]),
    products: json["products"] == null ? null : List<Product>.from(json["products"].map((x) => Product.fromJson(x))),
    marktdetails: json["marktdetails"] == null ? null : Marktdetails.fromJson(json["marktdetails"]),
    couponDetails: json["couponDetails"],
    orderPoints: json["orderPoints"],
  );

  Map<String, dynamic> toJson() => {
    "detail": detail == null ? null : detail.toJson(),
    "products": products == null ? null : List<dynamic>.from(products.map((x) => x.toJson())),
    "marktdetails": marktdetails == null ? null : marktdetails.toJson(),
    "couponDetails": couponDetails,
    "orderPoints": orderPoints,
  };
}

class Detail {
  Detail({
    this.id,
    this.sid,
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
    this.pid,
  });

  int id;
  int sid;
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
  int pid;

  factory Detail.fromJson(Map<String, dynamic> json) => Detail(
    id: json["id"] == null ? null : json["id"],
    sid: json["sid"] == null ? null : json["sid"],
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
    pid: json["pid"] == null ? null : json["pid"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "sid": sid == null ? null : sid,
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
    "pid": pid == null ? null : pid,
  };
}

class Marktdetails {
  Marktdetails({
    this.id,
    this.sid,
    this.name,
    this.preparingTime,
    this.deliveryTime,
    this.delivery,
    this.minimumSellPrice,
    this.minimumSellPrice2,
    this.firstPage,
    this.aboutUs,
    this.workingday1,
    this.workingday2,
    this.workingday3,
    this.workingday4,
    this.workingday5,
    this.workingday6,
    this.workingday7,
    this.workingday1Start,
    this.workingday1End,
    this.workingday2Start,
    this.workingday2End,
    this.workingday3Start,
    this.workingday3End,
    this.workingday4Start,
    this.workingday4End,
    this.workingday5Start,
    this.workingday5End,
    this.workingday6Start,
    this.workingday6End,
    this.workingday7Start,
    this.workingday7End,
    this.status,
    this.officialName,
    this.officialSurname,
    this.officialGender,
    this.phone,
    this.mobiltelefon,
    this.address,
    this.province,
    this.district,
    this.zipcode,
    this.logo,
    this.slug,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.point1,
    this.point2,
    this.point3,
  });

  int id;
  int sid;
  String name;
  int preparingTime;
  int deliveryTime;
  int delivery;
  int minimumSellPrice;
  int minimumSellPrice2;
  int firstPage;
  dynamic aboutUs;
  int workingday1;
  int workingday2;
  int workingday3;
  int workingday4;
  int workingday5;
  int workingday6;
  int workingday7;
  String workingday1Start;
  String workingday1End;
  String workingday2Start;
  String workingday2End;
  String workingday3Start;
  String workingday3End;
  String workingday4Start;
  String workingday4End;
  String workingday5Start;
  String workingday5End;
  String workingday6Start;
  String workingday6End;
  String workingday7Start;
  String workingday7End;
  int status;
  String officialName;
  String officialSurname;
  int officialGender;
  String phone;
  String mobiltelefon;
  String address;
  dynamic province;
  dynamic district;
  String zipcode;
  dynamic logo;
  String slug;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic deletedAt;
  String point1;
  String point2;
  String point3;

  factory Marktdetails.fromJson(Map<String, dynamic> json) => Marktdetails(
    id: json["id"] == null ? null : json["id"],
    sid: json["sid"] == null ? null : json["sid"],
    name: json["name"] == null ? null : json["name"],
    preparingTime: json["preparingTime"] == null ? null : json["preparingTime"],
    deliveryTime: json["deliveryTime"] == null ? null : json["deliveryTime"],
    delivery: json["delivery"] == null ? null : json["delivery"],
    minimumSellPrice: json["minimumSellPrice"] == null ? null : json["minimumSellPrice"],
    minimumSellPrice2: json["minimumSellPrice2"] == null ? null : json["minimumSellPrice2"],
    firstPage: json["firstPage"] == null ? null : json["firstPage"],
    aboutUs: json["aboutUs"],
    workingday1: json["workingday1"] == null ? null : json["workingday1"],
    workingday2: json["workingday2"] == null ? null : json["workingday2"],
    workingday3: json["workingday3"] == null ? null : json["workingday3"],
    workingday4: json["workingday4"] == null ? null : json["workingday4"],
    workingday5: json["workingday5"] == null ? null : json["workingday5"],
    workingday6: json["workingday6"] == null ? null : json["workingday6"],
    workingday7: json["workingday7"] == null ? null : json["workingday7"],
    workingday1Start: json["workingday1_start"] == null ? null : json["workingday1_start"],
    workingday1End: json["workingday1_end"] == null ? null : json["workingday1_end"],
    workingday2Start: json["workingday2_start"] == null ? null : json["workingday2_start"],
    workingday2End: json["workingday2_end"] == null ? null : json["workingday2_end"],
    workingday3Start: json["workingday3_start"] == null ? null : json["workingday3_start"],
    workingday3End: json["workingday3_end"] == null ? null : json["workingday3_end"],
    workingday4Start: json["workingday4_start"] == null ? null : json["workingday4_start"],
    workingday4End: json["workingday4_end"] == null ? null : json["workingday4_end"],
    workingday5Start: json["workingday5_start"] == null ? null : json["workingday5_start"],
    workingday5End: json["workingday5_end"] == null ? null : json["workingday5_end"],
    workingday6Start: json["workingday6_start"] == null ? null : json["workingday6_start"],
    workingday6End: json["workingday6_end"] == null ? null : json["workingday6_end"],
    workingday7Start: json["workingday7_start"] == null ? null : json["workingday7_start"],
    workingday7End: json["workingday7_end"] == null ? null : json["workingday7_end"],
    status: json["status"] == null ? null : json["status"],
    officialName: json["officialName"] == null ? null : json["officialName"],
    officialSurname: json["officialSurname"] == null ? null : json["officialSurname"],
    officialGender: json["officialGender"] == null ? null : json["officialGender"],
    phone: json["phone"] == null ? null : json["phone"],
    mobiltelefon: json["mobiltelefon"] == null ? null : json["mobiltelefon"],
    address: json["address"] == null ? null : json["address"],
    province: json["province"],
    district: json["district"],
    zipcode: json["zipcode"] == null ? null : json["zipcode"],
    logo: json["logo"],
    slug: json["slug"] == null ? null : json["slug"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    deletedAt: json["deleted_at"],
    point1: json["point1"] == null ? null : json["point1"],
    point2: json["point2"] == null ? null : json["point2"],
    point3: json["point3"] == null ? null : json["point3"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "sid": sid == null ? null : sid,
    "name": name == null ? null : name,
    "preparingTime": preparingTime == null ? null : preparingTime,
    "deliveryTime": deliveryTime == null ? null : deliveryTime,
    "delivery": delivery == null ? null : delivery,
    "minimumSellPrice": minimumSellPrice == null ? null : minimumSellPrice,
    "minimumSellPrice2": minimumSellPrice2 == null ? null : minimumSellPrice2,
    "firstPage": firstPage == null ? null : firstPage,
    "aboutUs": aboutUs,
    "workingday1": workingday1 == null ? null : workingday1,
    "workingday2": workingday2 == null ? null : workingday2,
    "workingday3": workingday3 == null ? null : workingday3,
    "workingday4": workingday4 == null ? null : workingday4,
    "workingday5": workingday5 == null ? null : workingday5,
    "workingday6": workingday6 == null ? null : workingday6,
    "workingday7": workingday7 == null ? null : workingday7,
    "workingday1_start": workingday1Start == null ? null : workingday1Start,
    "workingday1_end": workingday1End == null ? null : workingday1End,
    "workingday2_start": workingday2Start == null ? null : workingday2Start,
    "workingday2_end": workingday2End == null ? null : workingday2End,
    "workingday3_start": workingday3Start == null ? null : workingday3Start,
    "workingday3_end": workingday3End == null ? null : workingday3End,
    "workingday4_start": workingday4Start == null ? null : workingday4Start,
    "workingday4_end": workingday4End == null ? null : workingday4End,
    "workingday5_start": workingday5Start == null ? null : workingday5Start,
    "workingday5_end": workingday5End == null ? null : workingday5End,
    "workingday6_start": workingday6Start == null ? null : workingday6Start,
    "workingday6_end": workingday6End == null ? null : workingday6End,
    "workingday7_start": workingday7Start == null ? null : workingday7Start,
    "workingday7_end": workingday7End == null ? null : workingday7End,
    "status": status == null ? null : status,
    "officialName": officialName == null ? null : officialName,
    "officialSurname": officialSurname == null ? null : officialSurname,
    "officialGender": officialGender == null ? null : officialGender,
    "phone": phone == null ? null : phone,
    "mobiltelefon": mobiltelefon == null ? null : mobiltelefon,
    "address": address == null ? null : address,
    "province": province,
    "district": district,
    "zipcode": zipcode == null ? null : zipcode,
    "logo": logo,
    "slug": slug == null ? null : slug,
    "created_at": createdAt == null ? null : createdAt.toIso8601String(),
    "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
    "deleted_at": deletedAt,
    "point1": point1 == null ? null : point1,
    "point2": point2 == null ? null : point2,
    "point3": point3 == null ? null : point3,
  };
}

class Product {
  Product({
    this.name,
    this.image,
    this.price,
    this.qty,
    this.approvedQty,
  });

  String name;
  String image;
  String price;
  int qty;
  String approvedQty;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    name: json["name"] == null ? null : json["name"],
    image: json["image"] == null ? null : json["image"],
    price: json["price"] == null ? null : json["price"],
    qty: json["qty"] == null ? null : json["qty"],
    approvedQty: json["approved_qty"] == null ? null : json["approved_qty"],
  );

  Map<String, dynamic> toJson() => {
    "name": name == null ? null : name,
    "image": image == null ? null : image,
    "price": price == null ? null : price,
    "qty": qty == null ? null : qty,
    "approved_qty": approvedQty == null ? null : approvedQty,
  };
}
