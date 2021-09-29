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
import 'package:beysion/rest/get_request.dart';
import 'package:beysion/rest/persistent.dart';
import 'package:beysion/rest/response_models/base_response.dart';

import '../../post_request.dart';
import '../crud_service.dart';

class ProductAllService extends CrudService<ProductEntity>{

  static ProductAllService operations(){
    return new ProductAllService();
  }

  //TODO AUTH_TOKEN LOOSE  -- TÜM ÜRÜNLER KATEOGORİ LİSTESİ
  Future<BaseResponse> allCategories() async {
    return await getRequest("$apiURL/market/categories");
  }

  //TODO AUTH_TOKEN LOOSE  -- TÜM ÜRÜNLER MARKA LİSTESİ
  Future<BaseResponse> allBrands() async {
    return await getRequest("$apiURL/market/brands");
  }

  //TODO AUTH_TOKEN LOOSE  -- TÜM ÜRÜNLER LİSTESİ
  Future<BaseResponse> allProducts(int categoryId, String search,String zipPlzCode, String _token,int lieferService, int abholService,{int page = 0 ,int order = 0}) async {
    return await postRequest("$apiURL/product/all?"
        "category=$categoryId&"
        "plz=$zipPlzCode&"
        "lieferservice=$lieferService&"
        "abholservice=$abholService&"
        "page=$page&"
        "search=$search&"
        "order=$order&"
        "_token=$_token");
  }

}