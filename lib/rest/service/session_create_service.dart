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

import 'package:beysion/rest/entity/user/session_create_entity.dart';
import 'package:beysion/rest/response_models/base_response.dart';

import '../get_request.dart';
import 'crud_service.dart';

class SessionCreateService extends CrudService<SessionCreateEntity>{

  static SessionCreateService operations(){
    return new SessionCreateService();
  }

  //TODO AUTH_TOKEN LOOSE
  Future<BaseResponse> sessionCreate() async {
    return await getRequest("$mainServerURL/createsession/mobile");
  }

}