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

import 'package:beysion/rest/entity/user/market/markets_home_entity.dart';
import 'package:beysion/rest/post_request.dart';
import 'package:beysion/rest/response_models/base_response.dart';

import '../crud_service.dart';

class MarketsHomeService extends CrudService<MarketsHomeEntity>{

  static MarketsHomeService operations(){
    return new MarketsHomeService();
  }

  //TODO AUTH_TOKEN LOOSE  -- ANA EKRAN MARKET LİSTESİ
  Future<BaseResponse> marketsHome(String zipPlzCode, int lieferService, int abholService, int orderCount) async {
    return await postRequest("$apiURL/markets/home?plz=$zipPlzCode&lieferservice=$lieferService&abholservice=$abholService&order=$orderCount");
  }

}