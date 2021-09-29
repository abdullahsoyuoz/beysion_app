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

class SellerOrderDetailEntity extends Persistent{
  SellerOrderDetailEntity({
    this.detail,
    this.products,
    this.buyer,
    this.address,
    this.orderPoints,
  });

  final DetailSeller detail;
  List<ProductSeller> products;
  final Buyer buyer;
  final AddressSeller address;
  final dynamic orderPoints;

  factory SellerOrderDetailEntity.fromJson(Map<String, dynamic> json) => SellerOrderDetailEntity(
    detail: json["detail"] == null ? null : DetailSeller.fromJson(json["detail"]),
    products: json["products"] == null ? null : List<ProductSeller>.from(json["products"].map((x) => ProductSeller.fromJson(x))),
    buyer: json["buyer"] == null ? null : Buyer.fromJson(json["buyer"]),
    address: json["address"] == null ? null : AddressSeller.fromJson(json["address"]),
    orderPoints: json["orderPoints"],
  );

  Map<String, dynamic> toJson() => {
    "detail": detail == null ? null : detail.toJson(),
    "products": products == null ? null : List<dynamic>.from(products.map((x) => x.toJson())),
    "buyer": buyer == null ? null : buyer.toJson(),
    "address": address == null ? null : address.toJson(),
    "orderPoints": orderPoints,
  };
}

class AddressSeller {
  AddressSeller({
    this.id,
    this.oid,
    this.addressNameSurname,
    this.addressText,
    this.taxId,
    this.taxName,
    this.phone,
    this.taxAddress,
    this.taxNameSurname,
    this.taxPhone,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  final int id;
  final int oid;
  final String addressNameSurname;
  final String addressText;
  final String taxId;
  final String taxName;
  final String phone;
  final String taxAddress;
  final String taxNameSurname;
  final String taxPhone;
  final DateTime createdAt;
  final DateTime updatedAt;
  final dynamic deletedAt;

  factory AddressSeller.fromJson(Map<String, dynamic> json) => AddressSeller(
    id: json["id"] == null ? null : json["id"],
    oid: json["oid"] == null ? null : json["oid"],
    addressNameSurname: json["addressNameSurname"] == null ? null : json["addressNameSurname"],
    addressText: json["addressText"] == null ? null : json["addressText"],
    taxId: json["taxId"] == null ? null : json["taxId"],
    taxName: json["taxName"] == null ? null : json["taxName"],
    phone: json["phone"] == null ? null : json["phone"],
    taxAddress: json["taxAddress"] == null ? null : json["taxAddress"],
    taxNameSurname: json["taxNameSurname"] == null ? null : json["taxNameSurname"],
    taxPhone: json["taxPhone"] == null ? null : json["taxPhone"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    deletedAt: json["deleted_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "oid": oid == null ? null : oid,
    "addressNameSurname": addressNameSurname == null ? null : addressNameSurname,
    "addressText": addressText == null ? null : addressText,
    "taxId": taxId == null ? null : taxId,
    "taxName": taxName == null ? null : taxName,
    "phone": phone == null ? null : phone,
    "taxAddress": taxAddress == null ? null : taxAddress,
    "taxNameSurname": taxNameSurname == null ? null : taxNameSurname,
    "taxPhone": taxPhone == null ? null : taxPhone,
    "created_at": createdAt == null ? null : createdAt.toIso8601String(),
    "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
    "deleted_at": deletedAt,
  };
}

class Buyer {
  Buyer({
    this.id,
    this.name,
    this.surname,
    this.gender,
    this.email,
    this.phone,
    this.emailVerifiedAt,
    this.registerToken,
    this.status,
    this.notification,
    this.lastLogin,
    this.lastLoginIp,
    this.zipcode,
    this.taxId,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.register,
    this.facebookId,
    this.lastApiToken,
  });

  final int id;
  final String name;
  final String surname;
  final int gender;
  final String email;
  final String phone;
  final DateTime emailVerifiedAt;
  final String registerToken;
  final int status;
  final String notification;
  final DateTime lastLogin;
  final String lastLoginIp;
  final dynamic zipcode;
  final dynamic taxId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final dynamic deletedAt;
  final int register;
  final dynamic facebookId;
  final String lastApiToken;

  factory Buyer.fromJson(Map<String, dynamic> json) => Buyer(
    id: json["id"] == null ? null : json["id"],
    name: json["name"] == null ? null : json["name"],
    surname: json["surname"] == null ? null : json["surname"],
    gender: json["gender"] == null ? null : json["gender"],
    email: json["email"] == null ? null : json["email"],
    phone: json["phone"] == null ? null : json["phone"],
    emailVerifiedAt: json["email_verified_at"] == null ? null : DateTime.parse(json["email_verified_at"]),
    registerToken: json["register_token"] == null ? null : json["register_token"],
    status: json["status"] == null ? null : json["status"],
    notification: json["notification"] == null ? null : json["notification"],
    lastLogin: json["last_login"] == null ? null : DateTime.parse(json["last_login"]),
    lastLoginIp: json["last_login_ip"] == null ? null : json["last_login_ip"],
    zipcode: json["zipcode"],
    taxId: json["taxId"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    deletedAt: json["deleted_at"],
    register: json["register"] == null ? null : json["register"],
    facebookId: json["facebookId"],
    lastApiToken: json["lastApiToken"] == null ? null : json["lastApiToken"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "name": name == null ? null : name,
    "surname": surname == null ? null : surname,
    "gender": gender == null ? null : gender,
    "email": email == null ? null : email,
    "phone": phone == null ? null : phone,
    "email_verified_at": emailVerifiedAt == null ? null : emailVerifiedAt.toIso8601String(),
    "register_token": registerToken == null ? null : registerToken,
    "status": status == null ? null : status,
    "notification": notification == null ? null : notification,
    "last_login": lastLogin == null ? null : lastLogin.toIso8601String(),
    "last_login_ip": lastLoginIp == null ? null : lastLoginIp,
    "zipcode": zipcode,
    "taxId": taxId,
    "created_at": createdAt == null ? null : createdAt.toIso8601String(),
    "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
    "deleted_at": deletedAt,
    "register": register == null ? null : register,
    "facebookId": facebookId,
    "lastApiToken": lastApiToken == null ? null : lastApiToken,
  };
}

class DetailSeller {
  DetailSeller({
    this.id,
    this.uid,
    this.ordercode,
    this.createdAt,
    this.name,
    this.deliveryType,
    this.deliveryTime,
    this.deliveryTime2,
    this.totalItem,
    this.total,
    this.status,
    this.cargoPrice,
    this.cancelNote,
  });

  final int id;
  final int uid;
  final String ordercode;
  final DateTime createdAt;
  final String name;
  final int deliveryType;
  final DateTime deliveryTime;
  final String deliveryTime2;
  final int totalItem;
  final String total;
  final int status;
  final String cargoPrice;
  final dynamic cancelNote;

  factory DetailSeller.fromJson(Map<String, dynamic> json) => DetailSeller(
    id: json["id"] == null ? null : json["id"],
    uid: json["uid"] == null ? null : json["uid"],
    ordercode: json["ordercode"] == null ? null : json["ordercode"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    name: json["name"] == null ? null : json["name"],
    deliveryType: json["deliveryType"] == null ? null : json["deliveryType"],
    deliveryTime: json["deliveryTime"] == null ? null : DateTime.parse(json["deliveryTime"]),
    deliveryTime2: json["deliveryTime2"] == null ? null : json["deliveryTime2"],
    totalItem: json["totalItem"] == null ? null : json["totalItem"],
    total: json["total"] == null ? null : json["total"],
    status: json["status"] == null ? null : json["status"],
    cargoPrice: json["cargoPrice"] == null ? null : json["cargoPrice"],
    cancelNote: json["cancel_note"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "uid": uid == null ? null : uid,
    "ordercode": ordercode == null ? null : ordercode,
    "created_at": createdAt == null ? null : createdAt.toIso8601String(),
    "name": name == null ? null : name,
    "deliveryType": deliveryType == null ? null : deliveryType,
    "deliveryTime": deliveryTime == null ? null : deliveryTime.toIso8601String(),
    "deliveryTime2": deliveryTime2 == null ? null : deliveryTime2,
    "totalItem": totalItem == null ? null : totalItem,
    "total": total == null ? null : total,
    "status": status == null ? null : status,
    "cargoPrice": cargoPrice == null ? null : cargoPrice,
    "cancel_note": cancelNote,
  };
}

class ProductSeller {
  ProductSeller({
    this.id,
    this.name,
    this.image,
    this.price,
    this.qty,
    this.approvedQty,
  });

  final int id;
  final String name;
  final String image;
  final String price;
  int qty;
  final String approvedQty;

  factory ProductSeller.fromJson(Map<String, dynamic> json) => ProductSeller(
    id: json["id"] == null ? null : json["id"],
    name: json["name"] == null ? null : json["name"],
    image: json["image"] == null ? null : json["image"],
    price: json["price"] == null ? null : json["price"],
    qty: json["qty"] == null ? null : json["qty"],
    approvedQty: json["approved_qty"] == null ? null : json["approved_qty"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "name": name == null ? null : name,
    "image": image == null ? null : image,
    "price": price == null ? null : price,
    "qty": qty == null ? null : qty,
    "approved_qty": approvedQty == null ? null : approvedQty,
  };
}
