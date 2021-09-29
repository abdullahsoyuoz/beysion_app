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

import 'package:beysion/rest/entity/user/session_create_entity.dart';
import 'package:beysion/rest/response_models/base_response.dart';
import 'package:beysion/rest/response_models/ok_response.dart';
import 'package:beysion/rest/service/session_create_service.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:beysion/constant/app_configurations.dart' as settingRepo;


class SessionCreateProvider with ChangeNotifier {

  sessionCreateController() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    BaseResponse response = await SessionCreateService.operations().sessionCreate();
    try{
      if(!sharedPreferences.containsKey("sessionToken")){
        sharedPreferences.clear();
        if (response is OkResponse) {
          if (response.body != null) {
            if (response.body["result"] != null) {
              SessionCreateEntity sessionCreateEntity = new SessionCreateEntity.fromJson(response.body);
              if(sessionCreateEntity!=null){
                //print('SessioMobile Showing -- ${sessionCreateEntity.result.session}');
                sharedPreferences.setString("sessionToken", sessionCreateEntity.result.session);
                settingRepo.sessionToken.value = sessionCreateEntity.result.session;
                notifyListeners();
              }
            }
          }
        }
      }else{
        String sessionTokenSepet = sharedPreferences.getString("sessionToken");
        settingRepo.sessionToken.value = sessionTokenSepet;
        print('SESSİON TOKEN CREATE- $sessionTokenSepet');
        print('TOKEN Available');
      }
    }catch(e){
      print('Exception Create Session -- $e');
    }
  }
}
