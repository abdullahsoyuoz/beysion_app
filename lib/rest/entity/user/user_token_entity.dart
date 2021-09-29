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

import '../../persistent.dart';


class UserTokenEntity extends Persistent{
  UserTokenEntity({
    this.token,
    this.message,
  });

  String token;
  String message;

  factory UserTokenEntity.fromJson(Map<String, dynamic> json) => UserTokenEntity(
    token: json["token"] == null ? null : json["token"],
    message: json["message"] == null ? null : json["message"],
  );

  Map<String, dynamic> toJson() => {
    "token": token == null ? null : token,
    "message": message == null ? null : message,
  };
}

