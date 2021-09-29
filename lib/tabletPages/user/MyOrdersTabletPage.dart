import 'package:beysion/Utility/Colors.dart';
import 'package:beysion/Utility/Icons.dart';
import 'package:beysion/Utility/util.dart';
import 'package:beysion/rest/controller/user/user_order_provider.dart';
import 'package:beysion/rest/entity/user/user_order_entity.dart';
import 'package:beysion/utility/Widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

import 'MyOrderDetailTabletPage.dart';

class MyOrdersTabletPage extends StatefulWidget {
  @override
  _MyOrdersTabletPageState createState() => _MyOrdersTabletPageState();
}

class _MyOrdersTabletPageState extends State<MyOrdersTabletPage> {
  TextEditingController _searchTextFormField;
  ScrollController _myOrdersListViewController;
  var selectedItem = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      Provider.of<UserOrderProvider>(context, listen: false)
          .getOrdersListDataController();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBarTablet(context),
      body: buildBody(context),
    );
  }

  buildBody(BuildContext context) {
    List<UserOrderEntity> userOrderDataList =
        Provider.of<UserOrderProvider>(context, listen: true).userOrderList;
    return SingleChildScrollView(
      physics: ClampingScrollPhysics(),
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
            children: userOrderDataList
                .map(
                  (orderEntity) => BuildOrderCard(orderEntity),
                )
                .toList(),
          ),
          userOrderDataList.length > 0
              ? Padding(
                  padding: EdgeInsets.only(
                    top: getSize(context, true, 10 / 415),
                    bottom: getSize(context, true, 10 / 415),
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
                        Provider.of<UserOrderProvider>(context, listen: false)
                            .getOrdersListDataController(page: -1);
                      },
                    ),
                  ),
                )
              : SizedBox(),
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
            padding: EdgeInsets.only(bottom: getSize(context, true, 10 / 415)),
            child: Text("Meine Bestellungen",
                style: GoogleFonts.overpass(
                    color: Colors.black,
                    fontSize: 17,
                    fontWeight: FontWeight.w600)),
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
                      hintText: "Auftragssuche",
                      hintStyle: GoogleFonts.overpass(
                        color: BeysionColors.gray2,
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
              border: Border.all(color: BeysionColors.border, width: 1)),
          child: Center(
            child: Padding(
              padding: EdgeInsets.all(getSize(context, true, 2 / 415)),
              child: DropdownButton(
                  icon: Padding(
                    padding:
                        EdgeInsets.only(left: getSize(context, true, 4 / 415)),
                    child: Image.asset(IconsPath.dropArrow),
                  ),
                  iconEnabledColor: BeysionColors.yellow,
                  style: GoogleFonts.overpass(fontSize: 14, color: Colors.black),
                  underline: SizedBox(),
                  items: [
                    DropdownMenuItem(value: 0, child: Text("Zeige: alles")),
                    DropdownMenuItem(value: 1, child: Text("Zeige: alles*")),
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
          bottom: getSize(context, true, 10 / 415),
        ),
        padding: EdgeInsets.symmetric(
          vertical: getSize(context, true, 5 / 415),
          horizontal: getSize(context, true, 10 / 415),
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(5)),
          border: Border.all(
              color: BeysionColors.border.withOpacity(0.5), width: 1),
        ),
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
                      "Bestellnummer", style: GoogleFonts.overpass(fontSize: 18, fontWeight: FontWeight.w800, color: BeysionColors.blueNavy),
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "${widget.orderEntity.ordercode}", style: GoogleFonts.overpass(fontSize: 18, fontWeight: FontWeight.w800, color: BeysionColors.blueNavy),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          margin: EdgeInsets.only(
                              left: getSize(context, true, 10 / 415)),
                          decoration: BoxDecoration(
                              color: orderStatusColor(widget.orderEntity),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5))),
                          child: Center(
                            child: Text(
                              orderStatusStr(widget.orderEntity),
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
                height: getSize(context, true, 10/415),
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
                      "${widget.orderEntity.deliveryTime2}", style: GoogleFonts.overpass(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: getSize(context, true, 3 / 415),
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
                          "${widget.orderEntity.name}", style: GoogleFonts.overpass(fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(
                height: getSize(context, true, 3 / 415),
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
                      "${widget.orderEntity.deliveryType}", style: GoogleFonts.overpass(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: getSize(context, true, 3 / 415),
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
                      "${widget.orderEntity.total}", style: GoogleFonts.overpass(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                  )
                ],
              ),
              Divider(
                height: getSize(context, true, 10 / 415),
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
                                width: getSize(context, true, 25 / 415),
                                height: getSize(context, true, 25 / 415),
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(IconsPath.repeat))),
                              ),
                              Container(
                                height: getSize(context, true, 25 / 415),
                                padding: EdgeInsets.only(
                                    left: getSize(context, true, 2 / 415)),
                                child: Center(
                                  child: Text("Order Again", style: GoogleFonts.overpass(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w500),),
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
                          width: getSize(context, true, 25 / 415),
                          height: getSize(context, true, 25 / 415),
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(IconsPath.basket))),
                        ),
                        Container(
                          height: getSize(context, true, 25 / 415),
                          padding: EdgeInsets.only(
                              left: getSize(context, true, 2 / 415)),
                          child: Center(
                            child: Text("Inhalt zeigen", style: GoogleFonts.overpass(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w500),),
                          ),
                        )
                      ],
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MyOrderDetailTabletPage(
                                  widget.orderEntity.ordercode)));
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      ),
      onTap: () {
        showDialog(
            context: context,
            builder: (context) => StatefulBuilder(
                  builder: (context, setState,) {
                    return Dialog(
                      child: FittedBox(
                        fit: BoxFit.fitHeight,
                        child: Container(
                          width: getSize(context, true, 300 / 415),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(10))),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: getSize(context, true, 10/415),
                              vertical: getSize(context, true, 10/415),
                            ),
                            decoration:
                            BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10))),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Are you satisfied with the order?",
                                      style: GoogleFonts.overpass(fontSize: 22, fontWeight: FontWeight.w700),
                                    ),
                                    Align(
                                        alignment: Alignment.centerRight,
                                        child: IconButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          icon: FaIcon(FontAwesomeIcons.times,),
                                        )),
                                  ],
                                ),
                                Divider(
                                  color: BeysionColors.gray2,
                                ),
                                SizedBox(
                                  height: getSize(context, true, 2 / 415),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: Text(
                                        "Bestelldatum",
                                        style: GoogleFonts.overpass(
                                            fontSize: 16,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Text(
                                        "${widget.orderEntity.deliveryTime2}",
                                        style: GoogleFonts.overpass(
                                            fontSize: 16,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: getSize(context, true, 2 / 415),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: Text(
                                        "Market Name",
                                        style: GoogleFonts.overpass(
                                            fontSize: 16,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Row(
                                        children: [
                                          Text(
                                            "${widget.orderEntity.name}",
                                            style: GoogleFonts.overpass(
                                                fontSize: 16,
                                                color: Colors.black,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: getSize(context, true, 2 / 415),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: Text(
                                        "Gelieferter Typ",
                                        style: GoogleFonts.overpass(
                                            fontSize: 16,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Text(
                                        "${widget.orderEntity.deliveryType}",
                                        style: GoogleFonts.overpass(
                                            fontSize: 16,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: getSize(context, true, 2 / 415),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: Text(
                                        "Gesamtmenge",
                                        style: GoogleFonts.overpass(
                                            fontSize: 16,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Text(
                                        "${widget.orderEntity.total}",
                                        style: GoogleFonts.overpass(
                                            fontSize: 16,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: getSize(context, true, 2 / 415),
                                ),
                                Divider(
                                  color: BeysionColors.gray2,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Reaktionszeit",
                                      style: GoogleFonts.overpass(fontSize: 16,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "1",
                                          style: GoogleFonts.overpass(
                                              fontSize: 16,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        SizedBox(width: getSize(context, true, 5 / 415),),
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
                                        SizedBox(width: getSize(context, true, 5 / 415),),
                                        Text(
                                          "10",
                                          style: GoogleFonts.overpass(
                                              fontSize: 16,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Divider(
                                  color: BeysionColors.gray2,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Services",
                                      style: GoogleFonts.overpass(fontSize: 16,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "1",
                                          style: GoogleFonts.overpass(
                                              fontSize: 16,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        SizedBox(width: getSize(context, true, 5 / 415),),
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
                                        SizedBox(width: getSize(context, true, 5 / 415),),
                                        Text(
                                          "10",
                                          style: GoogleFonts.overpass(
                                              fontSize: 16,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Divider(
                                  color: BeysionColors.gray2,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Packing",
                                      style: GoogleFonts.overpass(fontSize: 16,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "1",
                                          style: GoogleFonts.overpass(
                                              fontSize: 16,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        SizedBox(width: getSize(context, true, 5 / 415),),
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
                                        SizedBox(width: getSize(context, true, 5 / 415),),
                                        Text(
                                          "10",
                                          style: GoogleFonts.overpass(
                                              fontSize: 16,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Divider(
                                  color: BeysionColors.gray2,
                                ),
                                SizedBox(
                                  height: getSize(context, true, 10 / 415),
                                ),
                                FlatButton(
                                  minWidth: getSize(context, true, 1),
                                  color: BeysionColors.yellow,
                                  child: Text("GIVE POINTS",
                                      style: GoogleFonts.overpass(fontSize: 16, fontWeight: FontWeight.w600)),
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


  String orderStatusStr(UserOrderEntity orderEntity) {
    try {
      return orderEntity.status == 0
          ? "WAITING"
          : orderEntity.status == 1
              ? "PREPARING"
              : orderEntity.status == 2
                  ? "READY"
                  : orderEntity.status == 3
                      ? "WAS DELIVERED"
                      : "state_null";
    } catch (e) {
      return "StatusNull";
    }
  }

  Color orderStatusColor(UserOrderEntity orderEntity) {
    try {
      return orderEntity.status == 0
          ? BeysionColors.orderState0
          : orderEntity.status == 1
              ? BeysionColors.orderState1
              : orderEntity.status == 2
                  ? BeysionColors.orderState2
                  : orderEntity.status == 3
                      ? BeysionColors.orderState3
                      : Colors.white;
    } catch (e) {
      return Colors.white;
    }
  }
}
