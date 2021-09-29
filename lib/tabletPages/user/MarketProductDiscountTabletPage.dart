import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:beysion/Utility/Colors.dart';
import 'package:beysion/Utility/Icons.dart';
import 'package:beysion/Utility/util.dart';
import 'package:beysion/constant/ScanBarcodePage.dart';
import 'package:beysion/constant/app_configurations.dart';
import 'package:beysion/rest/controller/user/market_campaign_products_provider.dart';
import 'package:beysion/rest/entity/user/campaign_market_entity.dart';
import 'package:beysion/rest/entity/user/product_entity.dart';
import 'package:beysion/rest/service/market/market_product_service.dart';
import 'package:beysion/rest/service/user_service.dart';
import 'package:beysion/tabletPages/user/UserLoginTabletPage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../rest/controller/user/basket_provider.dart';
import 'package:beysion/rest/controller/user/market_brand_provider.dart';
import 'package:beysion/rest/controller/user/market_list_provider.dart';
import 'package:beysion/rest/controller/user/product_all_provider.dart';
import 'package:beysion/rest/entity/user/market/market_brand_entity.dart';
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
import 'ProductDetailTabletPage.dart';

class MarketProductDiscountTabletPage extends StatefulWidget {
  CampaignMarketEntity campaignMarketEntity;
  MarketProductDiscountTabletPage(this.campaignMarketEntity);
  @override
  _MarketProductDiscountTabletPageState createState() => _MarketProductDiscountTabletPageState();
}

class _MarketProductDiscountTabletPageState extends State<MarketProductDiscountTabletPage> with SingleTickerProviderStateMixin {
  ScrollController _scrollControllerBody = ScrollController(initialScrollOffset: 0.0, keepScrollOffset: true);
  TextEditingController _searchTextFormField = new TextEditingController();

  int viewStyle = 0;
  bool getData = false;
  TextEditingController produktSuchenDialogController = new TextEditingController();
  int page=0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Provider.of<MarketCampaignProductsProvider>(context, listen: false).getMarketCampaignProductListController(widget.campaignMarketEntity.id,pageNumber: page);
    _scrollControllerBody.addListener(() {
      if (_scrollControllerBody.position.pixels == _scrollControllerBody.position.maxScrollExtent) {
        page++;
        Provider.of<MarketCampaignProductsProvider>(context, listen: false).getMarketCampaignProductListController(widget.campaignMarketEntity.id,pageNumber: page);
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _scrollControllerBody.dispose();
    produktSuchenDialogController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<ProductEntity> productDiscountAllList = Provider.of<MarketCampaignProductsProvider>(context, listen: true).marketCampaignsProductList;
    List<MarketBrandEntity> brandListData = Provider.of<MarketBrandProvider>(context, listen:true).allMarketBrandsList;
    List<MarketListEntity> marketListData = Provider.of<MarketListProvider>(context, listen: true).marketDataList;
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
        toolbarHeight: AppBar().preferredSize.height* 2.75,
        actions: [
          IconButton(
            icon: FaIcon(FontAwesomeIcons.search,
              color: Colors.black,),
            onPressed: () {
              showProduktSuchenFullScreenDialog(context, produktSuchenDialogController);
            },
          )
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(AppBar().preferredSize.height * 1.75),
          child: Column(
            children: [
              Container(
                height: AppBar().preferredSize.height * 0.75,
                decoration: BoxDecoration(
                    border: Border(top: BorderSide(color: Colors.grey, width: 0.2))
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: getSize(context, true, 15/360)),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          IconButton(
                            icon: FaIcon(viewStyle == 0 ? FontAwesomeIcons.th :
                            viewStyle == 1 ? FontAwesomeIcons.solidSquare :
                            viewStyle == 2 ? FontAwesomeIcons.thList : SizedBox()),
                            onPressed: () {
                              setState(() {
                                if(viewStyle == 2){
                                  viewStyle = 0;
                                }
                                else viewStyle ++;
                              });
                            },),
                          DropdownButton(
                            items: [
                              DropdownMenuItem(
                                value: 0,
                                child: Text("Gridlist"),
                              ),
                              DropdownMenuItem(
                                value: 1,
                                child: Text("Single"),
                              ),
                              DropdownMenuItem(
                                value: 2,
                                child: Text("Standartliste"),
                              ),
                            ],
                            hint: Text("${viewStyle == 0 ? "Gridlist" : viewStyle == 1 ? "Single" : "Standartliste"}", style: TextStyle(color: Colors.black, fontSize: 20),),
                            underline: SizedBox(),
                            icon: Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: FaIcon(FontAwesomeIcons.chevronDown, size: getSize(context, true, 10/360),),
                            ),
                            onChanged: (value) {
                              setState(() {
                                viewStyle = value;
                              });
                              print(viewStyle.toString());
                            },
                          )
                        ],
                      ),
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
                          buildShowDialog(context, marketListData,brandListData);
                        },
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                height: AppBar().preferredSize.height,
                decoration: BoxDecoration(
                    color: BeysionColors.textFieldBackground,
                    border: Border(top: BorderSide(color: Colors.grey, width: 0.2))
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: getSize(context, true, 15/360)),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Text("${widget.campaignMarketEntity.name}", style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal),),
                          Container(
                            width: getSize(context, true, 15/360),
                            height: getSize(context, true, 15/360),
                            margin: EdgeInsets.only(left: 10),
                            decoration: BoxDecoration(
                                color: BeysionColors.orange,
                                borderRadius: BorderRadius.circular(5)
                            ),
                            child: Center(child: Text("${widget.campaignMarketEntity.avgScore}", style: TextStyle(color: BeysionColors.purple, fontWeight: FontWeight.w700),)),
                          )
                        ],
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
        child: ListView(
          controller: _scrollControllerBody,
          shrinkWrap: true,
          children: [
            if (viewStyle == 0) GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: productDiscountAllList.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 0.54
              ),
              itemBuilder: (context, index) {
                ProductEntity productDataEntity = productDiscountAllList[index];
                return ProductWidgetView0(productDataEntity, index, widget.campaignMarketEntity);
              },
            ) else SizedBox(),
            if (viewStyle == 1) GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: productDiscountAllList.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                  childAspectRatio: 1.8
              ),
              itemBuilder: (context, index) {
                ProductEntity productDataEntity = productDiscountAllList[index];
                return ProductWidgetView1(productDataEntity, index, widget.campaignMarketEntity);
              },
            ) else SizedBox(),
            if (viewStyle == 2) ListView.separated(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              separatorBuilder: (context, index) => Divider(color: Colors.grey.shade300, thickness: 1, height: 3,),
              itemCount: productDiscountAllList.length,
              itemBuilder: (context, index) {
                ProductEntity productDataEntity = productDiscountAllList[index];
                return ProductWidgetView2(productDataEntity, index, widget.campaignMarketEntity);
              },
            ) else SizedBox(),
          ],
        ),
      ),
    );
  }

  void showProduktSuchenFullScreenDialog(BuildContext context, TextEditingController testController) {
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
                                                      onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) => ProductDetailTabletPage(productEntity,marketId: widget.campaignMarketEntity.id,)));},
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
                                                                child: CachedNetworkImage(
                                                                  imageUrl:  productEntity.image,
                                                                  imageBuilder: (context, imageProvider) =>  Image.network(
                                                                    productEntity.image,
                                                                    fit: BoxFit.fitHeight,
                                                                    height: 75,width: 75,
                                                                  ),
                                                                  errorWidget: (context, url, error) => Icon(Icons.error),
                                                                  placeholder: (context, url) => SizedBox(
                                                                      height: 75,width: 75,
                                                                      child: Center(child: Padding(
                                                                        padding: const EdgeInsets.all(8.0),
                                                                        child: CircularProgressIndicator(),
                                                                      ))),
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
                                                                    style: GoogleFonts.overpass(color: Colors.black, fontWeight: FontWeight.w300, fontSize: 18,),
                                                                    maxLines: 2,
                                                                    textAlign: TextAlign.start,
                                                                  ),
                                                                  Row(
                                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                                    children: [
                                                                      SmoothStarRating(
                                                                        starCount: 5,
                                                                        size: getSize(context, true, 10 / 415),
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
                                                                          size: getSize(context, true, 8 / 415),
                                                                        ),
                                                                      ),
                                                                      Expanded(
                                                                        child: Text("${widget.campaignMarketEntity.name}",
                                                                          overflow: TextOverflow.fade,
                                                                          softWrap: false,
                                                                          maxLines: 1,
                                                                          style: GoogleFonts.overpass(
                                                                              fontSize: 15,
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
                                                                            width: getSize(context, true, 25 / 415),
                                                                            height: getSize(context, true, 20 / 415),
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
                                                                                    fontSize: 16,
                                                                                    fontWeight: FontWeight.w400),
                                                                                textAlign: TextAlign.center,
                                                                              ),
                                                                              Text(
                                                                                "${productEntity.discountPrice.toString().replaceAll(".", ",")} €",
                                                                                style: GoogleFonts.overpass(
                                                                                    color: Colors.black,
                                                                                    fontSize: 18,
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
                                                                        fontSize: 18,
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
          ); },
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
    BaseResponse response = await MarketProductService.operations().marketCampaignProducts(widget.campaignMarketEntity.id,search,sessionToken,page: pageNumber,order: orderId);
    try{
      print('SSSSSSSSSSSS --- $search');
      getData = false;
      if (response is OkResponse) {
        if (response.body != null) {
          if (response.body["data"] != null) {
            List<dynamic> dataList = response.body["data"];
            List<ProductEntity> newDataList = new List();
            for (var dataStr in dataList) {
              ProductEntity model = new ProductEntity.fromJson(dataStr);
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

  buildShowDialog(BuildContext context, List<MarketListEntity> marketList, List<MarketBrandEntity> brandsList) {
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
                        Provider.of<ProductAllProvider>(context, listen: false).getProductAllList(pageNumber: 1);
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


class ProductWidgetView0 extends StatefulWidget {
  ProductEntity productDataEntity;
  int index;
  CampaignMarketEntity marketDataEntity;
  ProductWidgetView0(this.productDataEntity, this.index, this.marketDataEntity);

  @override
  _ProductWidgetView0State createState() => _ProductWidgetView0State();
}

class _ProductWidgetView0State extends State<ProductWidgetView0> {
  int productQuantity = 1;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      // TODO: control !!
      onTap: () => Navigator.push(context, CupertinoPageRoute(builder: (context) => ProductDetailTabletPage(widget.productDataEntity, marketId: widget.marketDataEntity.id,),)),
      child: Container(
        width: getSize(context, true, 1),
        padding: EdgeInsets.symmetric(
          vertical: 0,
        ),
        decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(color: Colors.grey.shade300),
              right: BorderSide(color: widget.index %3 == 0 || widget.index % 3 == 1 ? Colors.grey.shade300 : Colors.transparent),
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
                    Stack(
                      children:[
                        Image.network(widget.productDataEntity.image),
                        Positioned(
                          right: -20.0,
                          top: 0.0,
                          child: RawMaterialButton(
                            onPressed: () async {
                              if(settingRepo.currentUserTokenEntity.value.token!=null){
                                UserService userService = new UserService();
                                if(widget.productDataEntity.favStatus == 0){
                                  BaseResponse responseData = await userService.userFavoriteAdd(widget.productDataEntity.id);
                                  if (responseData.body != null) {
                                    print('EKLENDİİİİ ${responseData.body}');
                                    if(responseData is OkResponse){
                                      setState((){
                                        widget.productDataEntity.favStatus = 1;
                                      });
                                    }else{
                                      toastWidget("Das Produkt konnte nicht zu den Favoriten hinzugefügt werden!", Colors.red);
                                    }
                                  }else{
                                    toastWidget("Das Produkt konnte nicht zu den Favoriten hinzugefügt werden!", Colors.red);
                                  }
                                }else{
                                  BaseResponse responseData = await userService.userFavoriteDelete(widget.productDataEntity.id);
                                  if (responseData.body != null) {
                                    if(responseData is OkResponse){
                                      setState((){
                                        widget.productDataEntity.favStatus = 0;
                                      });
                                    }else{
                                      toastWidget("Das Produkt konnte nicht aus den Favoriten entfernt werden!", Colors.red);
                                    }
                                  }else{
                                    toastWidget("Das Produkt konnte nicht aus den Favoriten entfernt werden!", Colors.red);
                                  }
                                }
                              }else{
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => UserLoginTabletPage()));
                              }
                            },

                            fillColor: Colors.white,
                            shape: CircleBorder(),
                            elevation: 8.0,
                            child: Padding(
                              padding: EdgeInsets.all(5),
                              child: widget.productDataEntity.favStatus == 0 ? Icon(
                                Icons.favorite_border,
                                color: Colors.black,
                                size: 25,
                              ): Icon(
                                Icons.favorite,
                                color: BeysionColors.yellow,
                                size: 25,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 3.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SmoothStarRating(
                            starCount: 5,
                            size: getSize(context, true, 10 / 360),
                            rating: 0,
                            isReadOnly: false,
                            allowHalfRating: false,
                            borderColor: BeysionColors.yellow,
                            color: BeysionColors.yellow,
                            onRated: (rating) {},
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text("(3)", style: TextStyle(color: Colors.grey, fontSize: 10),),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("${widget.productDataEntity.name}",
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              softWrap: true,
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                fontSize: 16
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: 8,
                            ),
                            child: widget.productDataEntity.discountPrice == null
                                ? Text("${widget.productDataEntity.price.toString().replaceAll(".", ",")} €", style: TextStyle(color: Colors.black, fontSize: 20),)
                                : Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: getSize(context, true, 25/360),
                                  height: getSize(context, true, 15/360),
                                  decoration: BoxDecoration(
                                      color: BeysionColors.red,
                                      borderRadius: BorderRadius.circular(5)
                                  ),
                                  child: Center(child: Text("${fiyatYuzdeHesaplama(widget.productDataEntity)}", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500),)),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 5.0),
                                  child: Column(
                                    children: [
                                      Text("${widget.productDataEntity.price.toString().replaceAll(".", ",")} €", style: TextStyle(decoration: TextDecoration.lineThrough, color: Colors.grey.shade500),),
                                      Text("${widget.productDataEntity.discountPrice.toString().replaceAll(".", ",")} €", style: TextStyle(color: Colors.black, fontSize: 20),),
                                    ],
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                  ),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5.0),
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  FaIcon(FontAwesomeIcons.store, color: BeysionColors.purple, size: getSize(context, true, 8/360),),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 3.0),
                                    child: Text(widget.marketDataEntity.name, style: TextStyle(color: BeysionColors.purple, fontWeight: FontWeight.w500, fontSize: 12),),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          InkWell(
                            //TOP 8
                            child: Container(
                              height: getSize(context, true, 20 / 415),
                              width: getSize(context, true, 75 / 415),
                              margin: EdgeInsets.only(top: 10),
                              decoration: BoxDecoration(
                                  color: BeysionColors.orange,
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(5))),
                              child: widget.productDataEntity.selected == false ? Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  FaIcon(
                                    FontAwesomeIcons.shoppingBasket,
                                    color: Colors.black,
                                    size: getSize(context, true, 10 / 415),
                                  ),
                                  SizedBox(
                                    width: getSize(context, true, 5 / 415),
                                  ),
                                  Text(
                                    "In den Warenkorb",
                                    style: TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.black),
                                  ),
                                ],
                              ): Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  InkWell(
                                    child: productQuantity != 1 ? Container(
                                      width: getSize(context, true, 15 / 415),
                                      height: getSize(context, true, 15 / 415),
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle, color: Colors.white),
                                      child: Center(child: Text("-",style: TextStyle(fontSize: 18),)),
                                    ):Container(
                                      width: getSize(context, true, 22 / 415),
                                      height: getSize(context, true, 22 / 415),
                                      child: Center(child: Icon(Icons.delete, color: Colors.white, size: 22,)),
                                    ),
                                    onTap: () async {
                                      if(productQuantity == 1){
                                        BaseResponse basketService = await BasketService.operations().deleteBasketProduct(widget.productDataEntity.id);
                                        if(basketService is OkResponse){
                                          toastWidget("Das Produkt wurde aus dem Warenkorb gelöscht", Colors.red);
                                          Provider.of<BasketProvider>(context, listen: false).getBasketDetailDataController();
                                          setState(() {
                                            widget.productDataEntity.selected = false;
                                          });
                                        }
                                      }else{
                                        BasketService basketService = new BasketService();
                                        int addQuant = productQuantity-1;
                                        BaseResponse responseData = await basketService.basketUpdate(widget.productDataEntity.id, addQuant);
                                        if (responseData.body != null) {
                                          if(responseData is OkResponse){
                                            Provider.of<BasketProvider>(context, listen: false).getBasketDetailDataController();
                                            setState((){
                                              if(productQuantity > 1){
                                                productQuantity--;
                                              }
                                            });
                                          }
                                        }

                                      }

                                    },
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    width: getSize(context, true, 22 / 415),
                                    height: getSize(context, true, 22 / 415),
                                    child: Text(productQuantity.toString(), style: TextStyle(fontWeight:  FontWeight.w700),),
                                  ),
                                  InkWell(
                                    child: Container(
                                      width: getSize(context, true, 15 / 415),
                                      height: getSize(context, true, 15 / 415),
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.white),
                                      child: Center(child: Text("+")),
                                    ),
                                    onTap: () async {
                                      BasketService basketService = new BasketService();
                                      int addQuant = productQuantity+1;
                                      BaseResponse responseData = await basketService.basketUpdate(widget.productDataEntity.id, addQuant);
                                      if (responseData.body != null) {
                                        if(responseData is OkResponse){
                                          print('GÜNCELLEME BAŞARILIII');
                                          Provider.of<BasketProvider>(context, listen: false).getBasketDetailDataController();
                                          setState(() {
                                            productQuantity++;
                                          });
                                        }
                                      }
                                    },
                                  ),
                                ],
                              ),
                            ),
                            onTap: () async {
                              BasketService basketService = new BasketService();
                              BaseResponse responseData = await basketService.addBasket(widget.productDataEntity.id);
                              if (responseData.body != null) {
                                print('BASKER RESPONSEE ${responseData.body}');
                                if(responseData is OkResponse){
                                  if(responseData.body["errorCode"].toString().compareTo("1") == 0){
                                    showBasketAddDialogResponse(widget.productDataEntity);
                                  }else{
                                    toastWidget("Das Produkt wurde in den Warenkorb gelegt", Colors.green);
                                    Provider.of<BasketProvider>(context, listen: false).getBasketDetailDataController();
                                    setState(() {
                                      widget.productDataEntity.selected = true;
                                    });
                                  }
                                }
                              }
                              // TODO: inkwell onTap
                            },
                          )                  ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showBasketAddDialogResponse(ProductEntity productDataEntity) async {
    //BASKET ADD YAPTIĞIMIZDA BAŞKA MARKET VARSA ERROR CODE 1 DÖNECEK
    // VE BU UYARIYI GÖSTERECEĞİZ.
    // EĞER KABUL EDERSE AYNI DEĞERLERE EK "accept=1" ekleyip göndereceğiz.
    AwesomeDialog(
      context: context,
      dialogType: DialogType.INFO,
      animType: AnimType.BOTTOMSLIDE,
      dismissOnBackKeyPress: false,
      dismissOnTouchOutside: false,
      title: 'Korbwechselbestätigung',
      desc: 'Ihr Warenkorb enthält Produkte aus anderen Märkten. Möchten Sie Ihren Warenkorb leeren, um das Produkt dieses Marktes in Ihren Warenkorb zu legen?',
      btnCancelText: "CANCEL",
      btnCancelOnPress: () {
      },
      btnOkText: "JA",
      btnOkOnPress: () async {
        BasketService basketService = new BasketService();
        BaseResponse responseData = await basketService.addBasket(widget.productDataEntity.id, acceptId: 1);
        if (responseData.body != null) {
          print('BASKER RESPONSEE ${responseData.body}');
          if(responseData is OkResponse){
            toastWidget("Das Produkt wurde in den Warenkorb gelegt", Colors.green);
            Provider.of<BasketProvider>(context, listen: false).getBasketDetailDataController();
            setState(() {
              widget.productDataEntity.selected = true;
            });
          }
        }
      },
    )..show();
  }

}

class ProductWidgetView1 extends StatefulWidget {
  ProductEntity productDataEntity;
  int index;
  CampaignMarketEntity marketDataEntity;
  ProductWidgetView1(this.productDataEntity, this.index, this.marketDataEntity);

  @override
  _ProductWidgetView1State createState() => _ProductWidgetView1State();
}

class _ProductWidgetView1State extends State<ProductWidgetView1> {
  int productQuantity = 1;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.push(context, CupertinoPageRoute(builder: (context) => ProductDetailTabletPage(widget.productDataEntity, marketId: widget.marketDataEntity.id,),)),
      child: Container(
        padding: EdgeInsets.only(
          right: getSize(context, true, 10/360),
          left: getSize(context, true, 10/360),
          bottom: getSize(context, true, 0/360),
        ),
        decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(color: Colors.grey.shade300),
              right: BorderSide(color: widget.index % 3 == 0 ? Colors.grey.shade300 :  widget.index % 3 == 1 ? Colors.grey.shade300 : Colors.transparent),
            )
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                width: getSize(context, true, 100/360),
                height: getSize(context, true, 100/360),
                child: Stack(
                  children: [
                    Center(
                      child: Image.network(widget.productDataEntity.image,
                          width: getSize(context, true, 90/360),
                          height: getSize(context, true, 90/360),
                          fit: BoxFit.fitHeight
                      ),
                    ),
                    Positioned(
                      right: -20.0,
                      top: 0.0,
                      child: RawMaterialButton(
                        onPressed: () async {
                          if(settingRepo.currentUserTokenEntity.value.token!=null){
                            UserService userService = new UserService();
                            if(widget.productDataEntity.favStatus == 0){
                              BaseResponse responseData = await userService.userFavoriteAdd(widget.productDataEntity.id);
                              if (responseData.body != null) {
                                print('EKLENDİİİİ ${responseData.body}');
                                if(responseData is OkResponse){
                                  setState((){
                                    widget.productDataEntity.favStatus = 1;
                                  });
                                }else{
                                  toastWidget("Das Produkt konnte nicht zu den Favoriten hinzugefügt werden!", Colors.red);
                                }
                              }else{
                                toastWidget("Das Produkt konnte nicht zu den Favoriten hinzugefügt werden!", Colors.red);
                              }
                            }else{
                              BaseResponse responseData = await userService.userFavoriteDelete(widget.productDataEntity.id);
                              if (responseData.body != null) {
                                if(responseData is OkResponse){
                                  setState((){
                                    widget.productDataEntity.favStatus = 0;
                                  });
                                }else{
                                  toastWidget("Das Produkt konnte nicht aus den Favoriten entfernt werden!", Colors.red);
                                }
                              }else{
                                toastWidget("Das Produkt konnte nicht aus den Favoriten entfernt werden!", Colors.red);
                              }
                            }
                          }else{
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => UserLoginTabletPage()));
                          }
                        },
                        fillColor: Colors.white,
                        shape: CircleBorder(),
                        elevation: 4.0,
                        child: Padding(
                          padding: EdgeInsets.all(5),
                          child: widget.productDataEntity.favStatus == 0 ? Icon(
                            Icons.favorite_border,
                            color: Colors.black,
                            size: 20,
                          ): Icon(
                            Icons.favorite,
                            color: BeysionColors.yellow,
                            size: 20,
                          ),
                        ),
                      ),
                    )                  ],
                )
            ),
            Column(
              children: [
                Text("${widget.productDataEntity.name.toString()}",
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  softWrap: true,
                  style: TextStyle(
                      fontWeight: FontWeight.w500
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SmoothStarRating(
                        starCount: 5,
                        size: getSize(context, true, 10 / 360),
                        rating: 0,
                        isReadOnly: false,
                        allowHalfRating: false,
                        borderColor: BeysionColors.yellow,
                        color: BeysionColors.yellow,
                        onRated: (rating) {},
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text("(3 Kommentar)", style: TextStyle(color: Colors.grey, fontSize: 10),),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 8,
                  ),
                  child: widget.productDataEntity.discountPrice == null
                      ? Text("${widget.productDataEntity.price.toString().replaceAll(".", ",")} €", style: TextStyle(color: Colors.black, fontSize: 20),)
                      : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: getSize(context, true, 30/360),
                        height: getSize(context, true, 15/360),
                        decoration: BoxDecoration(
                            color: BeysionColors.red,
                            borderRadius: BorderRadius.circular(5)
                        ),
                        child: Center(child: Text("${fiyatYuzdeHesaplama(widget.productDataEntity)}", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500),)),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 5.0),
                        child: Column(
                          children: [
                            Text("${widget.productDataEntity.price.toString().replaceAll(".", ",")} €", style: TextStyle(decoration: TextDecoration.lineThrough, color: Colors.grey.shade500),),
                            Text("${widget.productDataEntity.discountPrice.toString().replaceAll(".", ",")} €", style: TextStyle(color: Colors.black, fontSize: 16),),
                          ],
                          crossAxisAlignment: CrossAxisAlignment.start,
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FaIcon(FontAwesomeIcons.store, color: BeysionColors.purple, size: getSize(context, true, 8/360),),
                        Padding(
                          padding: const EdgeInsets.only(left: 3.0),
                          child: Text(widget.marketDataEntity.name, style: TextStyle(color: BeysionColors.purple, fontWeight: FontWeight.w500, fontSize: 12),),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                InkWell(
                  child: Container(
                    height: getSize(context, true, 20 / 415),
                    width: getSize(context, true, 110 / 415),
                    decoration: BoxDecoration(
                        color: BeysionColors.orange,
                        borderRadius:
                        BorderRadius.all(Radius.circular(5))),
                    child: widget.productDataEntity.selected == false ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        FaIcon(
                          FontAwesomeIcons.shoppingBasket,
                          color: Colors.black,
                          size: getSize(context, true, 10 / 415),
                        ),
                        SizedBox(
                          width: getSize(context, true, 5 / 415),
                        ),
                        Text(
                          "In den Warenkorb",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Colors.black),
                        ),
                      ],
                    ): Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InkWell(
                          child: productQuantity != 1 ? Container(
                            width: getSize(context, true, 22 / 415),
                            height: getSize(context, true, 22 / 415),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle, color: Colors.white),
                            child: Center(child: Text("-")),
                          ):Container(
                            width: getSize(context, true, 22 / 415),
                            height: getSize(context, true, 22 / 415),
                            child: Center(child: Icon(Icons.delete, color: Colors.white, size: 18,)),
                          ),
                          onTap: () async {
                            if(productQuantity == 1){
                              BaseResponse basketService = await BasketService.operations().deleteBasketProduct(widget.productDataEntity.id);
                              if(basketService is OkResponse){
                                toastWidget("Das Produkt wurde aus dem Warenkorb gelöscht", Colors.red);
                                Provider.of<BasketProvider>(context, listen: false).getBasketDetailDataController();
                                setState(() {
                                  widget.productDataEntity.selected = false;
                                });
                              }
                            }else{
                              BasketService basketService = new BasketService();
                              int addQuant = productQuantity-1;
                              BaseResponse responseData = await basketService.basketUpdate(widget.productDataEntity.id, addQuant);
                              if (responseData.body != null) {
                                if(responseData is OkResponse){
                                  Provider.of<BasketProvider>(context, listen: false).getBasketDetailDataController();
                                  setState((){
                                    if(productQuantity > 1){
                                      productQuantity--;
                                    }
                                  });
                                }
                              }

                            }

                          },
                        ),
                        Container(
                          alignment: Alignment.center,
                          width: getSize(context, true, 22 / 415),
                          height: getSize(context, true, 22 / 415),
                          child: Text(productQuantity.toString()),
                        ),
                        InkWell(
                          child: Container(
                            width: getSize(context, true, 22 / 415),
                            height: getSize(context, true, 22 / 415),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white),
                            child: Center(child: Text("+")),
                          ),
                          onTap: () async {
                            BasketService basketService = new BasketService();
                            int addQuant = productQuantity+1;
                            BaseResponse responseData = await basketService.basketUpdate(widget.productDataEntity.id, addQuant);
                            if (responseData.body != null) {
                              if(responseData is OkResponse){
                                print('GÜNCELLEME BAŞARILIII');
                                Provider.of<BasketProvider>(context, listen: false).getBasketDetailDataController();
                                setState(() {
                                  productQuantity++;
                                });
                              }
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                  onTap: () async {
                    BasketService basketService = new BasketService();
                    BaseResponse responseData = await basketService.addBasket(widget.productDataEntity.id);
                    if (responseData.body != null) {
                      print('BASKER RESPONSEE ${responseData.body}');
                      if(responseData is OkResponse){
                        if(responseData.body["errorCode"].toString().compareTo("1") == 0){
                          showBasketAddDialogResponse(widget.productDataEntity);
                        }else{
                          toastWidget("Das Produkt wurde in den Warenkorb gelegt", Colors.green);
                          Provider.of<BasketProvider>(context, listen: false).getBasketDetailDataController();
                          setState(() {
                            widget.productDataEntity.selected = true;
                          });
                        }
                      }
                    }
                    // TODO: inkwell onTap
                  },
                )              ],
            ),

          ],
        ),
      ),
    );
  }

  void showBasketAddDialogResponse(ProductEntity productDataEntity) async {
    //BASKET ADD YAPTIĞIMIZDA BAŞKA MARKET VARSA ERROR CODE 1 DÖNECEK
    // VE BU UYARIYI GÖSTERECEĞİZ.
    // EĞER KABUL EDERSE AYNI DEĞERLERE EK "accept=1" ekleyip göndereceğiz.
    AwesomeDialog(
      context: context,
      dialogType: DialogType.INFO,
      animType: AnimType.BOTTOMSLIDE,
      dismissOnBackKeyPress: false,
      dismissOnTouchOutside: false,
      title: 'Korbwechselbestätigung',
      desc: 'Ihr Warenkorb enthält Produkte aus anderen Märkten. Möchten Sie Ihren Warenkorb leeren, um das Produkt dieses Marktes in Ihren Warenkorb zu legen?',
      btnCancelText: "CANCEL",
      btnCancelOnPress: () {
      },
      btnOkText: "JA",
      btnOkOnPress: () async {
        BasketService basketService = new BasketService();
        BaseResponse responseData = await basketService.addBasket(widget.productDataEntity.id, acceptId: 1);
        if (responseData.body != null) {
          print('BASKER RESPONSEE ${responseData.body}');
          if(responseData is OkResponse){
            toastWidget("Das Produkt wurde in den Warenkorb gelegt", Colors.green);
            Provider.of<BasketProvider>(context, listen: false).getBasketDetailDataController();
            setState(() {
              widget.productDataEntity.selected = true;
            });
          }
        }
      },
    )..show();
  }

}


class ProductWidgetView2 extends StatefulWidget {
  ProductWidgetView2(this.productDataEntity, this.index, this.marketDataEntity);
  ProductEntity productDataEntity;
  CampaignMarketEntity marketDataEntity;
  int index;

  @override
  _ProductWidgetView2State createState() => _ProductWidgetView2State();
}

class _ProductWidgetView2State extends State<ProductWidgetView2> {

  int productQuantity = 1;


  @override
  Widget build(BuildContext context) {
    return InkWell(
      // TODO: control !!
      onTap: () => Navigator.push(context, CupertinoPageRoute(builder: (context) => ProductDetailTabletPage(widget.productDataEntity, marketId: widget.marketDataEntity.id,),)),
      child: Container(
        width: getSize(context, true, 1),
        padding: EdgeInsets.symmetric(
          vertical: 0,
        ),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Stack(
                  children: [
                    Column(
                      children: [
                        Image.network(widget.productDataEntity.image,
                          width: getSize(context, true, 85 / 415),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 3.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SmoothStarRating(
                                starCount: 5,
                                size: getSize(context, true, 10 / 360),
                                rating: 0,
                                isReadOnly: false,
                                allowHalfRating: false,
                                borderColor: BeysionColors.yellow,
                                color: BeysionColors.yellow,
                                onRated: (rating) {},
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Text("(3)", style: TextStyle(color: Colors.grey, fontSize: 10),),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    Positioned(
                      right: 0.0,
                      top: 0.0,
                      child: RawMaterialButton(
                        onPressed: () async {
                          if(settingRepo.currentUserTokenEntity.value.token!=null){
                            UserService userService = new UserService();
                            if(widget.productDataEntity.favStatus == 0){
                              BaseResponse responseData = await userService.userFavoriteAdd(widget.productDataEntity.id);
                              if (responseData.body != null) {
                                print('EKLENDİİİİ ${responseData.body}');
                                if(responseData is OkResponse){
                                  setState((){
                                    widget.productDataEntity.favStatus = 1;
                                  });
                                }else{
                                  toastWidget("Das Produkt konnte nicht zu den Favoriten hinzugefügt werden!", Colors.red);
                                }
                              }else{
                                toastWidget("Das Produkt konnte nicht zu den Favoriten hinzugefügt werden!", Colors.red);
                              }
                            }else{
                              BaseResponse responseData = await userService.userFavoriteDelete(widget.productDataEntity.id);
                              if (responseData.body != null) {
                                if(responseData is OkResponse){
                                  setState((){
                                    widget.productDataEntity.favStatus = 0;
                                  });
                                }else{
                                  toastWidget("Das Produkt konnte nicht aus den Favoriten entfernt werden!", Colors.red);
                                }
                              }else{
                                toastWidget("Das Produkt konnte nicht aus den Favoriten entfernt werden!", Colors.red);
                              }
                            }
                          }else{
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => UserLoginTabletPage()));
                          }
                        },
                        fillColor: Colors.white,
                        shape: CircleBorder(),
                        elevation: 4.0,
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: widget.productDataEntity.favStatus == 0 ? Icon(
                            Icons.favorite_border,
                            color: Colors.black,
                            size: 35,
                          ): Icon(
                            Icons.favorite,
                            color: BeysionColors.yellow,
                            size: 35,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Padding(
                padding: EdgeInsets.only(right: getSize(context, true, 40/360)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("${widget.productDataEntity.name.toString()}",
                      textAlign: TextAlign.start,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      softWrap: true,
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                        fontSize: 18
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 8,
                      ),
                      child: widget.productDataEntity.discountPrice == null
                          ? Text("${widget.productDataEntity.price.toString().replaceAll(".", ",")} €", style: TextStyle(color: Colors.black, fontSize: 20),)
                          : Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            width: getSize(context, true, 25/360),
                            height: getSize(context, true, 15/360),
                            decoration: BoxDecoration(
                                color: BeysionColors.red,
                                borderRadius: BorderRadius.circular(5)
                            ),
                            child: Center(child: Text("${fiyatYuzdeHesaplama(widget.productDataEntity)}", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500),)),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 5.0),
                            child: Column(
                              children: [
                                Text("${widget.productDataEntity.price.toString().replaceAll(".", ",")} €", style: TextStyle(decoration: TextDecoration.lineThrough,fontSize: 18, color: Colors.grey.shade500),),
                                Text("${widget.productDataEntity.discountPrice.toString().replaceAll(".", ",")} €", style: TextStyle(color: Colors.black, fontSize: 20),),
                              ],
                              crossAxisAlignment: CrossAxisAlignment.start,
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            FaIcon(FontAwesomeIcons.store, color: BeysionColors.purple, size: getSize(context, true, 8/360),),
                            Padding(
                              padding: const EdgeInsets.only(left: 3.0),
                              child: Text(widget.marketDataEntity.name, style: TextStyle(color: BeysionColors.purple, fontWeight: FontWeight.w500, fontSize: 16),),
                            ),
                          ],
                        ),
                      ),
                    ),
                   /* Padding(
                      padding: EdgeInsets.only(top: 8.0),
                      child: SizedBox(
                        width: getSize(context, true, 110/360),
                        child: FlatButton(
                          child: Center(child: Text("In den Warenkorb", style: TextStyle(fontSize: 12),),),
                          color: BeysionColors.orange,
                          onPressed: () {},
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        ),
                      ),
                    ),*/
                    SizedBox(height: 10,),
                    InkWell(
                      child: Container(
                        height: getSize(context, true, 20 / 415),
                        width:getSize(context, true, 130 / 415),
                        decoration: BoxDecoration(
                            color: BeysionColors.orange,
                            borderRadius:
                            BorderRadius.all(Radius.circular(5))),
                        child: widget.productDataEntity.selected == false ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            FaIcon(
                              FontAwesomeIcons.shoppingBasket,
                              color: Colors.black,
                              size: getSize(context, true, 10 / 415),
                            ),
                            SizedBox(
                              width: getSize(context, true, 5 / 415),
                            ),
                            Text(
                              "In den Warenkorb",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black),
                            ),
                          ],
                        ): Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            InkWell(
                              child: productQuantity != 1 ? Container(
                                width: getSize(context, true, 15 / 415),
                                height: getSize(context, true, 15 / 415),
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle, color: Colors.white),
                                child: Center(child: Text("-", style: TextStyle(fontSize: 25),)),
                              ):Container(
                                width: getSize(context, true, 22 / 415),
                                height: getSize(context, true, 22 / 415),
                                child: Center(child: Icon(Icons.delete, color: Colors.white, size: 25,)),
                              ),
                              onTap: () async {
                                if(productQuantity == 1){
                                  BaseResponse basketService = await BasketService.operations().deleteBasketProduct(widget.productDataEntity.id);
                                  if(basketService is OkResponse){
                                    toastWidget("Das Produkt wurde aus dem Warenkorb gelöscht", Colors.red);
                                    Provider.of<BasketProvider>(context, listen: false).getBasketDetailDataController();
                                    setState(() {
                                      widget.productDataEntity.selected = false;
                                    });
                                  }
                                }else{
                                  BasketService basketService = new BasketService();
                                  int addQuant = productQuantity-1;
                                  BaseResponse responseData = await basketService.basketUpdate(widget.productDataEntity.id, addQuant);
                                  if (responseData.body != null) {
                                    if(responseData is OkResponse){
                                      Provider.of<BasketProvider>(context, listen: false).getBasketDetailDataController();
                                      setState((){
                                        if(productQuantity > 1){
                                          productQuantity--;
                                        }
                                      });
                                    }
                                  }

                                }

                              },
                            ),
                            Container(
                              alignment: Alignment.center,
                              width: getSize(context, true, 30 / 415),
                              height: getSize(context, true, 30 / 415),
                              child: Text(productQuantity.toString(), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                            ),
                            InkWell(
                              child: Container(
                                width: getSize(context, true, 15 / 415),
                                height: getSize(context, true, 15 / 415),
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white),
                                child: Center(child: Text("+")),
                              ),
                              onTap: () async {
                                BasketService basketService = new BasketService();
                                int addQuant = productQuantity+1;
                                BaseResponse responseData = await basketService.basketUpdate(widget.productDataEntity.id, addQuant);
                                if (responseData.body != null) {
                                  if(responseData is OkResponse){
                                    print('GÜNCELLEME BAŞARILIII');
                                    Provider.of<BasketProvider>(context, listen: false).getBasketDetailDataController();
                                    setState(() {
                                      productQuantity++;
                                    });
                                  }
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                      onTap: () async {
                        BasketService basketService = new BasketService();
                        BaseResponse responseData = await basketService.addBasket(widget.productDataEntity.id);
                        if (responseData.body != null) {
                          print('BASKER RESPONSEE ${responseData.body}');
                          if(responseData is OkResponse){
                            if(responseData.body["errorCode"].toString().compareTo("1") == 0){
                              showBasketAddDialogResponse(widget.productDataEntity);
                            }else{
                              toastWidget("Das Produkt wurde in den Warenkorb gelegt", Colors.green);
                              Provider.of<BasketProvider>(context, listen: false).getBasketDetailDataController();
                              setState(() {
                                widget.productDataEntity.selected = true;
                              });
                            }
                          }
                        }
                        // TODO: inkwell onTap
                      },
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showBasketAddDialogResponse(ProductEntity productDataEntity) async {
    //BASKET ADD YAPTIĞIMIZDA BAŞKA MARKET VARSA ERROR CODE 1 DÖNECEK
    // VE BU UYARIYI GÖSTERECEĞİZ.
    // EĞER KABUL EDERSE AYNI DEĞERLERE EK "accept=1" ekleyip göndereceğiz.
    AwesomeDialog(
      context: context,
      dialogType: DialogType.INFO,
      animType: AnimType.BOTTOMSLIDE,
      dismissOnBackKeyPress: false,
      dismissOnTouchOutside: false,
      title: 'Korbwechselbestätigung',
      desc: 'Ihr Warenkorb enthält Produkte aus anderen Märkten. Möchten Sie Ihren Warenkorb leeren, um das Produkt dieses Marktes in Ihren Warenkorb zu legen?',
      btnCancelText: "CANCEL",
      btnCancelOnPress: () {
      },
      btnOkText: "JA",
      btnOkOnPress: () async {
        BasketService basketService = new BasketService();
        BaseResponse responseData = await basketService.addBasket(widget.productDataEntity.id, acceptId: 1);
        if (responseData.body != null) {
          print('BASKER RESPONSEE ${responseData.body}');
          if(responseData is OkResponse){
            toastWidget("Das Produkt wurde in den Warenkorb gelegt", Colors.green);
            Provider.of<BasketProvider>(context, listen: false).getBasketDetailDataController();
            setState(() {
              widget.productDataEntity.selected = true;
            });
          }
        }
      },
    )..show();
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