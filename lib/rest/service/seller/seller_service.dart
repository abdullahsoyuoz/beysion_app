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

import 'package:beysion/rest/entity/seller/seller_login_entity.dart';
import 'package:beysion/rest/entity/seller/seller_order_entity_list.dart';
import 'package:beysion/rest/entity/seller/seller_register_entity.dart';
import 'package:beysion/rest/post_request.dart';
import 'package:beysion/rest/response_models/base_response.dart';
import 'package:beysion/constant/app_configurations.dart' as settingRepo;

import '../../get_request.dart';
import '../crud_service.dart';

class SellerService extends CrudService<SellerLoginEntity>{

  static SellerService operations(){
    return new SellerService();
  }

  //TODO AUTH_TOKEN LOOSE
  Future<BaseResponse> sellerLoginService(String email, String password) async {
    SellerEmailPassword userEmailPassword = new SellerEmailPassword(email: email, password: password);
    return await postRequest("$apiURL/auth/seller", model: userEmailPassword);
  }

  Future<BaseResponse> orderList({int page= 0, String orderCodeSearch, int status}) async {
    String bearerToken = settingRepo.sellerLoginInformationEntity.value.token;
    return await postRequest("$apiURL/seller/orders?page=$page&keyword=$orderCodeSearch&status=$status", bearerToken: bearerToken);
  }

  Future<BaseResponse> orderInformationData(String orderCode) async {
    String bearerToken = settingRepo.sellerLoginInformationEntity.value.token;
    return await getRequest("$apiURL/seller/orders/detail/$orderCode", bearerToken: bearerToken);
  }

  //TODO SİPARİŞ ONAYLAMA
  Future<BaseResponse> orderProcess(String orderCode, List<SelectedOrderProduct> selectedProductList) async {
    OrderProcessEntity orderProcessEntity = new OrderProcessEntity();
    orderProcessEntity.step = "1";
    orderProcessEntity.ordercode = orderCode;
    orderProcessEntity..data = selectedProductList;
    String bearerToken = settingRepo.sellerLoginInformationEntity.value.token;
    return await postRequest("$apiURL/seller/orders/process", bearerToken: bearerToken, model: orderProcessEntity);
  }

  //TODO SİPARİŞ İPTAL ET
  Future<BaseResponse> cancelOrder(String orderCode) async {
    String bearerToken = settingRepo.sellerLoginInformationEntity.value.token;
    return await postRequest("$apiURL/seller/orders/process?step=4&ordercode=$orderCode", bearerToken: bearerToken);
  }


  //#####################################################################################################################

  Future<BaseResponse> sellerRegister(SellerRegisterEntity sellerRegisterEntity) async {
    String bearerToken = settingRepo.currentUserTokenEntity.value.token;
    return await postRequest("$apiURL/seller/register", bearerToken: bearerToken, model: sellerRegisterEntity);
  }

  Future<BaseResponse> sellerActivate(String token) async {
    return await postRequest("$apiURL/seller/activate?token=$token");
  }

  Future<BaseResponse> sellerReset(String email) async {
    return await postRequest("$apiURL/seller/reset?email=$email");
  }

  Future<BaseResponse> sellerResetVerify(String token, String password, String passwordConfirmation) async {
    return await postRequest("$apiURL/seller/reset/verify?token=$token&password=$password&password_confirmation=$passwordConfirmation");
  }

}


