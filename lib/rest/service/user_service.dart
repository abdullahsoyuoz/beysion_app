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

import 'package:beysion/rest/entity/user/basket/basket_send_data.dart';
import 'package:beysion/rest/entity/user/user_login_entity.dart';
import 'package:beysion/rest/entity/user/user_register_entity.dart';
import 'package:beysion/rest/persistent.dart';
import 'package:beysion/rest/post_request.dart';
import 'package:beysion/rest/response_models/base_response.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:beysion/constant/app_configurations.dart' as settingRepo;

import '../get_request.dart';
import 'crud_service.dart';

class UserService extends CrudService<UserLoginInformationEntity>{

  static UserService operations(){
    return new UserService();
  }

  //TODO AUTH_TOKEN LOOSE
  Future<BaseResponse> loginUser(String email, String password) async {
    String sessionToken = settingRepo.sessionToken.value;
    print('SESSİON TOKEN LOGİN USER -  $sessionToken');
    UserEmailPassword userEmailPassword = new UserEmailPassword(email: email, password: password, token: sessionToken);
    return await postRequest("$apiURL/auth/client", model: userEmailPassword);
  }

  Future<BaseResponse> userInformationShow() async {
    String bearerToken = settingRepo.currentUserTokenEntity.value.token;
    return await getRequest("$apiURL/client/information/show", bearerToken: bearerToken);
  }

  Future<BaseResponse> userUpdate(String name, String surname, String phone, int gender, {String password, String passwordConfirm}) async {
    if(password!=null && passwordConfirm!=null){
      UserUpdatePasswordEntity userUpdatePasswordEntity = new UserUpdatePasswordEntity(name: name,surname: surname, gender: gender,phone: phone, password: password, passwordConfirm: passwordConfirm);
      String bearerToken = settingRepo.currentUserTokenEntity.value.token;
      return await postRequest("$apiURL/client/information/update", bearerToken: bearerToken, model: userUpdatePasswordEntity);
    }else{
      UserUpdateEntity userUpdatePasswordEntity = new UserUpdateEntity(name: name,surname: surname, gender: gender,phone: phone);
      String bearerToken = settingRepo.currentUserTokenEntity.value.token;
      return await postRequest("$apiURL/client/information/update", bearerToken: bearerToken, model: userUpdatePasswordEntity);
    }
  }

  Future<BaseResponse> userRegister(UserRegisterEntity userRegisterEntity) async {
    return await postRequest("$apiURL/client/register", model: userRegisterEntity);
  }

  Future<BaseResponse> userActivate(String token) async {
    return await postRequest("$apiURL/client/activate?token=$token");
  }

  Future<BaseResponse> userReset(String email) async {
    return await postRequest("$apiURL/client/reset?email=$email");
  }

  Future<BaseResponse> userResetVerify(String token, String password, String passwordConfirmation) async {
    return await postRequest("$apiURL/client/reset/verify?token=$token&password=$password&password_confirmation=$passwordConfirmation");
  }

  //#########################################################################################################

  Future<BaseResponse> orderList({int page= 0, int perPage = 5}) async {
    String bearerToken = settingRepo.currentUserTokenEntity.value.token;
    return await postRequest("$apiURL/client/orders?perpage=$perPage&page=$page", bearerToken: bearerToken);
  }

  Future<BaseResponse> orderInformationData(String orderCode) async {
    String bearerToken = settingRepo.currentUserTokenEntity.value.token;
    return await getRequest("$apiURL/client/orders/detail/$orderCode", bearerToken: bearerToken);
  }

  //#########################################################################################################

  Future<BaseResponse> userFavoriteAll() async {
    String bearerToken = settingRepo.currentUserTokenEntity.value.token;
    return await getRequest("$apiURL/client/favorite/all", bearerToken: bearerToken);
  }

  Future<BaseResponse> userFavoriteAdd(int productId) async {
    String bearerToken = settingRepo.currentUserTokenEntity.value.token;
    return await postRequest("$apiURL/client/favorite/add?id=$productId", bearerToken: bearerToken);
  }

  Future<BaseResponse> userFavoriteDelete(int productId) async {
    String bearerToken = settingRepo.currentUserTokenEntity.value.token;
    return await postRequest("$apiURL/client/favorite/delete?id=$productId", bearerToken: bearerToken);
  }

  Future<BaseResponse> userFavoriteDeleteAll() async {
    String bearerToken = settingRepo.currentUserTokenEntity.value.token;
    return await postRequest("$apiURL/client/favorite/deleteAll", bearerToken: bearerToken);
  }

  //############################################################################################################

  Future<BaseResponse> basketOrderApproved(BasketSendData basketSendData) async {
    String bearerToken = settingRepo.currentUserTokenEntity.value.token;
    return await postRequest("$apiURL/client/makeorder", bearerToken: bearerToken, model: basketSendData);
  }
}

class UserEmailPassword extends Persistent{
  UserEmailPassword({
    this.email,
    this.password,
    this.token,
  });

  String email;
  String password;
  String token;

  factory UserEmailPassword.fromJson(Map<String, dynamic> json) => UserEmailPassword(
    email: json["email"] == null ? null : json["email"],
    password: json["password"] == null ? null : json["password"],
    token: json["_token"] == null ? null : json["_token"],
  );

  Map<String, dynamic> toJson() => {
    "email": email == null ? null : email,
    "password": password == null ? null : password,
    "_token": token == null ? null : token,
  };
}

class UserUpdateEntity extends Persistent{
  UserUpdateEntity({
    this.name,
    this.surname,
    this.gender,
    this.phone,
    this.password,
    this.passwordConfirm,
  });

  String name;
  String surname;
  int gender;
  String phone;
  String password;
  String passwordConfirm;

  factory UserUpdateEntity.fromJson(Map<String, dynamic> json) => UserUpdateEntity(
    name: json["name"] == null ? null : json["name"],
    surname: json["surname"] == null ? null : json["surname"],
    gender: json["gender"] == null ? null : json["gender"],
    phone: json["phone"] == null ? null : json["phone"],
    password: json["password"] == null ? null : json["password"],
    passwordConfirm: json["password_confirm"] == null ? null : json["password_confirm"],
  );

  Map<String, dynamic> toJson() => {
    "name": name == null ? null : name,
    "surname": surname == null ? null : surname,
    "gender": gender == null ? null : gender,
    "phone": phone == null ? null : phone,
    "password": password == null ? null : password,
    "password_confirm": passwordConfirm == null ? null : passwordConfirm,
  };
}

class UserUpdatePasswordEntity extends Persistent{
  UserUpdatePasswordEntity({
    this.name,
    this.surname,
    this.gender,
    this.phone,
    this.password,
    this.passwordConfirm,
  });

  String name;
  String surname;
  int gender;
  String phone;
  String password;
  String passwordConfirm;

  factory UserUpdatePasswordEntity.fromJson(Map<String, dynamic> json) => UserUpdatePasswordEntity(
    name: json["name"] == null ? null : json["name"],
    surname: json["surname"] == null ? null : json["surname"],
    gender: json["gender"] == null ? null : json["gender"],
    phone: json["phone"] == null ? null : json["phone"],
    password: json["password"] == null ? null : json["password"],
    passwordConfirm: json["password_confirm"] == null ? null : json["password_confirm"],
  );

  Map<String, dynamic> toJson() => {
    "name": name == null ? null : name,
    "surname": surname == null ? null : surname,
    "gender": gender == null ? null : gender,
    "phone": phone == null ? null : phone,
    "password": password == null ? null : password,
    "password_confirm": passwordConfirm == null ? null : passwordConfirm,
  };
}



