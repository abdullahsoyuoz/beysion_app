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


import 'package:beysion/rest/entity/user/postal_code_select_entity.dart';
import 'package:beysion/rest/get_request.dart';
import 'package:beysion/rest/response_models/base_response.dart';

import 'crud_service.dart';

class PostalCodeSelectService extends CrudService<PostalCodeSelectEntity>{

  static PostalCodeSelectService operations(){
    return new PostalCodeSelectService();
  }

  //TODO AUTH_TOKEN LOOSE
  Future<BaseResponse> postalCodeSearch(String latLong) async {
    return await getRequest("https://maps.googleapis.com/maps/api/geocode/json?latlng=$latLong&sensor=true&key=AIzaSyDuzSJKqezawI8gJi7qx-TJ2N_jT7oKoCs");
  }


}