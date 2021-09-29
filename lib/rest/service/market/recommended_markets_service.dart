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

import 'package:beysion/rest/entity/user/market/recommended_markets_entity.dart';
import 'package:beysion/rest/post_request.dart';
import 'package:beysion/rest/response_models/base_response.dart';

import '../crud_service.dart';

class RecommendedMarketsService extends CrudService<RecommendedMarketsEntity>{

  static RecommendedMarketsService operations(){
    return new RecommendedMarketsService();
  }

  //TODO AUTH_TOKEN LOOSE  -- ANA EKRAN MARKET LİSTESİ
  Future<BaseResponse> marketsRecommended(String zipPlzCode, int lieferService, int abholService) async {
    return await postRequest("$apiURL/markets/recommended?plz=$zipPlzCode&lieferservice=$lieferService&abholservice=$abholService");
  }

}