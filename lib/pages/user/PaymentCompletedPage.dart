import 'package:auto_size_text/auto_size_text.dart';
import 'package:beysion/Utility/Colors.dart';
import 'package:beysion/Utility/Icons.dart';
import 'package:beysion/Utility/Widgets.dart';
import 'package:beysion/Utility/util.dart';
import 'package:beysion/pages/user/MyOrderDetailPage.dart';
import 'package:beysion/rest/entity/user/basket/basket_to_accept_order_entity.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class PaymentCompletedPage extends StatefulWidget {
  List<BasketToAcceptOrderEntity> basketToAcceptOrderEntity;
  PaymentCompletedPage(this.basketToAcceptOrderEntity);
  @override
  _PaymentCompletedPageState createState() => _PaymentCompletedPageState();
}

class _PaymentCompletedPageState extends State<PaymentCompletedPage> {
  ScrollController _paymentListViewController;
  int allOrdersSelectedValue = 0;
  bool checkIncludeItems = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _paymentListViewController = ScrollController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _paymentListViewController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: Stack(
        children: [
          Padding(
              padding: EdgeInsets.symmetric(
                horizontal: getSize(context, true, 0 / 415),
              ),
              child: ListView(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                padding: EdgeInsets.symmetric(
                  //horizontal: getSize(context, true, 20 / 415),
                  vertical: getSize(context, true, 70 / 415),
                ),
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      left: getSize(context, true, 20 / 415),
                      top: getSize(context, true, 20 / 415),
                      bottom: getSize(context, true, 20 / 415),
                    ),
                    child: Text("Bestellerfolg"),
                  ),
                  Column(
                    children: [
                      buildContainer(
                          context,
                          Column(
                            children: [
                              Align(
                                child: Text(
                                  "Wir bedanken uns für Ihren Einkauf\nbeysi-on Team.",
                                  style: GoogleFonts.overpass(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w500,
                                      color: BeysionColors.greenDark),
                                ),
                                alignment: Alignment.centerLeft,
                              ),
                              Divider(),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Gesamt  (${widget.basketToAcceptOrderEntity.length} Produkt)"),
                                  Text("${widget.basketToAcceptOrderEntity[0].detail.basketTotal.toString().replaceAll(".", ",")} €"),
                                ],
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Gesamtliefergebühr (${widget.basketToAcceptOrderEntity.length} Markt)"),
                                  Text("${widget.basketToAcceptOrderEntity[0].cargoPrice.toString().replaceAll(".", ",")} €"),
                                ],
                              ),
                              Divider(),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Gesamtmenge"),
                                  Text("${widget.basketToAcceptOrderEntity[0].total.toString().replaceAll(".", ",")} €"),
                                ],
                              ),
                              SizedBox(
                                height: 40,
                              ),
                            ],
                          )),
                      SizedBox(
                        height: getSize(context, true, 15 / 415),
                      ),
                      ListView.builder(
                          shrinkWrap: true,
                          controller: _paymentListViewController,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: widget.basketToAcceptOrderEntity.length,
                          itemBuilder: (context, index){
                            return buildOrderDetail(context,widget.basketToAcceptOrderEntity[index]);
                          }),
                      SizedBox(
                        height: getSize(context, true, 15 / 415),
                      ),
                    ],
                  )
                ],
              )),
          buildMakeYourPaymentPageTopNavigationBar(context, 4)
        ],
      ),
    );
  }

  buildOrderDetail(BuildContext context, BasketToAcceptOrderEntity basketToAcceptOrderEntity) {
    return buildContainer(
        context,
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            SizedBox(
              height: getSize(context, true, 20 / 415),
            ),
            Row(
              children: [
                Expanded(
                    child: Text(
                  "Bestellnummer",
                  style: GoogleFonts.overpass(color: BeysionColors.blueNavy, fontSize: 16),
                )),
                Expanded(
                    child: Text(
                  "${basketToAcceptOrderEntity.ordercode}",
                  style: GoogleFonts.overpass(color: BeysionColors.blueNavy, fontSize: 16),
                )),
              ],
            ),
            Divider(),
            Row(
              children: [
                Expanded(
                    child: Text(
                  "Bestelldatum",
                  style: GoogleFonts.overpass(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w300),
                )),
                Expanded(
                    child: Text(
                  "${basketToAcceptOrderEntity.deliveryTime}",
                  style: GoogleFonts.overpass(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w300),
                )),
              ],
            ),
            SizedBox(
              height: getSize(context, true, 10 / 415),
            ),
            Row(
              children: [
                Expanded(
                    child: Text(
                  "Market Name",
                  style: GoogleFonts.overpass(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w300),
                )),
                Expanded(
                    child: Text(
                  "${basketToAcceptOrderEntity.detail.name}",
                  style: GoogleFonts.overpass(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w300),
                )),
              ],
            ),
            SizedBox(
              height: getSize(context, true, 10 / 415),
            ),
            Row(
              children: [
                Expanded(
                    child: Text(
                  "Adresse",
                  style: GoogleFonts.overpass(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w300),
                )),
                Expanded(
                    child: Text(
                  "${basketToAcceptOrderEntity.detail.fulladdress}",
                  style: GoogleFonts.overpass(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w300),
                )),
              ],
            ),
            Container(
              height: getSize(context, true, 30 / 415),
              margin: EdgeInsets.symmetric(
                  vertical: getSize(context, true, 20 / 415)),
              child: OutlineButton(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: 5),
                      child: Image.asset(
                        IconsPath.location,
                        height: getSize(context, true, 20 / 415),
                      ),
                    ),
                    Text(
                      "Karte öffnen",
                      style: GoogleFonts.overpass(
                          fontSize: 14, fontWeight: FontWeight.normal),
                    ),
                  ],
                ),
                onPressed: ()  async{
                  // TODO: openMap onTap
                  if (await canLaunch("${basketToAcceptOrderEntity.detail.mapUrl}")) {
                    await launch("${basketToAcceptOrderEntity.detail.mapUrl}");
                  }
                },
              ),
            ),
            Row(
              children: [
                Expanded(
                    child: Text(
                  "Gelieferter Typ",
                  style: GoogleFonts.overpass(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w300),
                )),
                Expanded(
                    child: Text(
                  "${basketToAcceptOrderEntity.detail.serviceTypeText}",
                  style: GoogleFonts.overpass(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w300),
                )),
              ],
            ),
            SizedBox(
              height: getSize(context, true, 10 / 415),
            ),
            Row(
              children: [
                Expanded(
                    child: Text(
                  "Lieferzeit",
                  style: GoogleFonts.overpass(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w300),
                )),
                Expanded(
                    child: Text(
                  "30 Min.",
                  style: GoogleFonts.overpass(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w300),
                )),
              ],
            ),
            SizedBox(
              height: getSize(context, true, 10 / 415),
            ),
            Row(
              children: [
                Expanded(
                    child: Text(
                  "Gesamtsumme",
                  style: GoogleFonts.overpass(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w700),
                )),
                Expanded(
                    child: Text(
                  "${basketToAcceptOrderEntity.detail.basketTotal.toString().replaceAll(".", ",")} € - ${basketToAcceptOrderEntity.detail.basket.length} Produkt ",
                  style: GoogleFonts.overpass(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w700),
                )),
              ],
            ),
            Container(
              height: getSize(context, true, 30 / 415),
              margin: EdgeInsets.symmetric(
                  vertical: getSize(context, true, 20 / 415)),
              child: OutlineButton(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: 5),
                      child: Image.asset(
                        IconsPath.list,
                        height: getSize(context, true, 20 / 415),
                      ),
                    ),
                    Text(
                      "Siehe Artikel",
                      style: GoogleFonts.overpass(
                          fontSize: 14, fontWeight: FontWeight.normal),
                    ),
                  ],
                ),
                onPressed: () {

                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MyOrderDetailPage(basketToAcceptOrderEntity.ordercode)));

                },
              ),
            ),
          ],
        ));
  }

  buildMakeYourPaymentPageTopNavigationBar(BuildContext context, int index) {
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        width: getSize(context, true, 1),
        height: getSize(context, true, 58 / 415),
        decoration: BoxDecoration(
          color: BeysionColors.blueNavy,
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: getSize(context, true, 20 / 415)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: getSize(context, true, 50 / 415),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Image.asset(IconsPath.basket,
                        width: getSize(context, true, 25 / 415),
                        height: getSize(context, true, 25 / 415),
                        color: BeysionColors.orange),
                  ],
                ),
              ),
              Container(
                width: getSize(context, true, 20 / 415),
                height: getSize(context, true, 50 / 415),
                margin: EdgeInsets.symmetric(
                    horizontal: getSize(context, true, 15 / 415)),
                child: Center(
                  child: FaIcon(
                    FontAwesomeIcons.chevronRight,
                    color: BeysionColors.overlay,
                    size: getSize(context, true, 15 / 415),
                  ),
                ),
              ),
              Container(
                width: getSize(context, true, 20 / 415),
                height: getSize(context, true, 50 / 415),
                child: Center(
                  child: FaIcon(
                    FontAwesomeIcons.checkCircle,
                    color: BeysionColors.orange,
                    size: getSize(context, true, 25 / 415),
                  ),
                ),
              ),
              Container(
                height: getSize(context, true, 50 / 415),
                margin: EdgeInsets.only(left: getSize(context, true, 15 / 415)),
                child: Center(
                  child: AutoSizeText(
                    "Die Zahlung ist abgeschlossen",
                    style: GoogleFonts.overpass(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w600),
                    minFontSize: 5,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
