import 'package:beysion/Utility/Colors.dart';
import 'package:beysion/Utility/FakeData.dart';
import 'package:beysion/Utility/Icons.dart';
import 'package:beysion/Utility/Widgets.dart';
import 'package:beysion/Utility/util.dart';
import 'package:beysion/constant/colors_theme_widget.dart';
import 'package:beysion/rest/controller/seller/seller_order_provider.dart';
import 'package:beysion/rest/entity/seller/seller_entity.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'SellerSalesDetailPage.dart';

class SellerSalesPage extends StatefulWidget {
  @override
  _SellerSalesPageState createState() => _SellerSalesPageState();
}

class _SellerSalesPageState extends State<SellerSalesPage> {
  TextEditingController _searchTextFormField = new TextEditingController();
  ScrollController _myOrdersListViewController;
  var selectedItem = 0;
  var selectedAppBarMarketItem = 0;
  int statusOrder=0;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      Provider.of<SellerOrderProvider>(context, listen: false).getSellerOrdersListDataController(page:0,orderCode: "", status: statusOrder);
    });
  }

  @override
  Widget build(BuildContext context) {
    List<SellerOrderData> sellerOrderDataList = Provider.of<SellerOrderProvider>(context, listen: true).sellerOrderList;
    return Scaffold(
      appBar: buildAppBarSeller(context),
      body: buildBody(context,sellerOrderDataList),
    );
  }

  buildBody(BuildContext context, List<SellerOrderData> sellerOrderDataList) {
    return SingleChildScrollView(
      padding: EdgeInsets.only(
          left: getSize(context, true, 20 / 415),
          right: getSize(context, true, 20 / 415),
          top: getSize(context, true, 20 / 415)),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: getSize(context, true, 20 / 415)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: getSize(context, true, 5 / 415)),
                  child: Text("Der Umsatz", style: GoogleFonts.overpass(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w600),),
                ),
                Container(
                  height: getSize(context, true, 45 / 415),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      border: Border.all(color: Colors.grey.shade300, width: 1)),
                  child: Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(left: 20),
                          child: DropdownButton(
                              icon: SizedBox(),
                              iconEnabledColor: BeysionColors.yellow,
                              style: TextStyle(fontSize: 14, color: Colors.black),
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
                                  Provider.of<SellerOrderProvider>(context, listen: false).getSellerOrdersListDataController(page:0,orderCode: "", status: statusOrder);
                                });
                              },
                              value: statusOrder),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        child: Icon(Icons.keyboard_arrow_down, color: BeysionColors.orange, size: 20,),
                      )
                    ],
                  ),
                ),
                Container(
                  height: getSize(context, true, 45 / 415),
                  margin: EdgeInsets.only(top: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    border: Border.all(color: Colors.grey.shade300, width: 1),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          textAlignVertical: TextAlignVertical.center,
                          controller: _searchTextFormField,
                          onChanged: (searchStr){
                            if(searchStr.length>4){
                              Provider.of<SellerOrderProvider>(context, listen: false).getSellerOrdersListDataController(page:0,orderCode: searchStr, status: statusOrder);
                            }else{
                              Provider.of<SellerOrderProvider>(context, listen: false).getSellerOrdersListDataController(page:0,orderCode: "", status: statusOrder);
                            }
                          },
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(left: 20),
                              border: InputBorder.none,
                              suffixIcon: SizedBox(),
                              isCollapsed: true,
                              hintText: "Suchreihenfolge",
                              hintStyle: TextStyle(
                                color: BeysionColors.gray1,
                                fontSize: 15,
                              )),

                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Icon(Icons.search, color: BeysionColors.yellow, size: 20,),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          ListView.builder(
              controller: _myOrdersListViewController,
              shrinkWrap: true,
              itemCount: sellerOrderDataList.length,
              physics: NeverScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              itemBuilder: (context,index){
            return buildOrderCard(sellerOrderDataList[index]);
          }),
          sellerOrderDataList.length>0 ?
            Padding(
              padding: const EdgeInsets.only(bottom: 32.0),
              child: FittedBox(
                child: RaisedButton(
                  color: BeysionColors.yellow,
                  child: Center(
                      child: Text(
                        "Mehr Sales",
                        style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                      )),
                  onPressed: () {
                    Provider.of<SellerOrderProvider>(context, listen: false).getSellerOrdersListDataController(page: -1, orderCode:"",status: statusOrder);
                  },
                ),
              ),
            )
          : SizedBox(),
        ],
      ),
    );
  }

  buildOrderCard(SellerOrderData sellerOrderData) {
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
          border: Border.all(
              color: BeysionColors.border.withOpacity(0.5), width: 1),
        ),
        child: Padding(
          padding:
              EdgeInsets.symmetric(vertical: getSize(context, true, 10 / 415)),
          child: Container(
            width: getSize(context, true, 1),
            child: Column(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Bestellnummer",
                      style: TextStyle(
                          fontSize: 14, color: BeysionColors.blueNavy),
                    ),
                    Row(
                      children: [
                        Text(
                          "${sellerOrderData.ordercode}",
                          style: TextStyle(
                              fontSize: 14, color: BeysionColors.blueNavy),
                        ),
                        Container(
                          width: getSize(context, true, 165 / 415),
                          height: getSize(context, true, 24 / 415),
                          margin: EdgeInsets.only(
                              left: getSize(context, true, 10 / 415)),
                          decoration: BoxDecoration(
                              color: orderStatusColor(sellerOrderData),
                              borderRadius:
                              BorderRadius.all(Radius.circular(2))),
                          child: Center(
                            child: Text(
                              "${orderStatusStr(sellerOrderData)}",
                              style:
                              TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: Colors.white),
                            ),
                          ),
                        )                      ],
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
                        style: TextStyle(
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
                            "${sellerOrderData.deliveryTime2}",
                            style: TextStyle(
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
                        "Clients",
                        style: TextStyle(
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
                            "${sellerOrderData.name}",
                            style: TextStyle(
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
                        style: TextStyle(
                            fontSize: 12,
                            color: Colors.black,
                            fontWeight: FontWeight.w300),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Text(
                        "${sellerOrderData.deliveryType}",
                        style: TextStyle(
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
                        style: TextStyle(
                            fontSize: 12,
                            color: Colors.black,
                            fontWeight: FontWeight.w300),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Text(
                        "€ ${sellerOrderData.total.toString().replaceAll(("."), ",")} - ${sellerOrderData.totalItem} Items",
                        style: TextStyle(
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
                          Container(
                            width: getSize(context, true, 100 / 415),
                            height: getSize(context, true, 25 / 415),
                            padding: EdgeInsets.only(
                                left: getSize(context, true, 5 / 415)),
                            child: Center(
                              child: Text("Bestell-Details",
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600)),
                            ),
                          )
                        ],
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SellerSalesDetailPage(sellerOrderData.ordercode)));
                        },
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
      onTap: () {},
    );
  }

  String orderStatusStr(SellerOrderData orderEntity){
    try{
      if(orderEntity.status==0){
        return "warten auf die Bestätigung";
      }else if(orderEntity.status == 1){
        return "wird vorbereitet";
      }else if(orderEntity.status == 2){
        return "Abholbereit / Versandbereit";
      }else if(orderEntity.status == 3){
        return "wird vorbereitet";
      }else if(orderEntity.status == 4){
        return "Bestellung storniert";
      }else {
        return " ";
      }

    }catch(e){
      return "StatusNull";
    }
  }

  Color orderStatusColor(SellerOrderData orderEntity){
    try{
      if(orderEntity.status==0){
        return Color(getColorHexFromStr("#5D68CC"));
      }else if(orderEntity.status == 1){
        return Color(getColorHexFromStr("#FFC934"));
      }else if(orderEntity.status == 2){
        return Color(getColorHexFromStr("#1EC1FF"));
      }else if(orderEntity.status == 3){
        return Color(getColorHexFromStr("#1EC1FF"));
      }else if(orderEntity.status == 4){
        return Color(getColorHexFromStr("#e41200"));
      }else {
        return Colors.white;
      }
    }catch(e){
      return Colors.white;
    }
  }

}
