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

import 'package:beysion/rest/entity/user/product_entity.dart';
import 'package:beysion/rest/post_request.dart';
import 'package:beysion/rest/response_models/base_response.dart';

import '../crud_service.dart';

class ProductDiscountedService extends CrudService<ProductEntity>{

  static ProductDiscountedService operations(){
    return new ProductDiscountedService();
  }

  //TODO AUTH_TOKEN LOOSE  -- ANA EKRAN MARKET LİSTESİ
  Future<BaseResponse> productDiscounted(
      String zipPlzCode,
      int lieferService,
      int abholService,
      int category,
      int marketId,
      String _token, {int page = 1}) async {
    return await postRequest("$apiURL/product/discounted?"
        "plz=$zipPlzCode&"
        "lieferservice=$lieferService&"
        "abholservice=$abholService&"
        "category=$category&"
        "market=$marketId&"
        "page=$page&"
        "_token=$_token");
  }

}