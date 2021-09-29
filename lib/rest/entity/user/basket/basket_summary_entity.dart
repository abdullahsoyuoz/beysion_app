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


class BasketSummaryEntity extends Persistent{
  BasketSummaryEntity({
    this.status,
    this.message,
    this.totalAndPrice,
  });

  bool status;
  String message;
  TotalAndPrice totalAndPrice;

  factory BasketSummaryEntity.fromJson(Map<String, dynamic> json) => BasketSummaryEntity(
    status: json["status"] == null ? null : json["status"],
    message: json["message"] == null ? null : json["message"],
    totalAndPrice: json["data"] == null ? null : TotalAndPrice.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status == null ? null : status,
    "message": message == null ? null : message,
    "data": totalAndPrice == null ? null : totalAndPrice.toJson(),
  };
}

class TotalAndPrice {
  TotalAndPrice({
    this.price,
    this.total,
  });

  String price;
  int total;

  factory TotalAndPrice.fromJson(Map<String, dynamic> json) => TotalAndPrice(
    price: json["price"] == null ? null : json["price"],
    total: json["total"] == null ? null : json["total"],
  );

  Map<String, dynamic> toJson() => {
    "price": price == null ? null : price,
    "total": total == null ? null : total,
  };
}
