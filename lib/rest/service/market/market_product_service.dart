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
import 'package:beysion/rest/entity/user/product_entity.dart';
import 'package:beysion/rest/post_request.dart';
import 'package:beysion/rest/response_models/base_response.dart';

import '../crud_service.dart';

class MarketProductService extends CrudService<ProductEntity>{

  static MarketProductService operations(){
    return new MarketProductService();
  }

  // TODO ORDER = 0 (STANDART LİSTE)
  // TODO ORDER = 1 (ARTAN FİYAT)
  // TODO ORDER = 2 (AZALAN FİYAT)

  //TODO AUTH_TOKEN LOOSE  -- ANA EKRAN MARKET LİSTESİ
  Future<BaseResponse> marketProducts(int marketId, int categoryId, String search, String _token,{int page = 0 ,int order = 0}) async {
    return await postRequest("$apiURL/market/products?"
        "id=$marketId&"
        "category=$categoryId&"
        "page=$page&"
        "search=$search&"
        "order=$order&"
        "_token=$_token");
  }

  Future<BaseResponse> marketCampaignProducts(int marketId, String search, String _token,{int page = 0 ,int order = 0}) async {
    return await postRequest("$apiURL/market/products?"
        "id=$marketId&"
        "page=$page&"
        "search=$search&"
        "order=$order&"
        "_token=$_token&"
        "campaigns=1");
  }

}