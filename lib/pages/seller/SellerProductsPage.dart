import 'package:beysion/Utility/Colors.dart';
import 'package:beysion/Utility/FakeData.dart';
import 'package:beysion/Utility/Icons.dart';
import 'package:beysion/Utility/Widgets.dart';
import 'package:beysion/Utility/util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'SellerAddProductPage.dart';

class SellerProductsPage extends StatefulWidget {
  @override
  _SellerProductsPageState createState() => _SellerProductsPageState();
}

class _SellerProductsPageState extends State<SellerProductsPage> {
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
      appBar: buildAppBarSeller(context),
      body: buildBody(context),
    );
  }

  buildBody(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: getSize(context, true, 20 / 415),
              vertical: getSize(context, true, 20 / 415),
            ),
            child: Text("Products", style: GoogleFonts.overpass(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w600),),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: getSize(context, true, 20 / 415),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: getSize(context, true, 31 / 415),
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
                                style: TextStyle(fontSize: 14, color: Colors.black),
                                underline: SizedBox(),
                                items: [
                                  DropdownMenuItem(value: 0, child: Text("Zeige 25 Zeilen")),
                                  DropdownMenuItem(value: 1, child: Text("Zeige 50 Zeilen")),
                                  DropdownMenuItem(value: 2, child: Text("Zeige 100 Zeilen")),
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
                    SizedBox(width: 10,),
                    Expanded(
                      child: Container(
                        height: getSize(context, true, 31 / 415),
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
                                style: TextStyle(fontSize: 14, color: Colors.black),
                                underline: SizedBox(),
                                items: [
                                  DropdownMenuItem(value: 0, child: Text("Alle Kategorie")),
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
                Container(
                  height: getSize(context, true, 31 / 415),
                  margin: EdgeInsets.only(top: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    border: Border.all(
                        color: BeysionColors.border.withOpacity(0.5), width: 1),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 1,
                        child: TextFormField(
                          textAlignVertical: TextAlignVertical.center,
                          controller: _searchTextFormField,
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: getSize(context, true, 5 / 415)),
                              border: InputBorder.none,
                              suffixIcon: SizedBox(),
                              suffixIconConstraints: BoxConstraints.tightFor(),
                              isCollapsed: true,
                              hintText: "Suche",
                              hintStyle: TextStyle(
                                color: BeysionColors.gray1,
                                fontSize: 15,
                              )),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Icon(Icons.search, color: BeysionColors.orange,),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: getSize(context, true, 20 / 415),
              horizontal: getSize(context, true, 20 / 415),
            ),
            child: Text("53 Products Listed"),
          ),
          buildContainer(
              context,
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Products"),
                      FlatButton(
                          height: getSize(context, true, 35 / 415),
                          color: BeysionColors.yellow,
                          onPressed: () {
                            //Navigator.pushNamed(context, "/sellerAddProduct");
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SellerAddProductPage()));
                            },
                          child: Row(
                            children: [
                              Image.asset(
                                IconsPath.plus,
                                color: Colors.black,
                                width: getSize(context, true, 15 / 415),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: getSize(context, true, 10 / 415)),
                                child: Text(
                                  "Add Products",
                                  style: TextStyle(fontSize: 12),
                                ),
                              )
                            ],
                          ))
                    ],
                  ),
                  Divider(),
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
                      Text("Wählen Sie Alle"),
                      SizedBox(
                        width: getSize(context, true, 10 / 415),
                      ),
                      Container(
                        width: getSize(context, true, 110 / 415),
                        height: getSize(context, true, 29 / 415),
                        child: OutlineButton(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(right: 5),
                                child: Image.asset(IconsPath.delete),
                              ),
                              Text(
                                "Delete",
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal),
                              ),
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
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
            Row(
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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${item.title}",
                      style: TextStyle(fontSize: 12),
                    ),
                    Container(
                        width: getSize(context, true, 238 / 415),
                        height: getSize(context, true, 30 / 415),
                        child: Text(
                          "Fruit Vegetable, Meat Fish, Freshness & Cooling",
                          style: TextStyle(fontSize: 10),
                        ))
                  ],
                ),
              ],
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              "${item.price} €",
              style: TextStyle(color: Colors.red),
            ),
            SizedBox(
              width: getSize(context, true, 5 / 415),
            ),
            Text(
              "${item.oldPrice} €",
              style: TextStyle(decoration: TextDecoration.lineThrough),
            ),
            SizedBox(
              width: getSize(context, true, 20 / 415),
            ),
            Container(
              width: getSize(context, true, 85 / 415),
              height: getSize(context, true, 29 / 415),
              child: OutlineButton(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: 5),
                      child: Image.asset(IconsPath.pen),
                    ),
                    Text(
                      "Edit",
                      style: TextStyle(
                          fontSize: 14, fontWeight: FontWeight.normal),
                    ),
                  ],
                ),
                onPressed: () {},
              ),
            ),
            SizedBox(
              width: getSize(context, true, 15 / 415),
            ),
            Container(
              width: getSize(context, true, 30 / 415),
              height: getSize(context, true, 29 / 415),
              decoration: BoxDecoration(
                  image: DecorationImage(image: AssetImage(IconsPath.delete))),
              child: OutlineButton(
                child: Image.asset(
                  IconsPath.delete,
                  width: getSize(context, true, 30 / 415),
                  height: getSize(context, true, 29 / 415),
                  fit: BoxFit.contain,
                ),
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
