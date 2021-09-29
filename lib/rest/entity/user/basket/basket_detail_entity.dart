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



class BasketDetailEntity extends Persistent{
  BasketDetailEntity({
    this.status,
    this.message,
    this.basketMarketDataList,
    this.basketTotal,
    this.basketTotalPrice,
    this.totalSeller,
  });

  bool status;
  String message;
  List<BasketMarketInData> basketMarketDataList;
  int basketTotal;
  String basketTotalPrice;
  int totalSeller;

  factory BasketDetailEntity.fromJson(Map<String, dynamic> json) => BasketDetailEntity(
    status: json["status"] == null ? null : json["status"],
    message: json["message"] == null ? null : json["message"],
    basketMarketDataList: json["data"] == null ? null : List<BasketMarketInData>.from(json["data"].map((x) => BasketMarketInData.fromJson(x))),
    basketTotal: json["basketTotal"] == null ? null : json["basketTotal"],
    basketTotalPrice: json["basketTotalPrice"] == null ? null : json["basketTotalPrice"],
    totalSeller: json["totalSeller"] == null ? null : json["totalSeller"],
  );

  Map<String, dynamic> toJson() => {
    "status": status == null ? null : status,
    "message": message == null ? null : message,
    "data": basketMarketDataList == null ? null : List<dynamic>.from(basketMarketDataList.map((x) => x.toJson())),
    "basketTotal": basketTotal == null ? null : basketTotal,
    "basketTotalPrice": basketTotalPrice == null ? null : basketTotalPrice,
    "totalSeller": totalSeller == null ? null : totalSeller,
  };
}

class BasketMarketInData {
  BasketMarketInData({
    this.mid,
    this.name,
    this.fulladdress,
    this.mapUrl,
    this.minimumSellPrice,
    this.minimumSellPrice2,
    this.preparingTime,
    this.deliveryTypes,
    this.shippingType,
    this.averageDeliveryTime,
    this.serviceTimes,
    this.comeTimes,
    this.basketProductList,
    this.basketTotal,
    this.marketUrl,
    this.workingStatus,
    this.workingTimeNow,
    this.freeCargoTotal,
    this.cargoPrice,
  });

  int mid;
  String name;
  String fulladdress;
  String mapUrl;
  int minimumSellPrice;
  int minimumSellPrice2;
  String preparingTime;
  List<DeliveryType> deliveryTypes;
  int shippingType;
  String averageDeliveryTime;
  List<ETime> serviceTimes = new List();
  List<ETime> comeTimes  = new List();
  List<BasketProduct> basketProductList;
  double basketTotal;
  String marketUrl;
  int workingStatus;
  String workingTimeNow;
  String freeCargoTotal;
  String cargoPrice;

  factory BasketMarketInData.fromJson(Map<String, dynamic> json) => BasketMarketInData(
    mid: json["mid"] == null ? null : json["mid"],
    name: json["name"] == null ? null : json["name"],
    fulladdress: json["fulladdress"] == null ? null : json["fulladdress"],
    mapUrl: json["mapUrl"] == null ? null : json["mapUrl"],
    minimumSellPrice: json["minimumSellPrice"] == null ? null : json["minimumSellPrice"],
    minimumSellPrice2: json["minimumSellPrice2"] == null ? null : json["minimumSellPrice2"],
    preparingTime: json["preparingTime"] == null ? null : json["preparingTime"],
    deliveryTypes: json["deliveryTypes"] == null ? null : List<DeliveryType>.from(json["deliveryTypes"].map((x) => DeliveryType.fromJson(x))),
    shippingType: json["shippingType"] == null ? null : json["shippingType"],
    averageDeliveryTime: json["averageDeliveryTime"] == null ? null : json["averageDeliveryTime"],
    serviceTimes: json["serviceTimes"] == null ? null : List<ETime>.from(json["serviceTimes"].map((x) => ETime.fromJson(x))),
    comeTimes: json["comeTimes"] == null ? null : List<ETime>.from(json["comeTimes"].map((x) => ETime.fromJson(x))),
    basketProductList: json["basket"] == null ? null : List<BasketProduct>.from(json["basket"].map((x) => BasketProduct.fromJson(x))),
    basketTotal: json["basketTotal"] == null ? null : json["basketTotal"].toDouble(),
    marketUrl: json["marketUrl"] == null ? null : json["marketUrl"],
    workingStatus: json["workingStatus"] == null ? null : json["workingStatus"],
    workingTimeNow: json["workingTimeNow"] == null ? null : json["workingTimeNow"],
    freeCargoTotal: json["freeCargoTotal"] == null ? null : json["freeCargoTotal"],
    cargoPrice: json["cargoPrice"] == null ? null : json["cargoPrice"],
  );

  Map<String, dynamic> toJson() => {
    "mid": mid == null ? null : mid,
    "name": name == null ? null : name,
    "fulladdress": fulladdress == null ? null : fulladdress,
    "mapUrl": mapUrl == null ? null : mapUrl,
    "minimumSellPrice": minimumSellPrice == null ? null : minimumSellPrice,
    "minimumSellPrice2": minimumSellPrice2 == null ? null : minimumSellPrice2,
    "preparingTime": preparingTime == null ? null : preparingTime,
    "deliveryTypes": deliveryTypes == null ? null : List<dynamic>.from(deliveryTypes.map((x) => x.toJson())),
    "shippingType": shippingType == null ? null : shippingType,
    "averageDeliveryTime": averageDeliveryTime == null ? null : averageDeliveryTime,
    "serviceTimes": serviceTimes == null ? null : List<dynamic>.from(serviceTimes.map((x) => x.toJson())),
    "comeTimes": comeTimes == null ? null : List<dynamic>.from(comeTimes.map((x) => x.toJson())),
    "basket": basketProductList == null ? null : List<dynamic>.from(basketProductList.map((x) => x.toJson())),
    "basketTotal": basketTotal == null ? null : basketTotal,
    "marketUrl": marketUrl == null ? null : marketUrl,
    "workingStatus": workingStatus == null ? null : workingStatus,
    "workingTimeNow": workingTimeNow == null ? null : workingTimeNow,
    "freeCargoTotal": freeCargoTotal == null ? null : freeCargoTotal,
    "cargoPrice": cargoPrice == null ? null : cargoPrice,
  };
}

class BasketProduct {
  BasketProduct({
    this.aid,
    this.name,
    this.slug,
    this.image,
    this.qty,
    this.stock,
    this.resultPrice,
    this.price,
    this.discountPrice,
    this.stockError,
    this.priceWarning,
    this.selected = true,
    this.selectedProduct = false,
  });

  int aid;
  String name;
  String slug;
  String image;
  int qty;
  int stock;
  String resultPrice;
  String price;
  String discountPrice;
  int stockError;
  int priceWarning;
  bool selectedProduct = false;
  bool selected;

  factory BasketProduct.fromJson(Map<String, dynamic> json) => BasketProduct(
    aid: json["aid"] == null ? null : json["aid"],
    name: json["name"] == null ? null : json["name"],
    slug: json["slug"] == null ? null : json["slug"],
    image: json["image"] == null ? null : json["image"],
    qty: json["qty"] == null ? null : json["qty"],
    stock: json["stock"] == null ? null : json["stock"],
    resultPrice: json["resultPrice"] == null ? null : json["resultPrice"],
    price: json["price"] == null ? null : json["price"],
    discountPrice: json["discountPrice"] == null ? null : json["discountPrice"],
    stockError: json["stockError"] == null ? null : json["stockError"],
    priceWarning: json["priceWarning"] == null ? null : json["priceWarning"],
  );

  Map<String, dynamic> toJson() => {
    "aid": aid == null ? null : aid,
    "name": name == null ? null : name,
    "slug": slug == null ? null : slug,
    "image": image == null ? null : image,
    "qty": qty == null ? null : qty,
    "stock": stock == null ? null : stock,
    "resultPrice": resultPrice == null ? null : resultPrice,
    "price": price == null ? null : price,
    "discountPrice": discountPrice == null ? null : discountPrice,
    "stockError": stockError == null ? null : stockError,
    "priceWarning": priceWarning == null ? null : priceWarning,
  };
}

class ETime {
  ETime({
    this.text,
    this.hour,
    this.datetext,
    this.date,
    this.day,
  });

  String text;
  String hour;
  String datetext;
  String date;
  int day;

  factory ETime.fromJson(Map<String, dynamic> json) => ETime(
    text: json["text"] == null ? null : json["text"],
    hour: json["hour"] == null ? null : json["hour"],
    datetext: json["datetext"] == null ? null : json["datetext"],
    date: json["date"] == null ? null : json["date"],
    day: json["day"] == null ? null : json["day"],
  );

  Map<String, dynamic> toJson() => {
    "text": text == null ? null : text,
    "hour": hour == null ? null : hour,
    "datetext": datetext == null ? null : datetext,
    "date": date == null ? null : date,
    "day": day == null ? null : day,
  };
}


class DeliveryType {
  DeliveryType({
    this.id,
    this.name,
  });

  int id;
  String name;

  factory DeliveryType.fromJson(Map<String, dynamic> json) => DeliveryType(
    id: json["id"] == null ? null : json["id"],
    name: json["name"] == null ? null : json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "name": name == null ? null : name,
  };
}

