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

import 'package:beysion/rest/entity/user/campaign_market_entity.dart';
import 'package:beysion/rest/entity/user/session_create_entity.dart';
import 'package:beysion/rest/response_models/base_response.dart';
import 'package:beysion/rest/response_models/ok_response.dart';
import 'package:beysion/rest/service/market/markets_service.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:beysion/rest/service/session_create_service.dart';
import 'package:beysion/constant/app_configurations.dart' as settingRepo;

class MarketCampaignsProvider with ChangeNotifier {

  List<CampaignMarketEntity> _marketCampaignList = new List();

  List<CampaignMarketEntity> get marketCampaignList => _marketCampaignList;

  set marketCampaignList(List<CampaignMarketEntity> value) {
    _marketCampaignList = value;
  }

  int pageToNumber = 0;

  getMarketCampaignsListController({int pageNumber=0, int orderId = 0, String search =""}) async {
    if(pageNumber==0){
      marketCampaignList.clear();
    }else{
      pageToNumber++;
      pageNumber = pageToNumber;
    }
    SharedPreferences sharedPref = await SharedPreferences.getInstance();
    int abholService = 1;
    int lieferService = 1;
    String plzZipCode = "12801";
    if(sharedPref.containsKey("plzZipCode")){
      plzZipCode = sharedPref.getString("plzZipCode");
    }
    if(sharedPref.containsKey("abholService")){
      abholService = sharedPref.getInt("abholService");
    }
    if(sharedPref.containsKey("lieferService")){
      lieferService = sharedPref.getInt("lieferService");
    }
    if(!sharedPref.containsKey("sessionToken")){
      BaseResponse response = await SessionCreateService.operations().sessionCreate();
      try{
        if (response is OkResponse) {
          if (response.body != null) {
            if (response.body["result"] != null) {
              SessionCreateEntity sessionCreateEntity = new SessionCreateEntity.fromJson(response.body);
              if(sessionCreateEntity!=null){
                sharedPref.setString("sessionToken", sessionCreateEntity.result.session);
                settingRepo.sessionToken.value = sessionCreateEntity.result.session;
                BaseResponse response = await MarketsService.operations().campaignMarketsAll(plzZipCode,search,lieferService,abholService,settingRepo.sessionToken.value, page: pageNumber, order: orderId);
                try{
                  if (response is OkResponse) {
                    if (response.body != null) {
                      if (response.body["data"] != null) {
                        List<dynamic> dataList = response.body["data"];
                        List<CampaignMarketEntity> newDataList = new List();
                        for (var dataStr in dataList) {
                          CampaignMarketEntity model = new CampaignMarketEntity.fromJson(dataStr);
                          if (model != null) {
                            newDataList.add(model);
                            print('Market Campaign Product Data -- ${model.name}');
                          }
                        }
                        marketCampaignList.addAll(newDataList);
                        notifyListeners();
                      }
                    }
                  }
                }catch(e){
                  print('Exception Market Campaign Product A List -  $e');
                }
              }
            }
          }
        }
      }catch(e){
        print('Exception Create Session -- $e');
      }
    }else{
      String sessionToken = sharedPref.getString("sessionToken");
      settingRepo.sessionToken.value = sessionToken;
      BaseResponse response = await MarketsService.operations().campaignMarketsAll(plzZipCode,search,lieferService,abholService,sessionToken, page: pageNumber, order: orderId);
      try{
        if (response is OkResponse) {
          if (response.body != null) {
            if (response.body["data"] != null) {
              List<dynamic> dataList = response.body["data"];
              List<CampaignMarketEntity> newDataList = new List();
              for (var dataStr in dataList) {
                CampaignMarketEntity model = new CampaignMarketEntity.fromJson(dataStr);
                if (model != null) {
                  newDataList.add(model);
                 // print('CAMPAİGNS All List Data -- ${model.name}');
                }
              }
              marketCampaignList.addAll(newDataList);
              notifyListeners();
            }
          }
        }
      }catch(e){
        print('Exception Market Campaign Product All List -  $e');
      }
    }
  }


}
