import 'package:auto_size_text/auto_size_text.dart';
import 'package:beysion/Utility/Colors.dart';
import 'package:beysion/Utility/Icons.dart';
import 'package:beysion/Utility/Widgets.dart';
import 'package:beysion/Utility/util.dart';
import 'package:beysion/constant/app_configurations.dart';
import 'package:beysion/pages/user/EmptyCartWidget.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../rest/controller/user/basket_provider.dart';
import 'package:beysion/rest/entity/user/basket/basket_detail_entity.dart';
import 'package:beysion/rest/entity/user/basket/basket_send_data.dart';
import 'package:beysion/rest/entity/user/product_entity.dart';
import 'package:beysion/rest/response_models/base_response.dart';
import 'package:beysion/rest/response_models/ok_response.dart';
import 'package:beysion/rest/service/basket/basket_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:beysion/constant/app_configurations.dart' as settingRepo;

import 'MakeYourChoicePage.dart';
import 'ProductDetailBasketPage.dart';
import 'ProductDetailPage.dart';
import 'UserLoginPageBasket.dart';

class BasketPage extends StatefulWidget {
  bool widgetStatus;
  BasketPage(this.widgetStatus);
  @override
  _BasketPageState createState() => _BasketPageState();
}

class _BasketPageState extends State<BasketPage> {
  ScrollController basketListViewController;
  Map<int, BasketProductSelect> selectedBasketDataTime = new Map<int, BasketProductSelect>();

  @override
  void initState() {
    basketListViewController = ScrollController();
    basketListViewController.addListener(_scrollListener);
    BasketSendData basketSend = new BasketSendData();
    List<BasketProductSelect> basketSelect = new List();
    basketSend.basketSelect = basketSelect;
    super.initState();
  }

  _scrollListener() {
    if (basketListViewController.offset >= basketListViewController.position.maxScrollExtent &&
        !basketListViewController.position.outOfRange) {
      setState(() {//you can do anything here
      });
    }
    if (basketListViewController.offset <= basketListViewController.position.minScrollExtent &&
        !basketListViewController.position.outOfRange) {
      setState(() {//you can do anything here
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    BasketDetailEntity  basketDetailEntity =  Provider.of<BasketProvider>(context, listen: true).basketDetailEntity;
    return WillPopScope(
      onWillPop: () async => widget.widgetStatus,
      child: Scaffold(
        backgroundColor: BeysionColors.textFieldBackground,
        appBar: buildAppBar(context, homePage: !widget.widgetStatus),
        body: basketDetailEntity.basketTotal != 0 ? Stack(
          children: [
            buildBasketBody2(context,basketDetailEntity.basketMarketDataList),
            buildBasketPageTopNavBar2(context, 0),
            buildBottomSheet(context, basketDetailEntity),
          ],
        ): EmptyCartWidget(),
      ),
    );
  }

  buildBasketBody2(BuildContext context, List<BasketMarketInData> basketMarketInDataList) {
    return ListView(
      controller: basketListViewController,
      physics: BouncingScrollPhysics(),
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      padding: EdgeInsets.symmetric(
        //horizontal: getSize(context, true, 20 / 415),
        vertical: getSize(context, true, 60 / 415),
      ),
      children: basketMarketInDataList.map((basketInMarketData) => BasketMarketItemData(basketInMarketData,selectedBasketDataTime)).toList(),
    );
  }

  buildBasketPageTopNavBar2(BuildContext context, int index) {
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        width: getSize(context, true, 1),
        height: getSize(context, true, 40 / 415),
        decoration: BoxDecoration(
          color: BeysionColors.blueNavy,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Image.asset(IconsPath.basket,
                width: getSize(context, true, 15 / 415),
                height: getSize(context, true, 15 / 415),
                fit: BoxFit.fitWidth,
                color: index == 0
                    ? BeysionColors.yellow
                    : BeysionColors.overlay),
            SizedBox(width: getSize(context, true, 5/415),),
            AutoSizeText(
              "Mein Warenkorb",
              style: GoogleFonts.overpass(
                  color: index == 0 ? Colors.white : BeysionColors.overlay,
                  fontSize: 16,
                  fontWeight: FontWeight.w500
              ),
              minFontSize: 5,
            ),
            SizedBox(width: getSize(context, true, 5/415),),
            FaIcon(
              FontAwesomeIcons.chevronRight,
              color: BeysionColors.overlay,
              size: getSize(context, true, 15 / 415),
            ),
            SizedBox(width: getSize(context, true, 5/415),),
            FaIcon(
              FontAwesomeIcons.checkCircle,
              color: BeysionColors.overlay,
              size: getSize(context, true, 25 / 415),
            ),
          ],
        ),
      ),
    );
  }

  TextEditingController couponController = new TextEditingController();

  buildBottomSheet(BuildContext context, BasketDetailEntity  basketDetailEntity) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: DraggableScrollableSheet(
        initialChildSize: 0.125,
        minChildSize: 0.125,
        maxChildSize: 0.9,
        builder: (context, scrollController) {
          return Container(
            color: Colors.white,
            width: getSize(context, true, 1),
            height: getSize(context, true, 1),
            padding: EdgeInsets.only(
                left: getSize(context, true, 20 / 415),
                right: getSize(context, true, 20 / 415),
                top: getSize(context, true, 10 / 415)),
            child: ListView(
              shrinkWrap: true,
              controller: scrollController,
              physics: ClampingScrollPhysics(),
              padding: EdgeInsets.symmetric(
                  horizontal: getSize(context, true, 15 / 415)),
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          FaIcon(FontAwesomeIcons.chevronUp,
                            color: BeysionColors.orange,
                            size: getSize(context, true, 20/415),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Text(
                                "Gesamtmenge",
                                style: GoogleFonts.overpass(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                "${basketDetailEntity.basketTotalPrice} €",
                                style: GoogleFonts.overpass(
                                    fontSize: 17, fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: RaisedButton(
                        color: BeysionColors.yellow,
                        child: Center(
                            child: Text(
                              "KASSE",
                              style: GoogleFonts.overpass(
                                  fontSize: 15, fontWeight: FontWeight.w400),
                            )),
                        onPressed: () {
                          if(settingRepo.currentUserTokenEntity.value.token!=null){
                            print('DDDDDDDDDD ${settingRepo.currentUserTokenEntity.value.token}');
                            if(selectedBasketDataTime.length>0){
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MakeYourChoicePage()));
                            }else{
                              toastWidget("Bitte wählen Sie eine Lieferzeit!", Colors.red);
                            }

                          }else{
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => UserLoginPageBasket()));
                          }
                        },
                      ),
                    )
                  ],
                ),
                Divider(),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: getSize(context, true, 10 / 415),
                    ),
                    child: Text(
                      "Allgemeine Information",
                      style:
                      GoogleFonts.overpass(fontSize: 17, fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
                Divider(),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                      padding: EdgeInsets.only(
                        top: getSize(context, true, 10 / 415),
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Gesamt (${basketDetailEntity.basketTotal} Produkt)",
                                style: GoogleFonts.overpass(
                                    fontSize: 15, fontWeight: FontWeight.w400),
                              ),
                              Text(
                                "${basketDetailEntity.basketTotalPrice} €",
                                style: GoogleFonts.overpass(
                                    fontSize: 15, fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                          SizedBox(height: 6,),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Gesamtliefergebühr (${basketDetailEntity.basketMarketDataList.length} Markt)",
                                style: GoogleFonts.overpass(
                                    fontSize: 15, fontWeight: FontWeight.w400),
                              ),
                              Text(
                                "${basketDetailEntity.basketMarketDataList[0].cargoPrice.toString().replaceAll(".", ",")} €",
                                style: GoogleFonts.overpass(
                                    fontSize: 15, fontWeight: FontWeight.w400),
                              ),
                            ],
                          )
                        ],
                      )),
                ),
/*                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: getSize(context, true, 5 / 415),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Tax (5%)",
                          style: GoogleFonts.overpass(
                              fontSize: 15, fontWeight: FontWeight.w300),
                        ),
                        Text(
                          "6,00 €",
                          style: GoogleFonts.overpass(
                              fontSize: 15, fontWeight: FontWeight.w300),
                        ),
                      ],
                    ),
                  ),
                )*/
                Divider(),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(
                            "Gesamtsumme",
                            style: GoogleFonts.overpass(
                                fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                          Text(
                            "(inkl. MwSt)",
                            style: GoogleFonts.overpass(
                                fontSize: 13, fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                      Text(
                        "${basketDetailEntity.basketTotalPrice.toString().replaceAll(".", ",")} €",
                        style: GoogleFonts.overpass(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
                Align(alignment: Alignment.bottomCenter,child: Padding(
                  padding: const EdgeInsets.only(top: 45),
                  child: Column(
                    children: [
                      Text("Gutschein Code einlösen", style: GoogleFonts.overpass(color: Colors.blue, decoration: TextDecoration.underline),),
                      Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: TextField(
                          controller: couponController,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: BeysionColors.border,
                                    width: 1),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: BeysionColors.border,
                                    width: getSize(context, true, 1/ 415)),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: BeysionColors.border,
                                    width: getSize(context, true, 1 / 415)),
                              ),
                              labelText: "Code",
                              suffixIcon: Container(
                                  height: getSize(context, true, 55/415),
                                  decoration: BoxDecoration(
                                      color: BeysionColors.yellow,
                                      borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(5),
                                        bottomRight: Radius.circular(5),
                                      )
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.check_circle_outline),
                                      Text("Einlösen",style: GoogleFonts.overpass(fontWeight: FontWeight.w500, fontSize: 10),),
                                    ],
                                  )),
                              labelStyle: GoogleFonts.overpass(color: BeysionColors.border)),
                        ),
                      ),
                    ],
                  ),
                ),),
                Divider(),
                Align(
                  alignment: Alignment.bottomLeft,
                  child:                       Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        "Unsere Versandkosten:",
                        style: GoogleFonts.overpass(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                      Text(
                        "Bestellungen, die den vom Markt festgelegten Mindestumsatz nicht erreichen, werden nicht in der Warenkorbzusammenfassung angezeigt.",
                        style: GoogleFonts.overpass(
                            fontSize: 13, fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}

class BasketMarketItemData extends StatefulWidget {
  BasketMarketInData basketMarketInData;
  BasketMarketItemData(this.basketMarketInData, this.selectedBasketDataTime);
  Map<int, BasketProductSelect> selectedBasketDataTime;

  @override
  _BasketMarketItemDataState createState() => _BasketMarketItemDataState();
}

class _BasketMarketItemDataState extends State<BasketMarketItemData> {
  DeliveryType selectedDeliveryType;
  List<BasketProduct> basketProductList;
  Map<int, BasketProduct> basketProductSelectedMap = new Map();

  bool basket1value = false;
  BasketProduct productItemValue;
  bool selectAllValue = false;
  int valueDeliveryHours = 0;

  int selectedServicesTimeId = -1;
  int selectedComeTimesId = -1;
  ScrollController daySelectListViewController;


  @override
  void initState() {
    super.initState();
    daySelectListViewController = ScrollController();
    try{
      selectedDeliveryType = widget.basketMarketInData.deliveryTypes[0];
    }catch(e){

    }
  }


  @override
  void dispose() {
    super.dispose();
    daySelectListViewController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return buildContainer(
        context,
        Container(
          width: getSize(context, true, 1),
          padding:
          EdgeInsets.symmetric(vertical: getSize(context, true, 20 / 415)),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${widget.basketMarketInData.name}",
                style: GoogleFonts.overpass(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: getSize(context, true, 5 / 415),
              ),
              Text(
                "${widget.basketMarketInData.fulladdress}",
                maxLines: 1,
                softWrap: false,
                overflow: TextOverflow.fade,
                style: GoogleFonts.overpass(
                    fontSize: 15,
                    fontWeight: FontWeight.w400
                ),
              ),
              SizedBox(
                height: getSize(context, true, 5 / 415),
              ),
              OutlineButton(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: 5),
                      child: Image.asset(IconsPath.location),
                    ),
                    Text(
                      "Karte öffnen",
                      style: GoogleFonts.overpass(
                          fontSize: 14, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                onPressed: ()  async{
                  // TODO: openMap onTap
                  if (await canLaunch("${widget.basketMarketInData.mapUrl}")) {
                    await launch("${widget.basketMarketInData.mapUrl}");
                  }
                },
              ),
              SizedBox(
                height: getSize(context, true, 10 / 415),
              ),
              Text(
                "Bitte wählen Sie Lieferart",
                textAlign: TextAlign.start,
                style: GoogleFonts.overpass(fontWeight: FontWeight.w600, fontSize: 15),
              ),
              SizedBox(
                height: getSize(context, true, 10 / 415),
              ),
              Container(
                height: getSize(context, true, 30 / 415),
                width: getSize(context, true, 1),
                margin: EdgeInsets.only(
                  top: getSize(context, true, 5 / 415),
                  bottom: getSize(context, true, 20 / 415),
                ),
                decoration: BoxDecoration(
                    color: BeysionColors.textFieldBackground,
                    borderRadius: BorderRadius.all(Radius.circular(5))),
                child: cupertinoSelectedDeliveryType(widget.basketMarketInData),
              ),

              selectedDeliveryType !=null && selectedDeliveryType.id == 1 ?
              Column(
                children: [
                  Row(children: [
                    Image.asset("assets/icons/lieferServiceBasket.png", width: 50,),
                    SizedBox(width: 5,),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Durchschnittliche Lieferzeit", style: GoogleFonts.overpass(fontWeight: FontWeight.bold, fontSize: 13),),
                          Text("Die von Ihnen ausgewählten Produkte werden innerhalb von durchschnittlich ${widget.basketMarketInData.averageDeliveryTime} versendet.", style: GoogleFonts.overpass(fontSize:11,fontWeight: FontWeight.w400),)
                        ],),
                    ),
                  ],),
                  SizedBox(height: 15,),
                  widget.basketMarketInData.serviceTimes.length>0 ?
                  Container(
                    width: getSize(context, true, 1),
                    height: getSize(context, true, 100 / 415),
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: widget.basketMarketInData.serviceTimes.length,
                        itemBuilder: (context, index) {
                          ETime getDeliveryServiceTimes = widget.basketMarketInData.serviceTimes[index];
                          return InkWell(
                            onTap: () {
                              setState(() {
                                selectedServicesTimeId = index;
                              });
                              int mid = widget.basketMarketInData.mid;

                              BasketProductSelect basketSelectNew = new BasketProductSelect();
                              basketSelectNew.mid = mid;
                              basketSelectNew.time = getDeliveryServiceTimes.date;
                              basketSelectNew.serviceType = selectedDeliveryType.id;

                              Map<int, BasketProductSelect> basketSelectMapTime = new Map();
                              basketSelectMapTime[mid] = basketSelectNew;
                              widget.selectedBasketDataTime.addAll(basketSelectMapTime);
                              settingRepo.mapBasketSendDataEntity.value = widget.selectedBasketDataTime;
                            },
                            child: Container(
                              width: getSize(context, true, 90 / 415),
                              margin: EdgeInsets.only(right: getSize(context, true, 10/415)),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border:
                                  Border.all(color: selectedServicesTimeId == index ? BeysionColors.purple : BeysionColors.gray1, width: 1),
                                  borderRadius: BorderRadius.all(Radius.circular(
                                      getSize(context, true, 5 / 415)))),
                              child: Stack(
                                children: [
                                  Container(
                                    width: getSize(context, true, 90 / 415),
                                    alignment: Alignment.center,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        FaIcon(
                                          FontAwesomeIcons.calendarDay,
                                          color: BeysionColors.purple,
                                          size: getSize(context, true, 16 / 415),
                                        ),
                                        SizedBox(
                                          height: getSize(context, true, 2 / 415),
                                        ),
                                        Text(
                                          "${getDeliveryServiceTimes.text}",
                                          style: GoogleFonts.overpass(
                                              color: BeysionColors.purple,
                                              fontSize: 13),
                                        ),
                                        SizedBox(
                                          height: getSize(context, true, 2 / 415),
                                        ),
                                        Text(
                                          "${getDeliveryServiceTimes.hour}",
                                          style: GoogleFonts.overpass(fontSize: 11),
                                        ),
                                        SizedBox(
                                          height: getSize(context, true, 2 / 415),
                                        ),
                                        Text(
                                          "${getDeliveryServiceTimes.datetext}",
                                          style: GoogleFonts.overpass(fontSize: 11),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.topRight,
                                    child: Padding(
                                      padding: EdgeInsets.all(getSize(context, true, 5/415)),
                                      child: FaIcon(
                                        FontAwesomeIcons.solidCheckCircle,
                                        color: selectedServicesTimeId == index ? BeysionColors.purple : BeysionColors.gray1,
                                        size: getSize(context, true, 16 / 415,
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        }),
                  ): SizedBox(height: 0,),
                ],
              ): Column(
                children: [
                  Row(children: [
                    Image.asset("assets/icons/abholServiceBasket.png", width: 50,),
                    SizedBox(width: 5,),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Abholzeit", style: GoogleFonts.overpass(fontWeight: FontWeight.bold, fontSize: 13),),
                          Text("Sie können die Produkte, die Sie auswählen, zum angegebenen Zeitpunkt auf diesem Markt kaufen. ${widget.basketMarketInData.preparingTime}", style: GoogleFonts.overpass(fontSize:11,fontWeight: FontWeight.w400),)
                        ],),
                    ),
                  ],),
                  SizedBox(height: 15,),
                  widget.basketMarketInData.comeTimes.length > 0?
                  Container(
                    width: getSize(context, true, 1),
                    height: getSize(context, true, 100 / 415),
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: widget.basketMarketInData.comeTimes.length,
                        itemBuilder: (context, index) {
                          ETime getDeliveryComeTimes = widget.basketMarketInData.comeTimes[index];
                          return InkWell(
                            onTap: () {
                              setState(() {
                                selectedComeTimesId = index;
                              });
                              int mid = widget.basketMarketInData.mid;

                              BasketProductSelect basketSelectNew = new BasketProductSelect();
                              basketSelectNew.mid = mid;
                              basketSelectNew.time = getDeliveryComeTimes.date;
                              basketSelectNew.serviceType = selectedDeliveryType.id;

                              Map<int, BasketProductSelect> basketSelectMapTime = new Map();
                              basketSelectMapTime[mid] = basketSelectNew;
                              widget.selectedBasketDataTime.addAll(basketSelectMapTime);
                              settingRepo.mapBasketSendDataEntity.value = widget.selectedBasketDataTime;
                            },
                            child: Container(
                              width: getSize(context, true, 90 / 415),
                              margin: EdgeInsets.only(right: getSize(context, true, 10/415)),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border:
                                  Border.all(color: selectedComeTimesId == index ? BeysionColors.purple : BeysionColors.gray1, width: 1),
                                  borderRadius: BorderRadius.all(Radius.circular(
                                      getSize(context, true, 5 / 415)))),
                              child: Stack(
                                children: [
                                  Container(
                                    width: getSize(context, true, 90 / 415),
                                    alignment: Alignment.center,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        FaIcon(
                                          FontAwesomeIcons.calendarDay,
                                          color: BeysionColors.purple,
                                          size: getSize(context, true, 16 / 415),
                                        ),
                                        SizedBox(
                                          height: getSize(context, true, 2 / 415),
                                        ),
                                        Text(
                                          "${getDeliveryComeTimes.text}",
                                          style: GoogleFonts.overpass(
                                              color: BeysionColors.purple,
                                              fontSize: 13),
                                        ),
                                        SizedBox(
                                          height: getSize(context, true, 2 / 415),
                                        ),
                                        Text(
                                          "${getDeliveryComeTimes.hour}",
                                          style: GoogleFonts.overpass(fontSize: 11),
                                        ),
                                        SizedBox(
                                          height: getSize(context, true, 2 / 415),
                                        ),
                                        Text(
                                          "${getDeliveryComeTimes.datetext}",
                                          style: GoogleFonts.overpass(fontSize: 11),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.topRight,
                                    child: Padding(
                                      padding: EdgeInsets.all(getSize(context, true, 5/415)),
                                      child: FaIcon(
                                        FontAwesomeIcons.solidCheckCircle,
                                        color: selectedComeTimesId == index ? BeysionColors.purple : BeysionColors.gray1,
                                        size: getSize(context, true, 16 / 415,
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        }),
                  ): SizedBox(height: 0,),
                ],
              ),
              SizedBox(
                height:
                getSize(context, true, 15 / 415),
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
                            "${widget.basketMarketInData.minimumSellPrice} €",
                            style: GoogleFonts.overpass(
                                color: Colors.black,
                                fontSize: 16,
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
                            "${widget.basketMarketInData.workingTimeNow}",
                            style: GoogleFonts.overpass(
                                color: Colors.black,
                                fontSize: 16,
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
                            "${widget.basketMarketInData.averageDeliveryTime}",
                            style: GoogleFonts.overpass(
                                color: Colors.black,
                                fontSize: 16,
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
/*              Container(
                height: getSize(context, true, 32 / 415),
                margin:
                EdgeInsets.only(bottom: getSize(context, true, 2 / 415)),
                child: Row(
                  children: [
                    Image.asset(
                      IconsPath.delivery,
                      width: getSize(context, true, 23 / 415),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: getSize(context, true, 5 / 415)),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: getSize(context, true, 140 / 415),
                            child: AutoSizeText(
                              "Liefergebühr",
                              style: GoogleFonts.overpass(
                                  color: BeysionColors.gray2, fontSize: 12),
                              maxLines: 1,
                              minFontSize: 8,
                              overflow: TextOverflow.visible,
                              wrapWords: true,
                            ),
                          ),
                          Container(
                            width: getSize(context, true, 140 / 415),
                            child: AutoSizeText(
                              "3€",
                              softWrap: true,
                              style: GoogleFonts.overpass(
                                  color: Colors.black,
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold),
                              maxLines: 1,
                              minFontSize: 8,
                              wrapWords: true,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              )*/
              SizedBox(
                height: getSize(context, true, 20 / 415),
              ),
              Text("Produkte", style: GoogleFonts.overpass(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w400
              ),),
              Divider(),
              ListView.separated(
                  shrinkWrap: true,
                  itemCount: widget.basketMarketInData.basketProductList.length,
                  physics: NeverScrollableScrollPhysics(),
                  separatorBuilder: (context, index) => Divider(),
                  itemBuilder: (context, index){
                    BasketProduct basketProduct = widget.basketMarketInData.basketProductList[index];
                    return BuildProductItemData(basketProduct);
                  }),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Checkbox(
                    visualDensity: VisualDensity.standard,
                    value: selectAllValue,
                    onChanged: (value) {
                      if(value){
                        basketProductSelectedMap.clear();
                        Map<int, BasketProduct> basketProductNewMap = new Map();
                        for(var data in widget.basketMarketInData.basketProductList){
                          setState(() {
                            data.selectedProduct = true;
                            basketProductNewMap[data.aid] = data;
                          });
                        }
                        settingRepo.selectBasketItemId.value.addAll(basketProductNewMap);
                      }else{
                        basketProductSelectedMap.clear();
                        settingRepo.selectBasketItemId.value = basketProductSelectedMap;
                        for(var data in widget.basketMarketInData.basketProductList){
                          setState(() {
                            data.selectedProduct = value;
                          });
                        }
                      }
                      setState(() {
                        selectAllValue = value;
                      });
                    },
                  ),
                  Text("Wählen Sie Alle", style: GoogleFonts.overpass(fontSize: 14),),
                  Padding(
                    padding: const EdgeInsets.only(left: 12),
                    child: InkWell(
                      onTap: () async {
                        if(settingRepo.selectBasketItemId.value.length>0){
                          List<int> dataAdsIds = new List();
                          for(var dataIn in settingRepo.selectBasketItemId.value.entries.toList()){
                            if(dataIn.value.selectedProduct){
                              dataAdsIds.add(dataIn.key);
                            }
                          }
                          if(dataAdsIds.length>0){
                            BaseResponse basketService = await BasketService.operations().deleteAllBasketProducts(dataAdsIds);
                            if(basketService is OkResponse){
                              toastWidget("Das Produkt wurde aus dem Warenkorb gelöscht", Colors.green);
                              Provider.of<BasketProvider>(context, listen: false).getBasketDetailDataController();
                            }else{
                              toastWidget("Löschen fehlgeschlagen. Versuchen Sie es nochmal!", Colors.red);
                            }
                          }else{
                            toastWidget("Zum Löschen müssen Sie zunächst ein Produkt auswählen", Colors.red);
                          }

                        }else{
                          toastWidget("Zum Löschen müssen Sie zunächst ein Produkt auswählen", Colors.red);
                        }

                      },
                      child: Card(
                          elevation: 2,
                          child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Row(children: [
                          FaIcon(Icons.delete, color: BeysionColors.yellow, size: 17,),
                          Text("Löschen", style: TextStyle(fontSize: 12),),
                        ],),
                      )),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Liefergebühren", style: GoogleFonts.overpass(fontSize: 13),),
                        Text("Gesamtsumme", style: GoogleFonts.overpass(fontSize: 15, fontWeight: FontWeight.bold),),
                      ],
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("${widget.basketMarketInData.cargoPrice.toString().replaceAll(".", ",")} €", style: GoogleFonts.overpass(fontSize: 13),),
                        Text("${widget.basketMarketInData.basketTotal.toString().replaceAll(".", ",")} €", style: GoogleFonts.overpass(fontSize: 15, fontWeight: FontWeight.bold),),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ), bottomMargin: 20);
  }


  Widget cupertinoSelectedDeliveryType(BasketMarketInData basketMarketItemData) {
    return GestureDetector(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
                "   ${selectedDeliveryType!=null && selectedDeliveryType.name != null ? selectedDeliveryType.name : "Not Selected Delivery Type"}"),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 4),
            child: Icon(Icons.keyboard_arrow_down, color: BeysionColors.yellow, size: 20,),
          ),
        ],
      ),
      onTap: () async {
        await showModalBottomSheet<int>(
          context: context,
          useRootNavigator: true,
          builder: (BuildContext context) {
            return Column(
              children: <Widget>[
                Expanded(
                  child: CupertinoPicker(
                    itemExtent: 40.0,
                    backgroundColor: CupertinoColors.white,
                    onSelectedItemChanged: (index) {
                      setState(() {
                        selectedDeliveryType = basketMarketItemData.deliveryTypes[index];
                      });
                    },
                    children: new List<Widget>.generate(
                        basketMarketItemData.deliveryTypes.length, (index) {
                      return new Center(
                        child: Text(
                          "${basketMarketItemData.deliveryTypes[index].name}",
                          style: GoogleFonts.overpass(fontSize: 22.0),
                        ),
                      );
                    }),
                  ),
                ),
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  color: BeysionColors.yellow,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: InkWell(
                      child: Text(
                        "Wählen Sie und kehren Sie zurück",
                        style:
                        GoogleFonts.overpass(fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                ),
                SizedBox(height: 20,)
              ],
            );
          },
        );
      },
    );
  }


}

class BuildProductItemData extends StatefulWidget {
  BasketProduct item;
  BuildProductItemData(this.item,);

  @override
  _BuildProductItemDataState createState() => _BuildProductItemDataState();
}

class _BuildProductItemDataState extends State<BuildProductItemData> {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.max,
      children: [
        Flexible(
          flex: 1,
          child: Checkbox(
            visualDensity: VisualDensity.standard,
            value: widget.item.selectedProduct,
            onChanged: (value) {
              setState(() {
                widget.item.selectedProduct = value;
                Map<int, BasketProduct> selectedIds = new Map();
                selectedIds[widget.item.aid] = widget.item;
                settingRepo.selectBasketItemId.value.addAll(selectedIds);
              });
            },
          ),
        ),
        Flexible(
          flex: 1,
          child: InkWell(
            child: Image.network(
              widget.item.image,
              fit: BoxFit.fitHeight,
              width: getSize(context, true, 50 / 415),
              height: getSize(context, true, 50 / 415),
            ),
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => ProductDetailBasketPage(widget.item, )));
            },
          ),
        ),
        SizedBox(width: getSize(context, true, 5 / 415),),
        Flexible(
          flex: 3,
          child: InkWell(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => ProductDetailBasketPage(widget.item, )));
            },
            child: Text("${widget.item.name}",
              maxLines: 3,
              softWrap: true,
              overflow: TextOverflow.fade,
              style: GoogleFonts.overpass(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w400
              ),
            ),
          ),),
        SizedBox(width: getSize(context, true, 5 / 415),),
        Container(
          child: widget.item.discountPrice!=null ?
          Padding(
            padding: EdgeInsets.only(top: getSize(context,true, 5/415)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: getSize(context, true, 30 / 405),
                  height: getSize(context, true, 30 / 405),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: Colors.red),
                  child: Center(
                    child: Text(
                      fiyatYuzdeHesaplama(new ProductEntity(), basketProduct: widget.item),
                      overflow: TextOverflow.fade,
                      maxLines: 1,
                      softWrap: false,
                      style: GoogleFonts.overpass(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.w800),
                    ),
                  ),
                ),
                SizedBox(
                  width: getSize(context, true, 5 / 415),
                ),
                Column(
                  children: [
                    Text(
                      "${widget.item.price.toString().replaceAll(".", ",")} €",
                      style: GoogleFonts.overpass(
                          decoration: TextDecoration.lineThrough,
                          color: Colors.black38,
                          fontSize: 13,
                          fontWeight: FontWeight.w400),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      "${widget.item.discountPrice.toString().replaceAll(".", ",")} €",
                      style: GoogleFonts.overpass(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.w700),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                SizedBox(width: getSize(context, true, 10/415),),
                Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      border: Border.all(color: BeysionColors.orange),
                      borderRadius: BorderRadius.circular(5)
                  ),
                  child: Row(
                    children: [
                      InkWell(
                        child: widget.item.qty != 1 ? Container(
                          width: getSize(context, true, 20 / 415),
                          height: getSize(context, true, 20 / 415),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: BeysionColors.yellow),
                          child: Center(child: Text("-", style: GoogleFonts.overpass(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),)),
                        ):Container(
                          width: getSize(context, true, 20 / 415),
                          height: getSize(context, true, 20 / 415),
                          child: Center(child: Icon(Icons.delete, color: BeysionColors.yellow, size: 18,)),
                        ) ,
                        onTap: () async {
                          if(widget.item.qty == 1){
                            BaseResponse basketService = await BasketService.operations().deleteBasketProduct(widget.item.aid);
                            if(basketService is OkResponse){
                              toastWidget("Das Produkt wurde aus dem Warenkorb gelöscht", Colors.red);
                              Provider.of<BasketProvider>(context, listen: false).getBasketDetailDataController();
                            }
                          }else{
                            if(widget.item.qty>1){
                              int quantity = widget.item.qty-1;
                              BaseResponse responseData = await BasketService.operations().basketUpdate(widget.item.aid, quantity);
                              if (responseData.body != null) {
                                if(responseData is OkResponse){
                                  print('GÜNCELLEME BAŞARILIII');
                                  Provider.of<BasketProvider>(context, listen: false).getBasketDetailDataController();
                                  setState(()  {
                                    widget.item.qty--;
                                  });
                                }
                              }
                            }

                          }
                        },
                      ),
                      Container(
                        alignment: Alignment.center,
                        width: getSize(context, true, 25 / 415),
                        height: getSize(context, true, 20 / 415),
                        child: Text(widget.item.qty.toString()),
                      ),
                      InkWell(
                        child: Container(
                          width: getSize(context, true, 20 / 415),
                          height: getSize(context, true, 20 / 415),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: BeysionColors.yellow),
                          child: Center(child: Text("+", style: GoogleFonts.overpass(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),)),
                        ),
                        onTap: () async {
                          int quantity = widget.item.qty+1;
                          BaseResponse responseData = await BasketService.operations().basketUpdate(widget.item.aid, quantity);
                          if (responseData.body != null) {
                            if(responseData is OkResponse){
                              print('GÜNCELLEME BAŞARILIII');
                              Provider.of<BasketProvider>(context, listen: false).getBasketDetailDataController();
                              setState(()  {
                                widget.item.qty++;
                              });
                            }
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ):
          Row(
            children: [
              Center(
                child: Text(
                  "${widget.item.price.toString().replaceAll(".", ",")} €",
                  style: GoogleFonts.overpass(
                      color: Colors.black,
                      fontSize: 17,
                      fontWeight: FontWeight.w700),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(width: getSize(context, true, 10/415),),
              Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                    border: Border.all(color: BeysionColors.orange),
                    borderRadius: BorderRadius.circular(5)
                ),
                child: Row(
                  children: [
                    InkWell(
                      child: widget.item.qty != 1 ? Container(
                        width: getSize(context, true, 20 / 415),
                        height: getSize(context, true, 20 / 415),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, color: BeysionColors.yellow),
                        child: Center(child: Text("-", style: GoogleFonts.overpass(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),)),
                      ):Container(
                        width: getSize(context, true, 20 / 415),
                        height: getSize(context, true, 20 / 415),
                        child: Center(child: Icon(Icons.delete, color: BeysionColors.yellow, size: 18,)),
                      ) ,
                      onTap: () async {
                        if(widget.item.qty == 1){
                          BaseResponse basketService = await BasketService.operations().deleteBasketProduct(widget.item.aid);
                          if(basketService is OkResponse){
                            toastWidget("Das Produkt wurde aus dem Warenkorb gelöscht", Colors.red);
                            Provider.of<BasketProvider>(context, listen: false).getBasketDetailDataController();
                          }
                        }else{
                          if(widget.item.qty>1){
                            int quantity = widget.item.qty-1;
                            BaseResponse responseData = await BasketService.operations().basketUpdate(widget.item.aid, quantity);
                            if (responseData.body != null) {
                              if(responseData is OkResponse){
                                print('GÜNCELLEME BAŞARILIII');
                                Provider.of<BasketProvider>(context, listen: false).getBasketDetailDataController();
                                setState(()  {
                                  widget.item.qty--;
                                });
                              }
                            }
                          }

                        }
                      },
                    ),
                    Container(
                      alignment: Alignment.center,
                      width: getSize(context, true, 25 / 415),
                      height: getSize(context, true, 20 / 415),
                      child: Text(widget.item.qty.toString()),
                    ),
                    InkWell(
                      child: Container(
                        width: getSize(context, true, 20 / 415),
                        height: getSize(context, true, 20 / 415),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, color: BeysionColors.yellow),
                        child: Center(child: Text("+", style: GoogleFonts.overpass(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),)),
                      ),
                      onTap: () async {
                        int quantity = widget.item.qty+1;
                        BaseResponse responseData = await BasketService.operations().basketUpdate(widget.item.aid, quantity);
                        if (responseData.body != null) {
                          if(responseData is OkResponse){
                            print('GÜNCELLEME BAŞARILIII');
                            Provider.of<BasketProvider>(context, listen: false).getBasketDetailDataController();
                            setState(()  {
                              widget.item.qty++;
                            });
                          }
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}



/*
*
* if(settingRepo.basketSendDataEntity.value.basketSelect!=null){
                                print('*******SERVİCE TİME DOLU*****');
                                for(var merhaba in settingRepo.basketSendDataEntity.value.basketSelect){
                                  print('MID--  ${merhaba.mid}');
                                  print('SERVICETYPE  ${merhaba.serviceType}');
                                  print('TIMEE  ${merhaba.time}');
                                  print('********************');

                                }
                                if(settingRepo.basketSendDataEntity.value.basketSelect.length>0){
                                  for(var localBasketSelect in settingRepo.basketSendDataEntity.value.basketSelect){
                                    if(localBasketSelect.mid == mid){
                                      print('EŞLEŞTİİİ  {${widget.basketMarketInData.name}');
                                      settingRepo.basketSendDataEntity.value.basketSelect.remove(localBasketSelect);
                                      BasketProductSelect basketSelectNew = new BasketProductSelect();
                                      basketSelectNew.mid = mid;
                                      basketSelectNew.time = getDeliveryServiceTimes.date;
                                      basketSelectNew.serviceType = selectedDeliveryType.id;
                                      List<BasketProductSelect> dataAdded = new List();
                                      dataAdded = settingRepo.basketSendDataEntity.value.basketSelect;
                                      dataAdded.add(basketSelectNew);
                                      settingRepo.basketSendDataEntity.value.basketSelect = dataAdded;

                                      print('EKLEME BAŞARILIMIIIIIIIIIIIIIIIIIIIIII');
                                    } else {
                                      BasketProductSelect basketSelectNew = new BasketProductSelect();
                                      basketSelectNew.mid = mid;
                                      basketSelectNew.time = getDeliveryServiceTimes.date;
                                      basketSelectNew.serviceType = selectedDeliveryType.id;
                                      List<BasketProductSelect> dataAdded = new List();
                                      dataAdded = settingRepo.basketSendDataEntity.value.basketSelect;
                                      dataAdded.add(basketSelectNew);

                                      settingRepo.basketSendDataEntity.value.basketSelect = dataAdded;

                                      print('EŞLEŞT MEDİİ {${widget.basketMarketInData.name}');

                                    }
                                  }
                                }else{
                                  print('LENGTH 0 EKLENMEMİŞ');
                                  BasketProductSelect basketSelectNew = new BasketProductSelect();
                                  basketSelectNew.mid = mid;
                                  basketSelectNew.time = getDeliveryServiceTimes.date;
                                  basketSelectNew.serviceType = selectedDeliveryType.id;
                                  List<BasketProductSelect> dataAdded = new List();
                                  dataAdded = settingRepo.basketSendDataEntity.value.basketSelect;
                                  dataAdded.add(basketSelectNew);
                                  settingRepo.basketSendDataEntity.value.basketSelect = dataAdded;
                                }
                              }else{
                                print('NULL GELDİ SERVİCE TİME');

                                BasketProductSelect basketSelectNew = new BasketProductSelect();
                                basketSelectNew.mid = mid;
                                basketSelectNew.time = getDeliveryServiceTimes.date;
                                basketSelectNew.serviceType = selectedDeliveryType.id;
                                List<BasketProductSelect> dataAdded = new List();
                                dataAdded = settingRepo.basketSendDataEntity.value.basketSelect;
                                dataAdded.add(basketSelectNew);
                                settingRepo.basketSendDataEntity.value.basketSelect = dataAdded;

                                print('EKLEME BAŞARILI');
                              }*/