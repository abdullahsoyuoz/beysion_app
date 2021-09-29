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


import 'package:beysion/rest/entity/user/zip_code_entity.dart';
import 'package:beysion/rest/post_request.dart';
import 'package:beysion/rest/response_models/base_response.dart';

import 'crud_service.dart';

class ZipCodeService extends CrudService<ZipCodeEntity>{

  static ZipCodeService operations(){
    return new ZipCodeService();
  }

  //TODO AUTH_TOKEN LOOSE
  Future<BaseResponse> zipCodeSearch(String search) async {
    return await postRequest("$apiURL/search/zipcode?search=$search");
  }


}