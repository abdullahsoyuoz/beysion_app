import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:beysion/Utility/Colors.dart';
import 'package:beysion/Utility/Icons.dart';
import 'package:beysion/Utility/Widgets.dart';
import 'package:beysion/Utility/util.dart';
import 'package:beysion/constant/app_configurations.dart';
import 'package:beysion/pages/user/MarketDetailHomePage.dart';
import 'package:beysion/rest/service/user_service.dart';
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
import 'UserLoginPage.dart';

class MyFavoritesPage extends StatefulWidget {
  @override
  _MyFavoritesPageState createState() => _MyFavoritesPageState();
}

class _MyFavoritesPageState extends State<MyFavoritesPage> {
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
      appBar: buildAppBar(context),
      body: buildBody(context),
    );
  }

  buildBody(BuildContext context) {
    List<UserFavoriteEntity> userFavoriteList = Provider.of<UserFavoriteProvider>(context, listen: true).userFavoriteList;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(
              top: getSize(context, true, 15 / 415),
              bottom: getSize(context, true, 5 / 415),
              left: getSize(context, true, 20 / 415),
            ),
            child: Text("Meine Favoriten"),
          ),

            userFavoriteList.length > 0 ? Container(
            margin: EdgeInsets.only(top: getSize(context, true, 10 / 415)),
            padding: EdgeInsets.all(getSize(context, true, 5 / 415)),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(5)),
              border: Border.all(color: BeysionColors.border, width: 1),
            ),
            child:GridView.count(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              physics: NeverScrollableScrollPhysics(),
              childAspectRatio: 0.57,
              crossAxisSpacing: getSize(context, true, 15 / 415),
              mainAxisSpacing: getSize(context, true, 10 / 415),
              padding: EdgeInsets.symmetric(
                  vertical: getSize(context, true, 20 / 415),
                  horizontal: getSize(context, true, 10 / 415)),
              crossAxisCount: 2,
              children: userFavoriteList.map((productDiscounted) => BuildProductCard( productDiscounted)).toList(),
            ),
          ): Container(
              height: 300,
              child: Center(child: Text("Sie haben kein Lieblingsprodukt"),),) ],
      ),
    );
  }

}



class BuildProductCard extends StatefulWidget {
  UserFavoriteEntity productEntity;
  BuildProductCard(this.productEntity);

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
                Container(
                  width: getSize(context, true, 100 / 415),
                  height: getSize(context, true, 100 / 485),
                  child: CachedNetworkImage(
                    imageUrl:  widget.productEntity.image,
                    imageBuilder: (context, imageProvider) =>  Image.network(
                      widget.productEntity.image,
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SmoothStarRating(
                      starCount: 5,
                      size: getSize(context, true, 15 / 415),
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
                  widget.productEntity.name,
                  style: GoogleFonts.overpass(
                    color: Colors.black,
                    fontWeight: FontWeight.w300,
                    fontSize: 13,
                  ),
                  maxLines: 2,
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: getSize(context, true, 10 / 415),
                ),
                widget.productEntity.discountPrice!=null ?
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                        flex: 1,
                        child: Container(
                          width: getSize(context, true, 45 / 415),
                          height: getSize(context, true, 45 / 415),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: Colors.red),
                          child: Center(
                            child: Text(
                              favoriteFiyatHesapla(widget.productEntity),
                              overflow: TextOverflow.fade,
                              maxLines: 1,
                              softWrap: false,
                              style: GoogleFonts.overpass(
                                  color: Colors.white,
                                  fontSize: 14,
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
                              "${widget.productEntity.price.toString().replaceAll(".", ",")} €",
                              style: GoogleFonts.overpass(
                                  decoration: TextDecoration.lineThrough,
                                  color: Colors.black38,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400),
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              "${widget.productEntity.discountPrice.toString().replaceAll(".", ",")} €",
                              style: GoogleFonts.overpass(
                                  color: Colors.black,
                                  fontSize: 17,
                                  fontWeight: FontWeight.w700),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        )),
                  ],
                ): Center(
                  child: Text(
                    "${widget.productEntity.price.toString().replaceAll(".", ",")} €",
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
                Container(
                  width: getSize(context, true, 135 / 415),
                  height: getSize(context, true, 50 / 415),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
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
                              child: Text("${widget.productEntity.marketName}",
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
                        InkWell(
                          child: Container(
                            height: getSize(context, true, 30 / 415),
                            decoration: BoxDecoration(
                                color: BeysionColors.orange,
                                borderRadius:
                                BorderRadius.all(Radius.circular(5))),
                            child: widget.productEntity.selected == false ? Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                FaIcon(
                                  FontAwesomeIcons.shoppingBasket,
                                  color: Colors.white,
                                  size: getSize(context, true, 15 / 415),
                                ),
                                SizedBox(
                                  width: getSize(context, true, 5 / 415),
                                ),
                                Text(
                                  "In den Warenkorb",
                                  style: GoogleFonts.overpass(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.white),
                                ),
                              ],
                            ): Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                InkWell(
                                  child: productQuantity != 1 ? Container(
                                    width: getSize(context, true, 22 / 415),
                                    height: getSize(context, true, 22 / 415),
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle, color: Colors.white),
                                    child: Center(child: Text("-")),
                                  ):Container(
                                    width: getSize(context, true, 22 / 415),
                                    height: getSize(context, true, 22 / 415),
                                    child: Center(child: Icon(Icons.delete, color: Colors.white, size: 18,)),
                                  ),
                                  onTap: () async {
                                    if(productQuantity == 1){
                                      BaseResponse basketService = await BasketService.operations().deleteBasketProduct(widget.productEntity.id);
                                      if(basketService is OkResponse){
                                        toastWidget("Das Produkt wurde aus dem Warenkorb gelöscht", Colors.red);
                                        Provider.of<BasketProvider>(context, listen: false).getBasketDetailDataController();
                                        setState(() {
                                          widget.productEntity.selected = false;
                                        });
                                      }
                                    }else{
                                      BasketService basketService = new BasketService();
                                      int addQuant = productQuantity-1;
                                      BaseResponse responseData = await basketService.basketUpdate(widget.productEntity.id, addQuant);
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
                                  child: Text(productQuantity.toString()),
                                ),
                                InkWell(
                                  child: Container(
                                    width: getSize(context, true, 22 / 415),
                                    height: getSize(context, true, 22 / 415),
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.white),
                                    child: Center(child: Text("+")),
                                  ),
                                  onTap: () async {
                                    BasketService basketService = new BasketService();
                                    int addQuant = productQuantity+1;
                                    BaseResponse responseData = await basketService.basketUpdate(widget.productEntity.id, addQuant);
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
                          onTap: () async {
                            BasketService basketService = new BasketService();
                            BaseResponse responseData = await basketService.addBasket(widget.productEntity.id);
                            if (responseData.body != null) {
                              print('BASKER RESPONSEE ${responseData.body}');
                              if(responseData is OkResponse){
                                if(responseData.body["errorCode"].toString().compareTo("1") == 0){
                                  showBasketAddDialogResponse(widget.productEntity);
                                }else{
                                  toastWidget("Das Produkt wurde in den Warenkorb gelegt", Colors.green);
                                  Provider.of<BasketProvider>(context, listen: false).getBasketDetailDataController();
                                  setState(() {
                                    widget.productEntity.selected = true;
                                  });
                                }
                              }else{
                                toastWidget("Das Produkt konnte nicht in den Warenkorb gelegt werden. Etwas ist schief gelaufen.", Colors.red);
                              }
                            }
                            // TODO: inkwell onTap
                          },
                        )
                      ],
                    ),
                  ),
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
                BaseResponse responseData = await userService.userFavoriteDelete(widget.productEntity.favoritesAdsId);
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
                        builder: (context) => UserLoginPage()));
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

      },
    );
  }

  void showBasketAddDialogResponse(UserFavoriteEntity productDataEntity) async {
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
        BaseResponse responseData = await basketService.addBasket(widget.productEntity.id, acceptId: 1);
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


class BuildFavoritesItem extends StatelessWidget {
  UserFavoriteEntity userFavoriteEntity;
  BuildFavoritesItem(this.userFavoriteEntity);
  @override
  Widget build(BuildContext context) {
    return buildContainer(
        context,
        Container(
          padding:
          EdgeInsets.symmetric(vertical: getSize(context, true, 15 / 415)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /*Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: getSize(context, true, 40 / 415),
                    height: getSize(context, true, 26 / 415),
                    decoration: BoxDecoration(
                      color: userFavoriteEntity.rank > 9.5
                          ? BeysionColors.rank1
                          : item.rank > 9.0
                          ? BeysionColors.rank2
                          : item.rank > 8.5
                          ? BeysionColors.rank3
                          : item.rank > 8.0
                          ? BeysionColors.rank4
                          : item.rank < 8.0
                          ? BeysionColors.rank5
                          : Colors.red,
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                    ),
                    child: Center(
                      child: Text("${item.rank}"),
                    ),
                  ),
                  InkWell(
                    child: Container(
                      width: getSize(context, true, 26 / 415),
                      height: getSize(context, true, 26 / 415),
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(IconsPath.delete2))),
                    ),
                    onTap: () {
                      // TODO: delete onTap
                    },
                  )

                ],
              ),*/
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: getSize(context, true, 5 / 415)),
                    child: Text(
                      "${userFavoriteEntity.marketName}",
                      style: GoogleFonts.overpass(fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: BeysionColors.purple),
                    ),
                  ),
                  InkWell(
                    child: Container(
                      width: getSize(context, true, 26 / 415),
                      height: getSize(context, true, 26 / 415),
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(IconsPath.delete2))),
                    ),
                    onTap: () {
                      // TODO: delete onTap
                    },
                  )
                ],
              ),
              Divider(color: BeysionColors.gray2,),
              Text(
                "${userFavoriteEntity.sku}",
                style: GoogleFonts.overpass(fontSize: 12,
                    fontWeight: FontWeight.w300,
                    color: Colors.black),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      "${userFavoriteEntity.name}",
                      style: GoogleFonts.overpass(fontSize: 12,
                          fontWeight: FontWeight.w300,
                          color: BeysionColors.gray2),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
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
                              child: Text("Im Laden einkaufen",
                                  style: GoogleFonts.overpass(
                                      fontSize: 12,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w700)),
                            ),
                          )
                        ],
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MarketDetailHomePage(userFavoriteEntity.mid)));
                      },
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
        bottomMargin: 10);
  }
}
