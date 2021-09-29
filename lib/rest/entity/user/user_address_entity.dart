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


class UserAddressEntity extends Persistent{
  UserAddressEntity({
    this.id,
    this.uid,
    this.datumDefault,
    this.name,
    this.firstname,
    this.lastname,
    this.phone,
    this.address,
    this.zipcode,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  int id;
  int uid;
  int datumDefault;
  String name;
  String firstname;
  String lastname;
  String phone;
  String address;
  int zipcode;
  DateTime createdAt;
  DateTime updatedAt;
  DateTime deletedAt;

  factory UserAddressEntity.fromJson(Map<String, dynamic> json) => UserAddressEntity(
    id: json["id"] == null ? null : json["id"],
    uid: json["uid"] == null ? null : json["uid"],
    datumDefault: json["default"] == null ? null : json["default"],
    name: json["name"] == null ? null : json["name"],
    firstname: json["firstname"] == null ? null : json["firstname"],
    lastname: json["lastname"] == null ? null : json["lastname"],
    phone: json["phone"] == null ? null : json["phone"],
    address: json["address"] == null ? null : json["address"],
    zipcode: json["zipcode"] == null ? null : json["zipcode"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    deletedAt: json["deleted_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "uid": uid == null ? null : uid,
    "default": datumDefault == null ? null : datumDefault,
    "name": name == null ? null : name,
    "firstname": firstname == null ? null : firstname,
    "lastname": lastname == null ? null : lastname,
    "phone": phone == null ? null : phone,
    "address": address == null ? null : address,
    "zipcode": zipcode == null ? null : zipcode,
    "created_at": createdAt == null ? null : createdAt.toIso8601String(),
    "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
    "deleted_at": deletedAt,
  };
}
