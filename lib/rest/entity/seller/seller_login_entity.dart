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

class SellerLoginEntity extends Persistent{
  SellerLoginEntity({
    this.token,
    this.sellerCompanyDetail,
    this.detail,
    this.message,
  });

  final String token;
  final Detail detail;
  final SellerCompanyDetail sellerCompanyDetail;
  final String message;

  factory SellerLoginEntity.fromJson(Map<String, dynamic> json) => SellerLoginEntity(
    token: json["token"] == null ? null : json["token"],
    sellerCompanyDetail: json["seller"] == null ? null : SellerCompanyDetail.fromJson(json["seller"]),
    detail: json["detail"] == null ? null : Detail.fromJson(json["detail"]),
    message: json["message"] == null ? null : json["message"],
  );

  Map<String, dynamic> toJson() => {
    "token": token == null ? null : token,
    "detail": detail == null ? null : detail.toJson(),
    "message": message == null ? null : message,
  };
}

class SellerCompanyDetail {
  SellerCompanyDetail({
    this.companyName,
    this.email,
    this.taxId,
  });

  final String companyName;
  final String email;
  final String taxId;

  factory SellerCompanyDetail.fromJson(Map<String, dynamic> json) => SellerCompanyDetail(
    companyName: json["companyName"] == null ? null : json["companyName"],
    email: json["email"] == null ? null : json["email"],
    taxId: json["taxId"] == null ? null : json["taxId"],
  );

  Map<String, dynamic> toJson() => {
    "companyName": companyName == null ? null : companyName,
    "email": email == null ? null : email,
    "taxId": taxId == null ? null : taxId,
  };
}


class Detail {
  Detail({
    this.id,
    this.sid,
    this.name,
    this.preparingTime,
    this.deliveryTime,
    this.delivery,
    this.minimumSellPrice,
    this.minimumSellPrice2,
    this.firstPage,
    this.aboutUs,
    this.workingday1,
    this.workingday2,
    this.workingday3,
    this.workingday4,
    this.workingday5,
    this.workingday6,
    this.workingday7,
    this.workingday1Start,
    this.workingday1End,
    this.workingday2Start,
    this.workingday2End,
    this.workingday3Start,
    this.workingday3End,
    this.workingday4Start,
    this.workingday4End,
    this.workingday5Start,
    this.workingday5End,
    this.workingday6Start,
    this.workingday6End,
    this.workingday7Start,
    this.workingday7End,
    this.status,
    this.officialName,
    this.officialSurname,
    this.officialGender,
    this.phone,
    this.mobiltelefon,
    this.address,
    this.province,
    this.district,
    this.zipcode,
    this.logo,
    this.slug,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.point1,
    this.point2,
    this.point3,
    this.excel,
  });

  final int id;
  final int sid;
  final String name;
  final int preparingTime;
  final int deliveryTime;
  final int delivery;
  final int minimumSellPrice;
  final int minimumSellPrice2;
  final int firstPage;
  final dynamic aboutUs;
  final int workingday1;
  final int workingday2;
  final int workingday3;
  final int workingday4;
  final int workingday5;
  final int workingday6;
  final int workingday7;
  final String workingday1Start;
  final String workingday1End;
  final String workingday2Start;
  final String workingday2End;
  final String workingday3Start;
  final String workingday3End;
  final String workingday4Start;
  final String workingday4End;
  final String workingday5Start;
  final String workingday5End;
  final String workingday6Start;
  final String workingday6End;
  final String workingday7Start;
  final String workingday7End;
  final int status;
  final String officialName;
  final String officialSurname;
  final int officialGender;
  final String phone;
  final String mobiltelefon;
  final String address;
  final dynamic province;
  final dynamic district;
  final String zipcode;
  final String logo;
  final String slug;
  final DateTime createdAt;
  final DateTime updatedAt;
  final dynamic deletedAt;
  final String point1;
  final String point2;
  final String point3;
  final String excel;

  factory Detail.fromJson(Map<String, dynamic> json) => Detail(
    id: json["id"] == null ? null : json["id"],
    sid: json["sid"] == null ? null : json["sid"],
    name: json["name"] == null ? null : json["name"],
    preparingTime: json["preparingTime"] == null ? null : json["preparingTime"],
    deliveryTime: json["deliveryTime"] == null ? null : json["deliveryTime"],
    delivery: json["delivery"] == null ? null : json["delivery"],
    minimumSellPrice: json["minimumSellPrice"] == null ? null : json["minimumSellPrice"],
    minimumSellPrice2: json["minimumSellPrice2"] == null ? null : json["minimumSellPrice2"],
    firstPage: json["firstPage"] == null ? null : json["firstPage"],
    aboutUs: json["aboutUs"],
    workingday1: json["workingday1"] == null ? null : json["workingday1"],
    workingday2: json["workingday2"] == null ? null : json["workingday2"],
    workingday3: json["workingday3"] == null ? null : json["workingday3"],
    workingday4: json["workingday4"] == null ? null : json["workingday4"],
    workingday5: json["workingday5"] == null ? null : json["workingday5"],
    workingday6: json["workingday6"] == null ? null : json["workingday6"],
    workingday7: json["workingday7"] == null ? null : json["workingday7"],
    workingday1Start: json["workingday1_start"] == null ? null : json["workingday1_start"],
    workingday1End: json["workingday1_end"] == null ? null : json["workingday1_end"],
    workingday2Start: json["workingday2_start"] == null ? null : json["workingday2_start"],
    workingday2End: json["workingday2_end"] == null ? null : json["workingday2_end"],
    workingday3Start: json["workingday3_start"] == null ? null : json["workingday3_start"],
    workingday3End: json["workingday3_end"] == null ? null : json["workingday3_end"],
    workingday4Start: json["workingday4_start"] == null ? null : json["workingday4_start"],
    workingday4End: json["workingday4_end"] == null ? null : json["workingday4_end"],
    workingday5Start: json["workingday5_start"] == null ? null : json["workingday5_start"],
    workingday5End: json["workingday5_end"] == null ? null : json["workingday5_end"],
    workingday6Start: json["workingday6_start"] == null ? null : json["workingday6_start"],
    workingday6End: json["workingday6_end"] == null ? null : json["workingday6_end"],
    workingday7Start: json["workingday7_start"] == null ? null : json["workingday7_start"],
    workingday7End: json["workingday7_end"] == null ? null : json["workingday7_end"],
    status: json["status"] == null ? null : json["status"],
    officialName: json["officialName"] == null ? null : json["officialName"],
    officialSurname: json["officialSurname"] == null ? null : json["officialSurname"],
    officialGender: json["officialGender"] == null ? null : json["officialGender"],
    phone: json["phone"] == null ? null : json["phone"],
    mobiltelefon: json["mobiltelefon"] == null ? null : json["mobiltelefon"],
    address: json["address"] == null ? null : json["address"],
    province: json["province"],
    district: json["district"],
    zipcode: json["zipcode"] == null ? null : json["zipcode"],
    logo: json["logo"] == null ? null : json["logo"],
    slug: json["slug"] == null ? null : json["slug"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    deletedAt: json["deleted_at"],
    point1: json["point1"] == null ? null : json["point1"],
    point2: json["point2"] == null ? null : json["point2"],
    point3: json["point3"] == null ? null : json["point3"],
    excel: json["excel"] == null ? null : json["excel"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "sid": sid == null ? null : sid,
    "name": name == null ? null : name,
    "preparingTime": preparingTime == null ? null : preparingTime,
    "deliveryTime": deliveryTime == null ? null : deliveryTime,
    "delivery": delivery == null ? null : delivery,
    "minimumSellPrice": minimumSellPrice == null ? null : minimumSellPrice,
    "minimumSellPrice2": minimumSellPrice2 == null ? null : minimumSellPrice2,
    "firstPage": firstPage == null ? null : firstPage,
    "aboutUs": aboutUs,
    "workingday1": workingday1 == null ? null : workingday1,
    "workingday2": workingday2 == null ? null : workingday2,
    "workingday3": workingday3 == null ? null : workingday3,
    "workingday4": workingday4 == null ? null : workingday4,
    "workingday5": workingday5 == null ? null : workingday5,
    "workingday6": workingday6 == null ? null : workingday6,
    "workingday7": workingday7 == null ? null : workingday7,
    "workingday1_start": workingday1Start == null ? null : workingday1Start,
    "workingday1_end": workingday1End == null ? null : workingday1End,
    "workingday2_start": workingday2Start == null ? null : workingday2Start,
    "workingday2_end": workingday2End == null ? null : workingday2End,
    "workingday3_start": workingday3Start == null ? null : workingday3Start,
    "workingday3_end": workingday3End == null ? null : workingday3End,
    "workingday4_start": workingday4Start == null ? null : workingday4Start,
    "workingday4_end": workingday4End == null ? null : workingday4End,
    "workingday5_start": workingday5Start == null ? null : workingday5Start,
    "workingday5_end": workingday5End == null ? null : workingday5End,
    "workingday6_start": workingday6Start == null ? null : workingday6Start,
    "workingday6_end": workingday6End == null ? null : workingday6End,
    "workingday7_start": workingday7Start == null ? null : workingday7Start,
    "workingday7_end": workingday7End == null ? null : workingday7End,
    "status": status == null ? null : status,
    "officialName": officialName == null ? null : officialName,
    "officialSurname": officialSurname == null ? null : officialSurname,
    "officialGender": officialGender == null ? null : officialGender,
    "phone": phone == null ? null : phone,
    "mobiltelefon": mobiltelefon == null ? null : mobiltelefon,
    "address": address == null ? null : address,
    "province": province,
    "district": district,
    "zipcode": zipcode == null ? null : zipcode,
    "logo": logo == null ? null : logo,
    "slug": slug == null ? null : slug,
    "created_at": createdAt == null ? null : createdAt.toIso8601String(),
    "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
    "deleted_at": deletedAt,
    "point1": point1 == null ? null : point1,
    "point2": point2 == null ? null : point2,
    "point3": point3 == null ? null : point3,
    "excel": excel == null ? null : excel,
  };
}
