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

class MarketBrandEntity extends Persistent{
  MarketBrandEntity({
    this.id,
    this.name,
    this.checkData = false,
  });

  int id;
  String name;
  bool checkData;

  factory MarketBrandEntity.fromJson(Map<String, dynamic> json) => MarketBrandEntity(
    id: json["id"] == null ? null : json["id"],
    name: json["name"] == null ? null : json["name"],
    checkData: false,
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "name": name == null ? null : name,
  };
}


