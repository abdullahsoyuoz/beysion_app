import 'package:beysion/constant/ScanBarcodePage.dart';
import 'package:beysion/constant/app_configurations.dart';
import 'package:beysion/pages/user/MarketCommentPage.dart';
import 'package:beysion/pages/user/ProductDetailPage.dart';
import 'package:beysion/pages/user/MarketProductCategoryPage.dart';
import 'package:beysion/rest/controller/user/market_in_category_provider.dart';
import 'package:beysion/rest/controller/user/markets_detail_provider.dart';
import 'package:beysion/rest/entity/user/market/market_category_entity.dart';
import 'package:beysion/rest/entity/user/market/market_detail_entity.dart';
import 'package:beysion/rest/entity/user/market/markets_all_entity.dart';
import 'package:beysion/rest/entity/user/product_entity.dart';
import 'package:beysion/rest/response_models/base_response.dart';
import 'package:beysion/rest/response_models/ok_response.dart';
import 'package:beysion/rest/service/market/market_product_service.dart';
import 'package:beysion/utility/Colors.dart';
import 'package:beysion/utility/util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:beysion/constant/app_configurations.dart' as settingRepo;

class MarketDetailHomePage extends StatefulWidget {
  int marketId;

  MarketDetailHomePage(this.marketId);
  @override
  _MarketDetailHomePageState createState() => _MarketDetailHomePageState();
}

class _MarketDetailHomePageState extends State<MarketDetailHomePage>  with SingleTickerProviderStateMixin {
  TextEditingController produktSuchenDialogController = new TextEditingController();

  TabController _tabController;
  ScrollController _scrollController;

  bool getData = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 1);
    _scrollController = ScrollController();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      Provider.of<MarketDetailProvider>(context, listen: false).getMarketDetailController(widget.marketId);
      Provider.of<MarketInCategoryProvider>(context, listen: false).getMarketInCategoryListController(widget.marketId);
    });
  }
  @override
  void dispose(){
    _tabController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<MarketCategoryEntity> marketCategoryDataList = Provider.of<MarketInCategoryProvider>(context, listen: true).marketNotAlleList;
    MarketDetailEntity marketDetailEntity = Provider.of<MarketDetailProvider>(context, listen: true).marketsDetailEntity;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color.fromARGB(255, 246, 246, 246),
      body: Container(
        margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        child: marketDetailEntity!=null && marketDetailEntity.name!=null ? NestedScrollView(
          controller: _scrollController,
          headerSliverBuilder: (BuildContext context, bool boxIsScrolled) {
            return <Widget>[
              SliverToBoxAdapter(
                child: Container(
                  child: Stack(
                    children: [
                      Container(
                        height: getSize(context, true, 120/360),
                        child: (Image.network("${marketDetailEntity.logo}",
                          width: getSize(context, true, 1),
                          fit: BoxFit.fitWidth,
                          alignment: Alignment.topCenter,
                        )),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: getSize(context, true, 120/360),),
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: ClipRRect(
                            borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.white
                              ),
                              padding: EdgeInsets.only(
                                top: 30,
                                left: getSize(context, true, 20/360),
                                right: getSize(context, true, 20/360),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          InkWell(
                                              onTap: () {
                                                //Navigator.pop(context);
                                                settingRepo.pageViewState.value.oneParam = null;
                                                settingRepo.pageViewState.value.twoParam = null;
                                                settingRepo.pageViewState.value.pageController.animateToPage(0, duration: Duration(milliseconds: 100), curve: Curves.easeInOutExpo);
                                              },
                                              child: FaIcon(FontAwesomeIcons.arrowLeft)),
                                          Padding(
                                            padding: EdgeInsets.only(left: 16.0),
                                            child: Text("${marketDetailEntity.name}", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),),
                                          ),
                                        ],
                                      ),
                                      Container(
                                        height: getSize(context, true, 20/360),
                                        padding: EdgeInsets.symmetric(horizontal: 10),
                                        margin: EdgeInsets.only(left: 10),
                                        decoration: BoxDecoration(
                                            color: BeysionColors.orange,
                                            borderRadius: BorderRadius.circular(5)
                                        ),
                                        child: Center(child: Text("${marketDetailEntity.avgScore}", style: TextStyle(color: BeysionColors.purple, fontWeight: FontWeight.w700),)),
                                      )
                                    ],
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: 8.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(child: Text("${marketDetailEntity.address}", style: TextStyle(color: Colors.grey.shade700, fontSize: 12),)),
                                        OutlineButton(
                                          child: Center(
                                            child: Row(
                                              children: [
                                                FaIcon(FontAwesomeIcons.mapMarkedAlt, color: Colors.grey.shade700, size: getSize(context, true, 15/360),),
                                                Padding(
                                                  padding: EdgeInsets.only(left: 8.0),
                                                  child: Text("Karte öffnen", style: TextStyle(color: Colors.grey.shade700, fontSize: 13),),
                                                )
                                              ],
                                            ),
                                          ),
                                          onPressed: () async{
                                            if (await canLaunch(
                                                "${marketDetailEntity.mapUrl}")) {
                                              await launch("${marketDetailEntity.mapUrl}");
                                            }
                                          },
                                        )
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: 16),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Container(
                                            padding: EdgeInsets.all(8),
                                            decoration: BoxDecoration(
                                                color: Colors.grey.shade100,
                                                borderRadius: BorderRadius.circular(5)
                                            ),
                                            child: Center(
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Text("Reaktionszeit", style: GoogleFonts.overpass(color: Colors.black, fontSize: 13),),
                                                  Text("${marketDetailEntity.point1}", style: GoogleFonts.overpass(color: BeysionColors.purple, fontSize: 15, fontWeight: FontWeight.w800),),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: getSize(context, true, 10/360),),
                                        Expanded(
                                          child: Container(
                                            padding: EdgeInsets.all(8),
                                            decoration: BoxDecoration(
                                                color: Colors.grey.shade100,
                                                borderRadius: BorderRadius.circular(5)
                                            ),
                                            child: Center(
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Text("Bedienung", style: GoogleFonts.overpass(color: Colors.black, fontSize: 13),),
                                                  Text("${marketDetailEntity.point2}", style: GoogleFonts.overpass(color: BeysionColors.purple, fontSize: 15, fontWeight: FontWeight.w800),),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: getSize(context, true, 10/360),),
                                        Expanded(
                                          child: Container(
                                            padding: EdgeInsets.all(8),
                                            decoration: BoxDecoration(
                                                color: Colors.grey.shade100,
                                                borderRadius: BorderRadius.circular(5)
                                            ),
                                            child: Center(
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Text("Verpackung", style: GoogleFonts.overpass(color: Colors.black, fontSize: 13),),
                                                  Text("${marketDetailEntity.point3}", style: GoogleFonts.overpass(color: BeysionColors.purple, fontSize: 15, fontWeight: FontWeight.w800),),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Column(
                                    //  MARKET INFO MINDESPAKETMENGE ETC...
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(top: 8.0),
                                        child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              child: Column(
                                                children: [
                                                  Text("Mindestpaketmenge",
                                                    textAlign: TextAlign.center,
                                                    maxLines: 1,
                                                    softWrap: true,
                                                    overflow: TextOverflow.ellipsis,
                                                    style: GoogleFonts.overpass(color: Colors.grey.shade500),),
                                                  Text("${marketDetailEntity.minimumSellPrice}",
                                                    textAlign: TextAlign.center,
                                                    maxLines: 1,
                                                    softWrap: true,
                                                    overflow: TextOverflow.ellipsis,
                                                    style: GoogleFonts.overpass(fontSize: 16),),
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                              child: Column(
                                                children: [
                                                  Text("Arbeitszeit (heute)", textAlign: TextAlign.center,
                                                    maxLines: 1,
                                                    softWrap: true,
                                                    overflow: TextOverflow.ellipsis,
                                                    style: GoogleFonts.overpass(color: Colors.grey.shade500),),
                                                  Text("${marketDetailEntity.workingTimeNow}", textAlign: TextAlign.center,
                                                    maxLines: 1,
                                                    softWrap: true,
                                                    overflow: TextOverflow.ellipsis,
                                                    style: GoogleFonts.overpass(fontSize: 16),),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 8.0),
                                        child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              child: Column(
                                                children: [
                                                  Text("Vorbereitungszeit", textAlign: TextAlign.center,
                                                    maxLines: 1,
                                                    softWrap: true,
                                                    overflow: TextOverflow.ellipsis,
                                                    style: GoogleFonts.overpass(color: Colors.grey.shade500),),
                                                  Text("${marketDetailEntity.preparingTime}", style: GoogleFonts.overpass(fontSize: 16),),
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                              child: Column(
                                                children: [
                                                  Text("Service Wählen",textAlign: TextAlign.center,
                                                    maxLines: 1,
                                                    softWrap: true,
                                                    overflow: TextOverflow.ellipsis,
                                                    style: GoogleFonts.overpass(color: Colors.grey.shade500),),
                                                  Text("${marketDetailEntity.deliveryType}",textAlign: TextAlign.center,
                                                    maxLines: 2,
                                                    softWrap: true,
                                                    overflow: TextOverflow.ellipsis,
                                                    style: GoogleFonts.overpass(fontSize: 16),),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),


                                    ],
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: 16),
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.push(context, MaterialPageRoute(builder: (context) => MarketCommentPage(),));
                                      },
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          FaIcon(FontAwesomeIcons.solidCommentAlt, color: Colors.grey.shade800, size: getSize(context, true, 15/360),),
                                          SizedBox(width: getSize(context, true, 5/360),),
                                          Text("Shop-Bewertungen"),
                                          SizedBox(width: getSize(context, true, 5/360),),
                                          Text("(147)"),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                      top: 16,
                                      bottom: 8.0,
                                    ),
                                    child: Container(
                                      height: getSize(context, true, 30/415),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(5),
                                          boxShadow: [BoxShadow(color: Colors.grey.shade200, blurRadius: 3, spreadRadius: 2)]
                                      ),
                                      child: FlatButton(
                                        onPressed: () {
                                          showProduktSuchenFullScreenDialog(context, produktSuchenDialogController, marketDetailEntity);
                                        },
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text("Product Search", style: GoogleFonts.overpass(color: Colors.grey.shade300),),
                                            FaIcon(FontAwesomeIcons.search, color: Colors.grey.shade300,)
                                          ],
                                        ),
                                        color: Colors.white,
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                        height: getSize(context, true, 50/415),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SliverPersistentHeader(
                delegate: CustomSliverDelegate(_tabController),
                pinned: true,
                floating: true,
              ),
            ];
          },
          body: TabBarView(
            controller: _tabController,
            children: <Widget>[
              GridView.count(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                physics: NeverScrollableScrollPhysics(),
                crossAxisCount: 3,
                mainAxisSpacing: getSize(context, true, 5/360),
                crossAxisSpacing: getSize(context, true, 5/360),
                childAspectRatio: 5/6,
                padding: EdgeInsets.symmetric(
                    vertical: getSize(context, true, 10 / 415),
                    horizontal: getSize(context, true, 5 / 415)),
                children: marketCategoryDataList.map((categoryEntity) => InkWell(
                  onTap: (){
                    MarketsAllEntity entityAllMarket = new MarketsAllEntity();
                    entityAllMarket.id = widget.marketId;
                    entityAllMarket.name = marketDetailEntity.name;
                    entityAllMarket.logo = marketDetailEntity.logo;
                    entityAllMarket.address = marketDetailEntity.address;
                    entityAllMarket.fulladdress = marketDetailEntity.address;
                    entityAllMarket.phone = marketDetailEntity.phone;
                    entityAllMarket.point1 = marketDetailEntity.point1;
                    entityAllMarket.point2 = marketDetailEntity.point2;
                    entityAllMarket.point3 = marketDetailEntity.point3;
                    entityAllMarket.avgScore = marketDetailEntity.avgScore;
                    entityAllMarket.firstPage = marketDetailEntity.firstPage;
                    entityAllMarket.deliveryType = marketDetailEntity.deliveryType;
                    entityAllMarket.preparingTime = marketDetailEntity.preparingTime;
                    entityAllMarket.minimumSellPrice = marketDetailEntity.minimumSellPrice;
                    entityAllMarket.workingStatus = marketDetailEntity.workingStatus;
                    entityAllMarket.workingTimeNow = marketDetailEntity.workingTimeNow;
                    entityAllMarket.workingDays = marketDetailEntity.workingDays;
                    entityAllMarket.today = marketDetailEntity.today;

                    //Navigator.pop(context);
                    settingRepo.pageViewState.value.oneParam = entityAllMarket;
                    settingRepo.pageViewState.value.twoParam = categoryEntity;
                    settingRepo.pageViewState.value.pageController.animateToPage(8, duration: Duration(milliseconds: 100), curve: Curves.easeInOutExpo);
                   // Navigator.push(context, CupertinoPageRoute(builder: (context) => MarketProductCategoryPage(categoryEntity,entityAllMarket),));
                  },
                  child: Container(
                    width: getSize(context, true, 100/360),
                    height: getSize(context, true, 150/360),
                    child: Column(
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(7),
                                boxShadow: [BoxShadow(color: Colors.grey.shade200, spreadRadius: 0, blurRadius: 3)]
                            ),
                            child: Image.network("${AppConfigurations.beysionURL}${categoryEntity.image}",
                              width: getSize(context, true, 100/360),
                              height: getSize(context, true, 100/360),
                            ),
                            width: getSize(context, true, 100/360),
                            height: getSize(context, true, 100/360),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 8.0),
                          child: Container(
                              width: getSize(context, true, 100/360),
                              height: getSize(context, true, 40/360),
                              child: Text("${categoryEntity.name}",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.overpass(fontSize: 13),)),
                        )
                      ],
                    ),
                  ),
                )).toList(),
              )
            ],
          ),
        ): Container(child: Center(child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            CircularProgressIndicator(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Wird geladen..."),
            ),
          ],
        ),),),
      ),
    );
  }


  void showProduktSuchenFullScreenDialog(BuildContext context, TextEditingController testController, MarketDetailEntity marketDetailEntity) {
    testController.clear();
    bool loadingData = false;
    List<ProductEntity> productSearchList = new List();
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
                                      padding: EdgeInsets.only(top: getSize(context, true, 50/415),),
                                      itemCount: productSearchList.length,
                                      itemBuilder: (context, index){
                                        return ClipRRect(
                                          borderRadius: BorderRadius.circular(8.0),
                                          child: Material(
                                            color: Colors.white,
                                            child: Container(
                                              color: Colors.white,
                                              child: Column(
                                                children: productSearchList.map((productEntity) =>
                                                    InkWell(
                                                      onTap: (){
                                                        Navigator.push(context, MaterialPageRoute(builder: (context) => ProductDetailPage(productEntity, marketId: widget.marketId,)));},
                                                      child: Padding(
                                                        padding: const EdgeInsets.all(8.0),
                                                        child: Row(
                                                          crossAxisAlignment: CrossAxisAlignment.center,
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          children: [
                                                            Expanded(
                                                              flex:1,
                                                              child: Padding(
                                                                padding: const EdgeInsets.all(8.0),
                                                                child: Image.network(
                                                                  productEntity.image,
                                                                  fit: BoxFit.fitHeight,
                                                                  height: 50,width: 50,
                                                                ),
                                                              ),
                                                            ),
                                                            Expanded(
                                                              flex: 4,
                                                              child: Column(
                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                mainAxisAlignment: MainAxisAlignment.start,
                                                                children: [
                                                                  Text(
                                                                    productEntity.name,
                                                                    style: GoogleFonts.overpass(color: Colors.black, fontWeight: FontWeight.w300, fontSize: 11,),
                                                                    maxLines: 2,
                                                                    textAlign: TextAlign.start,
                                                                  ),
                                                                  Row(
                                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                                    children: [
                                                                      SmoothStarRating(
                                                                        starCount: 5,
                                                                        size: getSize(context, true, 15 / 415),
                                                                        rating: 0,
                                                                        isReadOnly: false,
                                                                        allowHalfRating: false,
                                                                        borderColor: BeysionColors.yellow,
                                                                        color: BeysionColors.yellow,
                                                                        onRated: (rating) {},),
                                                                      Text("(5)",
                                                                        style: GoogleFonts.overpass(fontSize: 12),),
                                                                      Padding(
                                                                        padding: EdgeInsets.symmetric(horizontal: getSize(context, true, 5 / 415)),
                                                                        child: FaIcon(
                                                                          FontAwesomeIcons.store,
                                                                          color: BeysionColors.purple,
                                                                          size: getSize(context, true, 12 / 415),
                                                                        ),
                                                                      ),
                                                                      Expanded(
                                                                        child: Text("${marketDetailEntity.name}",
                                                                          overflow: TextOverflow.fade,
                                                                          softWrap: false,
                                                                          maxLines: 1,
                                                                          style: GoogleFonts.overpass(
                                                                              fontSize: 10,
                                                                              fontWeight: FontWeight.w400,
                                                                              color: BeysionColors.purple),
                                                                        ),
                                                                      )
                                                                    ],
                                                                  ),
                                                                  productEntity.discountPrice!=null ?
                                                                  Row(
                                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                                    children: [
                                                                      Flexible(
                                                                          flex: 1,
                                                                          child: Container(
                                                                            width: getSize(context, true, 50 / 415),
                                                                            height: getSize(context, true, 30 / 415),
                                                                            decoration: BoxDecoration(
                                                                                color: Colors.red,
                                                                                borderRadius: BorderRadius.circular(5)
                                                                            ),
                                                                            child: Center(
                                                                              child: Text(
                                                                                fiyatYuzdeHesaplama(productEntity),
                                                                                overflow: TextOverflow.fade,
                                                                                maxLines: 1,
                                                                                softWrap: false,
                                                                                style: GoogleFonts.overpass(
                                                                                    color: Colors.white,
                                                                                    fontSize: 15,
                                                                                    fontWeight: FontWeight.w800),
                                                                              ),
                                                                            ),
                                                                          )),
                                                                      SizedBox(
                                                                        width: getSize(context, true, 5 / 415),
                                                                      ),
                                                                      Flexible(
                                                                          flex: 1,
                                                                          child: Column(
                                                                            children: [
                                                                              Text(
                                                                                "${productEntity.price.toString().replaceAll(".", ",")} €",
                                                                                style: GoogleFonts.overpass(
                                                                                    decoration: TextDecoration.lineThrough,
                                                                                    color: Colors.black38,
                                                                                    fontSize: 15,
                                                                                    fontWeight: FontWeight.w400),
                                                                                textAlign: TextAlign.center,
                                                                              ),
                                                                              Text(
                                                                                "${productEntity.discountPrice.toString().replaceAll(".", ",")} €",
                                                                                style: GoogleFonts.overpass(
                                                                                    color: Colors.black,
                                                                                    fontSize: 17,
                                                                                    fontWeight: FontWeight.w700),
                                                                                textAlign: TextAlign.center,
                                                                              ),
                                                                            ],
                                                                          )),
                                                                    ],
                                                                  ): Text(
                                                                    "${productEntity.price.toString().replaceAll(".", ",")} €",
                                                                    style: GoogleFonts.overpass(
                                                                        color: Colors.black,
                                                                        fontSize: 15,
                                                                        fontWeight: FontWeight.w700),
                                                                    textAlign: TextAlign.center,
                                                                  ),
                                                                ],),
                                                            ),

                                                          ],
                                                        ),
                                                      ),
                                                    )

                                                ).toList(),
                                              ),
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
                                              hintText: "Produkt Suchen",
                                              hintStyle: TextStyle(color: Colors.grey.shade300),
                                              contentPadding: EdgeInsets.only(left: 20)
                                          ),
                                          onChanged: (value) async {
                                            if(value.length>2){
                                              setStateC(() {
                                                loadingData = true;
                                                getData = false;
                                              });
                                              productSearchList.clear();
                                              productSearchList = await getProductAllListSearch(search: value);
                                              setStateC(() {
                                              });
                                            }else{
                                              setStateC(() {
                                                loadingData = false;
                                                getData = false;
                                                productSearchList.clear();
                                              });
                                            }
                                          },
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: IconButton(
                                          onPressed: () async {
                                            final result = await Navigator.push(
                                              context,
                                              MaterialPageRoute(builder: (context) => QRCodeScannerPage()),
                                            );
                                            if(result.toString().compareTo("error")!=0){
                                              setStateC(() {
                                                String comeText = result.toString();
                                                testController.text = comeText;
                                              });
                                            }
                                          },
                                          icon: Image.asset("assets/icons/productSearchBarcodeLogo.png", width: 75,),
                                          highlightColor: Colors.transparent,
                                          splashColor: Colors.transparent,
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
          );
          },
        );
      },
    );
  }

  Future<List<ProductEntity>> getProductAllListSearch({int categoryId = 0, int pageNumber=0, int orderId = 0, String search =""}) async {
    List<ProductEntity> returnDataList = new List();
    SharedPreferences sharedPref = await SharedPreferences.getInstance();
    String sessionToken = sharedPref.getString("sessionToken");
    settingRepo.sessionToken.value = sessionToken;
    print('SESSİON TOKENIM NEDİR ProductAll Else- $sessionToken');
    BaseResponse response = await MarketProductService.operations().marketProducts(widget.marketId,0,search ,sessionToken, page: pageNumber, order: orderId);
    try{
      getData = false;
      if (response is OkResponse) {
        if (response.body != null) {
          if (response.body["data"] != null) {
            List<dynamic> dataList = response.body["data"];
            List<ProductEntity> newDataList = new List();
            for (var dataStr in dataList) {
              ProductEntity model = new ProductEntity.fromJson(dataStr);
              if (model != null) {
                if ((newDataList.singleWhere((it) => it.id == model.id,
                    orElse: () => null)) != null) {
                } else {
                  newDataList.add(model);
                }
              }
            }
            getData = true;
            returnDataList.clear();
            returnDataList.addAll(newDataList);
            return returnDataList;

          } return returnDataList;
        } return returnDataList;
      }
    }catch(e){
      print('Exception HOMMe Product All List -  $e');
    }
  }

}

class CustomSliverDelegate extends SliverPersistentHeaderDelegate {
  TabController _tabController;

  CustomSliverDelegate(this._tabController);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      height: 38.0,
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: TabBar(
        controller: _tabController,
        indicatorColor: Colors.white,
        tabs: <Widget>[
          Row(
            children: [
              Expanded(child: Text("Kategorien", style: GoogleFonts.overpass(color: BeysionColors.purple, fontSize: 18, fontWeight: FontWeight.w800),)),
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
