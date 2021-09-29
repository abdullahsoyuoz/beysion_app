import 'dart:ui';

import 'package:beysion/Utility/Colors.dart';
import 'package:beysion/Utility/util.dart';
import 'package:beysion/rest/response_models/base_response.dart';
import 'package:beysion/rest/response_models/ok_response.dart';
import 'package:beysion/rest/service/market/markets_service.dart';
import 'package:beysion/tabletPages/user/MarketDetailTabletPage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../rest/controller/user/market_all_list_provider.dart';
import 'package:beysion/rest/controller/user/product_all_provider.dart';
import 'package:beysion/rest/entity/user/market/markets_all_entity.dart';
import 'package:beysion/rest/entity/user/product_entity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';


class MarketListTabletPage extends StatefulWidget {
  bool mainPageViewStatus;
  MarketListTabletPage(this.mainPageViewStatus);
  @override
  _MarketListTabletPageState createState() => _MarketListTabletPageState();
}

class _MarketListTabletPageState extends State<MarketListTabletPage> {
  var _scrollControllerBody = ScrollController();

  TextEditingController dialogMarketSearchController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<MarketAllListProvider>(context, listen: false)
        .getMarketAllListController(pageCount: -1);
    _scrollControllerBody.addListener(() {
      if (_scrollControllerBody.position.pixels ==
          _scrollControllerBody.position.maxScrollExtent) {
        Provider.of<MarketAllListProvider>(context, listen: false)
            .getMarketAllListController(pageCount: 0);
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _scrollControllerBody.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double barHeight = MediaQuery.of(context).padding.top;
    List<MarketsAllEntity> marketsAllEntity =
        Provider.of<MarketAllListProvider>(context, listen: true)
            .marketInformationDataList;
    List<ProductEntity> productSearchList =
        Provider.of<ProductAllProvider>(context, listen: true).productAllList;

    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: marketsAllEntity.length > 0
            ? ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                physics: ClampingScrollPhysics(),
                controller: _scrollControllerBody,
                padding: EdgeInsets.only(top: getSize(context, true, 15 / 360)),
                itemCount: marketsAllEntity.length,
                itemBuilder: (context, index) {
                  MarketsAllEntity marketDataEntity = marketsAllEntity[index];
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                MarketDetailTabletPage(marketDataEntity),
                          ));
                    },
                    child: Container(
                      padding: EdgeInsets.all(getSize(context, true, 20 / 360)),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [BoxShadow(color: Colors.grey)]),
                      margin: EdgeInsets.only(
                          bottom: getSize(context, true, 15 / 360)),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        "${marketDataEntity.name}",
                                        textAlign: TextAlign.start,
                                        maxLines: 1,
                                        softWrap: true,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                    Container(
                                      width: getSize(context, true, 25 / 360),
                                      height: getSize(context, true, 15 / 360),
                                      margin: EdgeInsets.only(left: 5),
                                      decoration: BoxDecoration(
                                          color: BeysionColors.orange,
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      child: Center(
                                          child: Text(
                                        "${marketDataEntity.avgScore}",
                                        style: TextStyle(
                                            color: BeysionColors.purple,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w700),
                                      )),
                                    )
                                  ],
                                ),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.network(
                                    "${marketDataEntity.logo}",
                                    height: getSize(context, true, 55 / 380),
                                    fit: BoxFit.fitWidth,
                                    alignment: Alignment.topCenter,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 20,),
                          Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${marketDataEntity.fulladdress}",
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                softWrap: true,
                                style: TextStyle(
                                    color: Colors.grey.shade700, fontSize: 14),
                              ),
                              SizedBox(height: 10,),
                              Column(
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                          child: Text(
                                        "Mindestpaketmenge",
                                        style: TextStyle(
                                            color: Colors.grey.shade500,
                                            fontSize: 13),
                                      )),
                                      SizedBox(
                                        width: getSize(context, true, 5 / 360),
                                      ),
                                      Expanded(
                                          child: Text(
                                        "Arbeitszeit (heute)",
                                        style: TextStyle(
                                            color: Colors.grey.shade500,
                                            fontSize: 13),
                                      )),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                          child: Text(
                                        "${marketDataEntity.minimumSellPrice}",
                                        style: TextStyle(fontSize: 14),
                                      )),
                                      SizedBox(
                                        width: getSize(context, true, 5 / 360),
                                      ),
                                      Expanded(
                                          child: Text(
                                        "${marketDataEntity.workingTimeNow}",
                                        style: TextStyle(fontSize: 14),
                                      )),
                                    ],
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        top: getSize(context, true, 10 / 360)),
                                    child: Row(
                                      children: [
                                        Expanded(
                                            child: Text(
                                          "Vorbereitungszeit",
                                          style: TextStyle(
                                              color: Colors.grey.shade500,
                                              fontSize: 12),
                                        )),
                                        SizedBox(
                                          width: getSize(context, true, 5 / 360),
                                        ),
                                        Expanded(
                                            child: Text(
                                          "Service Wählen",
                                          style: TextStyle(
                                              color: Colors.grey.shade500,
                                              fontSize: 12),
                                        )),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                          child: Text(
                                        "${marketDataEntity.preparingTime}",
                                        style: TextStyle(fontSize: 14),
                                      )),
                                      SizedBox(
                                        width: getSize(context, true, 5 / 360),
                                      ),
                                      Expanded(
                                          child: Text(
                                        "${marketDataEntity.deliveryType}",
                                        style: TextStyle(fontSize: 14),
                                      )),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ))
                        ],
                      ),
                    ),
                  );
                },
              )
            : Container(
                child: Center(
                  child: Column(
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
              ),
      ),
      appBar: AppBar(
        title: Text("Alle Märkte", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
        centerTitle: false,
        backgroundColor: Colors.white,
        leading: widget.mainPageViewStatus == true ? SizedBox(width: 0, height: 0,): InkWell(
            onTap: (){
              print('ASSS');
              Navigator.pop(context);
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Center(child: FaIcon(FontAwesomeIcons.arrowLeft, color: Colors.black, size: 20,)),
            )),
        leadingWidth: widget.mainPageViewStatus == true ? 0:  35,
        elevation: 1,
        toolbarHeight: AppBar().preferredSize.height * 2,
        actions: [
          IconButton(
            icon: FaIcon(
              FontAwesomeIcons.search,
              color: Colors.black,
            ),
            onPressed: () {
              showMarktSuchenFullScreenDialog(
                  context, dialogMarketSearchController);
            },
          )
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(AppBar().preferredSize.height * 0.5),
          child: Container(
            decoration: BoxDecoration(
                border:
                    Border(top: BorderSide(color: Colors.grey, width: 0.2))),
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: getSize(context, true, 15 / 360)),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                            child: Icon(
                              Icons.filter_list_outlined,
                              size: 30,
                            )),
                        Padding(
                          padding: EdgeInsets.only(left: 8.0),
                          child: Text(
                            "Filter",
                            style: TextStyle(
                                color: Colors.grey.shade900, fontSize: 22),
                          ),
                        )
                      ],
                    ),
                    onPressed: () {
                      //Navigator.pushNamed(context, "/productListPage");
                      buildShowDialog(context);
                    },
                  ),
                  FlatButton(
                    child: Center(
                      child: Row(
                        children: [
                          FaIcon(
                            FontAwesomeIcons.mapMarkedAlt,
                            color: Colors.grey.shade900,
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 8.0),
                            child: Text(
                              "Kartenansicht",
                              style: TextStyle(
                                  color: Colors.grey.shade900, fontSize: 22),
                            ),
                          )
                        ],
                      ),
                    ),
                    onPressed: () {},
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void showMarktSuchenFullScreenDialog(
      BuildContext context, TextEditingController testController) {
    testController.clear();
    bool loadingData = false;
    List<MarketsAllEntity> marketSearchDataList = new List();
    showGeneralDialog(
      context: context,
      barrierColor: Colors.black12.withOpacity(0.6), // background color
      barrierLabel: "Dialog", // label for barrier
      transitionDuration: Duration(
          milliseconds:
              400), // how long it takes to popup dialog after button click
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
                                                  marketSearchDataList.length,
                                              itemBuilder: (context, index) {
                                                MarketsAllEntity
                                                    marketDataEntity =
                                                    marketSearchDataList[index];
                                                return InkWell(
                                                  onTap: (){
                                                    Navigator.push(context, MaterialPageRoute(builder: (context) => MarketDetailTabletPage(marketDataEntity),));

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
                                              marketSearchDataList.clear();
                                              marketSearchDataList =
                                                  await marketSearchUIController(
                                                      search: value);
                                              setStateC(() {});
                                            } else {
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

  double sliderValue = 150.0;
  int selectedDialogIndex = 0;
  bool getData = false;

  buildShowDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setStateC) {
            return Dialog(
              child: Container(
                height: MediaQuery.of(context).size.width * 0.6,
                width: MediaQuery.of(context).size.width * 0.7,
                padding: EdgeInsets.symmetric(
                    horizontal: getSize(context, true, 10 / 415),
                    vertical: getSize(context, true, 15 / 415)),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Text(
                        "Lieferart",
                        style: TextStyle(
                          color: BeysionColors.gray2,
                          fontSize: 22,
                        ),
                      ),
                    ),
                    InkWell(
                      child: ListTile(
                        leading: FaIcon(
                          FontAwesomeIcons.box,
                          size: 40,
                          color: selectedDialogIndex != 0
                              ? BeysionColors.border
                              : BeysionColors.orange,
                        ),
                        title: Text(
                          "Lieferservice und Abholservice",
                          style: TextStyle(fontSize: 22),
                        ),
                        dense: true,
                      ),
                      onTap: () {
                        setStateC(() {
                          selectedDialogIndex = 0;
                        });
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    InkWell(
                      child: ListTile(
                        leading: FaIcon(
                          FontAwesomeIcons.truck,
                          size: 40,
                          color: selectedDialogIndex != 1
                              ? BeysionColors.border
                              : BeysionColors.orange,
                        ),
                        title: Text(
                          "Lieferservice",
                          style: TextStyle(fontSize: 22),
                        ),
                        dense: true,
                      ),
                      onTap: () {
                        setStateC(() {
                          selectedDialogIndex = 1;
                        });
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    InkWell(
                      child: ListTile(
                        leading: FaIcon(
                          FontAwesomeIcons.walking,
                          size: 40,
                          color: selectedDialogIndex != 2
                              ? BeysionColors.border
                              : BeysionColors.orange,
                        ),
                        title: Text(
                          "Abholservice",
                          style: TextStyle(fontSize: 22),
                        ),
                        dense: true,
                      ),
                      onTap: () {
                        setStateC(() {
                          selectedDialogIndex = 2;
                        });
                      },
                    ),
                    Divider(),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Text(
                        "Mindest Bestellsumme",
                        style: TextStyle(
                          color: BeysionColors.gray2,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Slider(
                            value: sliderValue,
                            max: 150,
                            min: 0,
                            onChanged: (value) {
                              setStateC(() {
                                sliderValue = value;
                              });
                            },
                            activeColor: BeysionColors.orange,
                            inactiveColor: BeysionColors.border,
                          ),
                        ),
                        Text(
                          "${sliderValue.floorToDouble()} €",
                          style: TextStyle(
                            color: BeysionColors.gray2,
                          ),
                        )
                      ],
                    ),
                    InkWell(
                      child: Container(
                        margin: EdgeInsets.only(top: 15, left: 10, right: 10),
                        height: getSize(context, true, 18 / 285),
                        decoration: BoxDecoration(
                            color: BeysionColors.orange,
                            borderRadius: BorderRadius.all(Radius.circular(5))),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: Text(
                              "ANWENDEN",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      onTap: () {
                        Navigator.pop(context);
                        if (selectedDialogIndex == 0) {
                          Provider.of<MarketAllListProvider>(context,
                                  listen: false)
                              .getMarketAllListController(
                                  pageCount: -1,
                                  abholService: 1,
                                  lieferService: 1,
                                  filterStatus: true);
                        } else if (selectedDialogIndex == 1) {
                          Provider.of<MarketAllListProvider>(context,
                                  listen: false)
                              .getMarketAllListController(
                                  pageCount: -1,
                                  abholService: 0,
                                  lieferService: 1,
                                  filterStatus: true);
                        } else if (selectedDialogIndex == 2) {
                          Provider.of<MarketAllListProvider>(context,
                                  listen: false)
                              .getMarketAllListController(
                                  pageCount: -1,
                                  abholService: 1,
                                  lieferService: 0,
                                  filterStatus: true);
                        }
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

  marketSearchUIController(
      {String search = " ",
      int abholService = 1,
      int lieferService = 1}) async {
    List<MarketsAllEntity> returnDataList = new List();
    SharedPreferences sharedPref = await SharedPreferences.getInstance();
    String plzZipCode = "12801";
    if (sharedPref.containsKey("plzZipCode")) {
      plzZipCode = sharedPref.getString("plzZipCode");
    }
    if (sharedPref.containsKey("abholService")) {
      abholService = sharedPref.getInt("abholService");
    }
    if (sharedPref.containsKey("lieferService")) {
      lieferService = sharedPref.getInt("lieferService");
    }
    String sessionToken = sharedPref.getString("sessionToken");
    BaseResponse response = await MarketsService.operations()
        .allMarketsListInformation(
            plzZipCode, search, lieferService, abholService, sessionToken);
    try {
      getData = false;
      if (response is OkResponse) {
        if (response.body != null) {
          if (response.body["data"] != null) {
            returnDataList.clear();
            List<dynamic> dataList = response.body["data"];
            List<MarketsAllEntity> newDataList = new List();
            for (var dataStr in dataList) {
              MarketsAllEntity model = new MarketsAllEntity.fromJson(dataStr);
              newDataList.add(model);
              if (model != null) {
                if ((newDataList.singleWhere((it) => it.id == model.id,
                        orElse: () => null)) !=
                    null) {
                } else {
                  newDataList.add(model);
                }
              }
            }
            getData = true;
            returnDataList.addAll(newDataList);
            return returnDataList;
          } else {
            return returnDataList;
          }
        } else {
          return returnDataList;
        }
      } else {
        return returnDataList;
      }
    } catch (e) {
      print('Exception get All Market List Data -- $e');
    }
  }
}
