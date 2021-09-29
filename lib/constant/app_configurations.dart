

import 'package:beysion/pages/MainPageView.dart';
import 'package:beysion/rest/entity/seller/seller_login_entity.dart';
import 'package:beysion/rest/entity/user/basket/basket_detail_entity.dart';
import 'package:beysion/rest/entity/user/basket/basket_send_data.dart';
import 'package:beysion/rest/entity/user/campaign_market_entity.dart';
import 'package:beysion/rest/entity/user/product_entity.dart';
import 'package:beysion/rest/entity/user/user_address_entity.dart';
import 'package:beysion/rest/entity/user/user_favorite_entity.dart';
import 'package:beysion/rest/entity/user/user_token_entity.dart';
import 'package:beysion/rest/entity/user/zip_code_entity.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';


//TODO SELLER NOTIFIER
ValueNotifier<SellerLoginEntity> sellerLoginInformationEntity = new ValueNotifier(new SellerLoginEntity());


//TODO USER NOTIFIER
ValueNotifier<ZipCodeEntity> zipCodeSelectedEntity = new ValueNotifier(new ZipCodeEntity());
ValueNotifier<UserTokenEntity> currentUserTokenEntity = new ValueNotifier(new UserTokenEntity());
ValueNotifier<Map<int, BasketProductSelect>> mapBasketSendDataEntity = new ValueNotifier(new Map<int, BasketProductSelect>());
ValueNotifier<Map<int, BasketProduct>> selectBasketItemId = new ValueNotifier(new Map<int, BasketProduct>());
ValueNotifier<UserAddressEntity> selectedUserAddress = new ValueNotifier(new UserAddressEntity());
ValueNotifier<int> lieferService = new ValueNotifier(0);
ValueNotifier<int> abholService = new ValueNotifier(0);
ValueNotifier<String> sessionToken = new ValueNotifier("");

ValueNotifier<MainPageViewState> pageViewState = new ValueNotifier(new MainPageViewState());


class AppConfigurations {

  const AppConfigurations();

  static String mainColorRed = "#BB153B";
  static String beysionURL = "http://beysion.getusoft.com";

}

String fiyatYuzdeHesaplama(ProductEntity productEntity, {BasketProduct basketProduct}){

  try{
    if(basketProduct==null){
      double normalFiyat = double.parse(productEntity.price);
      double indirimliFiyat = double.parse(productEntity.discountPrice);

      int sonuc = (((normalFiyat-indirimliFiyat)/normalFiyat)*100).toInt();

      return "%${sonuc.toString()}";
    }else{
      double normalFiyat = double.parse(basketProduct.price);
      double indirimliFiyat = double.parse(basketProduct.discountPrice);

      int sonuc = (((normalFiyat-indirimliFiyat)/normalFiyat)*100).toInt();

      return "%${sonuc.toString()}";
    }
  }catch(e){
    return "Hata";
  }
}

String fiyatYuzdeHesaplamaCampaign(ProductCampaignMarket productEntity, {BasketProduct basketProduct}){

  try{
    if(basketProduct==null){
      double normalFiyat = double.parse(productEntity.price);
      double indirimliFiyat = double.parse(productEntity.discountPrice);

      int sonuc = (((normalFiyat-indirimliFiyat)/normalFiyat)*100).toInt();

      return "%${sonuc.toString()}";
    }else{
      double normalFiyat = double.parse(basketProduct.price);
      double indirimliFiyat = double.parse(basketProduct.discountPrice);

      int sonuc = (((normalFiyat-indirimliFiyat)/normalFiyat)*100).toInt();

      return "%${sonuc.toString()}";
    }
  }catch(e){
    return "Hata";
  }
}

String favoriteFiyatHesapla(UserFavoriteEntity productEntity){

  try{
    double normalFiyat = double.parse(productEntity.price);
    double indirimliFiyat = double.parse(productEntity.discountPrice);

    int sonuc = (((normalFiyat-indirimliFiyat)/normalFiyat)*100).toInt();

    return "%${sonuc.toString()}";

  }catch(e){
    return "Hata";
  }
}

Future<bool> toastWidget(String message, Color color, {ToastGravity toastGravity = ToastGravity.BOTTOM} ){

  return Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: toastGravity,
      timeInSecForIosWeb: 1,
      backgroundColor: color,
      textColor: Colors.white,
      fontSize: 16.0
  );

}


void setRecentSearch(String search) async {
  if (search != null) {
    if(search.isNotEmpty){
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('recent_search', search);
    }
  }
}

Future<String> getRecentSearch() async {
  String _search = "";
  SharedPreferences prefs = await SharedPreferences.getInstance();
  if (prefs.containsKey('recent_search')) {
    _search = prefs.get('recent_search').toString();
  }
  return _search;
}

class App {
  BuildContext _context;
  double _height;
  double _width;
  double _heightPadding;
  double _widthPadding;

  App(_context) {
    this._context = _context;
    MediaQueryData _queryData = MediaQuery.of(this._context);
    _height = _queryData.size.height / 100.0;
    _width = _queryData.size.width / 100.0;
    _heightPadding = _height - ((_queryData.padding.top + _queryData.padding.bottom) / 100.0);
    _widthPadding = _width - (_queryData.padding.left + _queryData.padding.right) / 100.0;
  }

  double appHeight(double v) {
    return _height * v;
  }

  double appWidth(double v) {
    return _width * v;
  }

  double appVerticalPadding(double v) {
    return _heightPadding * v;
  }

  double appHorizontalPadding(double v) {
    return _widthPadding * v;
  }
}