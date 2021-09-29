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

class RecommendedMarketsEntity extends Persistent{
  RecommendedMarketsEntity({
    this.id,
    this.name,
    this.address,
    this.slug,
    this.zipcode,
    this.zipname,
    this.point,
  });

  int id;
  String name;
  String address;
  String slug;
  String zipcode;
  String zipname;
  int point;

  factory RecommendedMarketsEntity.fromJson(Map<String, dynamic> json) => RecommendedMarketsEntity(
    id: json["id"] == null ? null : json["id"],
    name: json["name"] == null ? null : json["name"],
    address: json["address"] == null ? null : json["address"],
    slug: json["slug"] == null ? null : json["slug"],
    zipcode: json["zipcode"] == null ? null : json["zipcode"],
    zipname: json["zipname"] == null ? null : json["zipname"],
    point: json["point"] == null ? null : json["point"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "name": name == null ? null : name,
    "address": address == null ? null : address,
    "slug": slug == null ? null : slug,
    "zipcode": zipcode == null ? null : zipcode,
    "zipname": zipname == null ? null : zipname,
    "point": point == null ? null : point,
  };
}
