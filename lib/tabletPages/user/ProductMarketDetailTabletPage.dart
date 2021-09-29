import 'package:auto_size_text/auto_size_text.dart';
import 'package:beysion/Utility/Colors.dart';
import 'package:beysion/Utility/Icons.dart';
import 'package:beysion/Utility/util.dart';
import 'package:beysion/constant/app_configurations.dart';
import 'package:beysion/constant/colors_theme_widget.dart';
import 'package:beysion/rest/service/user_service.dart';
import 'package:beysion/tabletPages/user/UserLoginTabletPage.dart';
import 'package:beysion/utility/Widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../rest/controller/user/basket_provider.dart';
import 'package:beysion/rest/controller/user/market_brand_provider.dart';
import 'package:beysion/rest/controller/user/market_in_category_provider.dart';
import 'package:beysion/rest/controller/user/market_in_products_provider.dart';
import 'package:beysion/rest/controller/user/markets_detail_provider.dart';
import 'package:beysion/rest/entity/user/market/market_brand_entity.dart';
import 'package:beysion/rest/entity/user/market/market_category_entity.dart';
import 'package:beysion/rest/entity/user/market/market_detail_entity.dart';
import 'package:beysion/rest/entity/user/product_entity.dart';
import 'package:beysion/rest/response_models/base_response.dart';
import 'package:beysion/rest/response_models/ok_response.dart';
import 'package:beysion/rest/service/basket/basket_service.dart';
import 'package:beysion/utility/Images.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:beysion/constant/app_configurations.dart' as settingRepo;
import 'MarketProductCategoryTabletPage.dart';
import 'ProductDetailTabletPage.dart';

class ProductMarketDetailTabletPage extends StatefulWidget {
  MarketDetailEntity marketDetailEntity;
  int marketId;

  ProductMarketDetailTabletPage({this.marketDetailEntity, this.marketId});

  @override
  _ProductMarketDetailTabletPageState createState() =>
      _ProductMarketDetailTabletPageState();
}

class _ProductMarketDetailTabletPageState
    extends State<ProductMarketDetailTabletPage> with TickerProviderStateMixin {
  TabController _tabController;
  ScrollController _listViewController;
  TextEditingController _searchTextFormField;
  MarketCategoryEntity selectedCategoryEntity = new MarketCategoryEntity();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      Provider.of<MarketInProductsProvider>(context, listen: false)
          .getMarketProductListController(widget.marketId);
      var providerCategoryList =
          Provider.of<MarketInCategoryProvider>(context, listen: false);
      List<MarketCategoryEntity> catList = new List();
      catList = providerCategoryList.marketCategoryList;
      _tabController = TabController(length: catList.length, vsync: this);
    });

    _searchTextFormField = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    List<MarketCategoryEntity> marketCategoryDataList =
        Provider.of<MarketInCategoryProvider>(context, listen: true)
            .marketCategoryList;
    MarketDetailEntity marketDetailEntity =
        Provider.of<MarketDetailProvider>(context, listen: true)
            .marketsDetailEntity;

    return Scaffold(
      appBar: buildAppBarTablet(context),
      body: buildBody(context, marketCategoryDataList, marketDetailEntity),
    );
  }

  buildBody(BuildContext context, List<MarketCategoryEntity> categoryAllList,
      MarketDetailEntity marketDetailEntity) {
    List<MarketBrandEntity> brandListData =
        Provider.of<MarketBrandProvider>(context, listen: true)
            .allMarketBrandsList;
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              expandedHeight: getSize(context, true, 240 / 415),
              toolbarHeight: getSize(context, true, 40 / 415),
              centerTitle: true,
              snap: false,
              floating: false,
              pinned: true,
              automaticallyImplyLeading: false,
              backgroundColor: Colors.white,
              title: Text(
                "${marketDetailEntity.name}",
                style: GoogleFonts.overpass(
                  color: Colors.black,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              flexibleSpace: FlexibleSpaceBar(
                  collapseMode: CollapseMode.pin,
                  centerTitle: true,
                  background: Stack(
                    children: [
                      Align(
                        alignment: Alignment.topCenter,
                        child: Image.asset(
                          ImagesPath.headerDetailBack,
                          fit: BoxFit.fitWidth,
                          width: getSize(context, true, 1),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          left: getSize(context, true, 22 / 415),
                          top: getSize(context, true, 40 / 415),
                        ),
                        child: Text(
                          "${marketDetailEntity.address}",
                          style: GoogleFonts.overpass(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                      buildContainer(
                          context,
                          Container(
                            width: getSize(context, true, 371 / 415),
                            height: getSize(context, true, 240 / 415),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(
                                              bottom: getSize(
                                                  context, true, 10 / 415)),
                                          child: Image.network(
                                            "${marketDetailEntity.logo}",
                                            fit: BoxFit.fitWidth,
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: Text(
                                                "Durchschnittliche Punktzahl",
                                                style: GoogleFonts.overpass(
                                                    fontSize: 16,
                                                    fontWeight:
                                                    FontWeight.w500),
                                              ),
                                            ),
                                            Text(
                                              "${marketDetailEntity.avgScore}",
                                              style: GoogleFonts.overpass(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ],
                                        ),
                                        Divider(
                                          thickness: 3,
                                          color: BeysionColors.rank2,
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding: EdgeInsets.only(top: getSize(context, true, 2 / 575)),
                                            child: Column(
                                              mainAxisAlignment:MainAxisAlignment.start,
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Container(
                                                  margin: EdgeInsets.only(bottom: getSize(context, true, 5 / 415)),
                                                  child: Row(
                                                    children: [
                                                      Container(
                                                        width: getSize(context, true, 30 / 415),
                                                        height: getSize(context, true, 20 / 415),
                                                        decoration: BoxDecoration(
                                                            borderRadius: BorderRadius.all(Radius.circular(5)),
                                                            color: BeysionColors.rank2),
                                                        child: Center(
                                                            child: Text("${marketDetailEntity.point1}",
                                                              style: GoogleFonts.overpass(fontSize: 20, fontWeight: FontWeight.w500),)),),
                                                      Padding(
                                                        padding: EdgeInsets.only(left: getSize(context, true, 5 / 415)),
                                                        child: Text("Reaktionszeit",
                                                          style: GoogleFonts.overpass(
                                                              fontSize: 16,
                                                              fontWeight: FontWeight.w500),),)
                                                    ],
                                                  ),
                                                ),
                                                Container(
                                                  margin: EdgeInsets.only(bottom: getSize(context, true, 5 / 415)),
                                                  child: Row(
                                                    children: [
                                                      Container(
                                                        width: getSize(context, true, 30 / 415),
                                                        height: getSize(context, true, 20 / 415),
                                                        decoration: BoxDecoration(
                                                            borderRadius: BorderRadius.all(Radius.circular(5)),
                                                            color: BeysionColors.rank4),
                                                        child: Center(
                                                            child: Text("${marketDetailEntity.point2}",
                                                              style: GoogleFonts.overpass(
                                                                  fontSize: 20,
                                                                  fontWeight: FontWeight.w500),)),),
                                                      Padding(
                                                        padding: EdgeInsets.only(left: getSize(context, true, 5 / 415)),
                                                        child: Text("Bedienung",
                                                          style: GoogleFonts.overpass(
                                                              fontSize: 16,
                                                              fontWeight: FontWeight.w500),),)
                                                    ],
                                                  ),
                                                ),
                                                Container(
                                                  margin: EdgeInsets.only(bottom: getSize(context, true, 5 / 415)),
                                                  child: Row(
                                                    children: [
                                                      Container(
                                                        width: getSize(context, true, 30 / 415),
                                                        height: getSize(context, true, 20 / 415),
                                                        decoration: BoxDecoration(
                                                            borderRadius: BorderRadius.all(Radius.circular(5)),
                                                            color: BeysionColors.rank1),
                                                        child: Center(
                                                            child: Text("${marketDetailEntity.point3}",
                                                              style: GoogleFonts.overpass(
                                                                  fontSize: 20,
                                                                  fontWeight: FontWeight.w500),
                                                            )),
                                                      ),
                                                      Padding(
                                                        padding: EdgeInsets.only(left: getSize(context, true, 5 / 415)),
                                                        child: Text("Verpackung",
                                                          style: GoogleFonts.overpass(
                                                              fontSize: 16,
                                                              fontWeight: FontWeight.w500),),)
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: getSize(context, true, 5 / 415),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    margin: EdgeInsets.only(
                                        top: getSize(context, true, 15 / 415)),
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                      MainAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        AutoSizeText(
                                          "${marketDetailEntity.address}",
                                          style: GoogleFonts.overpass(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400),
                                          minFontSize: 10,
                                        ),
                                        OutlineButton(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: getSize(
                                                context, true, 10 / 415),
                                            vertical:
                                            getSize(context, true, 0 / 415),
                                          ),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    right: getSize(context,
                                                        true, 10 / 415)),
                                                child: Image.asset(
                                                    IconsPath.location),
                                              ),
                                              Text(
                                                "Karte öffnen",
                                                style: GoogleFonts.overpass(
                                                    fontSize: 15,
                                                    fontWeight:
                                                    FontWeight.w500),
                                              )
                                            ],
                                          ),
                                          onPressed: () async {
                                            // TODO: openMap onTap
                                            if (await canLaunch(
                                                "${marketDetailEntity.mapUrl}")) {
                                              await launch(
                                                  "${marketDetailEntity.mapUrl}");
                                            }
                                          },
                                        ),
                                        SizedBox(
                                          height:
                                          getSize(context, true, 10 / 415),
                                        ),
                                        Row(
                                          children: [
                                            Image.asset(
                                              IconsPath.box,
                                              width: getSize(
                                                  context, true, 23 / 415),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  left: getSize(
                                                      context, true, 5 / 415)),
                                              child: Column(
                                                children: [
                                                  Container(
                                                    width: getSize(context,
                                                        true, 140 / 415),
                                                    child: AutoSizeText(
                                                      "Mindestpaketmenge",
                                                      style: GoogleFonts.overpass(
                                                          color: BeysionColors
                                                              .gray2,
                                                          fontSize: 16),
                                                      minFontSize: 8,
                                                      maxLines: 1,
                                                      overflow:
                                                      TextOverflow.fade,
                                                      softWrap: false,
                                                      wrapWords: true,
                                                    ),
                                                  ),
                                                  Container(
                                                    width: getSize(context,
                                                        true, 140 / 415),
                                                    child: AutoSizeText(
                                                      "${marketDetailEntity.minimumSellPrice}",
                                                      style: GoogleFonts.overpass(
                                                          color: Colors.black,
                                                          fontSize: 18,
                                                          fontWeight:
                                                          FontWeight.bold),
                                                      minFontSize: 8,
                                                      maxLines: 1,
                                                      overflow:
                                                      TextOverflow.fade,
                                                      softWrap: false,
                                                      wrapWords: true,
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height:
                                          getSize(context, true, 5 / 415),
                                        ),
                                        Row(
                                          children: [
                                            Image.asset(
                                              IconsPath.box,
                                              width: getSize(
                                                  context, true, 23 / 415),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  left: getSize(
                                                      context, true, 5 / 415)),
                                              child: Column(
                                                children: [
                                                  Container(
                                                    width: getSize(context,
                                                        true, 140 / 415),
                                                    child: AutoSizeText(
                                                      "Arbeitszeit (heute)",
                                                      style: GoogleFonts.overpass(
                                                          color: BeysionColors
                                                              .gray2,
                                                          fontSize: 16),
                                                      minFontSize: 8,
                                                      maxLines: 1,
                                                      overflow:
                                                      TextOverflow.fade,
                                                      softWrap: false,
                                                      wrapWords: true,
                                                    ),
                                                  ),
                                                  Container(
                                                    width: getSize(context,
                                                        true, 140 / 415),
                                                    child: AutoSizeText(
                                                      "${marketDetailEntity.workingTimeNow}",
                                                      style: GoogleFonts.overpass(
                                                          color: Colors.black,
                                                          fontSize: 18,
                                                          fontWeight:
                                                          FontWeight.bold),
                                                      minFontSize: 8,
                                                      maxLines: 1,
                                                      overflow:
                                                      TextOverflow.fade,
                                                      softWrap: false,
                                                      wrapWords: true,
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height:
                                          getSize(context, true, 5 / 415),
                                        ),
                                        Row(
                                          children: [
                                            Image.asset(
                                              IconsPath.box,
                                              width: getSize(
                                                  context, true, 23 / 415),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  left: getSize(
                                                      context, true, 5 / 415)),
                                              child: Column(
                                                children: [
                                                  Container(
                                                    width: getSize(context,
                                                        true, 140 / 415),
                                                    child: AutoSizeText(
                                                      "Vorbereitungszeit",
                                                      style: GoogleFonts.overpass(
                                                          color: BeysionColors
                                                              .gray2,
                                                          fontSize: 16),
                                                      minFontSize: 8,
                                                      maxLines: 1,
                                                      overflow:
                                                      TextOverflow.fade,
                                                      softWrap: false,
                                                      wrapWords: true,
                                                    ),
                                                  ),
                                                  Container(
                                                    width: getSize(context,
                                                        true, 140 / 415),
                                                    child: AutoSizeText(
                                                      "${marketDetailEntity.preparingTime}",
                                                      style: GoogleFonts.overpass(
                                                          color: Colors.black,
                                                          fontSize: 18,
                                                          fontWeight:
                                                          FontWeight.bold),
                                                      minFontSize: 8,
                                                      maxLines: 1,
                                                      overflow:
                                                      TextOverflow.fade,
                                                      softWrap: false,
                                                      wrapWords: true,
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          topMargin: 65)
                    ],
                  )),
            ),
          ];
        },
        body: DefaultTabController(
          length: categoryAllList.length,
          initialIndex: 0,
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(
                  top: getSize(context, true, 50 / 415),
                  left: getSize(context, true, 20 / 415),
                  right: getSize(context, true, 20 / 415),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: getSize(context, true, 249 / 415),
                      height: getSize(context, true, 25 / 415),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        border: Border.all(
                            color: BeysionColors.border.withOpacity(0.5),
                            width: 1),
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
                                  hintText: "Produkt suchen",
                                  hintStyle: GoogleFonts.overpass(
                                    color: BeysionColors.gray1,
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
                    ), // TODO: marketDetail SearchBar
                    Container(
                      width: getSize(context, true, 112 / 415),
                      height: getSize(context, true, 25 / 415),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        border: Border.all(
                            color: BeysionColors.border.withOpacity(0.5),
                            width: 1),
                      ),
                      child: OutlineButton(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(right: 5),
                              child: Image.asset(IconsPath.filter),
                            ),
                            Text(
                              "Filter",
                              style: GoogleFonts.overpass(
                                  fontSize: 14, fontWeight: FontWeight.normal),
                            ),
                          ],
                        ),
                        onPressed: () {
                          print('ASSSSS');
                          buildShowDialog(context, brandListData);
                        },
                      ),
                    ), // TODO: marketDetail FilterButton
                  ],
                ),
              ),
              Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: getSize(context, true, 20 / 415),
                      vertical: getSize(context, true, 9 / 415),
                    ),
                    child: Text(
                      "Ermäßigte Produkte",
                      textAlign: TextAlign.start,
                      style: GoogleFonts.overpass(fontSize: 14),
                    ),
                  )),
              Expanded(
                child: ListView(
                  //controller: _tabController,
                    physics: NeverScrollableScrollPhysics(),
                    controller: _listViewController,
                    shrinkWrap: true,
                    children: [
                      buildMarketProductsView(context),
                      Provider.of<MarketInProductsProvider>(context,
                          listen: true)
                          .marketProductList
                          .length >
                          0
                          ? Padding(
                          padding: EdgeInsets.only(
                            top: getSize(context, true, 10 / 415),
                            bottom: getSize(context, true, 10 / 415),
                            left: getSize(context, true, 150 / 415),
                            right: getSize(context, true, 150 / 415),
                          ),
                          child: SizedBox(
                            width: getSize(context, true, 100 / 415),
                            child: FlatButton(
                              color: BeysionColors.orange,
                              child: Center(
                                child: Text(
                                  "MEHR PRODUKTE",
                                  style: GoogleFonts.overpass(
                                      color: Colors.white,
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              onPressed: () {
                                Provider.of<MarketInProductsProvider>(
                                    context,
                                    listen: false)
                                    .getMarketProductListController(
                                    widget.marketId,
                                    categoryId:
                                    selectedCategoryEntity.id,
                                    pageNumber: -1);
                              },
                            ),
                          ))
                          : SizedBox(),
                    ]),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        color: Color(getColorHexFromStr("#0c1a26")),
        shape: CircularNotchedRectangle(),
        child: Material(
          child: SizedBox(
            width: double.infinity,
            height: 60.0,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: categoryAllList.length,
              // itemExtent: 10.0,
              // reverse: true, //makes the list appear in descending order
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: () {
                    setState(() {
                      selectedCategoryIndex = index;
                    });
                    Provider.of<MarketInProductsProvider>(context,
                            listen: false)
                        .getMarketProductListController(widget.marketId,
                            categoryId: categoryAllList[index].id,
                            pageNumber: 0);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border(
                            right: BorderSide(color: BeysionColors.gray1),
                            bottom: selectedCategoryIndex == index
                                ? BorderSide(
                                    color: BeysionColors.yellow, width: 8)
                                : BorderSide.none)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Text(
                          categoryAllList[index].name,
                          style: GoogleFonts.overpass(fontSize: 13),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  int selectedCategoryIndex = 0;

  buildMarketProductsView(BuildContext context) {
    List<ProductEntity> marketProductListData =
        Provider.of<MarketInProductsProvider>(context, listen: true)
            .marketProductList;
    return ListView(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      children: [
        Container(
          margin: EdgeInsets.only(
            top: getSize(context, true, 10 / 415),
            right: getSize(context, true, 20 / 415),
            left: getSize(context, true, 20 / 415),
          ),
          padding: EdgeInsets.all(getSize(context, true, 5 / 415)),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(5)),
            border: Border.all(color: BeysionColors.border, width: 1),
          ),
          child: marketProductListData.length > 0
              ? GridView.count(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            physics: NeverScrollableScrollPhysics(),
            childAspectRatio: 0.55,
            crossAxisSpacing: getSize(context, true, 5 / 415),
            mainAxisSpacing: getSize(context, true, 5 / 415),
            padding: EdgeInsets.symmetric(
                vertical: getSize(context, true, 10 / 415),
                horizontal: getSize(context, true, 5 / 415)),
            crossAxisCount: 3,
            children: marketProductListData
                .map((productEntity) =>
                BuildProductCard(productEntity, widget.marketDetailEntity))
                .toList(),
          )
              : SizedBox(),
        )
      ],
    );
  }

  buildShowDialog(BuildContext context, List<MarketBrandEntity> brandsList) {
    return showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setStateC) {
            return Dialog(
              child: Container(
                height: MediaQuery.of(context).size.width * 1.0,
                width: MediaQuery.of(context).size.width * 0.7,
                padding: EdgeInsets.symmetric(
                    horizontal: getSize(context, true, 10 / 415),
                    vertical: getSize(context, true, 15 / 415)),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: Column(
                  children: [
                    Expanded(
                      child: ListView(
                        children: [
                          Container(
                            height: getSize(context, true, 31 / 415),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)),
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
                                            horizontal: getSize(
                                                context, true, 10 / 415)),
                                        border: InputBorder.none,
                                        suffixIcon: SizedBox(),
                                        suffix: SizedBox(),
                                        isCollapsed: true,
                                        suffixIconConstraints:
                                            BoxConstraints.tightFor(),
                                        hintText: "Produkte im Markt",
                                        hintStyle: GoogleFonts.overpass(
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
                          Divider(),
                          Text(
                            "Marken",
                            style: GoogleFonts.overpass(
                              color: BeysionColors.gray2,
                              fontSize: 14,
                            ),
                          ),
                          SizedBox(
                            height: getSize(context, true, 10 / 415),
                          ),
                          Container(
                            height: getSize(context, true, 31 / 415),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)),
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
                                            horizontal: getSize(
                                                context, true, 10 / 415)),
                                        border: InputBorder.none,
                                        suffixIcon: SizedBox(),
                                        suffix: SizedBox(),
                                        isCollapsed: true,
                                        suffixIconConstraints:
                                            BoxConstraints.tightFor(),
                                        hintText: "Marke suchen",
                                        hintStyle: GoogleFonts.overpass(
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
                              height: getSize(context, true, 240 / 415),
                              width: MediaQuery.of(context).size.width * 0.7,
                              margin: EdgeInsets.only(
                                  top: getSize(context, true, 10 / 415)),
                              child: ListView(
                                shrinkWrap: true,
                                children: brandsList
                                    .map((brandData) => DialogMarktItemCard(
                                        "${brandData.name}"))
                                    .toList(),
                              )),
                        ],
                      ),
                    ),
                    FlatButton(
                      color: BeysionColors.orange,
                      child: Text(
                        "ANWENDEN",
                        style: GoogleFonts.overpass(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      onPressed: () {
                        Provider.of<MarketInProductsProvider>(context,
                            listen: false)
                            .getMarketProductListController(widget.marketId,
                            pageNumber: 0, search: "");
                        Navigator.pop(context);
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

class BuildProductCard extends StatefulWidget {
  ProductEntity productEntity;
  MarketDetailEntity marketDetailEntity;

  BuildProductCard(this.productEntity, this.marketDetailEntity);

  @override
  _BuildProductCardState createState() => _BuildProductCardState();
}

class _BuildProductCardState extends State<BuildProductCard> {
  int productQuantity = 1;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children:[ InkWell(
        child: Container(
          padding: EdgeInsets.zero,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              border: Border.all(color: BeysionColors.border)),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(top: getSize(context, true, 5 / 415)),
                    child: CachedNetworkImage(
                      imageUrl: widget.productEntity.image,
                      imageBuilder: (context, imageProvider) => Image.network(
                        widget.productEntity.image,
                        fit: BoxFit.fitHeight,
                      ),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                      placeholder: (context, url) => SizedBox(
                          height: 50,
                          width: 50,
                          child: Center(
                              child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CircularProgressIndicator(),
                          ))),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SmoothStarRating(
                      starCount: 5,
                      size: getSize(context, true, 7 / 415),
                      rating: 0,
                      isReadOnly: false,
                      allowHalfRating: false,
                      borderColor: BeysionColors.yellow,
                      color: BeysionColors.yellow,
                      onRated: (rating) {},
                    ),
                    Text(
                      "(5)",
                      style: GoogleFonts.overpass(fontSize: 12),
                    )
                  ],
                ),
                Text(
                  widget.productEntity.name,
                  style: GoogleFonts.overpass(
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                  ),
                  maxLines: 2,
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: getSize(context, true, 5 / 415),
                ),
                widget.productEntity.discountPrice != null
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Flexible(
                              flex: 1,
                              child: Container(
                                width: getSize(context, true, 25 / 415),
                                height: getSize(context, true, 25 / 415),
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle, color: Colors.red),
                                child: Center(
                                  child: Text(
                                    fiyatYuzdeHesaplama(widget.productEntity),
                                    overflow: TextOverflow.fade,
                                    maxLines: 1,
                                    softWrap: false,
                                    style: GoogleFonts.overpass(
                                        color: Colors.white,
                                        fontSize: 13,
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
                                    "${widget.productEntity.price.toString().replaceAll(".", ",")} €",
                                    style: GoogleFonts.overpass(
                                        decoration: TextDecoration.lineThrough,
                                        color: Colors.black38,
                                        fontSize: 17,
                                        fontWeight: FontWeight.w400),
                                    textAlign: TextAlign.center,
                                  ),
                                  Text(
                                    "${widget.productEntity.discountPrice.toString().replaceAll(".", ",")} €",
                                    style: GoogleFonts.overpass(
                                        color: Colors.black,
                                        fontSize: 19,
                                        fontWeight: FontWeight.w700),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              )),
                        ],
                      )
                    : Center(
                        child: Text(
                          "${widget.productEntity.price.toString().replaceAll(".", ",")} €",
                          style: GoogleFonts.overpass(
                              color: Colors.black,
                              fontSize: 19,
                              fontWeight: FontWeight.w700),
                          textAlign: TextAlign.center,
                        ),
                      ),
                SizedBox(
                  height: getSize(context, true, 5 / 415),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      FaIcon(
                        FontAwesomeIcons.store,
                        color: BeysionColors.orange,
                        size: getSize(context, true, 12 / 415),
                      ),
                      SizedBox(
                        width: getSize(context, true, 5 / 415),
                      ),
                      /*Text(
                          item.alternativeMarkets == 1
                              ? "Niemerszein Market"
                              : "${item.alternativeMarkets.toString()} Markt",
                          style: GoogleFonts.overpass(
                              fontSize: 10,
                              fontWeight: FontWeight.w400,
                              color: BeysionColors.purple),
                        ),*/
                      Expanded(
                        child: Text(
                          "${widget.marketDetailEntity.name}",
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
                ),
                InkWell(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: getSize(context, true, 25 / 415),
                      decoration: BoxDecoration(
                          color: BeysionColors.orange,
                          borderRadius: BorderRadius.all(Radius.circular(5))),
                      child: widget.productEntity.selected == false
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                FaIcon(
                                  FontAwesomeIcons.shoppingBasket,
                                  color: Colors.white,
                                  size: getSize(context, true, 12 / 415),
                                ),
                                SizedBox(
                                  width: getSize(context, true, 2 / 415),
                                ),
                                Text(
                                  "In den Warenkorb",
                                  style: GoogleFonts.overpass(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.white),
                                ),
                              ],
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                InkWell(
                                  child: productQuantity != 1
                                      ? Container(
                                          width: getSize(context, true, 22 / 415),
                                          height:
                                              getSize(context, true, 22 / 415),
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Colors.white),
                                          child: Center(child: Text("-")),
                                        )
                                      : Container(
                                          width: getSize(context, true, 22 / 415),
                                          height:
                                              getSize(context, true, 22 / 415),
                                          child: Center(
                                              child: Icon(
                                            Icons.delete,
                                            color: Colors.white,
                                            size: 18,
                                          )),
                                        ),
                                  onTap: () async {
                                    if (productQuantity == 1) {
                                      BaseResponse basketService =
                                          await BasketService.operations()
                                              .deleteBasketProduct(
                                                  widget.productEntity.id);
                                      if (basketService is OkResponse) {
                                        toastWidget(
                                            "Das Produkt wurde aus dem Warenkorb gelöscht",
                                            Colors.red);
                                        Provider.of<BasketProvider>(context,
                                                listen: false)
                                            .getBasketDetailDataController();
                                        setState(() {
                                          widget.productEntity.selected = false;
                                        });
                                      }
                                    } else {
                                      BasketService basketService =
                                          new BasketService();
                                      int addQuant = productQuantity - 1;
                                      BaseResponse responseData =
                                          await basketService.basketUpdate(
                                              widget.productEntity.id, addQuant);
                                      if (responseData.body != null) {
                                        if (responseData is OkResponse) {
                                          Provider.of<BasketProvider>(context,
                                                  listen: false)
                                              .getBasketDetailDataController();
                                          setState(() {
                                            if (productQuantity > 1) {
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
                                    BasketService basketService =
                                        new BasketService();
                                    int addQuant = productQuantity + 1;
                                    BaseResponse responseData =
                                        await basketService.basketUpdate(
                                            widget.productEntity.id, addQuant);
                                    if (responseData.body != null) {
                                      if (responseData is OkResponse) {
                                        print('GÜNCELLEME BAŞARILIII');
                                        Provider.of<BasketProvider>(context,
                                                listen: false)
                                            .getBasketDetailDataController();
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
                  ),
                  onTap: () async {
                    BasketService basketService = new BasketService();
                    BaseResponse responseData =
                        await basketService.addBasket(widget.productEntity.id);
                    if (responseData.body != null) {
                      if (responseData is OkResponse) {
                        toastWidget("Das Produkt wurde in den Warenkorb gelegt",
                            Colors.green);
                        Provider.of<BasketProvider>(context, listen: false)
                            .getBasketDetailDataController();
                        setState(() {
                          widget.productEntity.selected = true;
                        });
                      }
                    }
                    // TODO: inkwell onTap
                  },
                ),
                SizedBox(
                  height: getSize(context, true, 10 / 415),
                )
              ],
            ),
          ),
        ),
        onTap: () {
          // FIXME: onTap navigator => productDetail 1 ise şu 1'den fazla market ise şu
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      ProductDetailTabletPage(widget.productEntity, marketId: widget.productEntity.mid,)));
        },
      ),
        Positioned(
          right: -20.0,
          top: 0.0,
          child: RawMaterialButton(
            onPressed: () async {
              if(settingRepo.currentUserTokenEntity.value.token!=null){
                UserService userService = new UserService();
                if(widget.productEntity.favStatus == 0){
                  BaseResponse responseData = await userService.userFavoriteAdd(widget.productEntity.id);
                  if (responseData.body != null) {
                    print('EKLENDİİİİ ${responseData.body}');
                    if(responseData is OkResponse){
                      setState((){
                        widget.productEntity.favStatus = 1;
                      });
                    }else{
                      toastWidget("Das Produkt konnte nicht zu den Favoriten hinzugefügt werden!", Colors.red);
                    }
                  }else{
                    toastWidget("Das Produkt konnte nicht zu den Favoriten hinzugefügt werden!", Colors.red);
                  }
                }else{
                  BaseResponse responseData = await userService.userFavoriteDelete(widget.productEntity.id);
                  if (responseData.body != null) {
                    if(responseData is OkResponse){
                      setState((){
                        widget.productEntity.favStatus = 0;
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
              child: Icon(
                widget.productEntity.favStatus == 0 ? Icons.favorite_border: Icons.favorite,
                color: BeysionColors.yellow,
                size: 20,
              ),
            ),
          ),
        ),
      ]
    );
  }
}

// ignore: must_be_immutable
class BottomTabBarItem extends StatelessWidget {
  BottomTabBarItem(this.categoryEntity, this.marketId);
  int marketId;
  MarketCategoryEntity categoryEntity;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Provider.of<MarketInProductsProvider>(context, listen: false)
            .getMarketProductListController(marketId,
                categoryId: categoryEntity.id, pageNumber: 0);
      },
      child: Container(
        decoration: BoxDecoration(
            border: Border(right: BorderSide(color: BeysionColors.gray1))),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Tab(
            text: categoryEntity.name,
          ),
        ),
      ),
    );
  }
}
