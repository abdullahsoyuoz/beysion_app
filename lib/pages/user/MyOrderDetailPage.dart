import 'package:beysion/Utility/Colors.dart';
import 'package:beysion/Utility/FakeData.dart';
import 'package:beysion/Utility/Icons.dart';
import 'package:beysion/Utility/Widgets.dart';
import 'package:beysion/Utility/util.dart';
import 'package:beysion/pages/MainPageView.dart';
import 'package:beysion/rest/controller/user/user_order_provider.dart';
import 'package:beysion/rest/entity/user/user_oder_detail_entity.dart';
import 'package:beysion/tabletPages/MainPageViewTablet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'HomePage.dart';

class MyOrderDetailPage extends StatefulWidget {
  String orderCode;
  MyOrderDetailPage(this.orderCode);
  @override
  _MyOrderDetailPageState createState() => _MyOrderDetailPageState();
}

class _MyOrderDetailPageState extends State<MyOrderDetailPage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('ORDER CODEE ${widget.orderCode}');
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      Provider.of<UserOrderProvider>(context, listen: false).getUserOrderShowDataController(widget.orderCode);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: buildBody(context),
    );
  }

  String orderStatusStr(UserOrderDetailEntity orderDetailEntity){
    try{
      return orderDetailEntity.detail.status == 0
          ? "WAITING"
          : orderDetailEntity.detail.status == 1
          ? "PREPARING"
          : orderDetailEntity.detail.status == 2
          ? "READY"
          : orderDetailEntity.detail.status == 3
          ? "WAS DELIVERED"
          : "state_null";
    }catch(e){
      return "StatusNull";
    }
  }

  Color orderStatusColor(UserOrderDetailEntity orderDetailEntity){
    try{
      return orderDetailEntity.detail.status == 0
          ? BeysionColors.orderState0
          : orderDetailEntity.detail.status == 1
          ? BeysionColors.orderState1
          : orderDetailEntity.detail.status == 2
          ? BeysionColors.orderState2
          : orderDetailEntity.detail.status == 3
          ? BeysionColors.orderState3
          : Colors.white;
    }catch(e){
      return Colors.white;
    }
  }

  buildBody(BuildContext context) {
    UserOrderDetailEntity userOrderDetailEntity = Provider.of<UserOrderProvider>(context, listen: true).userOrderDetailEntity;
    return SingleChildScrollView(
      // padding: EdgeInsets.symmetric(
      //   horizontal: getSize(context, true, 20 / 415),
      //   vertical: getSize(context, true, 18 / 415),
      // ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: getSize(context, true, 20 / 415),
              vertical: getSize(context, true, 18 / 415),
            ),
            child: Text("Bestelldetails"),
          ),
          userOrderDetailEntity!=null ?
          buildOrderCard(context, userOrderDetailEntity): SizedBox(),
          SizedBox(height: getSize(context, true, 20/415),),
          InkWell(
              onTap: (){
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => MainPageView()));
              },
              child: Center(child: Text("Kehren Sie zum Startbildschirm zurück"))),
          SizedBox(height: getSize(context, true, 20/415),),
          userOrderDetailEntity.products!=null ?
          buildList(context,userOrderDetailEntity.products):SizedBox(),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: getSize(context, true, 20 / 415),
              vertical: getSize(context, true, 18 / 415),
            ),
            child: Align(
              alignment: Alignment.centerRight,
              child: Container(
                width: getSize(context, true, 150 / 415),
                height: getSize(context, true, 25 / 415),
                child: OutlineButton(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(right: 5),
                        child: Image.asset(IconsPath.pdf),
                      ),
                      Expanded(
                        child: Text(
                          "Aussicht",
                          style: GoogleFonts.overpass(
                              fontSize: 14, fontWeight: FontWeight.normal),
                        ),
                      ),
                    ],
                  ),
                  onPressed: () {},
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  buildOrderCard(BuildContext context, UserOrderDetailEntity userOrderDetail) {
    return buildContainer(
        context,
        Padding(
          padding:
              EdgeInsets.symmetric(vertical: getSize(context, true, 10 / 415)),
          child: Container(
            width: getSize(context, true, 1),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      flex: 1,
                      child: Text(
                        "Bestellnummer",
                        style: GoogleFonts.overpass(
                            fontSize: 14, color: BeysionColors.blueNavy),
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: Row(
                        children: [
                          Text(
                            "${userOrderDetail!=null && userOrderDetail.detail!=null && userOrderDetail.detail.ordercode!=null ? userOrderDetail.detail.ordercode: "Load"}",
                            style: GoogleFonts.overpass(
                                fontSize: 14, color: BeysionColors.blueNavy),
                          ),
                          Expanded(
                            child: FittedBox(
                              child: Container(
                                width: getSize(context, true, 85 / 415),
                                height: getSize(context, true, 24 / 415),
                                margin: EdgeInsets.only(
                                    left: getSize(context, true, 10 / 415)),
                                decoration: BoxDecoration(
                                    color: orderStatusColor(userOrderDetail),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(2))),
                                child: Center(
                                  child: Text(
                                    "${orderStatusStr(userOrderDetail)}",
                                    style:
                                        GoogleFonts.overpass(fontSize: 8, color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
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
                            fontSize: 12,
                            color: Colors.black,
                            fontWeight: FontWeight.w300),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Text(
                        "${userOrderDetail!=null && userOrderDetail.detail!=null && userOrderDetail.detail.deliveryTime2 !=null ? userOrderDetail.detail.deliveryTime2 : "Load"}",
                        style: GoogleFonts.overpass(
                            fontSize: 12,
                            color: Colors.black,
                            fontWeight: FontWeight.w300),
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
                      child: Text(
                        "Market Name",
                        style: GoogleFonts.overpass(
                            fontSize: 12,
                            color: Colors.black,
                            fontWeight: FontWeight.w300),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Row(
                        children: [
                          Text(
                            "${userOrderDetail !=null && userOrderDetail.detail!=null && userOrderDetail.detail.name!=null? userOrderDetail.detail.name: "Load"}",
                            style: GoogleFonts.overpass(
                                fontSize: 12,
                                color: Colors.black,
                                fontWeight: FontWeight.w300),
                          ),
/*
                          Container(
                            width: getSize(context, true, 30 / 415),
                            height: getSize(context, true, 20 / 415),
                            margin: EdgeInsets.only(
                                left: getSize(context, true, 10 / 415)),
                            decoration: BoxDecoration(
                                color: userOrderDetail.marketRank > 9.5
                                    ? BeysionColors.rank1
                                    : userOrderDetail.marketRank > 9.0
                                        ? BeysionColors.rank2
                                        : userOrderDetail.marketRank > 8.5
                                            ? BeysionColors.rank3
                                            : userOrderDetail.marketRank > 8.0
                                                ? BeysionColors.rank4
                                                : userOrderDetail.marketRank < 8.0
                                                    ? BeysionColors.rank5
                                                    : Colors.red,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(2))),
                            child: Center(
                              child: Text(
                                "${userOrderDetail.marketRank.toString()}",
                                style: GoogleFonts.overpass(
                                    fontSize: 10,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w300),
                              ),
                            ),
                          )
*/
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
                      child: Text(
                        "Gelieferter Typ",
                        style: GoogleFonts.overpass(
                            fontSize: 12,
                            color: Colors.black,
                            fontWeight: FontWeight.w300),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Text(
                        "${userOrderDetail.detail!=null && userOrderDetail.detail.deliveryType!=null ? userOrderDetail.detail.deliveryType : "Load"}",
                        style: GoogleFonts.overpass(
                            fontSize: 12,
                            color: Colors.black,
                            fontWeight: FontWeight.w300),
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
                      child: Text(
                        "Gesamtmenge",
                        style: GoogleFonts.overpass(
                            fontSize: 12,
                            color: Colors.black,
                            fontWeight: FontWeight.w300),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Text(
                        "${userOrderDetail!=null && userOrderDetail.detail!=null ? userOrderDetail.detail.total : "Load"}",
                        style: GoogleFonts.overpass(
                            fontSize: 12,
                            color: Colors.black,
                            fontWeight: FontWeight.w300),
                      ),
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
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    userOrderDetail.detail.status == 3
                        ? InkWell(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Container(
                                  width: getSize(context, true, 30 / 415),
                                  height: getSize(context, true, 25 / 415),
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage(IconsPath.repeat))),
                                ),
                                Container(
                                  width: getSize(context, true, 100 / 415),
                                  height: getSize(context, true, 25 / 415),
                                  padding: EdgeInsets.only(
                                      left: getSize(context, true, 5 / 415)),
                                  child: Center(
                                    child: Text("Order Again",
                                        style: GoogleFonts.overpass(
                                            fontSize: 12,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w300)),
                                  ),
                                )
                              ],
                            ),
                            onTap: () {
                              // FIXME: order Again !!!
                            },
                          )
                        : SizedBox(
                            width: getSize(context, true, 100 / 415),
                            height: getSize(context, true, 25 / 415),
                          ),
                  ],
                )
              ],
            ),
          ),
        ));
  }

  buildList(BuildContext context, List<Product> orderProductList) {
    return buildContainer(
        context,
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Produkte",
                  style: GoogleFonts.overpass(fontWeight: FontWeight.w300),
                ),
                Text(
                  "Menge",
                  style: GoogleFonts.overpass(fontWeight: FontWeight.w300),
                ),
              ],
            ),
            ListView(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              children: orderProductList.map((productEntity) => BuildListInProductItem(productEntity)).toList(),
            )
          ],
        ));
  }
}

class BuildListInProductItem extends StatelessWidget {
  Product item;
  BuildListInProductItem(this.item);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: getSize(context, true, 1),
      height: getSize(context, true, 105/415),
      child: Column(
        children: [
          Divider(
            color: BeysionColors.gray2,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                flex: 3,
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Image.network(
                        item.image,
                        fit: BoxFit.fitHeight,
                        width: getSize(context, true, 50 / 415),
                        height: getSize(context, true, 50 / 415),
                      ),
                    ),
                    Expanded(child: Text("${item.name}\n${item.price}")),
                  ],
                ),
              ),
              Text("${item.qty}") ],
          ),
        ],
      ),
    );
  }
}

