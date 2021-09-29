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

import 'package:beysion/rest/entity/user/basket/basket_summary_entity.dart';
import 'package:beysion/rest/response_models/base_response.dart';

import '../../get_request.dart';
import '../crud_service.dart';
import 'package:beysion/constant/app_configurations.dart' as settingRepo;

class BasketSummaryService extends CrudService<BasketSummaryEntity>{

  static BasketSummaryService operations(){
    return new BasketSummaryService();
  }

  //TODO AUTH_TOKEN LOOSE
  Future<BaseResponse> basketSummary() async {
    String sessionToken = settingRepo.sessionToken.value;
    return await getRequest("$apiURL/basket/summary?_token=$sessionToken");
  }

}