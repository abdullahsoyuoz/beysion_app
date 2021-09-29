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

class BasketToAcceptOrderEntity extends Persistent{
  BasketToAcceptOrderEntity({
    this.uid,
    this.mid,
    this.sid,
    this.pid,
    this.ordercode,
    this.total,
    this.status,
    this.deliveryTime,
    this.deliveryTime2,
    this.paymentType,
    this.cargoPrice,
    this.discountPercent,
    this.detail,
  });

  dynamic uid;
  dynamic mid;
  dynamic sid;
  dynamic pid;
  String ordercode;
  dynamic total;
  dynamic status;
  String deliveryTime;
  String deliveryTime2;
  dynamic paymentType;
  dynamic cargoPrice;
  dynamic discountPercent;
  Detail detail;

  factory BasketToAcceptOrderEntity.fromJson(Map<String, dynamic> json) => BasketToAcceptOrderEntity(
    uid: json["uid"] == null ? null : json["uid"],
    mid: json["mid"] == null ? null : json["mid"],
    sid: json["sid"] == null ? null : json["sid"],
    pid: json["pid"] == null ? null : json["pid"],
    ordercode: json["ordercode"] == null ? null : json["ordercode"],
    total: json["total"] == null ? null : json["total"],
    status: json["status"] == null ? null : json["status"],
    deliveryTime: json["deliveryTime"] == null ? null : json["deliveryTime"],
    deliveryTime2: json["deliveryTime2"] == null ? null : json["deliveryTime2"],
    paymentType: json["paymentType"] == null ? null : json["paymentType"],
    cargoPrice: json["cargoPrice"] == null ? null : json["cargoPrice"],
    discountPercent: json["discountPercent"] == null ? null : json["discountPercent"],
    detail: json["detail"] == null ? null : Detail.fromJson(json["detail"]),
  );

  Map<String, dynamic> toJson() => {
    "uid": uid == null ? null : uid,
    "mid": mid == null ? null : mid,
    "sid": sid == null ? null : sid,
    "pid": pid == null ? null : pid,
    "ordercode": ordercode == null ? null : ordercode,
    "total": total == null ? null : total,
    "status": status == null ? null : status,
    "deliveryTime": deliveryTime == null ? null : deliveryTime,
    "deliveryTime2": deliveryTime2 == null ? null : deliveryTime2,
    "paymentType": paymentType == null ? null : paymentType,
    "cargoPrice": cargoPrice == null ? null : cargoPrice,
    "discountPercent": discountPercent == null ? null : discountPercent,
    "detail": detail == null ? null : detail.toJson(),
  };
}

class Detail {
  Detail({
    this.name,
    this.fulladdress,
    this.mapUrl,
    this.sid,
    this.mid,
    this.minimumSellPrice2,
    this.minimumSellPrice1,
    this.basket,
    this.basketTotal,
    this.freeCargoTotal,
    this.cargoPrice,
    this.selected,
    this.serviceTypeText,
    this.serviceTypeTime,
  });

  String name;
  String fulladdress;
  String mapUrl;
  dynamic sid;
  dynamic mid;
  dynamic minimumSellPrice2;
  dynamic minimumSellPrice1;
  List<Basket> basket;
  dynamic basketTotal;
  dynamic freeCargoTotal;
  dynamic cargoPrice;
  Selected selected;
  String serviceTypeText;
  String serviceTypeTime;

  factory Detail.fromJson(Map<String, dynamic> json) => Detail(
    name: json["name"] == null ? null : json["name"],
    fulladdress: json["fulladdress"] == null ? null : json["fulladdress"],
    mapUrl: json["mapUrl"] == null ? null : json["mapUrl"],
    sid: json["sid"] == null ? null : json["sid"],
    mid: json["mid"] == null ? null : json["mid"],
    minimumSellPrice2: json["minimumSellPrice2"] == null ? null : json["minimumSellPrice2"],
    minimumSellPrice1: json["minimumSellPrice1"] == null ? null : json["minimumSellPrice1"],
    basket: json["basket"] == null ? null : List<Basket>.from(json["basket"].map((x) => Basket.fromJson(x))),
    basketTotal: json["basketTotal"] == null ? null : json["basketTotal"],
    freeCargoTotal: json["freeCargoTotal"] == null ? null : json["freeCargoTotal"],
    cargoPrice: json["cargoPrice"] == null ? null : json["cargoPrice"],
    selected: json["selected"] == null ? null : Selected.fromJson(json["selected"]),
    serviceTypeText: json["serviceTypeText"] == null ? null : json["serviceTypeText"],
    serviceTypeTime: json["serviceTypeTime"] == null ? null : json["serviceTypeTime"],
  );

  Map<String, dynamic> toJson() => {
    "name": name == null ? null : name,
    "fulladdress": fulladdress == null ? null : fulladdress,
    "mapUrl": mapUrl == null ? null : mapUrl,
    "sid": sid == null ? null : sid,
    "mid": mid == null ? null : mid,
    "minimumSellPrice2": minimumSellPrice2 == null ? null : minimumSellPrice2,
    "minimumSellPrice1": minimumSellPrice1 == null ? null : minimumSellPrice1,
    "basket": basket == null ? null : List<dynamic>.from(basket.map((x) => x.toJson())),
    "basketTotal": basketTotal == null ? null : basketTotal,
    "freeCargoTotal": freeCargoTotal == null ? null : freeCargoTotal,
    "cargoPrice": cargoPrice == null ? null : cargoPrice,
    "selected": selected == null ? null : selected.toJson(),
    "serviceTypeText": serviceTypeText == null ? null : serviceTypeText,
    "serviceTypeTime": serviceTypeTime == null ? null : serviceTypeTime,
  };
}

class Basket {
  Basket({
    this.basketid,
    this.aid,
    this.name,
    this.image,
    this.qty,
    this.resultPrice,
    this.price,
    this.discountPrice,
  });

  dynamic basketid;
  dynamic aid;
  String name;
  String image;
  dynamic qty;
  dynamic resultPrice;
  dynamic price;
  dynamic discountPrice;

  factory Basket.fromJson(Map<String, dynamic> json) => Basket(
    basketid: json["basketid"] == null ? null : json["basketid"],
    aid: json["aid"] == null ? null : json["aid"],
    name: json["name"] == null ? null : json["name"],
    image: json["image"] == null ? null : json["image"],
    qty: json["qty"] == null ? null : json["qty"],
    resultPrice: json["resultPrice"] == null ? null : json["resultPrice"],
    price: json["price"] == null ? null : json["price"],
    discountPrice: json["discountPrice"] == null ? null : json["discountPrice"],
  );

  Map<String, dynamic> toJson() => {
    "basketid": basketid == null ? null : basketid,
    "aid": aid == null ? null : aid,
    "name": name == null ? null : name,
    "image": image == null ? null : image,
    "qty": qty == null ? null : qty,
    "resultPrice": resultPrice == null ? null : resultPrice,
    "price": price == null ? null : price,
    "discountPrice": discountPrice == null ? null : discountPrice,
  };
}

class Selected {
  Selected({
    this.mid,
    this.serviceType,
    this.time,
  });

  dynamic mid;
  dynamic serviceType;
  String time;

  factory Selected.fromJson(Map<String, dynamic> json) => Selected(
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
