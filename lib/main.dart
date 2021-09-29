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

import 'package:beysion/pages/SplashScreen.dart';
import 'package:beysion/rest/controller/seller/seller_login_information_provider.dart';
import 'package:beysion/rest/controller/seller/seller_order_provider.dart';
import 'package:beysion/rest/controller/user/market_campaign_products_provider.dart';
import 'package:beysion/rest/controller/user/market_campaigns_provider.dart';
import 'package:beysion/tabletPages/SplashScreenTablet.dart';
import 'rest/controller/user/market_all_list_provider.dart';
import 'package:beysion/rest/controller/user/market_brand_provider.dart';
import 'package:beysion/rest/controller/user/market_category_provider.dart';
import 'package:beysion/rest/controller/user/market_in_category_provider.dart';
import 'package:beysion/rest/controller/user/market_in_products_provider.dart';
import 'package:beysion/rest/controller/user/market_list_provider.dart';
import 'package:beysion/rest/controller/user/markets_detail_provider.dart';
import 'package:beysion/rest/controller/user/product_all_brands_provider.dart';
import 'package:beysion/rest/controller/user/product_all_category_provider.dart';
import 'package:beysion/rest/controller/user/product_discount_provider.dart';
import 'package:beysion/rest/controller/user/recommended_markets_home_provider.dart';
import 'package:beysion/rest/controller/user/session_create_provider.dart';
import 'package:beysion/rest/controller/user/product_all_provider.dart';
import 'package:beysion/rest/controller/user/user_address_provider.dart';
import 'package:beysion/rest/controller/user/user_favorite_provider.dart';
import 'package:beysion/rest/controller/user/user_login_information_provider.dart';
import 'rest/controller/user/user_order_provider.dart';
import 'rest/controller/user/zip_code_provider.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'package:flutter/material.dart';

import 'rest/controller/user/basket_provider.dart';
import 'rest/controller/user/markets_home_provider.dart';

void main() => run();

Future run() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(MyApp(SplashScreen(), SplashScreenTablet()));
}

class MyApp extends StatelessWidget {
  final Widget destination;
  final Widget destinationTablet;
  const MyApp(this.destination, this.destinationTablet);

  static bool isMobile(BuildContext context) => MediaQuery.of(context).size.width < 600;
  static bool isTablet(BuildContext context) =>  MediaQuery.of(context).size.width >= 600 && MediaQuery.of(context).size.width < 1100;
  static bool isDesktop(BuildContext context) => MediaQuery.of(context).size.width >= 1100;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<MarketsHomeProvider>(create: (context) => MarketsHomeProvider()),
        ChangeNotifierProvider<SessionCreateProvider>(create: (context) => SessionCreateProvider()),
        ChangeNotifierProvider<RecommendedMarketsHomeProvider>(create: (context) => RecommendedMarketsHomeProvider()),
        ChangeNotifierProvider<ProductDiscountProvider>(create: (context) => ProductDiscountProvider()),
        ChangeNotifierProvider<MarketCategoryProvider>(create: (context) => MarketCategoryProvider()),
        ChangeNotifierProvider<MarketBrandProvider>(create: (context) => MarketBrandProvider()),
        ChangeNotifierProvider<MarketListProvider>(create: (context) => MarketListProvider()),
        ChangeNotifierProvider<ProductAllProvider>(create: (context) => ProductAllProvider()),
        ChangeNotifierProvider<ProductAllCategoryProvider>(create: (context) => ProductAllCategoryProvider()),
        ChangeNotifierProvider<ProductAllBrandsProvider>(create: (context) => ProductAllBrandsProvider()),
        ChangeNotifierProvider<MarketAllListProvider>(create: (context) => MarketAllListProvider()),
        ChangeNotifierProvider<MarketInCategoryProvider>(create: (context) => MarketInCategoryProvider()),
        ChangeNotifierProvider<MarketInProductsProvider>(create: (context) => MarketInProductsProvider()),
        ChangeNotifierProvider<MarketCampaignProductsProvider>(create: (context) => MarketCampaignProductsProvider()),
        ChangeNotifierProvider<MarketCampaignsProvider>(create: (context) => MarketCampaignsProvider()),
        ChangeNotifierProvider<ZipCodeProvider>(create: (context) => ZipCodeProvider()),
        ChangeNotifierProvider<MarketDetailProvider>(create: (context) => MarketDetailProvider()),
        ChangeNotifierProvider<UserLoginInformationProvider>(create: (context) => UserLoginInformationProvider()),
        ChangeNotifierProvider<UserOrderProvider>(create: (context) => UserOrderProvider()),
        ChangeNotifierProvider<UserAddressProvider>(create: (context) => UserAddressProvider()),
        ChangeNotifierProvider<UserFavoriteProvider>(create: (context) => UserFavoriteProvider()),
        ChangeNotifierProvider<BasketProvider>(create: (context) => BasketProvider()),
        ChangeNotifierProvider<SellerOrderProvider>(create: (context) => SellerOrderProvider()),
        ChangeNotifierProvider<SellerLoginInformationProvider>(create: (context) => SellerLoginInformationProvider()),
      ],
      child: MaterialApp(
        title: 'beysi-on',
        theme: ThemeData(
          brightness: Brightness.light,
          primarySwatch: Paint().color = Colors.blue,
          buttonColor: Paint().color = Colors.blue,
        ),
        debugShowCheckedModeBanner: false,
        // home: destination,
        home: LayoutBuilder(
          builder: (context, constraints) {
            if(isMobile(context)){
              return destination;
            }
            if(isTablet(context)){
              return destinationTablet;
            }
            return SizedBox();
          },
        ),
        // home: AuthPage(),  this is replaced by routes '/'
      ),
    );
  }
}