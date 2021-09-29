import 'package:beysion/Utility/Colors.dart';
import 'package:beysion/Utility/util.dart';
import 'package:beysion/constant/app_configurations.dart';
import 'package:beysion/pages/user/UserLoginPage.dart';
import 'package:beysion/rest/entity/user/basket/basket_detail_entity.dart';
import 'package:beysion/rest/service/user_service.dart';
import 'package:beysion/utility/CustomCarouselWidget.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import '../../rest/controller/user/basket_provider.dart';
import 'package:beysion/rest/controller/user/markets_detail_provider.dart';
import 'package:beysion/rest/entity/user/market/market_detail_entity.dart';
import 'package:beysion/rest/entity/user/product_entity.dart';
import 'package:beysion/rest/response_models/base_response.dart';
import 'package:beysion/rest/response_models/ok_response.dart';
import 'package:beysion/rest/service/basket/basket_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:beysion/constant/app_configurations.dart' as settingRepo;
import 'package:awesome_dialog/awesome_dialog.dart';

import '../../constant/gallery_photo_view.dart';

class ProductDetailBasketPage extends StatefulWidget {
  BasketProduct productEntity;

  ProductDetailBasketPage(this.productEntity, );

  @override
  _ProductDetailBasketPageState createState() => _ProductDetailBasketPageState();
}

class _ProductDetailBasketPageState extends State<ProductDetailBasketPage> {
  TabController _tabController;
  int productQuantity =1;
  bool isAddCartButtonClicked = false;
  bool isOpenProduktbeschreibung = false;
  bool isOpenErnahrungswerte = false;
  bool isOpenErnahrungswerte2 = false;
  bool isOpenProduktrezensionen = false;
  bool verticalGallery = false;
  @override
  void initState() {
    productQuantity = widget.productEntity.qty;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BeysionColors.textFieldBackground,
      body: CustomScrollView(
        physics: ClampingScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(
            child: ListView(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              padding: EdgeInsets.only(top: 0),
              physics: NeverScrollableScrollPhysics(),
              children: [
                Container(
                  color: Colors.white,
                  child: Column(
                    children: [
                      Container(
                        width: getSize(context, true, 1),
                        height: getSize(context, true, 1),
                        child: Stack(
                          children: [
                            CustomCarousel(
                              images: [
                                InkWell(
                                  onTap: (){
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            GalleryPhotoViewWrapper(
                                              galleryItems: [widget.productEntity.image],
                                              backgroundDecoration:
                                              const BoxDecoration(
                                                color: Colors.transparent,
                                              ),
                                              initialIndex: 0,
                                              scrollDirection: verticalGallery
                                                  ? Axis.vertical
                                                  : Axis.horizontal,
                                            ),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    width: getSize(context, true, 1),
                                    height: getSize(context, true, 250/360),
                                    padding: EdgeInsets.all(getSize(context, true, 30/360)),
                                    child: Image.network(widget.productEntity.image),
                                  ),
                                ),
                              ],
                              dotSize: 3,
                              indicatorBgPadding: 8,
                              dotBgColor: Colors.transparent,
                              dotColor: Colors.grey.shade500,
                              dotIncreasedColor: Colors.grey.shade700,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: getSize(context, true, 1),
                        margin: EdgeInsets.only(top: 8),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: getSize(context, true, 20/360)),
                              child: Text("${widget.productEntity.name}",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600
                                ),
                                maxLines: 2,
                                softWrap: false,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                top: 8.0,
                                left: getSize(context, true, 20/360),
                                right: getSize(context, true, 20/360),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      SmoothStarRating(
                                        starCount: 5,
                                        size: getSize(context, true, 20 / 360),
                                        rating: 0,
                                        isReadOnly: false,
                                        allowHalfRating: false,
                                        borderColor: BeysionColors.yellow,
                                        color: BeysionColors.yellow,
                                        onRated: (rating) {},
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 8.0),
                                        child: Text("(3 Kommentar)", style: TextStyle(color: Colors.grey),),
                                      )
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: Text("Lager 99", style: TextStyle(color: Colors.black),),
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 8),
                              child: Column(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        isOpenProduktbeschreibung = !isOpenProduktbeschreibung;
                                      });
                                    },
                                    child: Container(
                                      width: getSize(context, true, 1),
                                      height: getSize(context, true, 60/360),
                                      padding: EdgeInsets.symmetric(horizontal: getSize(context, true, 20/360)),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border(
                                          top: BorderSide(color: Colors.grey.shade300, width: 1),
                                          bottom: BorderSide(color: Colors.grey.shade300, width: isOpenProduktbeschreibung ? 1 : 0),
                                        ),
                                      ),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("Produktbeschreibung"),
                                          FaIcon(isOpenProduktbeschreibung ? FontAwesomeIcons.chevronDown : FontAwesomeIcons.chevronRight, color: Colors.grey.shade700,)
                                        ],
                                      ),
                                    ),
                                  ),
                                  isOpenProduktbeschreibung ?
                                  Container(
                                    width: getSize(context, true, 1),
                                    height: getSize(context, true, 60/360),
                                    padding: EdgeInsets.symmetric(horizontal: getSize(context, true, 20/360)),
                                    decoration: BoxDecoration(
                                      color: Colors.amber,
                                    ),
                                  ) : SizedBox(),
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        isOpenErnahrungswerte = !isOpenErnahrungswerte;
                                      });
                                    },
                                    child: Container(
                                      width: getSize(context, true, 1),
                                      height: getSize(context, true, 60/360),
                                      padding: EdgeInsets.symmetric(horizontal: getSize(context, true, 20/360)),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border(
                                          top: BorderSide(color: Colors.grey.shade300, width: 1),
                                          bottom: BorderSide(color: Colors.grey.shade300, width: isOpenErnahrungswerte ? 1 : 0),
                                        ),
                                      ),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("Ernährungswerte"),
                                          FaIcon(isOpenErnahrungswerte ? FontAwesomeIcons.chevronDown : FontAwesomeIcons.chevronRight, color: Colors.grey.shade700,)
                                        ],
                                      ),
                                    ),
                                  ),
                                  isOpenErnahrungswerte ?
                                  Container(
                                    width: getSize(context, true, 1),
                                    height: getSize(context, true, 60/360),
                                    padding: EdgeInsets.symmetric(horizontal: getSize(context, true, 20/360)),
                                    decoration: BoxDecoration(
                                      color: Colors.amber,
                                    ),
                                  ) : SizedBox(),

                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        isOpenProduktrezensionen = !isOpenProduktrezensionen;
                                      });
                                    },
                                    child: Container(
                                      width: getSize(context, true, 1),
                                      height: getSize(context, true, 60/360),
                                      padding: EdgeInsets.symmetric(horizontal: getSize(context, true, 20/360)),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border(
                                          top: BorderSide(color: Colors.grey.shade300, width: 1),
                                          bottom: BorderSide(color: Colors.grey.shade300, width: isOpenProduktbeschreibung ? 1 : 0),
                                        ),
                                      ),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          RichText(
                                            text: TextSpan(
                                                text: "Produktrezensionen",
                                                style: TextStyle(color: Colors.black),
                                                children: [TextSpan(
                                                    text: " (3)",
                                                    style: TextStyle(color: Colors.grey)
                                                ),
                                                ]),
                                            softWrap: true,),
                                          FaIcon(isOpenProduktbeschreibung ? FontAwesomeIcons.chevronDown : FontAwesomeIcons.chevronRight, color: Colors.grey.shade700,)
                                        ],
                                      ),
                                    ),
                                  ),
                                  isOpenProduktrezensionen ?
                                  Container(
                                    width: getSize(context, true, 1),
                                    height: getSize(context, true, 60/360),
                                    padding: EdgeInsets.symmetric(horizontal: getSize(context, true, 20/360)),
                                    decoration: BoxDecoration(
                                      color: Colors.amber,
                                    ),
                                  ) : SizedBox(),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
      bottomNavigationBar: AnimatedContainer(
        // Renderflex-Overflow error from duration value !!
        duration: Duration(milliseconds: 0),
        height: widget.productEntity.selected == true ? getSize(context, true, 150/360) : getSize(context, true, 60/360),
        width: getSize(context, true, 1),
        padding: EdgeInsets.symmetric(horizontal: getSize(context, true, 20/360)),
        decoration: BoxDecoration(
          color: widget.productEntity.selected == true ? BeysionColors.orange : Colors.white,
          borderRadius: BorderRadius.vertical(
            top: widget.productEntity.selected == true ? Radius.circular(20) : Radius.circular(0)
          )
        ),
        child: widget.productEntity.selected == true ? Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: getSize(context, true, 10/360)),
                  child: Text("Menge"),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //AZALTMAAAA
                    InkWell(
                      onTap: () async {
                        if(productQuantity == 1){
                          BaseResponse basketService = await BasketService.operations().deleteBasketProduct(widget.productEntity.aid);
                          if(basketService is OkResponse){
                            toastWidget("Das Produkt wurde aus dem Warenkorb gelöscht", Colors.red, toastGravity: ToastGravity.CENTER);
                            Provider.of<BasketProvider>(context, listen: false).getBasketDetailDataController();
                            setState(() {
                              widget.productEntity.selected = false;
                            });
                          }
                        }else{
                          BasketService basketService = new BasketService();
                          int addQuant = productQuantity-1;
                          BaseResponse responseData = await basketService.basketUpdate(widget.productEntity.aid, addQuant);
                          if (responseData.body != null) {
                            if(responseData is OkResponse){
                              Provider.of<BasketProvider>(context, listen: false).getBasketDetailDataController();
                              setState((){
                                if(productQuantity > 1){
                                  productQuantity--;
                                }
                              });
                            }
                          }

                        }

                      },
                      child: Container(
                        width: getSize(context, true, 30/360),
                        height: getSize(context, true, 30/360),
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(10)
                        ),
                        child: Center(child: productQuantity != 1 ? FaIcon(FontAwesomeIcons.minus, color: BeysionColors.orange,): FaIcon(Icons.delete, color: BeysionColors.orange,),),
                      ),
                    ),
                    //MİKTARRRR
                    Expanded(
                      child: Container(
                        height: getSize(context, true, 35/360),
                        margin: EdgeInsets.symmetric(horizontal: getSize(context, true, 15/360)),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [BoxShadow(color: Colors.grey, offset: Offset(0, 1))]
                        ),
                        child: Center(child: Text("${productQuantity.toString()}"),),
                      ),
                    ),
                    //ARTTIRMAAAA
                    InkWell(
                      onTap: () async {
                        BasketService basketService = new BasketService();
                        int addQuant = productQuantity+1;
                        BaseResponse responseData = await basketService.basketUpdate(widget.productEntity.aid, addQuant);
                        if (responseData.body != null) {
                          if(responseData is OkResponse){
                            print('GÜNCELLEME BAŞARILIII');
                            Provider.of<BasketProvider>(context, listen: false).getBasketDetailDataController();
                            setState(() {
                              productQuantity++;
                            });
                          }
                        }
                      },
                      child: Container(
                        width: getSize(context, true, 30/360),
                        height: getSize(context, true, 30/360),
                        decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(10)
                        ),
                        child: Center(child: FaIcon(FontAwesomeIcons.plus, color: BeysionColors.orange,),),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: getSize(context, true, 10/360)),
                  child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                  Expanded(
                    flex: 1,
                    child: widget.productEntity.discountPrice == null
                      ? Text("${widget.productEntity.price.toString().replaceAll(".", ",")} €", style: TextStyle( fontSize: 18, fontWeight: FontWeight.w500),)
                      : Row(
                        children: [
                          Container(
                            width: getSize(context, true, 55/360),
                            height: getSize(context, true, 30/360),
                            decoration: BoxDecoration(
                              color: BeysionColors.red,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: Text(fiyatYuzdeHesaplama(null, basketProduct: widget.productEntity), style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("${widget.productEntity.price.toString().replaceAll(".", ",")} €", style: TextStyle(color: Colors.grey, decoration: TextDecoration.lineThrough),),
                                Text("${widget.productEntity.discountPrice.toString().replaceAll(".", ",")} €", style: TextStyle( fontSize: 18, fontWeight: FontWeight.w500),),
                              ],
                            ),
                          )
                        ],
                      ),
                  ),
                  Expanded(
                    flex: 1,
                    child: SizedBox(
                      height: getSize(context, true, 40/360),
                      child: FlatButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Center(child: Text("Zum Warenkorb", style: TextStyle(color: Colors.white), textAlign: TextAlign.center,),),
                        color: BeysionColors.purple,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                    ),
                  )],),
                ),
              ],
            ) : Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 1,
              child: widget.productEntity.discountPrice == null
                ? Text("${widget.productEntity.price.toString().replaceAll(".", ",")} €", style: TextStyle( fontSize: 18, fontWeight: FontWeight.w500),)
                : Row(
                children: [
                  Container(
                    width: getSize(context, true, 55/360),
                    height: getSize(context, true, 30/360),
                    decoration: BoxDecoration(
                      color: BeysionColors.red,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(fiyatYuzdeHesaplama(null, basketProduct: widget.productEntity), style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("${widget.productEntity.price.toString().replaceAll(".", ",")} €", style: TextStyle(color: Colors.grey, decoration: TextDecoration.lineThrough),),
                        Text("${widget.productEntity.discountPrice.toString().replaceAll(".", ",")} €", style: TextStyle( fontSize: 18, fontWeight: FontWeight.w500),),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: SizedBox(
                height: getSize(context, true, 40/360),
                child: FlatButton(
                  onPressed: () async {
                    BasketService basketService = new BasketService();
                    BaseResponse responseData = await basketService.addBasket(widget.productEntity.aid);
                    if (responseData.body != null) {
                      if(responseData is OkResponse){
                        if(responseData.body["errorCode"].toString().compareTo("1") == 0){
                          showBasketAddDialogResponse(widget.productEntity);
                        }else{
                          toastWidget("Das Produkt wurde in den Warenkorb gelegt", Colors.green, toastGravity: ToastGravity.CENTER);
                          Provider.of<BasketProvider>(context, listen: false).getBasketDetailDataController();
                          setState(() {
                            widget.productEntity.selected = true;
                          });
                        }
                      }
                    }
                    // TODO: inkwell onTap
                  },
                  child: Center(child: Text("In den Warenkorb"),),
                  color: BeysionColors.orange,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
              ),
            )
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: false,
        leading: InkWell(
            onTap: (){Navigator.pop(context);},
            child: Center(child: FaIcon(FontAwesomeIcons.chevronLeft, color: Colors.black))
        ),
        title: Text("${widget.productEntity.name}",
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          softWrap: true,
          style: TextStyle(color: Colors.black, fontSize: 14),
        ),
      ),
    );
  }

  void showBasketAddDialogResponse(BasketProduct productDataEntity) async {
    //BASKET ADD YAPTIĞIMIZDA BAŞKA MARKET VARSA ERROR CODE 1 DÖNECEK
    // VE BU UYARIYI GÖSTERECEĞİZ.
    // EĞER KABUL EDERSE AYNI DEĞERLERE EK "accept=1" ekleyip göndereceğiz.
    AwesomeDialog(
      context: context,
      dialogType: DialogType.INFO,
      animType: AnimType.BOTTOMSLIDE,
      dismissOnBackKeyPress: false,
      dismissOnTouchOutside: false,
      title: 'Korbwechselbestätigung',
      desc: 'Ihr Warenkorb enthält Produkte aus anderen Märkten. Möchten Sie Ihren Warenkorb leeren, um das Produkt dieses Marktes in Ihren Warenkorb zu legen?',
      btnCancelText: "CANCEL",
      btnCancelOnPress: () {
      },
      btnOkText: "JA",
      btnOkOnPress: () async {
        BasketService basketService = new BasketService();
        BaseResponse responseData = await basketService.addBasket(productDataEntity.aid, acceptId: 1);
        if (responseData.body != null) {
          print('BASKER RESPONSEE ${responseData.body}');
          if(responseData is OkResponse){
            toastWidget("Das Produkt wurde in den Warenkorb gelegt", Colors.green);
            Provider.of<BasketProvider>(context, listen: false).getBasketDetailDataController();
            setState(() {
              widget.productEntity.selected = true;
            });
          }
        }
      },
    )..show();
  }

}