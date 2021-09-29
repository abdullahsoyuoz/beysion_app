import 'package:beysion/Utility/Colors.dart';
import 'package:beysion/Utility/Icons.dart';
import 'package:beysion/Utility/util.dart';
import 'package:beysion/rest/controller/user/user_order_provider.dart';
import 'package:beysion/rest/entity/user/user_oder_detail_entity.dart';
import 'package:beysion/tabletPages/MainPageViewTablet.dart';
import 'package:beysion/utility/Widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'HomeTabletPage.dart';

class MyOrderDetailTabletPage extends StatefulWidget {
  String orderCode;
  MyOrderDetailTabletPage(this.orderCode);
  @override
  _MyOrderDetailTabletPageState createState() => _MyOrderDetailTabletPageState();
}

class _MyOrderDetailTabletPageState extends State<MyOrderDetailTabletPage> {

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
      appBar: buildAppBarTablet(context),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: getSize(context, true, 20 / 415),
              vertical: getSize(context, true, 10 / 415),
            ),
            child: Text("Bestelldetails", style: GoogleFonts.overpass(fontSize: 15, fontWeight: FontWeight.w600)),
          ),
          userOrderDetailEntity!=null && userOrderDetailEntity.detail!=null && userOrderDetailEntity.detail.ordercode!=null ?
          buildOrderCard(context, userOrderDetailEntity): SizedBox(),
          SizedBox(height: getSize(context, true, 20/415),),
          InkWell(
              onTap: (){
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => MainPageViewTablet()));
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
                              fontSize: 14, fontWeight: FontWeight.bold),
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
              EdgeInsets.symmetric(vertical: getSize(context, true, 5 / 415)),
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
                        "Bestellnummer", style: GoogleFonts.overpass(fontSize: 20, fontWeight: FontWeight.w600, color: BeysionColors.purple),
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: Row(
                        children: [
                          Text(
                            "${userOrderDetail!=null && userOrderDetail.detail.ordercode!=null ? userOrderDetail.detail.ordercode: "Load"}", style: GoogleFonts.overpass(fontSize: 20, fontWeight: FontWeight.w600, color: BeysionColors.purple),
                          ),
                          Container(
                            width: getSize(context, true, 85 / 415),
                            margin: EdgeInsets.only(
                                left: getSize(context, true, 10 / 415)),
                            decoration: BoxDecoration(
                                color: orderStatusColor(userOrderDetail),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5))),
                            child: Center(
                              child: Text(
                                "${orderStatusStr(userOrderDetail)}",
                                style:
                                    GoogleFonts.overpass(fontSize: 16, color: Colors.white),
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
                        "Bestelldatum", style: GoogleFonts.overpass(fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Text(
                        "${userOrderDetail!=null && userOrderDetail.detail.deliveryTime2 !=null ? userOrderDetail.detail.deliveryTime2 : "Load"}", style: GoogleFonts.overpass(fontSize: 16, fontWeight: FontWeight.w600),
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
                        "Market Name", style: GoogleFonts.overpass(fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Row(
                        children: [
                          Text(
                            "${userOrderDetail !=null && userOrderDetail.detail!=null ? userOrderDetail.detail.name: "Load"}", style: GoogleFonts.overpass(fontSize: 16, fontWeight: FontWeight.w600),
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
                      child: Text(
                        "Gelieferter Typ", style: GoogleFonts.overpass(fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Text(
                        "${userOrderDetail.detail!=null && userOrderDetail.detail.deliveryType!=null ? userOrderDetail.detail.deliveryType : "Load"}", style: GoogleFonts.overpass(fontSize: 16, fontWeight: FontWeight.w600),
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
                        "Gesamtmenge", style: GoogleFonts.overpass(fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Text(
                        "${userOrderDetail!=null && userOrderDetail.detail!=null ? userOrderDetail.detail.total : "Load"}", style: GoogleFonts.overpass(fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: getSize(context, true, 5 / 415),
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
                            height: getSize(context, true, 0 / 415),
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
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: getSize(context, true, 5/415)
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Produkte", style: GoogleFonts.overpass(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  Text(
                    "Menge", style: GoogleFonts.overpass(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
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
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        top: getSize(context, true, 2/415),
                        bottom: getSize(context, true, 2/415),
                        left: getSize(context, true, 2/415),
                        right: getSize(context, true, 2/415),
                      ),
                      child: Image.network(
                        item.image,
                        fit: BoxFit.fitHeight,
                        width: getSize(context, true, 50 / 415),
                        height: getSize(context, true, 50 / 415),
                      ),
                    ),
                    Expanded(
                      child: Text("${item.name}\n${item.price}",
                        maxLines: 3,
                        overflow: TextOverflow.fade,
                        softWrap: false,
                        style: GoogleFonts.overpass(
                          fontSize: 16,
                          fontWeight: FontWeight.w600
                        ),)
                    ),
                  ],
                ),
              ),
              Text("${item.qty}", style: GoogleFonts.overpass(
                  fontSize: 16,
                  fontWeight: FontWeight.w600
              )) ],
          ),
        ],
      ),
    );
  }
}

