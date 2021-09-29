import 'package:beysion/pages/user/BasketPage.dart';
import 'package:beysion/pages/user/HomePage.dart';
import 'package:beysion/pages/user/MarketDetailHomePage.dart';
import 'package:beysion/pages/user/MarketDetailPage.dart';
import 'package:beysion/pages/user/MarketDiscountPage.dart';
import 'package:beysion/pages/user/MarketListPage.dart';
import 'package:beysion/pages/user/MarketProductCategoryPage.dart';
import 'package:beysion/pages/user/MarketProductDiscountPage.dart';
import 'package:beysion/pages/user/MyProfilePage.dart';
import 'package:beysion/pages/user/ProductDetailPage.dart';
import 'package:beysion/pages/user/UserForgotPasswordPage.dart';
import 'package:beysion/utility/Colors.dart';
import 'package:beysion/utility/util.dart';
import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:beysion/constant/app_configurations.dart' as settingRepo;
import 'package:beysion/pages/user/UserLoginPage.dart';

class MainPageView extends StatefulWidget {
  @override
  MainPageViewState createState() => MainPageViewState();
}

class MainPageViewState extends State<MainPageView> {
  PageController pageController;
  int currentPageIndex = 0;

  dynamic oneParam;
  dynamic twoParam;
  String param;

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: currentPageIndex);
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    settingRepo.pageViewState.value = this;
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        bottomNavigationBar: DotNavigationBar(
          items: [
            DotNavigationBarItem(icon: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: getSize(context, true, 30/380),
                  height: getSize(context, true, 30/380),
                  decoration: BoxDecoration(
                      color: currentPageIndex == 0 ? BeysionColors.orange : Colors.transparent,
                      borderRadius: BorderRadius.circular(5)),
                  child: Center(child: FaIcon(FontAwesomeIcons.home)),),
                Text("Startseite", style: GoogleFonts.overpass(color: currentPageIndex == 0 ? BeysionColors.purple : Colors.grey.shade700),)
              ],
            )),
            DotNavigationBarItem(icon: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: getSize(context, true, 30/380),
                  height: getSize(context, true, 30/380),
                  decoration: BoxDecoration(
                      color: currentPageIndex == 1 ? BeysionColors.orange : Colors.transparent,
                      borderRadius: BorderRadius.circular(5)),
                  child: Center(child: FaIcon(FontAwesomeIcons.store)),),
                Text("Alle Märkte", style: GoogleFonts.overpass(color: currentPageIndex == 1 ? BeysionColors.purple : Colors.grey.shade700),)
              ],)),
            DotNavigationBarItem(icon: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: getSize(context, true, 30/380),
                  height: getSize(context, true, 30/380),
                  decoration: BoxDecoration(
                      color: currentPageIndex == 2 ? BeysionColors.orange : Colors.transparent,
                      borderRadius: BorderRadius.circular(5)),
                  child: Center(child: FaIcon(FontAwesomeIcons.shoppingBasket)),),
                Text("Mein Korb", style: GoogleFonts.overpass(color: currentPageIndex == 2 ? BeysionColors.purple : Colors.grey.shade700),)
              ],
            )),
            DotNavigationBarItem(icon: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: getSize(context, true, 30/380),
                  height: getSize(context, true, 30/380),
                  decoration: BoxDecoration(
                      color: currentPageIndex == 3 ? BeysionColors.orange : Colors.transparent,
                      borderRadius: BorderRadius.circular(5)),
                  child: Center(child: FaIcon(FontAwesomeIcons.user)),),
                Text("Anmelden", style: GoogleFonts.overpass(color: currentPageIndex == 3 ? BeysionColors.purple : Colors.grey.shade700),)
              ],
            )),
          ],
          margin: EdgeInsets.symmetric(horizontal: getSize(context, true, 30/380)),
          currentIndex: currentPageIndex,
          duration: Duration(milliseconds: 250),
          itemPadding: EdgeInsets.zero,
          dotIndicatorColor: Colors.transparent,
          selectedItemColor: BeysionColors.purple,
          unselectedItemColor: Colors.grey.shade700,
          onTap: (value) {
            setState(() {
              currentPageIndex = value;
              pageController.jumpToPage(value);
            });
          },
        ),
        body: PageView.builder(
          controller: pageController,
          itemCount: 12,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index){
            if(index == 0){
              return HomePage();
            }else if(index == 1){
              return MarketListPage(true);
            }else if(index == 2){
             return BasketPage(false);
            }else if(index == 3 ){
              return settingRepo.currentUserTokenEntity.value.token!=null ? MyProfilePage() : UserLoginPage();
            }else if(index == 4){
              return MarketDiscountPage();
            }else if(index == 5){
              if(oneParam!=null){
                return MarketProductDiscountPage(oneParam);
              }else{
                return SizedBox();
              }
            }else if(index == 6){
              if(oneParam!=null){
                return MarketDetailPage(oneParam);
              }else{
                return SizedBox();
              }
            }else if(index == 7){
              if(oneParam!=null && twoParam!=null){
                return MarketProductCategoryPage(twoParam,oneParam);
              }else{
                return SizedBox();
              }
            }else if(index == 8){
              if(oneParam!=null && twoParam!=null){
                return MarketProductCategoryPage(twoParam,oneParam);
              }else{
                return SizedBox();
              }
            }else if(index == 9){
              if(oneParam!=null){
                return MarketDetailHomePage(oneParam);
              }else{
                return SizedBox();
              }
            } else if(index == 10){
              return UserForgotPasswordPage();
            } else {
              return null;
            }
          },
          onPageChanged: (value){
            setState(() {
              currentPageIndex = value;
            });
          },
        ),
      ),
    );
  }
}
