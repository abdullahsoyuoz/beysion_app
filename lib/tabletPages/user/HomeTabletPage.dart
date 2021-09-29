import 'dart:convert';

import 'package:beysion/Utility/Colors.dart';
import 'package:beysion/Utility/Icons.dart';
import 'package:beysion/Utility/util.dart';
import 'package:beysion/pages/user/MarketDiscountPage.dart';
import 'package:beysion/rest/entity/user/market/markets_all_entity.dart';
import 'package:beysion/rest/service/market/markets_service.dart';
import 'package:beysion/tabletPages/user/MarketDiscountTabletPage.dart';
import 'package:beysion/tabletPages/user/MarketListTabletPage.dart';
import 'package:beysion/utility/Images.dart';
import 'package:beysion/utility/Widgets.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../rest/controller/user/basket_provider.dart';
import '../../rest/controller/user/market_all_list_provider.dart';
import 'package:beysion/rest/controller/user/market_list_provider.dart';
import 'package:beysion/rest/controller/user/markets_home_provider.dart';
import 'package:beysion/rest/controller/user/product_all_provider.dart';
import 'package:beysion/rest/controller/user/product_discount_provider.dart';
import 'package:beysion/rest/controller/user/recommended_markets_home_provider.dart';
import 'package:beysion/rest/controller/user/user_address_provider.dart';
import 'package:beysion/rest/controller/user/user_login_information_provider.dart';
import 'package:beysion/rest/entity/user/market/markets_home_entity.dart';
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

import 'MarketDetailHomeTabletPage.dart';
import 'MarketDetailTabletPage.dart';


class HomeTabletPage extends StatefulWidget {
  @override
  _HomeTabletPageState createState() => _HomeTabletPageState();
}

class _HomeTabletPageState extends State<HomeTabletPage> with SingleTickerProviderStateMixin {
  bool isSelectLieferservice = false;
  bool isSelectAbholservice = false;

  TextEditingController plzTextController = new TextEditingController();
  TextEditingController produktSuchenDialogController = new TextEditingController();

  bool getData = false;
  TabController _tabController;
  ScrollController _scrollController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if(settingRepo.abholService.value == 0 && settingRepo.lieferService.value ==0){
        _showDialog();
      }
      isLoggedInControl();
      Provider.of<ProductDiscountProvider>(context, listen: false).getProductDiscountController(pageNumber: 1);
      Provider.of<ProductAllProvider>(context, listen: false).getProductAllList(pageNumber: 1);
      Provider.of<MarketAllListProvider>(context, listen: false).getMarketAllListController();
      Provider.of<BasketProvider>(context, listen: false).getBasketDetailDataController();
    });
    _tabController = TabController(vsync: this, length: 1);
    _scrollController = ScrollController();
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
    super.dispose();
    _tabController.dispose();
    _scrollController.dispose();
  }

  Future getPageRefreshData() async {
    Provider.of<MarketsHomeProvider>(context, listen: false).getMarketsHomeController();
    Provider.of<ProductDiscountProvider>(context, listen: false).getProductDiscountController(pageNumber: 1, pageUserStatus: 1);
    Provider.of<RecommendedMarketsHomeProvider>(context, listen: false).getRecommendedMarketsHomeController();
    Provider.of<BasketProvider>(context, listen: false).getBasketDetailDataController();
  }

  @override
  Widget build(BuildContext context) {
    final double barHeight = MediaQuery.of(context).padding.top;
    List<MarketsHomeEntity> marketsHomeProvider = Provider.of<MarketsHomeProvider>(context, listen: true).marketsHomeEntityList;
    List<MarketsHomeEntity> recommendedMarketsList = Provider.of<RecommendedMarketsHomeProvider>(context, listen: true).recommendedMarketsHomeEntityList;

    return WillPopScope(
      onWillPop: () async => false,
      child: RefreshIndicator(
        onRefresh: () => getPageRefreshData(),
        child: Scaffold(
          // body: buildBody(context, barHeight,productSearchList, marketsHomeProvider,
          //     productListDiscounted, recommendedMarketsList),
          appBar: buildAppBarTablet(context, homePage: true),
          body: ListView(
            children: <Widget>[
              Container(
                height: getSize(context, true, 165/415),
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
                        child: Row(
                          children: [
                            Expanded(
                              child: FlatButton(
                                onPressed: () {
                                  showMarktSuchenFullScreenDialog(context, produktSuchenDialogController);
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Märkte Suchen", style: GoogleFonts.overpass(fontSize:18,color: Colors.grey.shade300),),
                                    FaIcon(FontAwesomeIcons.search, color: Colors.grey.shade300,)
                                  ],
                                ),
                                color: Colors.white,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                height: getSize(context, true, 30/415),
                              ),
                            ),
                            SizedBox(width: 20,),
                            Expanded(
                              child: FlatButton(
                                onPressed: () {
                                  Navigator.push(context, CupertinoPageRoute(builder: (context) => MarketListTabletPage(false),));
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        FaIcon(FontAwesomeIcons.store, color: BeysionColors.purple,),
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
                                height: getSize(context, true, 30/415),
                              ),
                            )
                          ],
                        ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          FlatButton(
                            onPressed: () {
                              Navigator.push(context, CupertinoPageRoute(builder: (context) => MarketDiscountTabletPage(),));
                            },
                            child: Row(
                              children: [
                                Row(
                                  children: [
                                    FaIcon(FontAwesomeIcons.tag, color: BeysionColors.purple,),
                                    Padding(
                                      padding: EdgeInsets.only(left: 12.0),
                                      child: Text("reduzierte Produkte", style: GoogleFonts.overpass(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w600),),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 12.0),
                                  child: FaIcon(FontAwesomeIcons.arrowRight, color: Colors.grey.shade800,),
                                )
                              ],
                            ),
                            color: BeysionColors.orange,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            height: getSize(context, true, 30/415),
                          ),
                        ],
                      ),
                    )                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: getSize(context, true, 20/360)),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("${settingRepo.zipCodeSelectedEntity.value.text}",style: TextStyle(
                      fontSize: 20,
                    ),),
                    FlatButton(
                      child: Text("PLZ ANDERN", style: GoogleFonts.overpass(color: BeysionColors.purple, fontSize: 20),),
                      padding: EdgeInsets.zero,
                      onPressed: () {
                        showFullScreenDialog(context, plzTextController);
                      },
                    )
                  ],
                ),
              ),
              SizedBox(height: 7,),
              buildRecommendedMarketListBody(context, recommendedMarketsList),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Kampagnen", style: GoogleFonts.overpass(color: BeysionColors.purple, fontSize: 22, fontWeight: FontWeight.w800),),
                  ),
                  Container(
                    width: getSize(context, true, 371 / 415),
                    height: getSize(context, true, 100 / 415),
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
                            fit: BoxFit.contain,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: getSize(context, true, 2 / 375)),
                          child: Image.asset(
                            ImagesPath.adv2,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          )
        ),
      ),
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
              Text("Unsere Markt Empfehlungen", style: GoogleFonts.overpass(color: BeysionColors.purple, fontSize: 22, fontWeight: FontWeight.w800),),
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
      margin: EdgeInsets.only(top: getSize(context, true, 10 / 415),),
      padding: EdgeInsets.only(bottom: getSize(context, true, 10/415)),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(5)),
          border: Border.all(
              color: BeysionColors.border.withOpacity(0.5), width: 1)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(
              left: getSize(context, true, 10 / 415),
              top: getSize(context, true, 10 / 415),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: getSize(context, true, 25 / 415),
                  height: getSize(context, true, 20 / 415),
                  decoration: BoxDecoration(
                      color: rankBoxColor,
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                  child: Center(child: Text(marketEntity.point.toString(),
                    style: GoogleFonts.overpass(
                        fontSize: 20,
                        fontWeight: FontWeight.bold
                    ),)),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(left: getSize(context, true, 7 / 415)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: getSize(context, true, 20 / 415),
                          alignment: Alignment.centerLeft,
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => MarketDetailHomeTabletPage( marketEntity.id,),
                                  ));
                            },
                            child: Text(
                              "${marketEntity.name}",
                              style: GoogleFonts.overpass(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: BeysionColors.purple),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: getSize(context, true, 10/415)),
                          child: Divider(
                            height: 1,
                            color: Colors.black.withOpacity(0.4),
                          ),
                        ),
                        SizedBox(height: getSize(context, true, 3 / 415),),
                        Text(
                          "${marketEntity.address}, ${marketEntity.zipcode}",
                          style: GoogleFonts.overpass(
                            fontSize: 12,
                            color: BeysionColors.gray2,
                          ),),
                        SizedBox(height: getSize(context, true, 3 / 415),),
                        InkWell(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(
                                IconsPath.basket,
                                width: getSize(context, true, 12/415),
                              ),
                              SizedBox(width: getSize(context, true, 3 / 415),),
                              Text(
                                "Im Laden einkaufen",
                                style: GoogleFonts.overpass(
                                    fontSize: 14, fontWeight: FontWeight.w600),
                              )
                            ],
                          ),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MarketDetailHomeTabletPage(marketEntity.id,),
                                ));
                          },
                        ),
                      ],
                    ),
                  ),
                )
              ],
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
                                top: getSize(context, true, 10 / 415),
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
                                      child: loadingData == false ? Container(
                                        margin: EdgeInsets.only(top: 85),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Text("Anruf...", style: TextStyle(fontSize: 18),),
                                              ),
                                            ),
                                          ],
                                        ),) :
                                      getData == false ? Container(
                                          margin: EdgeInsets.only(top: 100),
                                          child: Center(child: CircularProgressIndicator())) :
                                      ListView.builder(
                                          shrinkWrap: true,
                                          padding: EdgeInsets.only(top: getSize(context, true, 35/415),),
                                          itemCount: _zipCodeListData.length,
                                          itemBuilder: (context, index){
                                            return InkWell(
                                              onTap: () {
                                                setState(() {
                                                  settingRepo.zipCodeSelectedEntity.value =  _zipCodeListData[index];
                                                });
                                                Navigator.pop(context);
                                              },
                                              child: Container(
                                                height: getSize(context, true, 25/415),
                                                padding: EdgeInsets.symmetric(horizontal: 20),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  children: [
                                                    Expanded(
                                                      // TODO:
                                                      child: Text("${_zipCodeListData[index].text}",
                                                          overflow: TextOverflow.fade,
                                                          style: TextStyle(fontSize: 19),
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
                                      height: getSize(context, true, 35/415),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(5),
                                          boxShadow: [BoxShadow(color: Colors.grey.shade200, blurRadius: 3, spreadRadius: 2)]
                                      ),
                                      child: TextField(
                                        style: TextStyle(fontSize: 20),
                                        controller: testController,
                                        autofocus: true,
                                        decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: "Ihre PLZ",
                                            hintStyle: TextStyle(color: Colors.grey.shade300, fontSize: 20),
                                            contentPadding: EdgeInsets.all(20)
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
                                  child: loadingData == false ? Container(
                                    margin: EdgeInsets.only(top: 50),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text("Anruf..."),
                                          ),
                                        ),
                                      ],
                                    ),) :
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
                                            Navigator.push(context, MaterialPageRoute(builder: (context) => MarketDetailTabletPage(marketDataEntity),));
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


  _showDialog() async {
    await Future.delayed(Duration(milliseconds: 50)).then((value) => showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) {
            return WillPopScope(
              onWillPop: () async => false,
              child: StatefulBuilder(
                builder: (context, setsState) {
                  return Dialog(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25)),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 330 / 415,
                      height: MediaQuery.of(context).size.width * 330 / 415,
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
                                width: MediaQuery.of(context).size.width,
                                margin: EdgeInsets.only(
                                  bottom: MediaQuery.of(context).size.width * 5 / 415,
                                ),
                                decoration: BoxDecoration(
                                    color: BeysionColors.purple,
                                    shape: BoxShape.rectangle,
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(25),
                                        topRight: Radius.circular(25)
                                    )
                                ),
                                child: Center(
                                    child: Text("Service wählen",
                                        style: GoogleFonts.overpass(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 28,
                                            color: Colors.white),
                                        textAlign: TextAlign.center)),
                              ),
                              SizedBox(
                                height: getSize(context, true, 5/415),
                              ),
                              Text(
                                "Bitte wähle die Serviceart aus, die du möchtest:",
                                style: GoogleFonts.overpass(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w800),
                                textAlign: TextAlign.center,
                              )
                            ],
                          ),
                          buildContent(context, setsState),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: MediaQuery.of(context).size.width * 15 / 415,
                              ),
                              child: Column(
                                children: [
                                  Container(
                                    width: getSize(context, true, 1),
                                    height: getSize(context, true, 30 / 415),
                                    margin: EdgeInsets.only(bottom: getSize(context, true, 10/415)),
                                    padding: EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: getWeiterTextPossibility(
                                                  isSelectLieferservice,
                                                  isSelectAbholservice) ==
                                              1
                                          ? Colors.green.withOpacity(0.1)
                                          : Colors.red.withOpacity(0.1),
                                    ),
                                    child: Center(
                                      child: Text(
                                        getWeiterText(isSelectLieferservice,
                                            isSelectAbholservice),
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.overpass(
                                          color: getWeiterTextPossibility(
                                                      isSelectLieferservice,
                                                      isSelectAbholservice) ==
                                                  2
                                              ? BeysionColors.red
                                              : getWeiterTextPossibility(
                                                          isSelectLieferservice,
                                                          isSelectAbholservice) ==
                                                      1
                                                  ? Colors.green.shade900
                                                  : getWeiterTextPossibility(
                                                              isSelectLieferservice,
                                                              isSelectAbholservice) ==
                                                          0
                                                      ? BeysionColors.red
                                                      : Colors.black,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(bottom: getSize(context, true, 10/415)),
                                    child: OutlineButton(
                                      padding: EdgeInsets.symmetric(
                                        vertical: getSize(context, true, 5/415)
                                      ),
                                      borderSide: BorderSide(
                                          color: BeysionColors.purple,
                                          style: BorderStyle.solid),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5)),
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
                                            width: MediaQuery.of(context).size.width * 5 / 415,
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
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          },
        ));
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

  buildContent(BuildContext context, dynamic setsState) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width * 15 / 415,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            child: Stack(
              fit: StackFit.loose,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 140 / 415,
                  height: MediaQuery.of(context).size.width * 140 / 415,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: isSelectLieferservice == true
                        ? BeysionColors.purple
                        : BeysionColors.gray1,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FaIcon(
                        FontAwesomeIcons.truck,
                        color: isSelectLieferservice == true
                            ? BeysionColors.orange
                            : BeysionColors.purple,
                        size: getSize(context, true, 35 / 415),
                      ),
                      Text(
                        "Lieferservice",
                        style: GoogleFonts.overpass(
                            fontWeight: FontWeight.w600,
                            fontSize: 26,
                            color: isSelectLieferservice == true
                                ? Colors.white
                                : Colors.black),
                      ),
                      Text(
                        "Wir liefern bis an\ndeine Tür",
                        style: GoogleFonts.overpass(
                            fontSize: 15,
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
          InkWell(
            child: Stack(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 140 / 415,
                  height: MediaQuery.of(context).size.width * 140 / 415,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: isSelectAbholservice == true
                        ? BeysionColors.purple
                        : BeysionColors.gray1,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FaIcon(
                        FontAwesomeIcons.shoePrints,
                        color: isSelectAbholservice == true
                            ? BeysionColors.orange
                            : BeysionColors.purple,
                        size: getSize(context, true, 35 / 415),
                      ),
                      Text(
                        "Abholservice",
                        style: GoogleFonts.overpass(
                            fontWeight: FontWeight.w600,
                            fontSize: 26,
                            color: isSelectAbholservice == true
                                ? Colors.white
                                : Colors.black),
                      ),
                      Text(
                        "Du holst deinen\nEinkauf selbst ab",
                        style: GoogleFonts.overpass(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
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
        ],
      ),
    );
  }
}

class CustomSliverDelegate extends SliverPersistentHeaderDelegate {
  TabController _tabController;

  CustomSliverDelegate(this._tabController);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: TabBar(
        controller: _tabController,
        indicatorColor: Colors.white,
        tabs: <Widget>[
          Row(
            children: [
              Expanded(child: Text("Unsere Markt Empfehlungen", style: GoogleFonts.overpass(color: BeysionColors.purple, fontSize: 24, fontWeight: FontWeight.w800),)),
            ],
          ),
        ],
      ),
    );
  }

  @override
  double get maxExtent => 50.0;

  @override
  double get minExtent => 50.0;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
