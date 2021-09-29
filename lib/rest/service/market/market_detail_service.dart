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

import 'package:beysion/rest/entity/user/market/market_detail_entity.dart';
import 'package:beysion/rest/post_request.dart';
import 'package:beysion/rest/response_models/base_response.dart';

import '../crud_service.dart';

class MarketDetailService extends CrudService<MarketDetailEntity>{

  static MarketDetailService operations(){
    return new MarketDetailService();
  }

  //TODO AUTH_TOKEN LOOSE  -- ANA EKRAN MARKET LİSTESİ
  Future<BaseResponse> marketDetail(int marketId, int lieferService, int abholService) async {
    return await postRequest("$apiURL/markets/details?id=$marketId&lieferservice=$lieferService&abholservice=$abholService");
  }

}