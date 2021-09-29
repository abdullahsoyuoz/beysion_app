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

import 'package:beysion/rest/entity/user/market/market_category_entity.dart';
import 'package:beysion/rest/post_request.dart';
import 'package:beysion/rest/response_models/base_response.dart';

import '../../get_request.dart';
import '../crud_service.dart';

class MarketCategoryService extends CrudService<MarketCategoryEntity>{

  static MarketCategoryService operations(){
    return new MarketCategoryService();
  }

  //TODO AUTH_TOKEN LOOSE  MARKET DETAY SAYFASINDA
  Future<BaseResponse> marketInCategories(int marketId) async {
    return await postRequest("$apiURL/market/categories?id=$marketId");
  }

  //TODO AUTH_TOKEN LOOSE  ANA EKRAN
  Future<BaseResponse> marketCategoryList() async {
    return await getRequest("$apiURL/categories/list");
  }

}