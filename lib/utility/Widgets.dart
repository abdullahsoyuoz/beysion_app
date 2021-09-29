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

import 'package:auto_size_text/auto_size_text.dart';
import 'package:beysion/Utility/Colors.dart';
import 'package:beysion/Utility/Icons.dart';
import 'package:beysion/Utility/Images.dart';
import 'package:beysion/Utility/Logos.dart';
import 'package:beysion/Utility/util.dart';
import 'package:beysion/pages/seller/SellerLoginPage.dart';
import 'package:beysion/pages/seller/SellerProfilePage.dart';
import 'package:beysion/pages/user/BasketPage.dart';
import 'package:beysion/pages/user/HomePage.dart';
import 'package:beysion/pages/user/MyProfilePage.dart';
import 'package:beysion/pages/user/UserLoginPage.dart';
import 'package:beysion/tabletPages/seller/SellerLoginTabletPage.dart';
import 'package:beysion/tabletPages/seller/SellerProfileTabletPage.dart';
import 'package:beysion/tabletPages/user/BasketTabletPage.dart';
import 'package:beysion/tabletPages/user/HomeTabletPage.dart';
import 'package:beysion/tabletPages/user/MyProfileTabletPage.dart';
import 'package:beysion/tabletPages/user/UserLoginTabletPage.dart';
import '../rest/controller/user/basket_provider.dart';
import 'package:beysion/rest/entity/user/basket/basket_summary_entity.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:beysion/constant/app_configurations.dart' as settingRepo;

buildAppBar(BuildContext context,{bool homePage = false}) {
  BasketSummaryEntity  basketSummaryEntity =  Provider.of<BasketProvider>(context, listen: true).basketSummaryEntity;

  return AppBar(
    automaticallyImplyLeading: true,
    backgroundColor: BeysionColors.purple,
    leadingWidth: getSize(context, true, 20/415),
    leading: homePage == false ? GestureDetector(
      child: Container(
        width: getSize(context, true, 20/415),
        height: AppBar().preferredSize.height,
        color: Color(0xff4a529d),
        child: Image.asset(IconsPath.dropArrowleft, color: Colors.white,),
      ),
      onTap: () => Navigator.pop(context),
    ): SizedBox(),
    centerTitle: false,
    title: InkWell(
      onTap: (){
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => HomePage()));
      },
      child: Container(
        height: AppBar().preferredSize.height,
        child: Image.asset(
          LogosPath.beysion,
          width: getSize(context, true, 0.3),
          fit: BoxFit.contain,
        ),
      ),
    ),
    actions: [
      IconButton(
        icon: FaIcon(FontAwesomeIcons.bell, color: BeysionColors.orange,),
        onPressed: () {
          //sou
        },
      ),
      IconButton(
        icon: Stack(children:[
          Image.asset(IconsPath.basketNotify),
          Positioned(
              right: 3,
              top: 0,
              child: Text(summaryStatus(basketSummaryEntity), style: TextStyle(fontWeight: FontWeight.bold),)),
        ]),
        onPressed: () {
          settingRepo.pageViewState.value.oneParam = null;
          settingRepo.pageViewState.value.twoParam = null;
          settingRepo.pageViewState.value.pageController.animateToPage(2, duration: Duration(milliseconds: 100), curve: Curves.easeInOutExpo);
          /*Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => BasketPage(true)));*/
        },
      ),
      IconButton(
        icon: Image.asset(
          IconsPath.user,
          color: BeysionColors.yellow,
        ),
        onPressed: () {
          settingRepo.pageViewState.value.oneParam = null;
          settingRepo.pageViewState.value.twoParam = null;
          settingRepo.pageViewState.value.pageController.animateToPage(3, duration: Duration(milliseconds: 100), curve: Curves.easeInOutExpo);
        },
      )
    ],
  );
}

buildAppBarTablet(BuildContext context,{bool homePage = false}) {
  BasketSummaryEntity  basketSummaryEntity =  Provider.of<BasketProvider>(context, listen: true).basketSummaryEntity;

  return AppBar(
    automaticallyImplyLeading: true,
    backgroundColor: BeysionColors.purple,
    leadingWidth: getSize(context, true, 20/415),
    leading: homePage == false ? GestureDetector(
      child: Container(
        width: getSize(context, true, 20/415),
        height: AppBar().preferredSize.height,
        color: Color(0xff4a529d),
        child: Image.asset(IconsPath.dropArrowleft, color: Colors.white,),
      ),
      onTap: () => Navigator.pop(context),
    ): SizedBox(),
    centerTitle: false,
    title: InkWell(
      onTap: (){
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => HomeTabletPage()));
      },
      child: Container(
        height: AppBar().preferredSize.height,
        child: Image.asset(
          LogosPath.beysion,
          width: getSize(context, true, 0.3),
          fit: BoxFit.contain,
        ),
      ),
    ),
    actions: [
      IconButton(
        icon: FaIcon(FontAwesomeIcons.bell, color: BeysionColors.orange,),
        onPressed: () {
          //sou
        },
      ),
      IconButton(
        icon: Stack(children:[
          Image.asset(IconsPath.basketNotify),
          Positioned(
              right: 3,
              top: 0,
              child: Text(summaryStatus(basketSummaryEntity), style: TextStyle(fontWeight: FontWeight.bold),)),
        ]),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => BasketTabletPage(true)));
        },
      ),
      IconButton(
        icon: Image.asset(
          IconsPath.user,
          color: BeysionColors.yellow,
        ),
        onPressed: () {
          if(settingRepo.currentUserTokenEntity.value.token!=null){
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => MyProfileTabletPage()));
          }else{
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => UserLoginTabletPage()));
          }
        },
      )
    ],
  );
}

String summaryStatus(BasketSummaryEntity basketSummaryEntity){
  if(basketSummaryEntity!=null){
    if(basketSummaryEntity.totalAndPrice!=null){
      if(basketSummaryEntity.totalAndPrice.total!=null){
        return basketSummaryEntity.totalAndPrice.total.toString();
      }else{
        return "0";
      }
    }else{
      return"0";
    }
  }else{
    return "0";
  }

}

buildAppBarSeller(BuildContext context) {
  return AppBar(
    automaticallyImplyLeading: true,
    backgroundColor: BeysionColors.purple,
    leadingWidth: getSize(context, true, 35/415),
    leading: GestureDetector(
      child: Container(
        width: getSize(context, true, 20/415),
        height: AppBar().preferredSize.height,
        color: Color(0xff4a529d),
        child: Image.asset(IconsPath.dropArrowleft, color: Colors.white,),
      ),
      onTap: () => Navigator.pop(context),
    ),
    centerTitle: false,
    title: InkWell(
      onTap: (){
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => HomePage()));
      },
      child: Container(
        height: AppBar().preferredSize.height,
        child: Image.asset(
          LogosPath.beysion,
          width: getSize(context, true, 0.3),
          fit: BoxFit.contain,
        ),
      ),
    ),
    actions: [
      IconButton(
        icon: Image.asset(
          IconsPath.user,
          color: BeysionColors.yellow,
        ),
        onPressed: () {
          if(settingRepo.sellerLoginInformationEntity.value!=null){
            if(settingRepo.sellerLoginInformationEntity.value.token!=null){
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => SellerProfilePage()));
            }
          }else{
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => SellerLoginPage()));
          }
        },
      )
    ],
  );
}

buildAppBarSellerTablet(BuildContext context) {
  return AppBar(
    automaticallyImplyLeading: true,
    backgroundColor: BeysionColors.purple,
    leadingWidth: getSize(context, true, 35/415),
    leading: GestureDetector(
      child: Container(
        width: getSize(context, true, 20/415),
        height: AppBar().preferredSize.height,
        color: Color(0xff4a529d),
        child: Image.asset(IconsPath.dropArrowleft, color: Colors.white,),
      ),
      onTap: () => Navigator.pop(context),
    ),
    centerTitle: false,
    title: InkWell(
      onTap: (){
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => HomeTabletPage()));
      },
      child: Container(
        height: AppBar().preferredSize.height,
        child: Image.asset(
          LogosPath.beysion,
          width: getSize(context, true, 0.3),
          fit: BoxFit.contain,
        ),
      ),
    ),
    actions: [
      IconButton(
        icon: Image.asset(
          IconsPath.user,
          color: BeysionColors.yellow,
        ),
        onPressed: () {
          if(settingRepo.sellerLoginInformationEntity.value!=null){
            if(settingRepo.sellerLoginInformationEntity.value.token!=null){
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => SellerProfileTabletPage()));
            }
          }else{
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => SellerLoginTabletPage()));
          }
        },
      )
    ],
  );
}

buildSolidContainer(BuildContext context, Widget child, {EdgeInsets margin, EdgeInsets padding}){
  return Container(
    height: getSize(context, true, 45/415),
    margin: margin,
    padding: padding,
    decoration: BoxDecoration(
      color: BeysionColors.textFieldBackground,
      borderRadius: BorderRadius.all(Radius.circular(5))
    ),
    child: IconButton(
      icon: Image.asset(
        IconsPath.user,
        filterQuality: FilterQuality.high,
        height: getSize(context, true, 30 / 415),
        width: getSize(context, true, 30 / 415),
      ),
      onPressed: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => MyProfilePage()));
      },
    )
    ,
  );
}

Widget buildContainer(BuildContext context, Widget child,
    {double topMargin = 0, double bottomMargin = 0, Color colorData}) {
  return Container(
    margin: EdgeInsets.only(
      top: getSize(context, true, topMargin / 470),
      bottom: getSize(context, true, bottomMargin / 470),
      left: getSize(context, true, 20 / 415),
      right: getSize(context, true, 20 / 415),
    ),
    padding: EdgeInsets.symmetric(
      vertical: getSize(context, true, 5 / 385),
      horizontal: getSize(context, true, 10 / 385),
    ),
    decoration: BoxDecoration(
      color:colorData!=null ? colorData: Colors.white,
      borderRadius: BorderRadius.all(Radius.circular(5)),
      border:
          Border.all(color: BeysionColors.border, width: 1),
    ),
    child: child,
  );
}

Widget buildBannerAdv(BuildContext context) {
  return Container(
    width: getSize(context, true, 1),
    height: getSize(context, true, 49 / 415),
    decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage(ImagesPath.headerListBack), fit: BoxFit.cover)),
  );
}

Widget buildAdv(BuildContext context) {
  return Padding(
    padding: EdgeInsets.symmetric(
        horizontal: getSize(context, true, 22 / 415),
        vertical: getSize(context, true, 33 / 375)),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Kampagnen",
          style: TextStyle(fontSize: 14),
          textAlign: TextAlign.start,
        ),
        Container(
          width: getSize(context, true, 371 / 415),
          height: getSize(context, true, 215 / 415),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5))
          ),
          child: Carousel(
            autoplay: true,
            animationDuration: Duration(seconds: 1),
            showIndicator: false,
            boxFit: BoxFit.cover,
            borderRadius: true,
            images: [
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: getSize(context, true, 2 / 375)),
                child: Image.asset(
                  ImagesPath.adv2,
                  fit: BoxFit.fitWidth,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: getSize(context, true, 2 / 375)),
                child: Image.asset(
                  ImagesPath.adv2,
                  fit: BoxFit.fitWidth,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget buildBasketPageTopNavigationBar(BuildContext context, int index) {
  return Align(
    alignment: Alignment.topCenter,
    child: Container(
      width: getSize(context, true, 1),
      height: getSize(context, true, 58 / 415),
      decoration: BoxDecoration(
        color: BeysionColors.blueNavy,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            width: getSize(context, true, 120 / 415),
            height: getSize(context, true, 50 / 415),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Image.asset(
                    IconsPath.basket,
                    width: getSize(context, true, 25 / 415),
                    height: getSize(context, true, 25 / 415),
                    color: index == 0 ? BeysionColors.yellow : BeysionColors.overlay
                ),
                AutoSizeText(
                  "Mein Warenkorb",
                  style: TextStyle(color: index == 0 ? Colors.white : BeysionColors.overlay, fontSize: 10),
                  minFontSize: 5,
                )
              ],
            ),
          ),
          Container(
            width: getSize(context, true, 20 / 415),
            height: getSize(context, true, 50 / 415),
            child: Image.asset(
              IconsPath.rightArrow,
              color: BeysionColors.overlay,
              width: getSize(context, true, 25 / 415),
              height: getSize(context, true, 25 / 415),
            ),
          ),
          Container(
            width: getSize(context, true, 120 / 415),
            height: getSize(context, true, 50 / 415),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Image.asset(
                  IconsPath.sign,
                  color: index == 1 ? BeysionColors.yellow : BeysionColors.overlay,
                  width: getSize(context, true, 25 / 415),
                  height: getSize(context, true, 25 / 415),
                ),
                AutoSizeText(
                  "Make Your Choice",
                  style: TextStyle(color: index == 1 ? Colors.white : BeysionColors.overlay, fontSize: 10),
                  minFontSize: 5,
                )
              ],
            ),
          ),
          Container(
            width: getSize(context, true, 20 / 415),
            height: getSize(context, true, 50 / 415),
            child: Image.asset(
              IconsPath.rightArrow,
              color: BeysionColors.overlay,
              width: getSize(context, true, 25 / 415),
              height: getSize(context, true, 25 / 415),
            ),
          ),
          Container(
            width: getSize(context, true, 120 / 415),
            height: getSize(context, true, 50 / 415),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Image.asset(
                  IconsPath.wallet,
                  color: index == 2 ? BeysionColors.yellow : BeysionColors.overlay,
                  width: getSize(context, true, 25 / 415),
                  height: getSize(context, true, 25 / 415),
                ),
                AutoSizeText(
                  "Make Your Payment",
                  style: TextStyle(color: index == 2 ? Colors.white : BeysionColors.overlay, fontSize: 10),
                  minFontSize: 5,
                )
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

