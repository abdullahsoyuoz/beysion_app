import 'package:beysion/tabletPages/user/BasketTabletPage.dart';
import 'package:beysion/tabletPages/user/HomeTabletPage.dart';
import 'package:beysion/tabletPages/user/MarketListTabletPage.dart';
import 'package:beysion/tabletPages/user/MyProfileTabletPage.dart';
import 'package:beysion/tabletPages/user/UserLoginTabletPage.dart';
import 'package:beysion/utility/Colors.dart';
import 'package:beysion/utility/util.dart';
import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:beysion/constant/app_configurations.dart' as settingRepo;

class MainPageViewTablet extends StatefulWidget {
  @override
  _MainPageViewTabletState createState() => _MainPageViewTabletState();
}

class _MainPageViewTabletState extends State<MainPageViewTablet> {
  PageController _pageController;
  int currentPageIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }


  @override
  Widget build(BuildContext context) {
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
              _pageController.jumpToPage(value);
            });
          },
        ),
        body: PageView.builder(
          controller: _pageController,
          itemCount: 4,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index){
            if(index == 0){
              return HomeTabletPage();
            }else if(index == 1){
              return MarketListTabletPage(true);
            }else if(index == 2){
              return BasketTabletPage(false);
            }else {
              return settingRepo.currentUserTokenEntity.value.token!=null ? MyProfileTabletPage() : UserLoginTabletPage();
            }
          },
        ),
      ),
    );
  }
}
