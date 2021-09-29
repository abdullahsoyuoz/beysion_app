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


class SellerRegisterEntity extends Persistent{
  SellerRegisterEntity({
    this.companyName,
    this.zipCode,
    this.address,
    this.email,
    this.password,
    this.passwordConfirm,
  });

  String companyName;
  String zipCode;
  String address;
  String email;
  String password;
  String passwordConfirm;

  factory SellerRegisterEntity.fromJson(Map<String, dynamic> json) => SellerRegisterEntity(
    companyName: json["companyName"] == null ? null : json["companyName"],
    zipCode: json["zipCode"] == null ? null : json["zipCode"],
    address: json["address"] == null ? null : json["address"],
    email: json["email"] == null ? null : json["email"],
    password: json["password"] == null ? null : json["password"],
    passwordConfirm: json["password_confirmation"] == null ? null : json["password_confirmation"],
  );

  Map<String, dynamic> toJson() => {
    "companyName": companyName == null ? null : companyName,
    "zipCode": zipCode == null ? null : zipCode,
    "address": address == null ? null : address,
    "email": email == null ? null : email,
    "password": password == null ? null : password,
    "password_confirmation": passwordConfirm == null ? null : passwordConfirm,
  };
}