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

class UserLoginInformationEntity extends Persistent{
  UserLoginInformationEntity({
    this.gender,
    this.name,
    this.surname,
    this.email,
    this.mobil,
  });

  int gender;
  String name;
  String surname;
  String email;
  String mobil;

  factory UserLoginInformationEntity.fromJson(Map<String, dynamic> json) => UserLoginInformationEntity(
    gender: json["gender"] == null ? null : json["gender"],
    name: json["name"] == null ? null : json["name"],
    surname: json["surname"] == null ? null : json["surname"],
    email: json["email"] == null ? null : json["email"],
    mobil: json["mobil"] == null ? null : json["mobil"],
  );

  Map<String, dynamic> toJson() => {
    "gender": gender == null ? null : gender,
    "name": name == null ? null : name,
    "surname": surname == null ? null : surname,
    "email": email == null ? null : email,
    "mobil": mobil == null ? null : mobil,
  };
}
