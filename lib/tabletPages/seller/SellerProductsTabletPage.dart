import 'package:beysion/Utility/Colors.dart';
import 'package:beysion/Utility/FakeData.dart';
import 'package:beysion/Utility/Icons.dart';
import 'package:beysion/Utility/util.dart';
import 'package:beysion/utility/Widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import 'SellerAddProductTabletPage.dart';

class SellerProductsTabletPage extends StatefulWidget {
  @override
  _SellerProductsTabletPageState createState() => _SellerProductsTabletPageState();
}

class _SellerProductsTabletPageState extends State<SellerProductsTabletPage> {
  var selectedAppBarMarketItem = 0;
  var selectedShowAllValue = 0;
  var selectedAllDepartValue = 0;
  var valueItem = false;
  var selectAllValue = false;
  TextEditingController _searchTextFormField;
  ScrollController listViewController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBarSellerTablet(context),
      body: buildBody(context),
    );
  }

  List buildAction(BuildContext context) {
    return <Widget>[
      Container(
        width: getSize(context, true, 120 / 415),
        height: getSize(context, true, 5 / 415),
        margin: EdgeInsets.only(right: getSize(context, true, 15 / 415)),
        child: Center(
          child: DropdownButton(
              icon: Padding(
                padding: EdgeInsets.only(left: getSize(context, true, 4 / 415)),
                child: Image.asset(IconsPath.dropArrow),
              ),
              iconEnabledColor: BeysionColors.yellow,
              style: GoogleFonts.overpass(fontSize: 14, color: Colors.white),
              underline: SizedBox(),
              items: [
                DropdownMenuItem(value: 0, child: Text("Niemerszein")),
                DropdownMenuItem(value: 1, child: Text("Carrefour")),
              ],
              dropdownColor: BeysionColors.purple,
              onChanged: (value) {
                setState(() {
                  selectedAppBarMarketItem = value;
                });
              },
              value: selectedAppBarMarketItem),
        ),
      ),
    ];
  }

  buildBody(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: getSize(context, true, 20 / 415),
              vertical: getSize(context, true, 10 / 415),
            ),
            child: Text("Products", style: GoogleFonts.overpass(fontSize: 15, fontWeight: FontWeight.w600),),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: getSize(context, true, 20 / 415),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    height: getSize(context, true, 20 / 415),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        border:
                            Border.all(color: BeysionColors.border, width: 1)),
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.all(getSize(context, true, 2 / 415)),
                        child: DropdownButton(
                            icon: Padding(
                              padding: EdgeInsets.only(left: 8.0),
                              child: FaIcon(FontAwesomeIcons.chevronDown),
                            ),
                            iconEnabledColor: BeysionColors.yellow,
                            style: GoogleFonts.overpass(fontSize: 14, color: Colors.black),
                            underline: SizedBox(),
                            hint: Text("Zeige 35 Zeilen"),
                            items: [
                              DropdownMenuItem(value: 0, child: Text("Zeige 35 Zeilen")),
                              DropdownMenuItem(
                                  value: 1, child: Text("Show: All*")),
                            ],
                            onChanged: (value) {
                              setState(() {
                                selectedShowAllValue = value;
                              });
                            },
                            value: selectedShowAllValue),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: getSize(context, true, 5 / 415),),
                Expanded(
                  flex: 2,
                  child: Container(
                    height: getSize(context, true, 20 / 415),
                    //padding: EdgeInsets.zero,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      border: Border.all(
                          color: BeysionColors.border.withOpacity(0.5), width: 1),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Flexible(
                          flex: 1,
                          child: TextFormField(
                            textAlignVertical: TextAlignVertical.center,
                            controller: _searchTextFormField,
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: getSize(context, true, 5 / 415)),
                                border: InputBorder.none,
                                suffixIcon: Padding(
                                  padding: EdgeInsets.only(
                                      right: getSize(context, true, 3 / 415)),
                                  child: Image.asset(IconsPath.search),
                                ),
                                suffixIconConstraints: BoxConstraints.tightFor(),
                                isCollapsed: true,
                                hintText: "Suche",
                                hintStyle: GoogleFonts.overpass(
                                  color: BeysionColors.gray1,
                                  fontSize: 15,
                                )),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: getSize(context, true, 5 / 415),),
                Expanded(
                  flex: 1,
                  child: Container(
                    height: getSize(context, true, 20 / 415),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        border:
                            Border.all(color: BeysionColors.border, width: 1)),
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.all(getSize(context, true, 2 / 415)),
                        child: DropdownButton(
                            icon: Padding(
                              padding: EdgeInsets.only(
                                  left: getSize(context, true, 4 / 415)),
                              child: Image.asset(IconsPath.dropArrow),
                            ),
                            iconEnabledColor: BeysionColors.yellow,
                            style: GoogleFonts.overpass(fontSize: 14, color: Colors.black),
                            underline: SizedBox(),
                            items: [
                              DropdownMenuItem(
                                  value: 0, child: Text("All Depart")),
                              DropdownMenuItem(
                                  value: 1, child: Text("Show: All*")),
                            ],
                            onChanged: (value) {
                              setState(() {
                                selectedAllDepartValue = value;
                              });
                            },
                            value: selectedAllDepartValue),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: getSize(context, true, 10 / 415),
              horizontal: getSize(context, true, 20 / 415),
            ),
            child: Text("53 Products Listed", style: GoogleFonts.overpass(fontSize: 15, fontWeight: FontWeight.w500),),
          ),
          buildContainer(
              context,
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Products", style: GoogleFonts.overpass(fontSize: 15, fontWeight: FontWeight.w500),),
                      FlatButton(
                        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                          color: BeysionColors.yellow,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                          onPressed: () {
                            //Navigator.pushNamed(context, "/sellerAddProduct");
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SellerAddProductTabletPage()));
                            },
                          child: Row(
                            children: [
                              FaIcon(FontAwesomeIcons.plus, size: getSize(context, true, 7/415),),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: getSize(context, true, 3 / 415)),
                                child: Text(
                                  "Produkt hinzufügen",
                                  style: GoogleFonts.overpass(fontSize: 16, fontWeight: FontWeight.w600),
                                ),
                              )
                            ],
                          ))
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                    child: Divider(),
                  ),
                  ListView(
                    physics: NeverScrollableScrollPhysics(),
                    controller: listViewController,
                    shrinkWrap: true,
                    children: [
                      buildListInProductItem(context, FakeData.product1),
                      buildListInProductItem(context, FakeData.product2),
                      buildListInProductItem(context, FakeData.product3),
                    ],
                  ),
                  Row(
                    children: [
                      Checkbox(
                        value: selectAllValue,
                        onChanged: (value) {
                          setState(() {
                            selectAllValue = value;
                          });
                        },
                      ),
                      Text("Wählen Sie Alle", style: GoogleFonts.overpass(fontSize: 16, fontWeight: FontWeight.w600),),
                      SizedBox(
                        width: getSize(context, true, 10 / 415),
                      ),
                      Container(
                        padding: EdgeInsets.all(16),
                        child: OutlineButton(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(right: 5),
                                child: Image.asset(IconsPath.delete),),
                              Text("Delete", style: GoogleFonts.overpass(fontSize: 16, fontWeight: FontWeight.w600),),
                            ],
                          ),
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
                  Divider(),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: getSize(context, true, 20 / 415),
                      vertical: getSize(context, true, 5 / 415),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image.asset(IconsPath.dropArrowleft),
                        Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: BeysionColors.border
                                ),
                                borderRadius: BorderRadius.all(Radius.circular(5))
                              ),
                              margin: EdgeInsets.symmetric(
                                horizontal: getSize(context, true, 2.5/415)
                              ),
                              width: getSize(context, true, 30/415),
                              height: getSize(context, true, 30/415),
                              child: Center(
                                child: Text("1"),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: BeysionColors.border
                                ),
                                borderRadius: BorderRadius.all(Radius.circular(5))
                              ),
                              margin: EdgeInsets.symmetric(
                                horizontal: getSize(context, true, 2.5/415)
                              ),
                              width: getSize(context, true, 30/415),
                              height: getSize(context, true, 30/415),
                              child: Center(
                                child: Text("2"),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: BeysionColors.border
                                  ),
                                  borderRadius: BorderRadius.all(Radius.circular(5))
                              ),
                              margin: EdgeInsets.symmetric(
                                  horizontal: getSize(context, true, 2.5/415)
                              ),
                              width: getSize(context, true, 30/415),
                              height: getSize(context, true, 30/415),
                              child: Center(
                                child: Text("3"),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: BeysionColors.border

                              ),
                              margin: EdgeInsets.only(
                                left: getSize(context, true, 5/415),
                                  right: getSize(context, true, 2.5/415)
                              ),
                              width: getSize(context, true, 5/415),
                              height: getSize(context, true, 5/415),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: BeysionColors.border

                              ),
                              margin: EdgeInsets.only(
                                  left: getSize(context, true, 2.5/415),
                                right: getSize(context, true, 5/415),
                              ),
                              width: getSize(context, true, 5/415),
                              height: getSize(context, true, 5/415),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: BeysionColors.border
                                  ),
                                  borderRadius: BorderRadius.all(Radius.circular(5))
                              ),
                              margin: EdgeInsets.symmetric(
                                  horizontal: getSize(context, true, 2.5/415)
                              ),
                              width: getSize(context, true, 30/415),
                              height: getSize(context, true, 30/415),
                              child: Center(
                                child: Text("8"),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: BeysionColors.border
                                  ),
                                  borderRadius: BorderRadius.all(Radius.circular(5))
                              ),
                              margin: EdgeInsets.symmetric(
                                  horizontal: getSize(context, true, 2.5/415)
                              ),
                              width: getSize(context, true, 30/415),
                              height: getSize(context, true, 30/415),
                              child: Center(
                                child: Text("9"),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: BeysionColors.border
                                  ),
                                  borderRadius: BorderRadius.all(Radius.circular(5))
                              ),
                              margin: EdgeInsets.symmetric(
                                  horizontal: getSize(context, true, 2.5/415)
                              ),
                              width: getSize(context, true, 30/415),
                              height: getSize(context, true, 30/415),
                              child: Center(
                                child: Text("10"),
                              ),
                            ),
                          ],
                        ),
                        Image.asset(IconsPath.dropArrowright),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  )
                ],
              ))
        ],
      ),
    );
  }

  buildListInProductItem(BuildContext context, FakeProduct item) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Checkbox(
              visualDensity: VisualDensity.standard,
              value: valueItem,
              onChanged: (value) {
                setState(() {
                  valueItem = value;
                });
              },
            ),
            Image.asset(
              item.imagePath,
              fit: BoxFit.fitHeight,
              width: getSize(context, true, 50 / 415),
              height: getSize(context, true, 50 / 415),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${item.title}",
                    maxLines: 1,
                    softWrap: true,
                    overflow: TextOverflow.fade,
                    style: GoogleFonts.overpass(fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                  Text(
                    "Fruit Vegetable, Meat Fish, Freshness & Cooling",
                    maxLines: 2,
                    softWrap: true,
                    overflow: TextOverflow.fade,
                    style: GoogleFonts.overpass(fontSize: 14, color: Colors.black.withOpacity(0.6)),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(children: [
                  Text("${item.price} €", style: GoogleFonts.overpass(fontSize: 16, fontWeight: FontWeight.w600),),
                  Text("${item.oldPrice} €", style: GoogleFonts.overpass(color: Colors.black.withOpacity(0.4), fontSize: 16, fontWeight: FontWeight.w600, decoration: TextDecoration.lineThrough),),],),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: OutlineButton(
                padding: EdgeInsets.all(8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FaIcon(FontAwesomeIcons.pen, color: BeysionColors.orange,),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(
                        "Edit",
                        style: GoogleFonts.overpass(
                            fontSize: 14, fontWeight: FontWeight.normal),
                      ),
                    ),
                  ],
                ),
                onPressed: () {},
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: OutlineButton(
                child: FaIcon(FontAwesomeIcons.trash, color: BeysionColors.orange,),
                padding: EdgeInsets.all(8),
                onPressed: () {},
              ),
            ),
          ],
        ),
        Divider(),
      ],
    );
  }
}
