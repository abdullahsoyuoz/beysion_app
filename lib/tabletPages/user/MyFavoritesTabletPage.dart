import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:beysion/Utility/Colors.dart';
import 'package:beysion/Utility/Icons.dart';
import 'package:beysion/Utility/util.dart';
import 'package:beysion/constant/app_configurations.dart';
import 'package:beysion/rest/entity/user/product_entity.dart';
import 'package:beysion/rest/service/user_service.dart';
import 'package:beysion/tabletPages/user/UserLoginTabletPage.dart';
import 'package:beysion/utility/Widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../rest/controller/user/basket_provider.dart';
import 'package:beysion/rest/controller/user/user_favorite_provider.dart';
import 'package:beysion/rest/entity/user/user_favorite_entity.dart';
import 'package:beysion/rest/response_models/base_response.dart';
import 'package:beysion/rest/response_models/ok_response.dart';
import 'package:beysion/rest/service/basket/basket_service.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:beysion/constant/app_configurations.dart' as settingRepo;

class MyFavoritesTabletPage extends StatefulWidget {
  @override
  _MyFavoritesTabletPageState createState() => _MyFavoritesTabletPageState();
}

class _MyFavoritesTabletPageState extends State<MyFavoritesTabletPage> {
  ScrollController _listViewController;


  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      Provider.of<UserFavoriteProvider>(context, listen: false).getUserFavoriteListDataController();
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
    List<UserFavoriteEntity> userFavoriteList = Provider.of<UserFavoriteProvider>(context, listen: true).userFavoriteList;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: getSize(context, true, 20 / 415),
              vertical: getSize(context, true, 10 / 415),
            ),
            child: Text("Meine Favoriten",
                style: GoogleFonts.overpass(
                    color: Colors.black,
                    fontSize: 17,
                    fontWeight: FontWeight.w600)),
          ),

          userFavoriteList.length > 0 ? Container(
            margin: EdgeInsets.only(
              top: getSize(context, true, 0 / 415),
              left: getSize(context, true, 20 / 415),
              right: getSize(context, true, 20 / 415),
            ),
            padding: EdgeInsets.all(getSize(context, true, 0 / 415)),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(5)),
              border: Border.all(color: BeysionColors.border, width: 1),
            ),
            child:GridView.count(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              physics: NeverScrollableScrollPhysics(),
              childAspectRatio: 0.55,
              crossAxisSpacing: getSize(context, true, 10 / 415),
              mainAxisSpacing: getSize(context, true, 10 / 415),
              padding: EdgeInsets.symmetric(
                  vertical: getSize(context, true, 20 / 415),
                  horizontal: getSize(context, true, 10 / 415)),
              crossAxisCount: 3,
              children: userFavoriteList.map((productDiscounted) => BuildProductCard( productDiscounted)).toList(),
            ),
          ):Container(
            height: 300,
            child: Center(child: Text("Sie haben kein Lieblingsprodukt"),),) ],
      ),
    );
  }

}



class BuildProductCard extends StatefulWidget {
  UserFavoriteEntity userFavoriteProduct;
  BuildProductCard(this.userFavoriteProduct);

  @override
  _BuildProductCardState createState() => _BuildProductCardState();
}

class _BuildProductCardState extends State<BuildProductCard> {

  int productQuantity = 1;


  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Stack(children: [
        Container(
          padding: EdgeInsets.zero,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              border: Border.all(color: BeysionColors.border)),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(top: getSize(context, true, 5/415)),
                    child: CachedNetworkImage(
                      imageUrl:  widget.userFavoriteProduct.image,
                      imageBuilder: (context, imageProvider) =>  Image.network(
                        widget.userFavoriteProduct.image,
                        fit: BoxFit.fitHeight,
                      ),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                      placeholder: (context, url) => SizedBox(
                          height: 50,width: 50,
                          child: Center(child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CircularProgressIndicator(),
                          ))),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SmoothStarRating(
                      starCount: 5,
                      size: getSize(context, true, 7 / 415),
                      rating: 0,
                      isReadOnly: false,
                      allowHalfRating: false,
                      borderColor: BeysionColors.yellow,
                      color: BeysionColors.yellow,
                      onRated: (rating) {

                      },
                    ),
                    Text(
                      "(5)",
                      style: GoogleFonts.overpass(fontSize: 12),
                    )
                  ],
                ),
                Text(
                  widget.userFavoriteProduct.name,
                  style: GoogleFonts.overpass(
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                  ),
                  maxLines: 2,
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: getSize(context, true, 5 / 415),
                ),
                widget.userFavoriteProduct.discountPrice!=null ?
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                        flex: 1,
                        child: Container(
                          width: getSize(context, true, 25 / 415),
                          height: getSize(context, true, 25 / 415),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: Colors.red),
                          child: Center(
                            child: Text(
                              favoriteFiyatHesapla(widget.userFavoriteProduct),
                              overflow: TextOverflow.fade,
                              maxLines: 1,
                              softWrap: false,
                              style: GoogleFonts.overpass(
                                  color: Colors.white,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w800),
                            ),
                          ),
                        )),
                    SizedBox(
                      width: getSize(context, true, 5 / 415),
                    ),
                    Flexible(
                        flex: 1,
                        child: Column(
                          children: [
                            Text(
                              "${widget.userFavoriteProduct.price.toString().replaceAll(".", ",")} €",
                              style: GoogleFonts.overpass(
                                  decoration: TextDecoration.lineThrough,
                                  color: Colors.black38,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400),
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              "${widget.userFavoriteProduct.discountPrice.toString().replaceAll(".", ",")} €",
                              style: GoogleFonts.overpass(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        )),
                  ],
                ): Center(
                  child: Text(
                    "${widget.userFavoriteProduct.price.toString().replaceAll(".", ",")} €",
                    style: GoogleFonts.overpass(
                        color: Colors.black,
                        fontSize: 17,
                        fontWeight: FontWeight.w700),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  height: getSize(context, true, 5 / 415),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      FaIcon(
                        FontAwesomeIcons.store,
                        color: BeysionColors.orange,
                        size: getSize(context, true, 12 / 415),
                      ),
                      SizedBox(
                        width: getSize(context, true, 5 / 415),
                      ),
                      /*Text(
                        item.alternativeMarkets == 1
                            ? "Niemerszein Market"
                            : "${item.alternativeMarkets.toString()} Markt",
                        style: GoogleFonts.overpass(
                            fontSize: 10,
                            fontWeight: FontWeight.w400,
                            color: BeysionColors.purple),
                      ),*/
                      Expanded(
                        child: Text("${widget.userFavoriteProduct.marketName}",
                          overflow: TextOverflow.fade,
                          softWrap: false,
                          maxLines: 1,
                          style: GoogleFonts.overpass(
                              fontSize: 10,
                              fontWeight: FontWeight.w400,
                              color: BeysionColors.purple),
                        ),
                      )
                    ],
                  ),
                ),
                InkWell(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: getSize(context, true, 25 / 415),
                      decoration: BoxDecoration(
                          color: BeysionColors.orange,
                          borderRadius:
                          BorderRadius.all(Radius.circular(5))),
                      child: widget.userFavoriteProduct.selected == false ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          FaIcon(
                            FontAwesomeIcons.shoppingBasket,
                            color: Colors.black,
                            size: getSize(context, true, 9 / 415),
                          ),
                          SizedBox(
                            width: getSize(context, true, 2 / 415),
                          ),
                          Text(
                            "In den Warenkorb",
                            style: GoogleFonts.overpass(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: Colors.black),
                          ),
                        ],
                      ): Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          InkWell(
                            child: productQuantity != 1 ? Container(
                              width: getSize(context, true, 15 / 415),
                              height: getSize(context, true, 15 / 415),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle, color: Colors.white),
                              child: Center(child: Text("-", style: TextStyle(fontSize: 20),)),
                            ):Container(
                              width: getSize(context, true, 22 / 415),
                              height: getSize(context, true, 22 / 415),
                              child: Center(child: Icon(Icons.delete, color: Colors.white, size: 24,)),
                            ),
                            onTap: () async {
                              if(productQuantity == 1){
                                BaseResponse basketService = await BasketService.operations().deleteBasketProduct(widget.userFavoriteProduct.favoritesAdsId);
                                if(basketService is OkResponse){
                                  toastWidget("Das Produkt wurde aus dem Warenkorb gelöscht", Colors.red);
                                  Provider.of<BasketProvider>(context, listen: false).getBasketDetailDataController();
                                  setState(() {
                                    widget.userFavoriteProduct.selected = false;
                                  });
                                }
                              }else{
                                BasketService basketService = new BasketService();
                                int addQuant = productQuantity-1;
                                BaseResponse responseData = await basketService.basketUpdate(widget.userFavoriteProduct.favoritesAdsId, addQuant);
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
                          ),
                          Container(
                            alignment: Alignment.center,
                            width: getSize(context, true, 22 / 415),
                            height: getSize(context, true, 22 / 415),
                            child: Text(productQuantity.toString(), style: TextStyle(fontSize: 20),),
                          ),
                          InkWell(
                            child: Container(
                              width: getSize(context, true, 15 / 415),
                              height: getSize(context, true, 15 / 415),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white),
                              child: Center(child: Text("+")),
                            ),
                            onTap: () async {
                              BasketService basketService = new BasketService();
                              int addQuant = productQuantity+1;
                              BaseResponse responseData = await basketService.basketUpdate(widget.userFavoriteProduct.favoritesAdsId, addQuant);
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
                          ),
                        ],
                      ),
                    ),
                  ),
                  onTap: () async {
                    BasketService basketService = new BasketService();
                    BaseResponse responseData = await basketService.addBasket(widget.userFavoriteProduct.favoritesAdsId);
                    if (responseData.body != null) {
                      if(responseData is OkResponse){
                        if(responseData.body["errorCode"].toString().compareTo("1") == 0){
                          showBasketAddDialogResponse(widget.userFavoriteProduct.favoritesAdsId);
                        }else{
                          toastWidget("Das Produkt wurde in den Warenkorb gelegt", Colors.green, toastGravity: ToastGravity.CENTER);
                          Provider.of<BasketProvider>(context, listen: false).getBasketDetailDataController();
                          setState(() {
                            widget.userFavoriteProduct.selected = true;
                          });
                        }
                      }else{
                        toastWidget("Das Produkt konnte nicht in den Warenkorb gelegt werden.", Colors.red, toastGravity: ToastGravity.CENTER);
                      }
                    }
                    // TODO: inkwell onTap
                  },
                ),
                SizedBox(
                  height: getSize(context, true, 10 / 415),
                )
              ],
            ),
          ),
        ),
        Positioned(
          right: -20.0,
          top: 0.0,
          child: RawMaterialButton(
            onPressed: () async {
              if(settingRepo.currentUserTokenEntity.value.token!=null){
                UserService userService = new UserService();
                BaseResponse responseData = await userService.userFavoriteDelete(widget.userFavoriteProduct.favoritesAdsId);
                if (responseData.body != null) {
                  if(responseData is OkResponse){
                    Provider.of<UserFavoriteProvider>(context, listen: false).getUserFavoriteListDataController();
                  }else{
                    toastWidget("Das Produkt konnte nicht aus den Favoriten entfernt werden!", Colors.red);
                  }
                }else{
                  toastWidget("Das Produkt konnte nicht aus den Favoriten entfernt werden!", Colors.red);
                }
              }else{
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => UserLoginTabletPage()));
              }
            },
            fillColor: Colors.white,
            shape: CircleBorder(),
            elevation: 4.0,
            child: Padding(
              padding: EdgeInsets.all(5),
              child: Icon(
                Icons.favorite,
                color: BeysionColors.yellow,
                size: 20,
              ),
            ),
          ),
        ),
      ],
      ),
      onTap: () {
        // FIXME: onTap navigator => productDetail 1 ise şu 1'den fazla market ise şu
        /*Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ProductDetailPage(widget.productEntity.favoritesAdsId)));*/
        /* if (item.alternativeMarkets == 1) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ProductAltPricesPage()));
        }
        if (item.alternativeMarkets > 1) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ProductAltPricesPage()));
        }*/
      },
    );
  }

  void showBasketAddDialogResponse(int productDataEntity) async {
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
        BaseResponse responseData = await basketService.addBasket(productDataEntity, acceptId: 1);
        if (responseData.body != null) {
          print('BASKER RESPONSEE ${responseData.body}');
          if(responseData is OkResponse){
            toastWidget("Das Produkt wurde in den Warenkorb gelegt", Colors.green);
            Provider.of<BasketProvider>(context, listen: false).getBasketDetailDataController();
            setState(() {
              widget.userFavoriteProduct.selected = true;
            });
          }
        }
      },
    )..show();
  }

}