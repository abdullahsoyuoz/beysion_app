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


class BasketMessageReturnEntity extends Persistent{
  BasketMessageReturnEntity({
    this.status,
    this.message,
    this.data,
    this.qty,
  });

  bool status;
  String message;
  String data;
  int qty;

  factory BasketMessageReturnEntity.fromJson(Map<String, dynamic> json) => BasketMessageReturnEntity(
    status: json["status"] == null ? null : json["status"],
    message: json["message"] == null ? null : json["message"],
    data: json["data"] == null ? null : json["data"],
    qty: json["qty"] == null ? null : json["qty"],
  );

  Map<String, dynamic> toJson() => {
    "status": status == null ? null : status,
    "message": message == null ? null : message,
    "data": data == null ? null : data,
    "qty": qty == null ? null : qty,
  };
}

