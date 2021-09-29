import 'dart:convert';

import 'package:beysion/Utility/Colors.dart';
import 'package:beysion/Utility/util.dart';
import 'package:beysion/constant/app_configurations.dart';
import 'package:beysion/pages/user/MarketDetailHomePage.dart';
import 'package:beysion/pages/user/MarketDetailPage.dart';
import 'package:beysion/pages/user/MarketListPage.dart';
import 'package:beysion/rest/controller/user/market_campaigns_provider.dart';
import 'package:beysion/rest/entity/user/market/markets_all_entity.dart';
import 'package:beysion/rest/entity/user/market/markets_home_entity.dart';
import 'package:beysion/rest/service/market/markets_service.dart';
import 'package:beysion/utility/Icons.dart';
import 'package:beysion/utility/Widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../rest/controller/user/basket_provider.dart';
import 'package:beysion/rest/controller/user/market_list_provider.dart';
import 'package:beysion/rest/controller/user/markets_home_provider.dart';
import 'package:beysion/rest/controller/user/product_all_provider.dart';
import 'package:beysion/rest/controller/user/product_discount_provider.dart';
import 'package:beysion/rest/controller/user/recommended_markets_home_provider.dart';
import 'package:beysion/rest/controller/user/user_address_provider.dart';
import 'package:beysion/rest/controller/user/user_login_information_provider.dart';
import 'package:beysion/rest/entity/user/user_token_entity.dart';
import 'package:beysion/rest/entity/user/zip_code_entity.dart';
import 'package:beysion/rest/response_models/base_response.dart';
import 'package:beysion/rest/response_models/ok_response.dart';
import 'package:beysion/rest/service/zip_code_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:beysion/constant/app_configurations.dart' as settingRepo;
import 'package:beysion/rest/controller/user/market_category_provider.dart';
import 'package:beysion/rest/entity/user/market/market_category_entity.dart';

import 'MarketDiscountPage.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  bool isSelectLieferservice = false;
  bool isSelectAbholservice = false;
  bool getData = false;

  TextEditingController plzTextController = new TextEditingController();
  TextEditingController produktSuchenDialogController = new TextEditingController();

  TabController _tabController;
  ScrollController _scrollController;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(vsync: this, length: 1);
    _scrollController = ScrollController();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if(settingRepo.abholService.value == 0 && settingRepo.lieferService.value ==0){
        await Future.delayed(Duration(milliseconds: 50)).then((value) => showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) {
            return _showDialog();
          },
        ));
      }
      isLoggedInControl();
      Provider.of<ProductAllProvider>(context, listen: false).getProductAllList(pageNumber: 1);
      Provider.of<BasketProvider>(context, listen: false).getBasketDetailDataController();
      zipCodeRecentSearch();
    });
  }

  ZipCodeEntity zipCodeEntityRecentSearch = new ZipCodeEntity();

  zipCodeRecentSearch() async {
    String _search = "";
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('recent_search')) {
      _search = prefs.get('recent_search');
      ZipCodeEntity zipCodeEntity = new ZipCodeEntity.fromJson(json.decode(_search));
      zipCodeEntityRecentSearch = zipCodeEntity;
    }else{
      print('İÇERİK YOKKKKKK');
    }
  }

  isLoggedInControl() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey("userTokenEntity")) {
      UserTokenEntity userTokenEntity = new UserTokenEntity.fromJson(
          json.decode(prefs.getString("userTokenEntity")));
      settingRepo.currentUserTokenEntity.value = userTokenEntity;
      Provider.of<UserLoginInformationProvider>(context, listen: false).getUserInformationDataController();
      Provider.of<UserAddressProvider>(context, listen: false).getUserAddressAllDataController();

    } else {
      settingRepo.currentUserTokenEntity.value.token = null;
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  Future getPageRefreshData() async {
    Provider.of<MarketsHomeProvider>(context, listen: false).getMarketsHomeController();
    Provider.of<ProductDiscountProvider>(context, listen: false).getProductDiscountController(pageNumber: 1, pageUserStatus: 1);
    Provider.of<RecommendedMarketsHomeProvider>(context, listen: false).getRecommendedMarketsHomeController();
    Provider.of<BasketProvider>(context, listen: false).getBasketDetailDataController();
  }

  @override
  Widget build(BuildContext context) {
    //List<MarketsHomeEntity> marketsHomeProvider = Provider.of<MarketsHomeProvider>(context, listen: true).marketsHomeEntityList;
    List<MarketsHomeEntity> recommendedMarketsList = Provider.of<RecommendedMarketsHomeProvider>(context, listen: true).recommendedMarketsHomeEntityList;
    List<MarketCategoryEntity> categoryListProvider = Provider.of<MarketCategoryProvider>(context, listen: true).marketHomeCategoryList;
    return WillPopScope(
      onWillPop: () async => false,
      child: RefreshIndicator(
        onRefresh: () => getPageRefreshData(),
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: buildAppBar(context,  homePage: true),
          body: ListView(
            children: <Widget>[
              Container(
                height: getSize(context, true, 355/415),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
                  image: DecorationImage(
                      image: AssetImage("assets/images/iconsBack.png"),
                      fit: BoxFit.cover,
                      colorFilter: ColorFilter.mode(BeysionColors.purple, BlendMode.overlay)),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: getSize(context, true, 20/415)),
                      child: Column(
                        children: [
                          Text("Ihre Bestellung ist bereit!", style: TextStyle(color: BeysionColors.orange, fontSize: 23, fontWeight: FontWeight.w500),),
                          Padding(
                            padding: EdgeInsets.only(top: 8.0),
                            child: Text("Abholen oder liefern lassen?", style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w500),),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.only(
                          top: getSize(context, true, 20/415),
                          left: getSize(context, true, 20/415),
                          right: getSize(context, true, 20/415),
                        ),
                        child: FlatButton(
                          onPressed: () {
                            showMarktSuchenFullScreenDialog(context, produktSuchenDialogController);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Märkte Suchen", style: GoogleFonts.overpass(color: Colors.grey.shade300),),
                              FaIcon(FontAwesomeIcons.search, color: Colors.grey.shade300,)
                            ],
                          ),
                          color: Colors.white,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          height: getSize(context, true, 50/415),
                        )
                    ),
                    Padding(
                        padding: EdgeInsets.only(
                          top: getSize(context, true, 20/415),
                          left: getSize(context, true, 20/415),
                          right: getSize(context, true, 20/415),
                        ),
                        child: FlatButton(
                          onPressed: () {
                            settingRepo.pageViewState.value.oneParam = null;
                            settingRepo.pageViewState.value.twoParam = null;
                            settingRepo.pageViewState.value.pageController.animateToPage(1, duration: Duration(milliseconds: 100), curve: Curves.easeInOutExpo);
                           // Navigator.push(context, CupertinoPageRoute(builder: (context) => MarketListPage(false),));
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  FaIcon(FontAwesomeIcons.store, size: 20,),
                                  Padding(
                                    padding: EdgeInsets.only(left: 8.0),
                                    child: Text("Alle Märkte", style: GoogleFonts.overpass(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w600),),
                                  ),
                                ],
                              ),
                              FaIcon(FontAwesomeIcons.arrowRight, color: Colors.grey.shade800,)
                            ],
                          ),
                          color: BeysionColors.orange,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          height: getSize(context, true, 50/415),
                        )
                    ),
                    Padding(
                        padding: EdgeInsets.only(
                          top: getSize(context, true, 20/415),
                          left: getSize(context, true, 20/415),
                          right: getSize(context, true, 20/415),
                        ),
                        child: FlatButton(
                          onPressed: () {
                            settingRepo.pageViewState.value.oneParam = null;
                            settingRepo.pageViewState.value.twoParam = null;
                            settingRepo.pageViewState.value.pageController.animateToPage(4, duration: Duration(milliseconds: 100), curve: Curves.easeInOutExpo);
                            //Navigator.push(context, CupertinoPageRoute(builder: (context) => MarketDiscountPage(),));
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  FaIcon(FontAwesomeIcons.tag, color: BeysionColors.purple,),
                                  Padding(
                                    padding: EdgeInsets.only(left: 8.0),
                                    child: Text("reduzierte Produkte", style: GoogleFonts.overpass(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w600),),
                                  ),
                                ],
                              ),
                              FaIcon(FontAwesomeIcons.arrowRight, color: Colors.grey.shade800,)
                            ],
                          ),
                          color: BeysionColors.orange,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          height: getSize(context, true, 50/415),
                        )
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: getSize(context, true, 20/360)),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("${settingRepo.zipCodeSelectedEntity.value.text}"),
                    FlatButton(
                      child: Text("PLZ ANDERN", style: GoogleFonts.overpass(color: BeysionColors.purple),),
                      padding: EdgeInsets.zero,
                      onPressed: () {
                        showFullScreenDialog(context, plzTextController);
                      },
                    )
                  ],
                ),
              ),
              SizedBox(height: 7,),
              recommendedMarketsList.length>0 ?
              buildRecommendedMarketListBody(context, recommendedMarketsList): SizedBox(),
              buildAdv(context),
            ],
          ),
        ),
      ),
    );
  }

  void showFullScreenDialog(BuildContext context, TextEditingController testController) {
    List<ZipCodeEntity> _zipCodeListData = new List();
    bool loadingData = false;
    plzTextController.clear();
    showGeneralDialog(
      context: context,
      barrierColor: Colors.black12.withOpacity(0.6), // background color
      barrierDismissible: false, // should dialog be dismissed when tapped outside
      barrierLabel: "Dialog", // label for barrier
      transitionDuration: Duration(milliseconds: 400), // how long it takes to popup dialog after button click
      pageBuilder: (_, __, ___) {
        // your widget implementation
        return StatefulBuilder(
            builder: (context, setStateC) {
              return SizedBox.expand(
                child: Scaffold(
                  resizeToAvoidBottomInset: false,
                  body: Padding(
                    padding: EdgeInsets.symmetric(horizontal: getSize(context, true, 20 / 415)),
                    child: Container(
                      margin: EdgeInsets.only(
                        top: getSize(context, true, 20 / 415),
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Ihre Postleitzahl",
                                style: TextStyle(
                                    color: BeysionColors.purple,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700),
                              ),
                              IconButton(
                                icon: FaIcon(FontAwesomeIcons.times),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              )
                            ],
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(
                                top: getSize(context, true, 20 / 415),
                                bottom: 20,
                              ),
                              child: Container(
                                width: getSize(context, true, 1),
                                child: Stack(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(5),
                                          boxShadow: [BoxShadow(color: Colors.grey.shade300, blurRadius: 3, spreadRadius: 2)]
                                      ),
                                      child: loadingData == false ? SizedBox(
                                        child: zipCodeEntityRecentSearch!=null && zipCodeEntityRecentSearch.text!=null ? InkWell(
                                          onTap: (){
                                            setState(() {
                                              settingRepo.zipCodeSelectedEntity.value =  zipCodeEntityRecentSearch;
                                            });
                                            Navigator.pop(context);
                                          },
                                          child: Container(
                                            margin: EdgeInsets.only(top: 50),
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  child: Padding(
                                                    padding: const EdgeInsets.all(8.0),
                                                    child: Text("${zipCodeEntityRecentSearch!=null && zipCodeEntityRecentSearch.text!=null ? zipCodeEntityRecentSearch.text: ""}"),
                                                  ),
                                                ),
                                              ],
                                            ),),
                                        ): SizedBox(),
                                      ) :
                                      getData == false ? Container(
                                          margin: EdgeInsets.only(top: 50),
                                          child: Center(child: CircularProgressIndicator())) :
                                      ListView.builder(
                                          shrinkWrap: true,
                                          padding: EdgeInsets.only(top: getSize(context, true, 50/415),),
                                          itemCount: _zipCodeListData.length,
                                          itemBuilder: (context, index){
                                            return InkWell(
                                              onTap: () {
                                                setState(() {
                                                  settingRepo.zipCodeSelectedEntity.value =  _zipCodeListData[index];
                                                  saveSearch("${json.encode(_zipCodeListData[index].toJson())}");
                                                });
                                                Navigator.pop(context);
                                              },
                                              child: Container(
                                                height: getSize(context, true, 50/415),
                                                padding: EdgeInsets.symmetric(horizontal: 20),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  children: [
                                                    Expanded(
                                                      // TODO:
                                                      child: Text("${_zipCodeListData[index].text}",
                                                          overflow: TextOverflow.fade,
                                                          maxLines: 1,
                                                          softWrap: false
                                                      ),
                                                    ),
                                                    FaIcon(FontAwesomeIcons.locationArrow, color: Colors.grey.shade300,)
                                                  ],
                                                ),
                                              ),
                                            );
                                          }),
                                    ),
                                    Container(
                                      height: getSize(context, true, 50/415),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(5),
                                          boxShadow: [BoxShadow(color: Colors.grey.shade200, blurRadius: 3, spreadRadius: 2)]
                                      ),
                                      child: TextField(
                                        controller: testController,
                                        autofocus: true,
                                        decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: "Ihre PLZ",
                                            hintStyle: TextStyle(color: Colors.grey.shade300),
                                            contentPadding: EdgeInsets.only(left: 20)
                                        ),
                                        onChanged: (value) async {
                                          // setState TODO:
                                          if(value.length>2){
                                            setStateC(() {
                                              loadingData = true;
                                              getData = false;
                                            });
                                            _zipCodeListData.clear();
                                            _zipCodeListData = await getAllZipCodeListController(value);
                                            setStateC(() {
                                            });
                                          }else{
                                            setStateC(() {
                                              loadingData = false;
                                              getData = false;
                                              _zipCodeListData.clear();
                                            });
                                          }

                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              );}
        );
      },
    );
  }

  Future<void> saveSearch(String search) async {
    await setRecentSearch(search);
    zipCodeRecentSearch();
  }

  void showMarktSuchenFullScreenDialog(BuildContext context, TextEditingController testController) {
    testController.clear();
    bool loadingData = false;
    List<MarketsAllEntity> marketSearchDataList = new List();
    showGeneralDialog(
      context: context,
      barrierColor: Colors.black12.withOpacity(0.6), // background color
      barrierLabel: "Dialog", // label for barrier
      transitionDuration: Duration(milliseconds:400), // how long it takes to popup dialog after button click
      pageBuilder: (_, __, ___) {
        // your widget implementation
        return StatefulBuilder(builder: (context, setStateC) {
          return SizedBox.expand(
            child: Scaffold(
              body: Padding(
                padding: EdgeInsets.symmetric(horizontal: getSize(context, true, 15 / 415)),
                child: Container(
                  margin:EdgeInsets.only(top: 20),
                  child: Column(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(
                            top: getSize(context, true, 20 / 415),
                          ),
                          child: Container(
                            width: getSize(context, true, 1),
                            child: Stack(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(5),
                                      boxShadow: [BoxShadow(color: Colors.grey.shade300, blurRadius: 3, spreadRadius: 2)]
                                  ),
                                  margin: EdgeInsets.symmetric(horizontal: getSize(context, true, 5 / 415)),
                                  child: loadingData == false ? SizedBox() :
                                  getData == false ? Container(
                                      margin: EdgeInsets.only(top: 50),
                                      child: Center(child: CircularProgressIndicator())) : ListView.builder(
                                      shrinkWrap: true,
                                      padding: EdgeInsets.only(
                                        top: getSize(context, true, 50/415),
                                        left: getSize(context, true, 5/415),
                                        right: getSize(context, true, 5/415),
                                      ),
                                      physics: AlwaysScrollableScrollPhysics(),
                                      itemCount: marketSearchDataList.length,
                                      itemBuilder: (context, index){
                                        MarketsAllEntity marketDataEntity = marketSearchDataList[index];
                                        return InkWell(
                                          onTap: (){
                                            settingRepo.pageViewState.value.oneParam = marketDataEntity;
                                            settingRepo.pageViewState.value.twoParam = null;
                                            settingRepo.pageViewState.value.pageController.animateToPage(6, duration: Duration(milliseconds: 100), curve: Curves.easeInOutExpo);
                                            Navigator.pop(context);
                                            //Navigator.push(context, MaterialPageRoute(builder: (context) => MarketDetailPage(marketDataEntity),));
                                          },
                                          child: Container(
                                            padding: EdgeInsets.all(getSize(context, true, 20/360)),
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                boxShadow: [BoxShadow(color: Colors.grey)]
                                            ),
                                            margin: EdgeInsets.only(bottom: getSize(context, true, 15/360)),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  children: [
                                                    Text("${marketDataEntity.name}", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),),
                                                    Container(
                                                      width: getSize(context, true, 35/360),
                                                      height: getSize(context, true, 20/360),
                                                      margin: EdgeInsets.only(left: 10),
                                                      decoration: BoxDecoration(
                                                          color: BeysionColors.orange,
                                                          borderRadius: BorderRadius.circular(5)
                                                      ),
                                                      child: Center(child: Text("${marketDataEntity.avgScore}", style: TextStyle(color: BeysionColors.purple, fontWeight: FontWeight.w700),)),
                                                    )
                                                  ],
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(top: 8.0),
                                                  child: Text("${marketDataEntity.address}", style: TextStyle(color: Colors.grey.shade700),),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(top: 8),
                                                  child: ClipRRect(
                                                    borderRadius: BorderRadius.circular(10),
                                                    child: Image.network("${marketDataEntity.logo}",
                                                      width: getSize(context, true, 320/380),
                                                      height: getSize(context, true, 110/380),
                                                      fit: BoxFit.fitWidth,
                                                      alignment: Alignment.topCenter,
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(top: getSize(context, true, 15/360)),
                                                  child: Row(
                                                    children: [
                                                      Expanded(child: Text("Mindestpaketmenge", style: TextStyle(color: Colors.grey.shade500),)),
                                                      Expanded(child: Text("Arbeitszeit (heute)", style: TextStyle(color: Colors.grey.shade500),)),
                                                    ],
                                                  ),
                                                ),
                                                Row(
                                                  children: [
                                                    Expanded(child: Text("${marketDataEntity.minimumSellPrice}", style: TextStyle(fontSize: 16),)),
                                                    Expanded(child: Text("${marketDataEntity.workingTimeNow}", style: TextStyle(fontSize: 16),)),
                                                  ],
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(top: getSize(context, true, 15/360)),
                                                  child: Row(
                                                    children: [
                                                      Expanded(child: Text("Vorbereitungszeit", style: TextStyle(color: Colors.grey.shade500),)),
                                                      Expanded(child: Text("Service Wählen", style: TextStyle(color: Colors.grey.shade500),)),
                                                    ],
                                                  ),
                                                ),
                                                Row(
                                                  children: [
                                                    Expanded(child: Text("${marketDataEntity.preparingTime}", style: TextStyle(fontSize: 16),)),
                                                    Expanded(child: Text("${marketDataEntity.deliveryType}", style: TextStyle(fontSize: 16),)),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      }),
                                ),
                                Container(
                                  height: getSize(context, true, 50/415),
                                  margin: EdgeInsets.symmetric(horizontal: getSize(context, true, 5 / 415)),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(5),
                                      boxShadow: [BoxShadow(color: Colors.grey.shade200, blurRadius: 3, spreadRadius: 2)]
                                  ),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        flex: 8,
                                        child: TextField(
                                          autofocus: true,
                                          controller: testController,
                                          decoration: InputDecoration(
                                              border: InputBorder.none,
                                              hintText: "Märkte Suchen",
                                              hintStyle: TextStyle(color: Colors.grey.shade300),
                                              contentPadding: EdgeInsets.only(left: 20)
                                          ),
                                          onChanged: (value) async {
                                            if(value.length>2){
                                              setStateC(() {
                                                loadingData = true;
                                                getData = false;
                                              });
                                              marketSearchDataList.clear();
                                              marketSearchDataList = await marketSearchUIController(search: value);
                                              setStateC(() {
                                              });
                                            }else{
                                              setStateC(() {
                                                loadingData = false;
                                                getData = false;
                                                marketSearchDataList.clear();
                                              });
                                            }
                                          },
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: IconButton(
                                          onPressed: () {
                                            testController.clear();
                                            Navigator.pop(context);},
                                          icon: FaIcon(FontAwesomeIcons.times, color: Colors.grey.shade500),
                                          highlightColor: Colors.transparent,
                                          splashColor: Colors.transparent,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ); },
        );
      },
    );
  }

  buildRecommendedMarketListBody(
      BuildContext context, List<MarketsHomeEntity> recommended) {
    return Padding(
      padding: EdgeInsets.only(
          left: getSize(context, true, 22 / 415),
          right: getSize(context, true, 22 / 415),
          ),
      child: recommended.length > 0
          ? Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Unsere Markt Empfehlungen", style: GoogleFonts.overpass(color: BeysionColors.purple, fontSize: 18, fontWeight: FontWeight.w800),),
              ListView.builder(
              shrinkWrap: true,
              itemCount: recommended.length,
              controller: _scrollControllerList,
              scrollDirection: Axis.vertical,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                    MarketsHomeEntity marketHomeEntity = recommended[index];
                return buildMarketCard(
                    context, marketHomeEntity, BeysionColors.greenLight);
              }),
            ],
          )
          : CircularProgressIndicator(),
    );
  }

  var _scrollControllerList = ScrollController();

  buildMarketCard(BuildContext context, MarketsHomeEntity marketEntity,
      Color rankBoxColor) {
    return Container(
      width: getSize(context, true, 371 / 415),
      height: getSize(context, true, 110 / 415),
      margin: EdgeInsets.only(top: getSize(context, true, 9 / 415)),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(5)),
          border: Border.all(
              color: BeysionColors.border.withOpacity(0.5), width: 1)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(
              left: getSize(context, true, 16 / 415),
              top: getSize(context, true, 15 / 415),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: getSize(context, true, 33 / 415),
                  height: getSize(context, true, 22 / 415),
                  decoration: BoxDecoration(
                      color: rankBoxColor,
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                  child: Center(child: Text("${marketEntity.point}")),
                ),
                Expanded(
                  child: InkWell(
                    onTap: (){
                      settingRepo.pageViewState.value.oneParam = null;
                      settingRepo.pageViewState.value.twoParam = null;
                      settingRepo.pageViewState.value.oneParam = marketEntity.id;
                      settingRepo.pageViewState.value.pageController.animateToPage(9, duration: Duration(milliseconds: 100), curve: Curves.easeInOutExpo);
                      //Navigator.push(context, MaterialPageRoute(builder: (context) => MarketDetailHomePage(marketEntity.id,),));
                    },
                    child: Padding(
                      padding:
                      EdgeInsets.only(left: getSize(context, true, 7 / 415)),
                      child: Text(
                        "${marketEntity.name}",
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: BeysionColors.purple),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: getSize(context, true, 56 / 415),
              right: getSize(context, true, 20.8 / 371),
              top: getSize(context, true, 3.7 / 415),
            ),
            child: Divider(
              height: 1,
              color: Colors.black,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                top: getSize(context, true, 5.3 / 415),
                left: getSize(context, true, 56 / 415)),
            child: Text(
              "${marketEntity.address}, ${marketEntity.zipcode}",
              style: TextStyle(
                fontSize: 12,
                color: BeysionColors.gray2,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                top: getSize(context, true, 5.3 / 415),
                left: getSize(context, true, 56 / 415)),
            child: InkWell(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    IconsPath.basket,
                    width: 15,
                  ),
                  SizedBox(
                    width: getSize(context, true, 9 / 415),
                  ),
                  Text(
                    "Im Laden einkaufen",
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                  )
                ],
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MarketDetailHomePage(marketEntity.id,
                      ),
                    ));
              },
            ),
          ),
        ],
      ),
    );
  }


  Future<List<ZipCodeEntity>> getAllZipCodeListController(String search) async {
    List<ZipCodeEntity> _zipCodeListData = new List();
    try {
      BaseResponse response = await ZipCodeService.operations().zipCodeSearch(search);
      if (response is OkResponse) {
        if (response.body != null) {
          if (response.body["data"] != null) {
            getData = false;
            List<dynamic> dataList = response.body["data"];
            for (var dataStr in dataList) {
              ZipCodeEntity model = new ZipCodeEntity.fromJson(dataStr);
              if (model != null) {
                setState(() {
                  _zipCodeListData.add(model);
                });
              }
            }
            getData = true;
            return _zipCodeListData;
          } return _zipCodeListData;
        } return _zipCodeListData;
      } return _zipCodeListData;
    } catch (e) {
      print('Exception Get All Zip Code Welcome List Data -- $e');
      return new List();
    }
  }

  marketSearchUIController({String search=" ", int abholService = 1, int lieferService = 1}) async {
    List<MarketsAllEntity> returnDataList = new List();
    SharedPreferences sharedPref = await SharedPreferences.getInstance();
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
    String sessionToken = sharedPref.getString("sessionToken");
    BaseResponse response = await MarketsService.operations().allMarketsListInformation(plzZipCode, search, lieferService, abholService, sessionToken);
    try{
      getData = false;
      if (response is OkResponse) {
        if (response.body != null) {
          if (response.body["data"] != null) {
            returnDataList.clear();
            List<dynamic> dataList = response.body["data"];
            List<MarketsAllEntity>  newDataList = new List();
            for (var dataStr in dataList) {
              MarketsAllEntity model = new MarketsAllEntity.fromJson(dataStr);
              newDataList.add(model);
              if (model != null) {
                if ((newDataList.singleWhere((it) => it.id == model.id,
                    orElse: () => null)) != null) {
                } else {
                  newDataList.add(model);
                }
              }
            }
            getData = true;
            returnDataList.addAll(newDataList);
            return returnDataList;
          }else{
            return returnDataList;
          }
        }else{
          return returnDataList;
        }
      }else{
        return returnDataList;
      }
    }catch(e){
      print('Exception get All Market List Data -- $e');
    }
  }


  Widget _showDialog() {
    return WillPopScope(
      onWillPop: () async => false,
      child: StatefulBuilder(
        builder: (context, setsState) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25)),
            child: FittedBox(
              fit: BoxFit.fitHeight,
              child: Container(
                width: MediaQuery.of(context).size.width * 380 / 415,
                decoration: BoxDecoration(
                    color: BeysionColors.background,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.all(Radius.circular(25))
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.width * 60 / 415,
                          margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.width * 5 / 415,),
                          decoration: BoxDecoration(
                              color: BeysionColors.purple,
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(25),
                                  topRight: Radius.circular(25))),
                          child: Center(
                            child: Text("Service wählen",
                              style: GoogleFonts.overpass(fontWeight: FontWeight.w600, fontSize: 20, color: Colors.white),
                              textAlign: TextAlign.center)),),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8),
                          child: Text("Bitte wähle die Serviceart aus, die du möchtest:",
                            style: GoogleFonts.overpass(fontSize: 18,fontWeight: FontWeight.w600), textAlign: TextAlign.center,),
                        )],),
                    Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * 15 / 415,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: AspectRatio(
                              aspectRatio: 1,
                              child: InkWell(
                                child: Stack(
                                  fit: StackFit.loose,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: isSelectLieferservice == true
                                            ? BeysionColors.purple
                                            : BeysionColors.gray1,
                                      ),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Image.asset("assets/icons/dialogTruck.png",
                                            height: getSize(context, true, 70/415),
                                            width: getSize(context, true, 120/415),
                                            fit: BoxFit.fitHeight,
                                            color: isSelectLieferservice == true
                                                ? BeysionColors.orange
                                                : BeysionColors.purple,
                                          ),
                                          Text(
                                            "Lieferservice",
                                            style: GoogleFonts.overpass(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 16,
                                                color: isSelectLieferservice == true
                                                    ? Colors.white
                                                    : Colors.black),
                                          ),
                                          Text(
                                            "Wir liefern bis an deine Tür",
                                            style: GoogleFonts.overpass(
                                                fontSize: 13,
                                                fontWeight: FontWeight.w500,
                                                color: isSelectLieferservice == true
                                                    ? Colors.white
                                                    : Colors.black),
                                            textAlign: TextAlign.center,
                                          )
                                        ],
                                      ),
                                    ),
                                    isSelectLieferservice == true
                                        ? Positioned(
                                      top: getSize(context, true, 5 / 415),
                                      right: getSize(context, true, 5 / 415),
                                      child: Container(
                                        height: getSize(context, true, 30 / 415),
                                        width: getSize(context, true, 30 / 415),
                                        alignment: Alignment.topRight,
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle, color: Colors.white),
                                        child: Center(
                                          child: FaIcon(
                                            FontAwesomeIcons.check,
                                            color: BeysionColors.purple,
                                            size: getSize(context, true, 15 / 415),
                                          ),
                                        ),
                                      ),
                                    )
                                        : SizedBox()
                                  ],
                                ),
                                onTap: () {
                                  setsState(() {
                                    isSelectLieferservice = !isSelectLieferservice;
                                  });
                                },
                              ),
                            ),
                          ),
                          SizedBox(width: 20,),
                          Expanded(
                            child: AspectRatio(
                              aspectRatio: 1,
                              child: InkWell(
                                child: Stack(
                                  fit: StackFit.loose,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: isSelectAbholservice == true
                                            ? BeysionColors.purple
                                            : BeysionColors.gray1,
                                      ),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Image.asset("assets/icons/dialogStore.png",
                                            height: getSize(context, true, 70/415),
                                            width: getSize(context, true, 120/415),
                                            fit: BoxFit.fitHeight,
                                            color: isSelectAbholservice == true
                                                ? BeysionColors.orange
                                                : BeysionColors.purple,
                                          ),
                                          Text(
                                            "Abholservice",
                                            style: GoogleFonts.overpass(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 17,
                                                color: isSelectAbholservice == true
                                                    ? Colors.white
                                                    : Colors.black),
                                          ),
                                          Text(
                                            "Du holst deinen Einkauf selbst ab",
                                            style: GoogleFonts.overpass(
                                                fontSize: 14,
                                                color: isSelectAbholservice == true
                                                    ? Colors.white
                                                    : Colors.black),
                                            textAlign: TextAlign.center,
                                          )
                                        ],
                                      ),
                                    ),
                                    isSelectAbholservice == true
                                        ? Positioned(
                                      top: getSize(context, true, 5 / 415),
                                      right: getSize(context, true, 5 / 415),
                                      child: Container(
                                        height: getSize(context, true, 30 / 415),
                                        width: getSize(context, true, 30 / 415),
                                        alignment: Alignment.topRight,
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle, color: Colors.white),
                                        child: Center(
                                          child: FaIcon(
                                            FontAwesomeIcons.check,
                                            color: BeysionColors.purple,
                                            size: getSize(context, true, 15 / 415),
                                          ),
                                        ),
                                      ),
                                    )
                                        : SizedBox()
                                  ],
                                ),
                                onTap: () {
                                  setsState(() {
                                    isSelectAbholservice = !isSelectAbholservice;
                                  });
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: MediaQuery.of(context).size.width * 10 / 415,
                        horizontal: MediaQuery.of(context).size.width * 15 / 415,
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Container(
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: getWeiterTextPossibility(isSelectLieferservice, isSelectAbholservice) == 1
                                    ? Colors.green.withOpacity(0.1) : Colors.red.withOpacity(0.1),
                              ),
                              child: Center(
                                child: Text(
                                  getWeiterText(isSelectLieferservice, isSelectAbholservice),
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.overpass(
                                    color: getWeiterTextPossibility(isSelectLieferservice, isSelectAbholservice) == 2
                                        ? BeysionColors.red: getWeiterTextPossibility(isSelectLieferservice, isSelectAbholservice) == 1
                                        ? Colors.green.shade900 : getWeiterTextPossibility(isSelectLieferservice, isSelectAbholservice) == 0
                                        ? BeysionColors.red : Colors.black,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          OutlineButton(
                            borderSide: BorderSide(
                                color: BeysionColors.purple,
                                style: BorderStyle.solid),
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.circular(10)),
                            child: Row(
                              mainAxisAlignment:
                              MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Weiter",
                                  style: GoogleFonts.overpass(
                                      color: BeysionColors.purple,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16),
                                ),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width * 15 / 415,
                                ),
                                FaIcon(
                                  FontAwesomeIcons.arrowRight,
                                  color: BeysionColors.purple,
                                  size: MediaQuery.of(context).size.width * 15 / 415,
                                )
                              ],
                            ),
                            onPressed: () async {
                              SharedPreferences shared =
                              await SharedPreferences.getInstance();
                              if (getWeiterTextPossibility(isSelectLieferservice, isSelectAbholservice) != 0) {
                                if (isSelectLieferservice) {
                                  shared.setInt("lieferService", 1);
                                  settingRepo.lieferService.value = 1;
                                } else {
                                  shared.setInt("lieferService", 0);
                                  settingRepo.lieferService.value = 0;
                                }
                                if (isSelectAbholservice) {
                                  shared.setInt("abholService", 1);
                                  settingRepo.abholService.value = 1;
                                } else {
                                  shared.setInt("abholService", 0);
                                  settingRepo.abholService.value = 0;
                                }
                                try {
                                  Provider.of<MarketsHomeProvider>(context, listen: false).getMarketsHomeController();
                                  Provider.of<ProductDiscountProvider>(context, listen: false).getProductDiscountController(pageNumber: 1);
                                  Provider.of<RecommendedMarketsHomeProvider>(context, listen: false).getRecommendedMarketsHomeController();
                                  Provider.of<MarketListProvider>(context, listen: false).getMarketListController();
                                  Provider.of<BasketProvider>(context, listen: false).getBasketDetailDataController();
                                } catch (e) {
                                  print(
                                      'Exception -- WELCOME PAGE PROVIDER -- $e');
                                }
                                Navigator.pop(context, true);
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  getWeiterText(bool isSelectLieferservice, bool isSelectAbholservice) {
    if (isSelectAbholservice && isSelectLieferservice) {
      return "Beide Servicearten sind ausgewählt! Bitte bei der Produkt- oder Marktauswahl auf die Hinweise Lieferservice und Abholservice achten.";
    }
    if (isSelectAbholservice || isSelectLieferservice) {
      return "Sie können auch 2 Lieferoptionen auswählen, wenn Sie dies wünschen.";
    }
    if (isSelectAbholservice || isSelectLieferservice == false) {
      return "Bitte mindestens eine Serviceart auswählen.";
    }
  }

  //SharedPreferences sharedPreferences;
  int getWeiterTextPossibility(
      bool isSelectLieferservice, bool isSelectAbholservice) {
    if (isSelectAbholservice && isSelectLieferservice) {return 2;}
    if (isSelectAbholservice || isSelectLieferservice) {return 1;}
    if (isSelectAbholservice || isSelectLieferservice == false) {return 0;}
    return 0;
  }




}