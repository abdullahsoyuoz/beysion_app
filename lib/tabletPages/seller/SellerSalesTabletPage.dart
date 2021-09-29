import 'package:beysion/Utility/Colors.dart';
import 'package:beysion/Utility/FakeData.dart';
import 'package:beysion/Utility/Icons.dart';
import 'package:beysion/Utility/util.dart';
import 'package:beysion/constant/colors_theme_widget.dart';
import 'package:beysion/rest/controller/seller/seller_order_provider.dart';
import 'package:beysion/rest/entity/seller/seller_entity.dart';
import 'package:beysion/utility/Widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'SellerSalesDetailTabletPage.dart';

class SellerSalesTabletPage extends StatefulWidget {
  @override
  _SellerSalesTabletPageState createState() => _SellerSalesTabletPageState();
}

class _SellerSalesTabletPageState extends State<SellerSalesTabletPage> {
  TextEditingController _searchTextFormField = new TextEditingController();
  ScrollController _myOrdersListViewController;
  var selectedItem = 0;
  var selectedAppBarMarketItem = 0;
  int statusOrder = 0;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      Provider.of<SellerOrderProvider>(context, listen: false)
          .getSellerOrdersListDataController(
              page: 0, orderCode: "", status: statusOrder);
    });
  }

  @override
  Widget build(BuildContext context) {
    List<SellerOrderData> sellerOrderDataList =
        Provider.of<SellerOrderProvider>(context, listen: true).sellerOrderList;
    return Scaffold(
      appBar: buildAppBarSellerTablet(context),
      body: buildBody(context, sellerOrderDataList),
    );
  }

  buildBody(BuildContext context, List<SellerOrderData> sellerOrderDataList) {
    return SingleChildScrollView(
      padding: EdgeInsets.only(
          left: getSize(context, true, 20 / 415),
          right: getSize(context, true, 20 / 415),
          top: getSize(context, true, 10 / 415)),
      child: Column(
        children: [
          buildHeader(context),
          ListView.builder(
              controller: _myOrdersListViewController,
              shrinkWrap: true,
              itemCount: sellerOrderDataList.length,
              physics: NeverScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                return buildOrderCard(context, sellerOrderDataList[index]);
              }),
          sellerOrderDataList.length > 0
              ? Container(
                  width: getSize(context, true, 100 / 415),
                  margin: EdgeInsets.only(bottom: 20),
                  child: FlatButton(
                      color: BeysionColors.orange,
                      onPressed: () {
                        Provider.of<SellerOrderProvider>(context, listen: false)
                            .getSellerOrdersListDataController(
                                page: -1, orderCode: "", status: statusOrder);
                      },
                      child: Center(
                        child: Text(
                          "MEHR SALES",
                          style: GoogleFonts.overpass(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                      )),
                )
              : SizedBox(),
          /*ListView(
            controller: _myOrdersListViewController,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            scrollDirection: Axis.vertical,
            children: [
              buildOrderCard(context, FakeData.orders1),
              buildOrderCard(context, FakeData.orders2),
              buildOrderCard(context, FakeData.orders3),
              buildOrderCard(context, FakeData.orders4),
            ],
          )*/
        ],
      ),
    );
  }

  buildHeader(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: getSize(context, true, 10 / 415)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: getSize(context, true, 5 / 415)),
            child: Text(
              "Der Umsatz",
              style: GoogleFonts.overpass(
                  fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ),
          Column(
            children: [
              Container(
                height: getSize(context, true, 30 / 415),
                padding: EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    border:
                        Border.all(color: BeysionColors.border, width: 1)),
                child: Row(
                  children: [
                    Expanded(
                      child: DropdownButton(
                          icon: SizedBox(),
                          style: GoogleFonts.overpass(fontSize: 14, color: Colors.black),
                          underline: SizedBox(),
                          items: [
                            DropdownMenuItem(value: 0, child: Text("Alle Status")),
                            DropdownMenuItem(value: 1, child: Text("warten auf die Bestätigung")),
                            DropdownMenuItem(value: 2, child: Text("wird vorbereitet")),
                            DropdownMenuItem(value: 3, child: Text("Abholbereit / Versandbereit")),
                            DropdownMenuItem(value: 4, child: Text("Abgeschlossen")),
                            DropdownMenuItem(value: 5, child: Text("Warten auf Bestätigung des Käufers")),
                            DropdownMenuItem(value: 6, child: Text("Stornierungsanfrage")),
                            DropdownMenuItem(value: 7, child: Text("Im Rückblick")),
                          ],
                          onChanged: (value) {
                            setState(() {
                              statusOrder = value;
                              Provider.of<SellerOrderProvider>(context,
                                      listen: false)
                                  .getSellerOrdersListDataController(
                                      page: 0,
                                      orderCode: "",
                                      status: statusOrder);
                            });
                          },
                          value: statusOrder),
                    ),
                    Icon(Icons.keyboard_arrow_down, color: BeysionColors.orange,)
                  ],
                ),
              ),
              Container(
                height: getSize(context, true, 30 / 415),
                margin: EdgeInsets.only(top: 10),
                padding: EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    border:
                        Border.all(color: BeysionColors.border, width: 1)),
                child: TextFormField(
                  controller: _searchTextFormField,
                  onChanged: (searchStr) {
                    if (searchStr.length > 4) {
                      Provider.of<SellerOrderProvider>(context, listen: false)
                          .getSellerOrdersListDataController(
                              page: 0,
                              orderCode: searchStr,
                              status: statusOrder);
                    } else {
                      Provider.of<SellerOrderProvider>(context, listen: false)
                          .getSellerOrdersListDataController(
                              page: 0, orderCode: "", status: statusOrder);
                    }
                  },
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      suffixIcon: Padding(
                        padding: const EdgeInsets.only(left: 8, top: 8, bottom: 8),
                        child: Icon(
                          Icons.search,
                          color: BeysionColors.yellow,
                        ),
                      ),
                      hintText: "Suchreihenfolge",
                      hintStyle: GoogleFonts.overpass(
                        color: BeysionColors.gray1,
                        fontSize: 15,
                      )),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  buildOrderCard(BuildContext context, SellerOrderData sellerOrderData) {
    return InkWell(
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      child: Container(
        margin: EdgeInsets.only(
          bottom: getSize(context, true, 10 / 415),
        ),
        padding: EdgeInsets.symmetric(
          vertical: getSize(context, true, 5 / 415),
          horizontal: getSize(context, true, 10 / 415),
        ),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(5)),
            border: Border.all(color: BeysionColors.border, width: 1)),
        child: Container(
          width: getSize(context, true, 1),
          child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Bestellnummer:   ${sellerOrderData.ordercode}",
                        style: GoogleFonts.overpass(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: BeysionColors.blueNavy),
                      ),
                      Container(
                        width: getSize(context, true, 170 / 415),
                        margin: EdgeInsets.only(
                            left: getSize(context, true, 10 / 415)),
                        decoration: BoxDecoration(
                            color: orderStatusColor(sellerOrderData),
                            borderRadius: BorderRadius.all(Radius.circular(5))),
                        child: Center(
                          child: Text(
                            "${orderStatusStr(sellerOrderData)}",
                            style: GoogleFonts.overpass(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.white),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
              Divider(
                color: BeysionColors.gray1,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 1,
                    child: Text(
                      "Bestelldatum",
                      style: GoogleFonts.overpass(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Row(
                      children: [
                        Text(
                          "${sellerOrderData.deliveryTime2}",
                          style: GoogleFonts.overpass(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(
                height: getSize(context, true, 8 / 415),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 1,
                    child: Text("Clients",
                        style: GoogleFonts.overpass(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        )),
                  ),
                  Expanded(
                    flex: 1,
                    child: Row(
                      children: [
                        Text("${sellerOrderData.name}",
                            style: GoogleFonts.overpass(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            )),
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(
                height: getSize(context, true, 8 / 415),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 1,
                    child: Text("Gelieferter Typ",
                        style: GoogleFonts.overpass(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        )),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text("${sellerOrderData.deliveryType}",
                        style: GoogleFonts.overpass(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        )),
                  )
                ],
              ),
              SizedBox(
                height: getSize(context, true, 8 / 415),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 1,
                    child: Text("Gesamtmenge",
                        style: GoogleFonts.overpass(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        )),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text(
                        "€ ${sellerOrderData.total.toString().replaceAll(("."), ",")} - ${sellerOrderData.totalItem} Items",
                        style: GoogleFonts.overpass(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        )),
                  )
                ],
              ),
              SizedBox(
                height: getSize(context, true, 8 / 415),
              ),
              Divider(
                color: BeysionColors.gray1,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          width: getSize(context, true, 30 / 415),
                          height: getSize(context, true, 25 / 415),
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(IconsPath.basket))),
                        ),
                        Text("Bestell-Details",
                            style: GoogleFonts.overpass(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ))
                      ],
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SellerSalesDetailTabletPage(
                                  sellerOrderData.ordercode)));
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      ),
      onTap: () {},
    );
  }

  String orderStatusStr(SellerOrderData orderEntity) {
    try {
      if (orderEntity.status == 0) {
        return "warten auf die Bestätigung";
      } else if (orderEntity.status == 1) {
        return "wird vorbereitet";
      } else if (orderEntity.status == 2) {
        return "Abholbereit / Versandbereit";
      } else if (orderEntity.status == 3) {
        return "wird vorbereitet";
      } else if (orderEntity.status == 4) {
        return "Bestellung storniert";
      } else {
        return " ";
      }
    } catch (e) {
      return "StatusNull";
    }
  }

  Color orderStatusColor(SellerOrderData orderEntity) {
    try {
      if (orderEntity.status == 0) {
        return Color(getColorHexFromStr("#5D68CC"));
      } else if (orderEntity.status == 1) {
        return Color(getColorHexFromStr("#FFC934"));
      } else if (orderEntity.status == 2) {
        return Color(getColorHexFromStr("#1EC1FF"));
      } else if (orderEntity.status == 3) {
        return Color(getColorHexFromStr("#1EC1FF"));
      } else if (orderEntity.status == 4) {
        return Color(getColorHexFromStr("#e41200"));
      } else {
        return Colors.white;
      }
    } catch (e) {
      return Colors.white;
    }
  }
}
