import 'package:auto_size_text/auto_size_text.dart';
import 'package:beysion/Utility/Colors.dart';
import 'package:beysion/Utility/Icons.dart';
import 'package:beysion/Utility/util.dart';
import 'package:beysion/tabletPages/user/MyOrderDetailTabletPage.dart';
import 'package:beysion/rest/entity/user/basket/basket_to_accept_order_entity.dart';
import 'package:beysion/utility/Widgets.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class PaymentCompletedTabletPage extends StatefulWidget {
  List<BasketToAcceptOrderEntity> basketToAcceptOrderEntity;
  PaymentCompletedTabletPage(this.basketToAcceptOrderEntity);
  @override
  _PaymentCompletedTabletPageState createState() =>
      _PaymentCompletedTabletPageState();
}

class _PaymentCompletedTabletPageState
    extends State<PaymentCompletedTabletPage> {
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
      appBar: buildAppBarTablet(context),
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
                  vertical: getSize(context, true, 60 / 415),
                ),
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      left: getSize(context, true, 20 / 415),
                      top: getSize(context, true, 10 / 415),
                      bottom: getSize(context, true, 10 / 415),
                    ),
                    child: Text("Bestellerfolg",
                        style: GoogleFonts.overpass(
                            color: Colors.black,
                            fontSize: 17,
                            fontWeight: FontWeight.w600)),
                  ),
                  Column(
                    children: [
                      buildContainer(
                          context,
                          Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: getSize(context, true, 5/415)),
                                child: Align(
                                  child: Text(
                                    "Wir bedanken uns für Ihren Einkauf\nbeysi-on Team.",
                                    style: GoogleFonts.overpass(
                                        fontSize: 28,
                                        fontWeight: FontWeight.bold,
                                        color: BeysionColors.greenDark),
                                  ),
                                  alignment: Alignment.centerLeft,
                                ),
                              ),
                              Divider(),
                              SizedBox(height: getSize(context, true, 5/415),),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                      "Gesamt  (${widget.basketToAcceptOrderEntity.length} Produkt)", style: GoogleFonts.overpass(fontSize: 16, fontWeight: FontWeight.w500),),
                                  Text(
                                      "${widget.basketToAcceptOrderEntity[0].detail.basketTotal.toString().replaceAll(".", ",")} €", style: GoogleFonts.overpass(fontSize: 16, fontWeight: FontWeight.w500),),
                                ],
                              ),
                              SizedBox(height: getSize(context, true, 5/415),),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                      "Gesamtliefergebühr (${widget.basketToAcceptOrderEntity.length} Markt)", style: GoogleFonts.overpass(fontSize: 16, fontWeight: FontWeight.w500),),
                                  Text(
                                      "${widget.basketToAcceptOrderEntity[0].cargoPrice.toString().replaceAll(".", ",")} €", style: GoogleFonts.overpass(fontSize: 16, fontWeight: FontWeight.w500),),
                                ],
                              ),
                              SizedBox(height: getSize(context, true, 5/415),),
                              Divider(),
                              SizedBox(height: getSize(context, true, 5/415),),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Gesamtmenge", style: GoogleFonts.overpass(fontSize: 16, fontWeight: FontWeight.w500),),
                                  Text(
                                      "${widget.basketToAcceptOrderEntity[0].total.toString().replaceAll(".", ",")} €", style: GoogleFonts.overpass(fontSize: 16, fontWeight: FontWeight.w500),),
                                ],
                              ),
                              SizedBox(height: getSize(context, true, 5/415),),
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
                          itemBuilder: (context, index) {
                            return buildOrderDetail(context,
                                widget.basketToAcceptOrderEntity[index]);
                          }),
                    ],
                  )
                ],
              )),
          buildMakeYourPaymentPageTopNavigationBar(context, 3)
        ],
      ),
    );
  }

  buildOrderDetail(BuildContext context,
      BasketToAcceptOrderEntity basketToAcceptOrderEntity) {
    return buildContainer(
        context,
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            SizedBox(
              height: getSize(context, true, 5 / 415),
            ),
            Row(
              children: [
                Expanded(
                    child: Text("Bestellnummer", style: GoogleFonts.overpass(color: BeysionColors.purple, fontSize: 20, fontWeight: FontWeight.w500),),
                ),
                Expanded(
                    child: Text(
                  "${basketToAcceptOrderEntity.ordercode}", style: GoogleFonts.overpass(fontSize: 20, fontWeight: FontWeight.w500, color: BeysionColors.purple),
                )),
              ],
            ),
            Divider(),
            Row(
              children: [
                Expanded(
                    child: Text(
                  "Bestelldatum", style: GoogleFonts.overpass(fontSize: 16, fontWeight: FontWeight.w500),
                )),
                Expanded(
                    child: Text(
                  "${basketToAcceptOrderEntity.deliveryTime}", style: GoogleFonts.overpass(fontSize: 16, fontWeight: FontWeight.w500),
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
                  "Market Name", style: GoogleFonts.overpass(fontSize: 16, fontWeight: FontWeight.w500),
                )),
                Expanded(
                    child: Text(
                  "${basketToAcceptOrderEntity.detail.name}", style: GoogleFonts.overpass(fontSize: 16, fontWeight: FontWeight.w500),
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
                  "Adresse", style: GoogleFonts.overpass(fontSize: 16, fontWeight: FontWeight.w500),
                )),
                Expanded(
                    child: Text(
                  "${basketToAcceptOrderEntity.detail.fulladdress}", style: GoogleFonts.overpass(fontSize: 16, fontWeight: FontWeight.w500),
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
                      "Karte öffnen", style: GoogleFonts.overpass(fontSize: 20, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                onPressed: () async {
                  // TODO: openMap onTap
                  if (await canLaunch(
                      "${basketToAcceptOrderEntity.detail.mapUrl}")) {
                    await launch("${basketToAcceptOrderEntity.detail.mapUrl}");
                  }
                },
              ),
            ),
            Row(
              children: [
                Expanded(
                    child: Text(
                  "Gelieferter Typ", style: GoogleFonts.overpass(fontSize: 16, fontWeight: FontWeight.w500),
                )),
                Expanded(
                    child: Text(
                  "${basketToAcceptOrderEntity.detail.serviceTypeText}", style: GoogleFonts.overpass(fontSize: 16, fontWeight: FontWeight.w500),
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
                  "Lieferzeit", style: GoogleFonts.overpass(fontSize: 16, fontWeight: FontWeight.w500),
                )),
                Expanded(
                    child: Text(
                  "30 Min.", style: GoogleFonts.overpass(fontSize: 16, fontWeight: FontWeight.w500),
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
                  "Gesamtsumme", style: GoogleFonts.overpass(fontSize: 16, fontWeight: FontWeight.w700),
                )),
                Expanded(
                    child: Text(
                  "${basketToAcceptOrderEntity.detail.basketTotal.toString().replaceAll(".", ",")} € - ${basketToAcceptOrderEntity.detail.basket.length} Produkt ", style: GoogleFonts.overpass(fontSize: 16, fontWeight: FontWeight.w700),
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
                      "Siehe Artikel", style: GoogleFonts.overpass(fontSize: 20, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MyOrderDetailTabletPage(
                              basketToAcceptOrderEntity.ordercode)));
                },
              ),
            ),
          ],
        ),
      bottomMargin: getSize(context, true, 10/415)
    );
  }

  buildMakeYourPaymentPageTopNavigationBar(BuildContext context, int index) {
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        width: getSize(context, true, 1),
        height: getSize(context, true, 40 / 415),
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
              Image.asset(IconsPath.basket,
                  width: getSize(context, true, 15 / 415),
                  height: getSize(context, true, 15 / 415),
                  color: BeysionColors.orange),
              SizedBox(width: getSize(context, true, 5/415),),
              FaIcon(
                FontAwesomeIcons.chevronRight,
                color: BeysionColors.overlay,
                size: getSize(context, true, 15 / 415),
              ),
              SizedBox(width: getSize(context, true, 5/415),),
              FaIcon(
                FontAwesomeIcons.checkCircle,
                color: BeysionColors.orange,
                size: getSize(context, true, 25 / 415),
              ),
              SizedBox(width: getSize(context, true, 5/415),),
              AutoSizeText(
                "Die Zahlung ist abgeschlossen",
                style: GoogleFonts.overpass(
                    color: index == 3 ? Colors.white : BeysionColors.overlay,
                    fontSize: 16),
                minFontSize: 5,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
