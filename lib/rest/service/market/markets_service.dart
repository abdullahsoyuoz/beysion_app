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

import 'package:beysion/rest/entity/user/market/markets_all_entity.dart';
import 'package:beysion/rest/post_request.dart';
import 'package:beysion/rest/response_models/base_response.dart';

import '../../get_request.dart';
import '../crud_service.dart';
import 'package:beysion/constant/app_configurations.dart' as settingRepo;

class MarketsService extends CrudService<MarketsAllEntity>{

  static MarketsService operations(){
    return new MarketsService();
  }
  int lieferService = settingRepo.lieferService.value;
  int abholService = settingRepo.abholService.value;
  int plzZipCode = settingRepo.zipCodeSelectedEntity.value.id;
  String sessionToken = settingRepo.sessionToken.value;

  //TODO AUTH_TOKEN LOOSE  -- ANA EKRAN MARKET LİSTESİ ve TÜM ÜRÜNLER MARKETLER
  Future<BaseResponse> allMarketList(String zipPlzCode, int lieferService, int abholService) async {
    return await postRequest("$apiURL/markets/list?plz=$zipPlzCode&lieferservice=$lieferService&abholservice=$abholService");
  }

  // TODO ORDER = 0 (STANDART LİSTE)
  // TODO ORDER = 1 (ARTAN FİYAT)
  // TODO ORDER = 2 (AZALAN FİYAT)

  //TODO AUTH_TOKEN LOOSE  -- MARKET LİSTESİ SAYFASI
  Future<BaseResponse> allMarketsListInformation(
      String zipPlzCode,
      String search,
      int lieferService,
      int abholService,
      String _token,
      {int page = 0 ,
        int order = 0}) async {
    return await postRequest("$apiURL/markets/all?"
        "page=$page&"
        "search=$search&"
        "order=$order&"
        "plz=$zipPlzCode&"
        "lieferservice=$lieferService&"
        "abholservice=$abholService&"
        "_token=$_token");
  }

  //TODO AUTH_TOKEN LOOSE  -- MARKET LİSTESİ SAYFASI
  Future<BaseResponse> campaignMarketsAll(
      String zipPlzCode,
      String search,
      int lieferService,
      int abholService,
      String _token,
      {int page = 0 ,
        int order = 0}) async {
    return await postRequest("$apiURL/markets/campaigns?"
        "page=$page&"
        "search=$search&"
        "order=$order&"
        "plz=$zipPlzCode&"
        "lieferservice=$lieferService&"
        "abholservice=$abholService&"
        "_token=$_token");
  }
}