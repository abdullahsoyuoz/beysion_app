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

import 'package:beysion/rest/entity/user/market/market_brand_entity.dart';
import 'package:beysion/rest/get_request.dart';
import 'package:beysion/rest/post_request.dart';
import 'package:beysion/rest/response_models/base_response.dart';

import '../crud_service.dart';

class MarketBrandService extends CrudService<MarketBrandEntity>{

  static MarketBrandService operations(){
    return new MarketBrandService();
  }

  //TODO AUTH_TOKEN LOOSE  -- MARKET DETAY SAYFASINDA
  Future<BaseResponse> marketInBrands(int marketId) async {
    return await postRequest("$apiURL/market/brands?id=$marketId");
  }

  //TODO AUTH_TOKEN LOOSE  -- MARKET DETAY SAYFASINDA
  Future<BaseResponse> marketBrandsList() async {
    return await getRequest("$apiURL/market/brands");
  }

}