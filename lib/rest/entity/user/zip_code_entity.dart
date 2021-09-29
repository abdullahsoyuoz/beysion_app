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


class ZipCodeEntity extends Persistent{
  ZipCodeEntity({
    this.id,
    this.text,
  });

  int id;
  String text;

  factory ZipCodeEntity.fromJson(Map<String, dynamic> json) => ZipCodeEntity(
    id: json["id"] == null ? null : json["id"],
    text: json["text"] == null ? null : json["text"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "text": text == null ? null : text,
  };
}

