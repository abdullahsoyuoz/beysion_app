import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:beysion/Utility/Colors.dart';
import 'package:beysion/Utility/Icons.dart';
import 'package:beysion/Utility/util.dart';
import 'package:beysion/constant/ScanBarcodePage.dart';
import 'package:beysion/constant/app_configurations.dart';
import 'package:beysion/rest/controller/user/market_campaigns_provider.dart';
import 'package:beysion/rest/controller/user/market_in_products_provider.dart';
import 'package:beysion/rest/entity/user/campaign_market_entity.dart';
import 'package:beysion/rest/entity/user/market/markets_all_entity.dart';
import 'package:beysion/rest/entity/user/product_entity.dart';
import 'package:beysion/rest/service/market/market_product_service.dart';
import 'package:beysion/rest/service/market/markets_service.dart';
import 'package:beysion/rest/service/user_service.dart';
import 'package:beysion/tabletPages/user/UserLoginTabletPage.dart';
import 'package:beysion/utility/CustomCarouselWidget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../rest/controller/user/basket_provider.dart';
import 'package:beysion/rest/controller/user/market_brand_provider.dart';
import 'package:beysion/rest/controller/user/market_list_provider.dart';
import 'package:beysion/rest/controller/user/product_all_provider.dart';
import 'package:beysion/rest/entity/user/market/market_brand_entity.dart';
import 'package:beysion/rest/entity/user/market/market_category_entity.dart';
import 'package:beysion/rest/entity/user/market/market_list_entity.dart';
import 'package:beysion/rest/response_models/base_response.dart';
import 'package:beysion/rest/response_models/ok_response.dart';
import 'package:beysion/rest/service/basket/basket_service.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:beysion/constant/app_configurations.dart' as settingRepo;
import 'MarketProductDiscountTabletPage.dart';
import 'ProductDetailTabletPage.dart';

class MarketDiscountTabletPage extends StatefulWidget {
  @override
  _MarketDiscountTabletPageState createState() => _MarketDiscountTabletPageState();
}

class _MarketDiscountTabletPageState extends State<MarketDiscountTabletPage> with SingleTickerProviderStateMixin {
  ScrollController _scrollControllerBody = ScrollController(initialScrollOffset: 0.0, keepScrollOffset: true);
  TextEditingController _searchTextFormField = new TextEditingController();

  int viewStyle = 0;
  bool getData = false;
  TextEditingController marketCampaignSuchenDialogController = new TextEditingController();
  int page=0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<MarketCampaignsProvider>(context, listen: false).getMarketCampaignsListController(pageNumber: page);
    _scrollControllerBody.addListener(() {
      if (_scrollControllerBody.position.pixels == _scrollControllerBody.position.maxScrollExtent) {
        print('BUUUUUUUUUUUU $page');
        page++;
        Provider.of<MarketCampaignsProvider>(context, listen: false).getMarketCampaignsListController(pageNumber: page,);
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _scrollControllerBody.dispose();
    marketCampaignSuchenDialogController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<CampaignMarketEntity> campaignMarketDataList = Provider.of<MarketCampaignsProvider>(context, listen: true).marketCampaignList;
    List<MarketBrandEntity> brandListData = Provider.of<MarketBrandProvider>(context, listen:true).allMarketBrandsList;
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            InkWell(
              onTap: () {Navigator.pop(context);},
              child: FaIcon(FontAwesomeIcons.chevronLeft, color: Colors.black,),
            ),
            Padding(
              padding: EdgeInsets.only(left: 16.0),
              child: RichText(text: TextSpan(
                  text: "reduzierte Produkte",
                  style: TextStyle(fontSize: 22, color: Colors.black, fontWeight: FontWeight.bold),
                  children: [
                    TextSpan(
                        text: "",
                        style: TextStyle(color: Colors.grey)
                    )
                  ]
              ),),
            ),
          ],
        ),
        centerTitle: false,
        backgroundColor: Colors.white,
        leading: SizedBox(width: 0, height: 0,),
        leadingWidth: 0,
        elevation: 1,
        toolbarHeight: AppBar().preferredSize.height* 1.85,
        actions: [
          IconButton(
            icon: FaIcon(FontAwesomeIcons.search,
              color: Colors.black,),
            onPressed: () {
              showMarktSuchenFullScreenDialog(context, marketCampaignSuchenDialogController);
            },
          )
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(AppBar().preferredSize.height ),
          child: Column(
            children: [
              Container(
                height: AppBar().preferredSize.height * 0.8,
                decoration: BoxDecoration(
                    border: Border(top: BorderSide(color: Colors.grey, width: 0.2))
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: getSize(context, true, 15/360)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      OutlineButton(
                        borderSide: BorderSide.none,
                        highlightedBorderColor: BeysionColors.orange,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                                padding: EdgeInsets.only(right: 5),
                                child: Icon(Icons.filter_list_outlined, size: 25,)
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 8.0),
                              child: Text("Filter", style: TextStyle(color: Colors.grey.shade900, fontSize: 20),),
                            )
                          ],
                        ),
                        onPressed: () {
                          //Navigator.pushNamed(context, "/productListPage");
                          buildShowDialog(context, brandListData);
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Container(
        color: Colors.white,
        width: getSize(context, true, 1),
        child: campaignMarketDataList.length>0? GridView.builder(
          shrinkWrap: true,
          physics: ClampingScrollPhysics(),
          itemCount: campaignMarketDataList.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.56
          ),
          itemBuilder: (context, index) {
            CampaignMarketEntity productDataEntity = campaignMarketDataList[index];
            return CampaignWidgetView0(productDataEntity, index);
          },
        ): Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Wird geladen", style: TextStyle(fontSize: 22),),
            ),
          ],
        ),
      ),
    );
  }

  void showMarktSuchenFullScreenDialog(
      BuildContext context, TextEditingController testController) {
    testController.clear();
    bool loadingData = false;
    List<CampaignMarketEntity> campaignMarketSearchDataList = new List();
    showGeneralDialog(
      context: context,
      barrierColor: Colors.black12.withOpacity(0.6), // background color
      barrierLabel: "Dialog", // label for barrier
      transitionDuration: Duration(milliseconds: 400), // how long it takes to popup dialog after button click
      pageBuilder: (_, __, ___) {
        // your widget implementation
        return StatefulBuilder(
          builder: (context, setStateC) {
            return SizedBox.expand(
              // makes widget fullscreen
              child: Scaffold(
                resizeToAvoidBottomInset: false,
                body: Container(
                  margin: EdgeInsets.only(top: 20),
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
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.grey.shade300,
                                            blurRadius: 3,
                                            spreadRadius: 2)
                                      ]),
                                  child: loadingData == false
                                      ? Container(
                                    margin: EdgeInsets.only(top: 50),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Padding(
                                            padding:
                                            const EdgeInsets.all(8.0),
                                            child: Text("Anruf..."),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                      : getData == false
                                      ? Container(
                                      margin: EdgeInsets.only(top: 50),
                                      child: Center(
                                          child:
                                          CircularProgressIndicator()))
                                      : ListView.builder(
                                      shrinkWrap: true,
                                      padding: EdgeInsets.only(
                                        top: getSize(
                                            context, true, 50 / 415),
                                        left: getSize(
                                            context, true, 5 / 415),
                                        right: getSize(
                                            context, true, 5 / 415),
                                      ),
                                      physics:
                                      AlwaysScrollableScrollPhysics(),
                                      itemCount:
                                      campaignMarketSearchDataList.length,
                                      itemBuilder: (context, index) {
                                        CampaignMarketEntity marketDataEntity = campaignMarketSearchDataList[index];
                                        return InkWell(
                                          onTap: (){
                                           Navigator.push(context, MaterialPageRoute(builder: (context) => MarketProductDiscountTabletPage(marketDataEntity),));
                                          },
                                          child: Container(
                                            padding: EdgeInsets.all(
                                                getSize(context, true,
                                                    20 / 360)),
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                boxShadow: [
                                                  BoxShadow(
                                                      color: Colors.grey)
                                                ]),
                                            margin: EdgeInsets.only(
                                                bottom: getSize(context,
                                                    true, 15 / 360)),
                                            child: Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment
                                                  .start,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .start,
                                                  children: [
                                                    Text(
                                                      "${marketDataEntity.name}",
                                                      style: TextStyle(
                                                          fontSize: 18,
                                                          fontWeight:
                                                          FontWeight
                                                              .w500),
                                                    ),
                                                    Container(
                                                      width: getSize(
                                                          context,
                                                          true,
                                                          15 / 360),
                                                      height: getSize(
                                                          context,
                                                          true,
                                                          15 / 360),
                                                      margin:
                                                      EdgeInsets.only(
                                                          left: 10),
                                                      decoration: BoxDecoration(
                                                          color:
                                                          BeysionColors
                                                              .orange,
                                                          borderRadius:
                                                          BorderRadius
                                                              .circular(
                                                              5)),
                                                      child: Center(
                                                          child: Text(
                                                            "${marketDataEntity.avgScore}",
                                                            style: TextStyle(
                                                                color:
                                                                BeysionColors
                                                                    .purple,
                                                                fontWeight:
                                                                FontWeight
                                                                    .w700),
                                                          )),
                                                    )
                                                  ],
                                                ),
                                                Padding(
                                                  padding:
                                                  EdgeInsets.only(
                                                      top: 8.0),
                                                  child: Text(
                                                    "${marketDataEntity.fulladdress}",
                                                    style: TextStyle(
                                                        color: Colors.grey
                                                            .shade700),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                  EdgeInsets.only(
                                                      top: 8),
                                                  child: ClipRRect(
                                                    borderRadius:
                                                    BorderRadius
                                                        .circular(10),
                                                    child: Image.network(
                                                      "${marketDataEntity.logo}",
                                                      width: getSize(
                                                          context,
                                                          true,
                                                          320 / 380),
                                                      height: getSize(
                                                          context,
                                                          true,
                                                          110 / 380),
                                                      fit:
                                                      BoxFit.fitWidth,
                                                      alignment: Alignment
                                                          .topCenter,
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                  EdgeInsets.only(
                                                      top: getSize(
                                                          context,
                                                          true,
                                                          15 / 360)),
                                                  child: Row(
                                                    children: [
                                                      Expanded(
                                                          child: Text(
                                                            "Mindestpaketmenge",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .grey
                                                                    .shade500),
                                                          )),
                                                      Expanded(
                                                          child: Text(
                                                            "Arbeitszeit (heute)",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .grey
                                                                    .shade500),
                                                          )),
                                                    ],
                                                  ),
                                                ),
                                                Row(
                                                  children: [
                                                    Expanded(
                                                        child: Text(
                                                          "${marketDataEntity.minimumSellPrice}",
                                                          style: TextStyle(
                                                              fontSize: 16),
                                                        )),
                                                    Expanded(
                                                        child: Text(
                                                          "${marketDataEntity.workingTimeNow}",
                                                          style: TextStyle(
                                                              fontSize: 16),
                                                        )),
                                                  ],
                                                ),
                                                Padding(
                                                  padding:
                                                  EdgeInsets.only(
                                                      top: getSize(
                                                          context,
                                                          true,
                                                          15 / 360)),
                                                  child: Row(
                                                    children: [
                                                      Expanded(
                                                          child: Text(
                                                            "Vorbereitungszeit",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .grey
                                                                    .shade500),
                                                          )),
                                                      Expanded(
                                                          child: Text(
                                                            "Service Wählen",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .grey
                                                                    .shade500),
                                                          )),
                                                    ],
                                                  ),
                                                ),
                                                Row(
                                                  children: [
                                                    Expanded(
                                                        child: Text(
                                                          "${marketDataEntity.preparingTime}",
                                                          style: TextStyle(
                                                              fontSize: 16),
                                                        )),
                                                    Expanded(
                                                        child: Text(
                                                          "${marketDataEntity.deliveryType}",
                                                          style: TextStyle(
                                                              fontSize: 16),
                                                        )),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      }),
                                ),
                                Container(
                                  height: getSize(context, true, 50 / 415),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(5),
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.grey.shade200,
                                            blurRadius: 3,
                                            spreadRadius: 2)
                                      ]),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        flex: 8,
                                        child: TextField(
                                          controller: testController,
                                          autofocus: true,
                                          decoration: InputDecoration(
                                              border: InputBorder.none,
                                              hintText: "Märkte Suchen",
                                              hintStyle: TextStyle(
                                                  color: Colors.grey.shade300),
                                              contentPadding:
                                              EdgeInsets.only(left: 20)),
                                          onChanged: (value) async {
                                            if (value.length > 2) {
                                              setStateC(() {
                                                loadingData = true;
                                                getData = false;
                                              });
                                              campaignMarketSearchDataList.clear();
                                              campaignMarketSearchDataList = await getCampainMarketAllListSearch(search: value);
                                              setStateC(() {});
                                            } else {
                                              setStateC(() {
                                                loadingData = false;
                                                getData = false;
                                                campaignMarketSearchDataList.clear();
                                              });
                                            }
                                          },
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: IconButton(
                                          icon: FaIcon(
                                            FontAwesomeIcons.times,
                                            color: Colors.grey.shade400,
                                          ),
                                          onPressed: () {
                                            testController.clear();
                                            Navigator.pop(context);
                                          },
                                        ),
                                      )
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
            );
          },
        );
      },
    );
  }


  //TODO DÜZELECEKKKKKKKKKKKKKKK @@@@@@@@@@@@@@@@@@@@@@@@@@
  Future<List<CampaignMarketEntity>> getCampainMarketAllListSearch({int categoryId = 0, int pageNumber=0, int orderId = 0, String search =""}) async {
    List<CampaignMarketEntity> returnDataList = new List();
    SharedPreferences sharedPref = await SharedPreferences.getInstance();
    int abholService = 1;
    int lieferService = 1;
    String plzZipCode = settingRepo.zipCodeSelectedEntity.value.id.toString();
    if(sharedPref.containsKey("abholService")){
      abholService = sharedPref.getInt("abholService");
    }
    if(sharedPref.containsKey("lieferService")){
      lieferService = sharedPref.getInt("lieferService");
    }

    String sessionToken = sharedPref.getString("sessionToken");
    settingRepo.sessionToken.value = sessionToken;
    print('SESSİON TOKENIM NEDİR ProductAll Else- $sessionToken');
    BaseResponse response = await MarketsService.operations().campaignMarketsAll(plzZipCode,search,lieferService,abholService,sessionToken,page: pageNumber,order: orderId);
    try{
      getData = false;
      if (response is OkResponse) {
        if (response.body != null) {
          if (response.body["data"] != null) {
            List<dynamic> dataList = response.body["data"];
            List<CampaignMarketEntity> newDataList = new List();
            for (var dataStr in dataList) {
              CampaignMarketEntity model = new CampaignMarketEntity.fromJson(dataStr);
              if (model != null) {
                newDataList.add(model);
                //print('Product All List Data -- ${model.name}');
              }
            }
            getData = true;
            returnDataList.addAll(newDataList);
            return returnDataList;

          } return returnDataList;
        } return returnDataList;
      }
    }catch(e){
      print('Exception HOMMe Product All List -  $e');
    }
  }

  buildShowDialog(BuildContext context, List<MarketBrandEntity> brandsList) {
    return showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setStateC) {
            return Dialog(
              child: Container(
                height: MediaQuery.of(context).size.width * 1,
                width: MediaQuery.of(context).size.width * 0.7,
                padding: EdgeInsets.symmetric(
                    horizontal: getSize(context, true, 10/415),
                    vertical: getSize(context, true, 15/415)
                ),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(10))
                ),
                child: Column(
                  children: [
                    Expanded(
                      child: ListView(
                        children: [
                          Text("Marken", style: TextStyle(color: BeysionColors.gray2, fontSize: 14,),),
                          SizedBox(height: getSize(context, true, 10/415),),
                          Container(
                            height: getSize(context, true, 35 / 415),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(Radius.circular(5)),
                              border: Border.all(
                                  color: BeysionColors.border, width: 1),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  child: TextFormField(
                                    textAlignVertical: TextAlignVertical.center,
                                    controller: _searchTextFormField,
                                    decoration: InputDecoration(
                                        contentPadding: EdgeInsets.symmetric(
                                            horizontal:
                                            getSize(context, true, 10 / 415)),
                                        border: InputBorder.none,
                                        suffixIcon: SizedBox(),
                                        suffix: SizedBox(),
                                        isCollapsed: true,
                                        suffixIconConstraints:
                                        BoxConstraints.tightFor(),
                                        hintText: "Marke suchen",
                                        hintStyle: TextStyle(
                                          color: BeysionColors.gray2,
                                          fontSize: 15,
                                        )),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      right: getSize(context, true, 10 / 415)),
                                  child: Image.asset(IconsPath.search),
                                )
                              ],
                            ),
                          ),
                          Container(
                              height: getSize(context, true, 250/415),
                              width: MediaQuery.of(context).size.width * 0.7,
                              margin: EdgeInsets.only(
                                  top: getSize(context, true, 10/415)
                              ),
                              child: ListView(
                                shrinkWrap: true,
                                children: brandsList.map((brandData) => DialogMarktItemCard("${brandData.name}")).toList(),
                              )
                          ),
                        ],
                      ),
                    ),
                    InkWell(
                      child: Center(
                        child: Container(
                          decoration: BoxDecoration(
                              color: BeysionColors.orange,
                              borderRadius:
                              BorderRadius.all(Radius.circular(5))),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "ANWENDEN",
                              style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      onTap: () {
                        //Provider.of<ProductAllProvider>(context, listen: false).getProductAllList(pageNumber: 1);
                        Navigator.pop(context);

                        //Provider.of<ProductDiscountProvider>(context, listen: false).getProductDiscountController(pageNumber: 0, marketId: selectedMarket.id, categoryId: selectedCategoryEntity.id, pageUserStatus: 1);
                      },
                    )
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }


}


class CampaignWidgetView0 extends StatefulWidget {
  CampaignMarketEntity campaignMarketDataEntity;
  int index;
  CampaignWidgetView0(this.campaignMarketDataEntity, this.index);

  @override
  _CampaignWidgetView0State createState() => _CampaignWidgetView0State();
}

class _CampaignWidgetView0State extends State<CampaignWidgetView0> {
  int productQuantity = 1;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      // TODO: control !!
      onTap: (){
       // Navigator.push(context, CupertinoPageRoute(builder: (context) => ProductDetailTabletPage(widget.campaignMarketEntity, marketId: widget.marketDataEntity.id,),))
      },
      child: Container(
        width: getSize(context, true, 1),
        padding: EdgeInsets.symmetric(
          vertical: 0,
        ),
        decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(color: Colors.grey.shade300),
              right: BorderSide(color: widget.index %2 == 0 ? Colors.grey.shade300 : Colors.transparent),
            )
        ),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        right: getSize(context, true, 20/360),
                        left: getSize(context, true, 20/360),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("${widget.campaignMarketDataEntity.name}", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),),
                              Container(
                                width: getSize(context, true, 20/360),
                                height: getSize(context, true, 15/360),
                                margin: EdgeInsets.only(left: 10),
                                decoration: BoxDecoration(
                                    color: BeysionColors.orange,
                                    borderRadius: BorderRadius.circular(5)
                                ),
                                child: Center(child: Text("${widget.campaignMarketDataEntity.avgScore}", style: TextStyle(color: BeysionColors.purple, fontSize: 17,fontWeight: FontWeight.w700),)),
                              )
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 4.0),
                            child: Text("${widget.campaignMarketDataEntity.fulladdress}", textAlign: TextAlign.center, maxLines: 2, style: TextStyle(color: Colors.grey.shade700, fontSize: 15),),
                          )
                        ],
                      ),
                    ),
                    Container(
                      height: getSize(context, true, 225/360),
                      child: CustomCarousel(
                        images: widget.campaignMarketDataEntity.products.map((productEntity) =>InkWell(
                          onTap: (){
                            ProductEntity oldProductEntityData = new ProductEntity();
                            oldProductEntityData.id =productEntity.id;
                            oldProductEntityData.name = productEntity.name;
                            oldProductEntityData.image = productEntity.image;
                            oldProductEntityData.price = productEntity.price;
                            if(productEntity.discountPrice!=null){
                              oldProductEntityData.discountPrice = productEntity.discountPrice;
                            }
                            oldProductEntityData.favStatus = 0;
                            oldProductEntityData.mid = widget.campaignMarketDataEntity.id;
                            oldProductEntityData.marketname = widget.campaignMarketDataEntity.name;
                            oldProductEntityData.selected = false;
                            Navigator.push(context, MaterialPageRoute(builder: (context) => ProductDetailTabletPage(oldProductEntityData),));
                          },
                          child: Column(
                            children: [
                              Container(
                                padding: EdgeInsets.all(getSize(context, true, 10/360)),
                                child: Image.network(productEntity.image,
                                    width: getSize(context, true, 140/360),
                                    height: getSize(context, true, 140/360),
                                    fit: BoxFit.fitHeight
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 50,right: 50),
                                child: Text("${productEntity.name.toString()}",
                                  textAlign: TextAlign.center,
                                  maxLines: 2,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                    fontSize: 20
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  vertical: 2,
                                ),
                                child: productEntity.discountPrice == null
                                    ? Text("${productEntity.price.toString().replaceAll(".", ",")} €", style: TextStyle(color: Colors.black, fontSize: 20),)
                                    : Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: getSize(context, true, 30/360),
                                      height: getSize(context, true, 22/360),
                                      decoration: BoxDecoration(
                                          color: BeysionColors.red,
                                          borderRadius: BorderRadius.circular(5)
                                      ),
                                      child: Center(child: Text("${fiyatYuzdeHesaplamaCampaign(productEntity)}", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),)),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 5.0),
                                      child: Column(
                                        children: [
                                          Text("${productEntity.price.toString().replaceAll(".", ",")} €", style: TextStyle(fontSize: 17,decoration: TextDecoration.lineThrough, color: Colors.grey.shade500),),
                                          Text("${productEntity.discountPrice.toString().replaceAll(".", ",")} €", style: TextStyle(color: Colors.black, fontSize: 22),),
                                        ],
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )).toList(),
                        dotSize: 3,
                        autoplay: false,
                        indicatorBgPadding: 4,
                        dotBgColor: Colors.transparent,
                        dotColor: Colors.grey.shade500,
                        dotIncreasedColor: Colors.grey.shade700,
                      ),
                    ),
                    SizedBox(height: 8,),
                    InkWell(
                      child: Container(
                        height: getSize(context, true, 25 / 415),
                        width: getSize(context, true, 140 / 415),
                        decoration: BoxDecoration(
                            color: BeysionColors.orange,
                            borderRadius:
                            BorderRadius.all(Radius.circular(5))),
                        child:Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Kampagnenprodukte anzeigen",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => MarketProductDiscountTabletPage(widget.campaignMarketDataEntity),));
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DialogMarktItemCard extends StatefulWidget {
  String title;
  DialogMarktItemCard(this.title);
  @override
  _DialogMarktItemCardState createState() => _DialogMarktItemCardState();
}

class _DialogMarktItemCardState extends State<DialogMarktItemCard> {
  bool check = false;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          value: check,
          onChanged: (value) {
            setState(() {
              check = value;
            });
          },
        ),
        SizedBox(
          width: getSize(context, true, 5 / 415),
        ),
        Expanded(
            child: Text(
              widget.title,
              style:
              GoogleFonts.overpass(fontSize: 14, fontWeight: FontWeight.w600),
            ))
      ],
    );
  }
}