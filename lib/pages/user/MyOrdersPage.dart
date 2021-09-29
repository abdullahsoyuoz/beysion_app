import 'package:beysion/Utility/Colors.dart';
import 'package:beysion/Utility/FakeData.dart';
import 'package:beysion/Utility/Icons.dart';
import 'package:beysion/Utility/Widgets.dart';
import 'package:beysion/Utility/util.dart';
import 'package:beysion/rest/controller/user/user_order_provider.dart';
import 'package:beysion/rest/entity/user/user_order_entity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

import 'MyOrderDetailPage.dart';

class MyOrdersPage extends StatefulWidget {
  @override
  _MyOrdersPageState createState() => _MyOrdersPageState();
}

class _MyOrdersPageState extends State<MyOrdersPage> {
  TextEditingController _searchTextFormField;
  ScrollController _myOrdersListViewController;
  var selectedItem = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      Provider.of<UserOrderProvider>(context, listen: false).getOrdersListDataController();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: buildBody(context),
    );
  }

  buildBody(BuildContext context) {
    List<UserOrderEntity> userOrderDataList = Provider.of<UserOrderProvider>(context, listen: true).userOrderList;
    return SingleChildScrollView(
      padding: EdgeInsets.only(
          left: getSize(context, true, 22 / 415),
          right: getSize(context, true, 22 / 415),
          top: getSize(context, true, 19.5 / 415)),
      child: Column(
        children: [
          buildHeader(context),
          ListView(
            controller: _myOrdersListViewController,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            scrollDirection: Axis.vertical,
            children: userOrderDataList.map((orderEntity) => BuildOrderCard(orderEntity),).toList(),
          ),
          userOrderDataList.length>0?
          Padding(
            padding: const EdgeInsets.only(bottom: 32.0),
            child: FittedBox(
              child: RaisedButton(
                color: BeysionColors.yellow,
                child: Center(
                    child: Text(
                      "Mehr Order",
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                    )),
                onPressed: () {
                  Provider.of<UserOrderProvider>(context, listen: false).getOrdersListDataController(page: -1);
                },
              ),
            ),
          ): SizedBox(),
        ],
      ),
    );
  }

  buildHeader(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: getSize(context, true, 15 / 415)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: getSize(context, true, 15 / 415)),
            child: Text("Bestellungen", style: GoogleFonts.overpass(),),
          ),
          buildHeaderController(context),
        ],
      ),
    );
  }

  buildHeaderController(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: getSize(context, true, 235 / 415),
          height: getSize(context, true, 31 / 415),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(5)),
            border: Border.all(
                color: BeysionColors.border.withOpacity(0.5), width: 1),
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
                          horizontal: getSize(context, true, 10 / 415)),
                      border: InputBorder.none,
                      suffixIcon: SizedBox(),
                      suffix: SizedBox(),
                      isCollapsed: true,
                      hintText: "Search",
                      hintStyle: GoogleFonts.overpass(
                        color: BeysionColors.gray1,
                        fontSize: 15,
                      )),
                ),
              ),
              Padding(
                padding:
                    EdgeInsets.only(right: getSize(context, true, 10 / 415)),
                child: Image.asset(IconsPath.search),
              )
            ],
          ),
        ),
        Container(
          width: getSize(context, true, 120 / 415),
          height: getSize(context, true, 31 / 415),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(5)),
              border: Border.all(
                  color: BeysionColors.border, width: 1)),
          child: Center(
            child: Padding(
              padding:
              EdgeInsets.all(getSize(context, true, 2 / 415)),
              child: DropdownButton(
                  icon: Padding(
                    padding: EdgeInsets.only(
                        left: getSize(context, true, 4 / 415)),
                    child: Image.asset(IconsPath.dropArrow),
                  ),
                  iconEnabledColor: BeysionColors.yellow,
                  style: GoogleFonts.overpass(
                      fontSize: 14, color: Colors.black),
                  underline: SizedBox(),
                  items: [
                    DropdownMenuItem(
                        value: 0, child: Text("Zeige: alles")),
                    DropdownMenuItem(
                        value: 1, child: Text("Zeige: alles*")),
                  ],
                  onChanged: (value) {
                    setState(() {
                      selectedItem = value;
                    });
                  },
                  value: selectedItem),
            ),
          ),
        ),
      ],
    );
  }

}

class BuildOrderCard extends StatefulWidget {
  UserOrderEntity orderEntity;
  BuildOrderCard(this.orderEntity);

  @override
  _BuildOrderCardState createState() => _BuildOrderCardState();
}

class _BuildOrderCardState extends State<BuildOrderCard> {

  double rate = 2;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        margin: EdgeInsets.only(
          bottom: getSize(context, true, 20 / 415),
          // left: getSize(context, true, 20 / 415),
          // right: getSize(context, true, 20 / 415),
        ),
        padding: EdgeInsets.symmetric(
          vertical: getSize(context, true, 5 / 415),
          horizontal: getSize(context, true, 10 / 415),
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(5)),
          border:
          Border.all(color: BeysionColors.border.withOpacity(0.5), width: 1),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
              vertical: getSize(context, true, 10 / 415)),
          child: Container(
            width: getSize(context, true, 1),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Bestellnummer",
                  style: GoogleFonts.overpass(
                      fontSize: 15, fontWeight: FontWeight.w700, color: BeysionColors.blueNavy),
                ),
                Text(
                  "${widget.orderEntity.ordercode}",
                  style: GoogleFonts.overpass(
                      fontSize: 15, fontWeight: FontWeight.w600, color: BeysionColors.blueNavy),
                ),
                FittedBox(
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      vertical: 5,
                      horizontal: 16,
                    ),
                    decoration: BoxDecoration(
                        color: orderStatusColor(widget.orderEntity),
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                    child: Center(
                      child: Text(
                        orderStatusStr(widget.orderEntity),
                        style: GoogleFonts.overpass(fontSize: 12, color: Colors.white),
                      ),
                    ),
                  ),
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
                        "${widget.orderEntity.deliveryTime2}",
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
                            "${widget.orderEntity.name}",
                            style: GoogleFonts.overpass(
                                fontSize: 12,
                                color: Colors.black,
                                fontWeight: FontWeight.w300),
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
                        "${widget.orderEntity.deliveryType}",
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
                        "${widget.orderEntity.total}",
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
                    widget.orderEntity.status == 3
                        ? InkWell(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            width: getSize(context, true, 30 / 415),
                            height: getSize(context, true, 25 / 415),
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(
                                        IconsPath.repeat))),
                          ),
                          Container(
                            width: getSize(context, true, 100 / 415),
                            height: getSize(context, true, 25 / 415),
                            padding: EdgeInsets.only(
                                left:
                                getSize(context, true, 5 / 415)),
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
                          Container(
                            width: getSize(context, true, 100 / 415),
                            height: getSize(context, true, 25 / 415),
                            padding: EdgeInsets.only(
                                left: getSize(context, true, 5 / 415)),
                            child: Center(
                              child: Text("Inhalt zeigen",
                                  style: GoogleFonts.overpass(
                                      fontSize: 12,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w300)),
                            ),
                          )
                        ],
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MyOrderDetailPage(widget.orderEntity.ordercode)));
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),

      onTap: () {
        showDialog(
            context: context,
            builder: (context) => StatefulBuilder(
              builder: (
                  context,
                  setState,
                  ) {
                double width = getSize(context, true, 373 / 415);
                double height = getSize(context, true, 535 / 415);
                return Dialog(
                  child: FittedBox(
                    fit: BoxFit.fitHeight,
                    child: Container(
                      width: width,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10))),

                      child: Container(
                        width: getSize(context, true, 1),
                        margin: EdgeInsets.symmetric(
                          horizontal: getSize(context, true, 15 / 415),
                          vertical: getSize(context, true, 20 / 415),
                        ),
                        decoration:
                        BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10))),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Align(
                                alignment: Alignment.centerRight,
                                child: IconButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  icon: Image.asset(
                                    IconsPath.x,
                                    width: getSize(context, true, 20 / 415),
                                    height: getSize(context, true, 20 / 415),
                                  ),
                                )),
                            Text(
                              "Are you satisfied with the order?",
                              style: GoogleFonts.overpass(fontSize: 19, fontWeight: FontWeight.w300),
                            ),
                            Divider(
                              color: BeysionColors.gray2,
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
                                    "${widget.orderEntity.deliveryTime2}",
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
                                        "${widget.orderEntity.name}",
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
                            color: item.marketRank > 9.5
                                ? BeysionColors.rank1
                                : item.marketRank > 9.0
                                    ? BeysionColors.rank2
                                    : item.marketRank > 8.5
                                        ? BeysionColors.rank3
                                        : item.marketRank > 8.0
                                            ? BeysionColors.rank4
                                            : item.marketRank < 8.0
                                                ? BeysionColors.rank5
                                                : Colors.red,
                            borderRadius: BorderRadius.all(Radius.circular(2))),
                        child: Center(
                          child: Text(
                            "${item.marketRank.toString()}",
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
                                    "${widget.orderEntity.deliveryType}",
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
                                    "${widget.orderEntity.total}",
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
                              color: BeysionColors.gray2,
                            ),
                            Text(
                              "Reaktionszeit",
                              style: GoogleFonts.overpass(fontSize: 16, fontWeight: FontWeight.w300),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "1",
                                  style: GoogleFonts.overpass(
                                      fontSize: 12,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w300),
                                ),
                                SmoothStarRating(
                                  starCount: 10,
                                  rating: rate,
                                  isReadOnly: false,
                                  allowHalfRating: false,
                                  borderColor: BeysionColors.yellow,
                                  color: BeysionColors.yellow,
                                  onRated: (rating) {
                                    setState(() {
                                      rate = rating;
                                    });
                                  },
                                ),
                                Text(
                                  "10",
                                  style: GoogleFonts.overpass(
                                      fontSize: 12,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w300),
                                ),
                              ],
                            ),
                            Divider(
                              color: BeysionColors.gray2,
                            ),
                            Text(
                              "Services",
                              style: GoogleFonts.overpass(fontSize: 16, fontWeight: FontWeight.w300),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "1",
                                  style: GoogleFonts.overpass(
                                      fontSize: 12,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w300),
                                ),
                                SmoothStarRating(
                                  starCount: 10,
                                  rating: rate,
                                  isReadOnly: false,
                                  allowHalfRating: false,
                                  borderColor: BeysionColors.yellow,
                                  color: BeysionColors.yellow,
                                  onRated: (rating) {
                                    setState(() {
                                      rate = rating;
                                    });
                                  },
                                ),
                                Text(
                                  "10",
                                  style: GoogleFonts.overpass(
                                      fontSize: 12,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w300),
                                ),
                              ],
                            ),
                            Divider(
                              color: BeysionColors.gray2,
                            ),
                            Text(
                              "Packing",
                              style: GoogleFonts.overpass(fontSize: 16, fontWeight: FontWeight.w300),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "1",
                                  style: GoogleFonts.overpass(
                                      fontSize: 12,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w300),
                                ),
                                SmoothStarRating(
                                  starCount: 10,
                                  rating: rate,
                                  isReadOnly: false,
                                  allowHalfRating: false,
                                  borderColor: BeysionColors.yellow,
                                  color: BeysionColors.yellow,
                                  onRated: (rating) {
                                    setState(() {
                                      rate = rating;
                                    });
                                  },
                                ),
                                Text(
                                  "10",
                                  style: GoogleFonts.overpass(
                                      fontSize: 12,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w300),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: getSize(context, true, 8 / 415),
                            ),
                            FlatButton(
                              minWidth: getSize(context, true, 1),
                              color: BeysionColors.yellow,
                              child: Text("GIVE POINTS",
                                  style: GoogleFonts.overpass(fontSize: 16, fontWeight: FontWeight.w300)),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ));
      },
    );
  }

  // !!!!
  buildDialog(BuildContext context, double width, double height,
      StateSetter setStateHelper, UserOrderEntity item) {
    return Scaffold(
      body: Container(
        width: getSize(context, true, 1),
        margin: EdgeInsets.symmetric(
          horizontal: getSize(context, true, 15 / 415),
          vertical: getSize(context, true, 20 / 415),
        ),
        decoration:
        BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
                alignment: Alignment.centerRight,
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Image.asset(
                    IconsPath.x,
                    width: getSize(context, true, 20 / 415),
                    height: getSize(context, true, 20 / 415),
                  ),
                )),
            Text(
              "Are you satisfied with the order?",
              style: GoogleFonts.overpass(fontSize: 19, fontWeight: FontWeight.w300),
            ),
            Divider(
              color: BeysionColors.gray2,
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
                    "${item.deliveryTime2}",
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
                        "${item.name}",
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
                            color: item.marketRank > 9.5
                                ? BeysionColors.rank1
                                : item.marketRank > 9.0
                                    ? BeysionColors.rank2
                                    : item.marketRank > 8.5
                                        ? BeysionColors.rank3
                                        : item.marketRank > 8.0
                                            ? BeysionColors.rank4
                                            : item.marketRank < 8.0
                                                ? BeysionColors.rank5
                                                : Colors.red,
                            borderRadius: BorderRadius.all(Radius.circular(2))),
                        child: Center(
                          child: Text(
                            "${item.marketRank.toString()}",
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
                    "${item.deliveryType}",
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
                    "${item.total}",
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
              color: BeysionColors.gray2,
            ),
            Text(
              "Reaktionszeit",
              style: GoogleFonts.overpass(fontSize: 16, fontWeight: FontWeight.w300),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "1",
                  style: GoogleFonts.overpass(
                      fontSize: 12,
                      color: Colors.black,
                      fontWeight: FontWeight.w300),
                ),
                SmoothStarRating(
                  starCount: 10,
                  rating: rate,
                  isReadOnly: false,
                  allowHalfRating: false,
                  borderColor: BeysionColors.yellow,
                  color: BeysionColors.yellow,
                  onRated: (rating) {
                    setState(() {
                      setStateHelper(() {
                        rate = rating;
                      });
                    });
                  },
                ),
                Text(
                  "10",
                  style: GoogleFonts.overpass(
                      fontSize: 12,
                      color: Colors.black,
                      fontWeight: FontWeight.w300),
                ),
              ],
            ),
            Divider(
              color: BeysionColors.gray2,
            ),
            Text(
              "Services",
              style: GoogleFonts.overpass(fontSize: 16, fontWeight: FontWeight.w300),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "1",
                  style: GoogleFonts.overpass(
                      fontSize: 12,
                      color: Colors.black,
                      fontWeight: FontWeight.w300),
                ),
                SmoothStarRating(
                  starCount: 10,
                  rating: rate,
                  isReadOnly: false,
                  allowHalfRating: false,
                  borderColor: BeysionColors.yellow,
                  color: BeysionColors.yellow,
                  onRated: (rating) {
                    setState(() {
                      setStateHelper(() {
                        rate = rating;
                      });
                    });
                  },
                ),
                Text(
                  "10",
                  style: GoogleFonts.overpass(
                      fontSize: 12,
                      color: Colors.black,
                      fontWeight: FontWeight.w300),
                ),
              ],
            ),
            Divider(
              color: BeysionColors.gray2,
            ),
            Text(
              "Packing",
              style: GoogleFonts.overpass(fontSize: 16, fontWeight: FontWeight.w300),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "1",
                  style: GoogleFonts.overpass(
                      fontSize: 12,
                      color: Colors.black,
                      fontWeight: FontWeight.w300),
                ),
                SmoothStarRating(
                  starCount: 10,
                  rating: rate,
                  isReadOnly: false,
                  allowHalfRating: false,
                  borderColor: BeysionColors.yellow,
                  color: BeysionColors.yellow,
                  onRated: (rating) {
                    setState(() {
                      setStateHelper(() {
                        rate = rating;
                      });
                    });
                  },
                ),
                Text(
                  "10",
                  style: GoogleFonts.overpass(
                      fontSize: 12,
                      color: Colors.black,
                      fontWeight: FontWeight.w300),
                ),
              ],
            ),
            SizedBox(
              height: getSize(context, true, 8 / 415),
            ),
            FlatButton(
              minWidth: getSize(context, true, 1),
              color: BeysionColors.yellow,
              child: Text("GIVE POINTS",
                  style: GoogleFonts.overpass(fontSize: 16, fontWeight: FontWeight.w300)),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        ),
      ),
    );
  }


  String orderStatusStr(UserOrderEntity orderEntity){
    try{
      return orderEntity.status == 0
          ? "WAITING"
          : orderEntity.status == 1
          ? "PREPARING"
          : orderEntity.status == 2
          ? "READY"
          : orderEntity.status == 3
          ? "WAS DELIVERED"
          : "state_null";
    }catch(e){
      return "StatusNull";
    }
  }

  Color orderStatusColor(UserOrderEntity orderEntity){
    try{
      return orderEntity.status == 0
          ? BeysionColors.orderState0
          : orderEntity.status == 1
          ? BeysionColors.orderState1
          : orderEntity.status == 2
          ? BeysionColors.orderState2
          : orderEntity.status == 3
          ? BeysionColors.orderState3
          : Colors.white;
    }catch(e){
      return Colors.white;
    }
  }
}

