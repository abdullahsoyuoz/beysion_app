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


class UserRegisterEntity extends Persistent{
  UserRegisterEntity({
    this.name,
    this.nachname,
    this.mobil,
    this.email,
    this.password,
    this.passwordConfirm,
  });

  String name;
  String nachname;
  String mobil;
  String email;
  String password;
  String passwordConfirm;

  factory UserRegisterEntity.fromJson(Map<String, dynamic> json) => UserRegisterEntity(
    name: json["name"] == null ? null : json["name"],
    nachname: json["nachname"] == null ? null : json["nachname"],
    mobil: json["mobil"] == null ? null : json["mobil"],
    email: json["email"] == null ? null : json["email"],
    password: json["password"] == null ? null : json["password"],
    passwordConfirm: json["password_confirmation"] == null ? null : json["password_confirmation"],
  );

  Map<String, dynamic> toJson() => {
    "name": name == null ? null : name,
    "nachname": nachname == null ? null : nachname,
    "mobil": mobil == null ? null : mobil,
    "email": email == null ? null : email,
    "password": password == null ? null : password,
    "password_confirmation": passwordConfirm == null ? null : passwordConfirm,
  };
}