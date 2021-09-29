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

import 'package:beysion/rest/entity/user/basket/basket_message_return_entity.dart';
import 'package:beysion/rest/response_models/base_response.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../get_request.dart';
import '../../persistent.dart';
import '../../post_request.dart';
import '../crud_service.dart';
import 'package:beysion/constant/app_configurations.dart' as settingRepo;

class BasketService extends CrudService<BasketMessageReturnEntity>{

  static BasketService operations(){
    return new BasketService();
  }

  //TODO AUTH_TOKEN LOOSE  -- SEPETE EKLE
  Future<BaseResponse> basketUpdate(int productId, int quantity) async {
    int lieferService = settingRepo.lieferService.value;
    int abholService = settingRepo.abholService.value;
    int plzZipCode = settingRepo.zipCodeSelectedEntity.value.id;
    String sessionToken = settingRepo.sessionToken.value;
    return await postRequest("$apiURL/basket/update?adsid=$productId&qty=$quantity&lieferservice=$lieferService&abholservice=$abholService&plz=$plzZipCode&_token=$sessionToken");
  }

  //TODO AUTH_TOKEN LOOSE  -- SEPETE EKLE
  Future<BaseResponse> addBasket(int productId, {int acceptId}) async {
    int lieferService = settingRepo.lieferService.value;
    int abholService = settingRepo.abholService.value;
    int plzZipCode = settingRepo.zipCodeSelectedEntity.value.id;
    String sessionToken = settingRepo.sessionToken.value;
    if(acceptId!=null){
      return await postRequest("$apiURL/basket/add?adsid=$productId&plz=$plzZipCode&lieferservice=$lieferService&abholservice=$abholService&_token=$sessionToken&accept=1");
    }else{
      return await postRequest("$apiURL/basket/add?adsid=$productId&plz=$plzZipCode&lieferservice=$lieferService&abholservice=$abholService&_token=$sessionToken");
    }
  }

  //TODO AUTH_TOKEN LOOSE  -- ÜRÜNÜ SEPETTEN SİL
  Future<BaseResponse> deleteBasketProduct(int productId) async {
    String sessionToken = settingRepo.sessionToken.value;
    return await postRequest("$apiURL/basket/delete?adsid=$productId&_token=$sessionToken");
  }

  //TODO AUTH_TOKEN LOOSE  -- SEÇİLEN ÜRÜN veya Ürünleri SEPETTEN SİL
  Future<BaseResponse> deleteAllBasketProducts(List<int> deletedItemDataList) async {
    String sessionToken = settingRepo.sessionToken.value;
    BasketDeleteItem _basketDeleteItem = new BasketDeleteItem();
    _basketDeleteItem.deleteItemAdsids = deletedItemDataList;
    _basketDeleteItem.token = sessionToken ;
    return await postRequest("$apiURL/basket/deleteMultiple", model: _basketDeleteItem);
  }

  //TODO AUTH_TOKEN LOOSE  -- SEPET DETAY
  Future<BaseResponse> basketGetDetail() async {
    int lieferService = settingRepo.lieferService.value;
    int abholService = settingRepo.abholService.value;
    int plzZipCode = settingRepo.zipCodeSelectedEntity.value.id;
    String sessionToken = settingRepo.sessionToken.value;
    return await getRequest("$apiURL/basket/detail?_token=$sessionToken&plz=$plzZipCode&lieferservice=$lieferService&abholservice=$abholService");
  }

}

class BasketDeleteItem extends Persistent{
  BasketDeleteItem({
    this.deleteItemAdsids,
    this.token,
  });

  List<int> deleteItemAdsids;
  String token;

  factory BasketDeleteItem.fromJson(Map<String, dynamic> json) => BasketDeleteItem(
    deleteItemAdsids: json["adsids"] == null ? null : json["adsids"],
    token: json["_token"] == null ? null : json["_token"],
  );

  Map<String, dynamic> toJson() => {
    "adsids": deleteItemAdsids == null ? null : deleteItemAdsids,
    "_token": token == null ? null : token,
  };
}