import 'package:beysion/Utility/Colors.dart';
import 'package:beysion/Utility/FakeData.dart';
import 'package:beysion/Utility/Icons.dart';
import 'package:beysion/Utility/Widgets.dart';
import 'package:beysion/Utility/util.dart';
import 'package:beysion/constant/app_configurations.dart';
import 'package:beysion/constant/colors_theme_widget.dart';
import 'package:beysion/rest/controller/seller/seller_order_provider.dart';
import 'package:beysion/rest/entity/seller/seller_entity.dart';
import 'package:beysion/rest/entity/seller/seller_order_detail_entity.dart';
import 'package:beysion/rest/response_models/base_response.dart';
import 'package:beysion/rest/response_models/ok_response.dart';
import 'package:beysion/rest/service/seller/seller_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SellerSalesDetailPage extends StatefulWidget {
  String orderCode;
  SellerSalesDetailPage(this.orderCode);
  @override
  _SellerSalesDetailPageState createState() => _SellerSalesDetailPageState();
}

class _SellerSalesDetailPageState extends State<SellerSalesDetailPage> {
  ScrollController listViewController;
  var selectedAppBarMarketItem = 0;
  bool valueItem = false;
  bool valueAllProductChecked = false;


  @override
  void initState() {
    super.initState();
    print('ORDER CODEE ${widget.orderCode}');
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      Provider.of<SellerOrderProvider>(context, listen: false).getSellerOrderShowDataController(widget.orderCode);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBarSeller(context),
      body: buildBody(context),
    );
  }

  buildBody(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
                vertical: getSize(context, true, 15 / 415),
                horizontal: getSize(context, true, 20 / 415)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Bestelldetails", style: GoogleFonts.overpass(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w600),),
                Container(
                  height: getSize(context, true, 29 / 415),
                  child: OutlineButton(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(right: 5),
                          child: Image.asset(IconsPath.pdf),
                        ),
                        Text(
                          "Drucken",
                          style: GoogleFonts.overpass(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ),
          buildSalesContent(context)
        ],
      ),
    );
  }

  buildSalesContent(BuildContext context) {
    SellerOrderDetailEntity sellerOrderDetailEntity = Provider.of<SellerOrderProvider>(context, listen: true).sellerOrderDetailEntity;
    return buildContainer(context, Column(
      children: [
        Divider(),
        sellerOrderDetailEntity!=null ?
        buildOrderCard(context): SizedBox(),
        Divider(),
        sellerOrderDetailEntity.products!=null && sellerOrderDetailEntity.products.length>0?
        ListView.builder(
            itemCount: sellerOrderDetailEntity.products.length,
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            physics: NeverScrollableScrollPhysics(),
            controller: listViewController,
            itemBuilder: (context,index){
          return buildListInProductItem(context,  sellerOrderDetailEntity.products[index]);
        }): SizedBox(),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: sellerOrderDetailEntity.detail.status!=4 ? MainAxisAlignment.spaceBetween: MainAxisAlignment.center,
          children: [
            Container(
              height: getSize(context, true, 29 / 415),
              child: OutlineButton(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: 5),
                      child: Image.asset(IconsPath.approve),
                    ),
                    Text(
                      "Bestellung bestätigen",
                      style: GoogleFonts.overpass(color: Colors.black, fontSize: 15, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                onPressed: () {
                  _showDialogApprovedOrder();
                },
              ),
            ),
            sellerOrderDetailEntity.detail.status!=4?
            SizedBox(width: 4,): SizedBox(),
            sellerOrderDetailEntity.detail.status!=4?
            Container(
              height: getSize(context, true, 29 / 415),
              child: OutlineButton(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: 5),
                      child: Icon(Icons.close, color: BeysionColors.yellow,),
                    ),
                    Text(
                      "Stornieren",
                      style: GoogleFonts.overpass(color: Colors.black, fontSize: 15, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                onPressed: () {
                  _showDialogCancelledOrder(sellerOrderDetailEntity.detail.ordercode);
                },
              ),
            ): SizedBox(),
          ],
        ),
      ],
    ));
  }

  void _showDialogCancelledOrder(String orderCode) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Bestellung stornieren"),
          content: new Text("Möchten Sie die Bestellung stornieren?"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Ja"),
              onPressed: () {
                Navigator.of(context).pop();
                cancelledOrder(orderCode);
              },
            ),new FlatButton(
              child: new Text("Nein"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void cancelledOrder (String orderCode) async {
    SellerService sellerService = new SellerService();
    BaseResponse responseData = await sellerService.cancelOrder(orderCode);
    if (responseData.body != null) {
      if(responseData is OkResponse){
        Provider.of<SellerOrderProvider>(context, listen: false).getSellerOrderShowDataController(orderCode);
        Provider.of<SellerOrderProvider>(context, listen: false).getSellerOrdersListDataController();
      }
    }
  }

  void _showDialogApprovedOrder() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Bestätigung"),
          content: new Text("Möchten Sie die Bestellung bestätigen?"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Ja"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),new FlatButton(
              child: new Text("Nein"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  buildOrderCard(BuildContext context) {
    SellerOrderDetailEntity sellerOrderDetailEntity = Provider.of<SellerOrderProvider>(context, listen: true).sellerOrderDetailEntity;

    return sellerOrderDetailEntity.detail!=null ? Container(
      width: getSize(context, true, 1),
      child: Column(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Bestellnummer",
                style: TextStyle(
                    fontSize: 14, color: BeysionColors.blueNavy),
              ),
              Row(
                children: [
                  Text(
                    "${sellerOrderDetailEntity!=null && sellerOrderDetailEntity.detail.ordercode!=null ? sellerOrderDetailEntity.detail.ordercode: "Load"}",
                    style: TextStyle(
                        fontSize: 14, color: BeysionColors.blueNavy),
                  ),
                  Container(
                    width: getSize(context, true, 165 / 415),
                    height: getSize(context, true, 24 / 415),
                    margin: EdgeInsets.only(
                        left: getSize(context, true, 10 / 415)),
                    decoration: BoxDecoration(
                        color: orderStatusColor(sellerOrderDetailEntity.detail),
                        borderRadius:
                        BorderRadius.all(Radius.circular(2))),
                    child: Center(
                      child: Text(
                        "${orderStatusStr(sellerOrderDetailEntity.detail)}",
                        style:
                        TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: Colors.white),
                      ),
                    ),
                  )
                ],
              )            ],
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
                child: Text(
                  "${sellerOrderDetailEntity!=null && sellerOrderDetailEntity.detail.deliveryTime2 !=null ? sellerOrderDetailEntity.detail.deliveryTime2 : "Load"}",
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
                  "Kunden",
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
                      "${sellerOrderDetailEntity !=null && sellerOrderDetailEntity.buyer!=null ? "${sellerOrderDetailEntity.buyer.name} ${sellerOrderDetailEntity.buyer.surname}": "Load"}",
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
                  "Addresse",
                  style: TextStyle(
                      fontSize: 12,
                      color: Colors.black,
                      fontWeight: FontWeight.w300),
                ),
              ),
              Expanded(
                flex: 1,
                child: Text(
                  "${sellerOrderDetailEntity.address!=null && sellerOrderDetailEntity.address.addressText!=null ? sellerOrderDetailEntity.address.addressText : "Load"}",
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
                  "Lieferart",
                  style: TextStyle(
                      fontSize: 12,
                      color: Colors.black,
                      fontWeight: FontWeight.w300),
                ),
              ),
              Expanded(
                flex: 1,
                child: Text(
                  "${sellerOrderDetailEntity!=null && sellerOrderDetailEntity.detail!=null ? "${sellerOrderDetailEntity.detail.deliveryType} - ${sellerOrderDetailEntity.detail.deliveryTime2}" : "Load"}",
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
        ],
      ),
    ): CircularProgressIndicator();
  }

  buildListInProductItem(BuildContext context, ProductSeller productSeller) {
    int productQuantity = productSeller.qty;
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
            Flexible(
              flex: 3,
              child: Row(
                children: [
                  Image.network(
                    productSeller.image,
                    fit: BoxFit.fitHeight,
                    width: getSize(context, true, 50 / 415),
                    height: getSize(context, true, 50 / 415),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("${productSeller.name}", maxLines: 2, softWrap: true, overflow: TextOverflow.ellipsis,),
                        Text("${productSeller.price} €"),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 10,left: 6,top: 5,bottom: 5),
              child: Column(
                children: [
                  InkWell(
                    child: Container(
                      width: getSize(context, true, 30 / 415),
                      height: getSize(context, true, 30 / 415),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: BeysionColors.yellow),
                      child: Center(child: Text("-")),
                    ),
                    onTap: () {
                      setState(() {
                        if(productSeller.qty > 0){
                          productSeller.qty--;
                        }
                      });
                    },
                  ),
                  Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.all(4),
                    width: getSize(context, true, 22 / 415),
                    height: getSize(context, true, 22 / 415),
                    child: Text(productSeller.qty.toString()),
                  ),
                  InkWell(
                    child: Container(
                      width: getSize(context, true, 30 / 415),
                      height: getSize(context, true, 30 / 415),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: BeysionColors.yellow),
                      child: Center(child: Text("+")),
                    ),
                    onTap: () {
                      setState(() {
                        productSeller.qty++;
                      });
                    },
                  ),
                ],
              ),
            )
          ],
        ),
        Divider(),
      ],
    );
  }

  String orderStatusStr(DetailSeller orderEntity){
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

  Color orderStatusColor(DetailSeller detailSeller){
    try{
      if(detailSeller.status==0){
        return Color(getColorHexFromStr("#5D68CC"));
      }else if(detailSeller.status == 1){
        return Color(getColorHexFromStr("#FFC934"));
      }else if(detailSeller.status == 2){
        return Color(getColorHexFromStr("#1EC1FF"));
      }else if(detailSeller.status == 3){
        return Color(getColorHexFromStr("#1EC1FF"));
      }else if(detailSeller.status == 4){
        return Color(getColorHexFromStr("#e41200"));
      }else {
        return Colors.white;
      }
    }catch(e){
      return Colors.white;
    }
  }

}
