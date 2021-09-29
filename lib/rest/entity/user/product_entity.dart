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


class ProductEntity extends Persistent{
  ProductEntity({
    this.id,
    this.pid,
    this.price,
    this.discountPrice,
    this.name,
    this.point,
    this.image,
    this.slug,
    this.resultPrice,
    this.mid,
    this.total,
    this.marketname,
    this.marketurl,
    this.baskettotal,
    this.favStatus,
    this.minPrice,
    this.selected = false,
  });

  int id;
  int pid;
  String price;
  String discountPrice;
  String name;
  String point;
  String image;
  String resultPrice;
  String slug;
  int mid;
  int total;
  String marketname;
  String marketurl;
  int baskettotal;
  int favStatus;
  String minPrice;
  bool selected;

  factory ProductEntity.fromJson(Map<String, dynamic> json) => ProductEntity(
    id: json["id"] == null ? null : json["id"],
    pid: json["pid"] == null ? null : json["pid"],
    price: json["price"] == null ? null : json["price"].toString(),
    discountPrice: json["discountPrice"] == null ? null : json["discountPrice"],
    name: json["name"] == null ? null : json["name"],
    point: json["point"] == null ? null : json["point"],
    image: json["image"] == null ? null : json["image"],
    resultPrice: json["resultPrice"] == null ? null : json["resultPrice"],
    slug: json["slug"] == null ? null : json["slug"],
    mid: json["mid"] == null ? null : json["mid"],
    total: json["total"] == null ? null : json["total"],
    marketname: json["marketname"] == null ? null : json["marketname"],
    marketurl: json["marketurl"] == null ? null : json["marketurl"],
    baskettotal: json["baskettotal"] == null ? null : json["baskettotal"],
    favStatus: json["favStatus"] == null ? null : json["favStatus"],
    minPrice: json["minPrice"] == null ? null : json["minPrice"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "pid": pid == null ? null : pid,
    "price": price == null ? null : price,
    "discountPrice": discountPrice == null ? null : discountPrice,
    "name": name == null ? null : name,
    "point": point == null ? null : point,
    "image": image == null ? null : image,
    "resultPrice": resultPrice == null ? null : resultPrice,
    "slug": slug == null ? null : slug,
    "mid": mid == null ? null : mid,
    "total": total == null ? null : total,
    "marketname": marketname == null ? null : marketname,
    "marketurl": marketurl == null ? null : marketurl,
    "baskettotal": baskettotal == null ? null : baskettotal,
    "favStatus": favStatus == null ? null : favStatus,
    "minPrice": minPrice == null ? null : minPrice,
  };
}

