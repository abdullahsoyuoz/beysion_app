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

class SellerEmailPassword extends Persistent{
  SellerEmailPassword({
    this.email,
    this.password,
  });

  String email;
  String password;

  factory SellerEmailPassword.fromJson(Map<String, dynamic> json) => SellerEmailPassword(
    email: json["email"] == null ? null : json["email"],
    password: json["password"] == null ? null : json["password"],
  );

  Map<String, dynamic> toJson() => {
    "email": email == null ? null : email,
    "password": password == null ? null : password,
  };
}

class SelectedOrderProduct extends Persistent{
  SelectedOrderProduct({
    this.productId,
    this.productQuantity,
  });

  String productId;
  String productQuantity;

  factory SelectedOrderProduct.fromJson(Map<String, dynamic> json) => SelectedOrderProduct(
    productId: json["adsid"] == null ? null : json["adsid"],
    productQuantity: json["qty"] == null ? null : json["qty"],
  );

  Map<String, dynamic> toJson() => {
    "adsid": productId == null ? null : productId,
    "qty": productQuantity == null ? null : productQuantity,
  };
}

class OrderProcessEntity extends Persistent{
  OrderProcessEntity({
    this.step,
    this.ordercode,
    this.data,
  });

  String step;
  String ordercode;
  List<SelectedOrderProduct> data;

  factory OrderProcessEntity.fromJson(Map<String, dynamic> json) => OrderProcessEntity(
    step: json["step"] == null ? null : json["step"],
    ordercode: json["ordercode"] == null ? null : json["ordercode"],
    data: json["data"] == null ? null : List<SelectedOrderProduct>.from(json["data"].map((x) => SelectedOrderProduct.fromJson(x))),

  );

  Map<String, dynamic> toJson() => {
    "adsid": step == null ? null : step,
    "qty": ordercode == null ? null : ordercode,
    "data": data == null ? null : List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

