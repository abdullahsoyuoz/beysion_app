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


class SessionCreateEntity extends Persistent{
  SessionCreateEntity({
    this.response,
    this.result,
  });

  String response;
  Result result;

  factory SessionCreateEntity.fromJson(Map<String, dynamic> json) => SessionCreateEntity(
    response: json["response"] == null ? null : json["response"],
    result: json["result"] == null ? null : Result.fromJson(json["result"]),
  );

  Map<String, dynamic> toJson() => {
    "response": response == null ? null : response,
    "result": result == null ? null : result.toJson(),
  };

}

class Result {
  Result({
    this.session,
  });

  String session;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    session: json["session"] == null ? null : json["session"],
  );

  Map<String, dynamic> toJson() => {
    "session": session == null ? null : session,
  };
}
