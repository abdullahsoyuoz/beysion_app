import 'dart:convert';

import 'package:beysion/Utility/util.dart';
import 'package:beysion/constant/app_configurations.dart' as settingRepo;
import 'package:beysion/constant/app_configurations.dart';
import 'package:beysion/pages/seller/SellerLoginPage.dart';
import 'package:beysion/pages/seller/SellerDashboardPage.dart';
import 'package:beysion/rest/controller/user/market_brand_provider.dart';
import 'package:beysion/rest/controller/user/market_campaigns_provider.dart';
import 'package:beysion/rest/controller/user/market_category_provider.dart';
import 'package:beysion/rest/controller/user/market_in_category_provider.dart';
import 'package:beysion/rest/controller/user/market_list_provider.dart';
import 'package:beysion/rest/controller/user/markets_home_provider.dart';
import 'package:beysion/rest/controller/user/product_all_brands_provider.dart';
import 'package:beysion/rest/controller/user/product_all_category_provider.dart';
import 'package:beysion/rest/controller/user/recommended_markets_home_provider.dart';
import 'package:beysion/rest/controller/user/session_create_provider.dart';
import 'package:beysion/rest/entity/seller/seller_login_entity.dart';
import 'package:beysion/rest/entity/user/postal_code_select_entity.dart';
import 'package:beysion/rest/entity/user/zip_code_entity.dart';
import 'package:beysion/rest/response_models/base_response.dart';
import 'package:beysion/rest/response_models/ok_response.dart';
import 'package:beysion/rest/service/postal_code_select_service.dart';
import 'package:beysion/rest/service/zip_code_service.dart';
import 'package:beysion/tabletPages/MainPageViewTablet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:beysion/Utility/Colors.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_map_location_picker/google_map_location_picker.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';
import 'MainPageView.dart';

class WelcomePage extends StatefulWidget {
  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {

  TextEditingController zipCodeOrStreetNameController = new TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool selectedZipCode = false;
  bool getData = false;

  TextEditingController plzController = new TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      try {
        Provider.of<SessionCreateProvider>(context, listen: false).sessionCreateController();
        Provider.of<MarketsHomeProvider>(context, listen: false).getMarketsHomeController();
        Provider.of<RecommendedMarketsHomeProvider>(context, listen: false).getRecommendedMarketsHomeController();
        Provider.of<MarketCategoryProvider>(context, listen: false).getMarketCategoryListController();
        Provider.of<MarketListProvider>(context, listen: false).getMarketListController();
        Provider.of<ProductAllCategoryProvider>(context, listen: false).getProductAllCategoriesController();
        Provider.of<ProductAllBrandsProvider>(context, listen: false).getProductAllBrandsController();
        Provider.of<MarketInCategoryProvider>(context, listen: false).getMarketInCategoryListController(1);
        Provider.of<MarketBrandProvider>(context, listen: false).getAllBrandsController();
        isSellerLoggedInControl();
        zipCodeRecentSearch();
      } catch (e) {
        print('Exception -- WELCOME PAGE PROVIDER -- $e');
      }
    });
  }
  ZipCodeEntity zipCodeEntityRecentSearch = new ZipCodeEntity();

  zipCodeRecentSearch() async {
    String _search = "";
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('recent_search')) {
      _search = prefs.get('recent_search');
      ZipCodeEntity zipCodeEntity = new ZipCodeEntity.fromJson(json.decode(_search));
      zipCodeEntityRecentSearch = zipCodeEntity;
    }else{
      print('İÇERİK YOKKKKKK');
    }
  }

  isSellerLoggedInControl() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey("sellerLoginEntity")) {
      SellerLoginEntity sellerLoginEntity = new SellerLoginEntity.fromJson(
          json.decode(prefs.getString("sellerLoginEntity")));
      settingRepo.sellerLoginInformationEntity.value = sellerLoginEntity;
    } else {
      settingRepo.sellerLoginInformationEntity.value = null;
    }
  }

  @override
  void dispose() {
    zipCodeOrStreetNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        width: getSize(context, true, 1),
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/iconsBack.png"),
              fit: BoxFit.fitHeight,
              colorFilter: ColorFilter.mode(
                  Colors.white.withOpacity(0.8), BlendMode.screen)),
        ),
        child: Stack(
          children: [
            Center(
              child: ListView(
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: getSize(context, true, 75 / 415)),
                    child: Image.asset(
                      "assets/logos/Logo2.png",
                      width: getSize(context, true, 360 / 415),
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                  Padding(
                    padding:
                    EdgeInsets.only(top: getSize(context, true, 70 / 415)),
                    child: Center(
                      child: Text(
                        "wo sind Sie",
                        style: TextStyle(
                            color: BeysionColors.purple,
                            fontSize: 20,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: getSize(context, true, 20 / 415),
                      left: getSize(context, true, 20 / 415),
                      right: getSize(context, true, 20 / 415),
                    ),
                    child: FlatButton(
                      onPressed: () async{
                        LocationResult result = await showLocationPicker(
                          context,
                          "AIzaSyDuzSJKqezawI8gJi7qx-TJ2N_jT7oKoCs",
                          initialCenter: LatLng(51.278804,207.260317),
                          myLocationButtonEnabled: true,
                          hintText: "Suche"
                        );
                        if(result!=null){
                          PostalCodeSelectService postalCodeService = new PostalCodeSelectService();
                          String latLong = "${result.latLng.latitude},${result.latLng.longitude}";
                          BaseResponse responseData = await postalCodeService.postalCodeSearch(latLong);
                          if (responseData.body != null) {
                            if (responseData.body["results"] != null) {
                              if(responseData.body["results"][0]["address_components"]!=null){
                                if(responseData is OkResponse){
                                  List<dynamic> dataList = responseData.body["results"][0]["address_components"];
                                  for (var dataStr in dataList) {
                                    PostalCodeSelectEntity model = new PostalCodeSelectEntity.fromJson(dataStr);
                                    if (model != null) {
                                      if(model.types!=null){
                                        if(model.types[0].toString().compareTo("postal_code")== 0){
                                          List<ZipCodeEntity> _zipCodeListData = await getAllZipCodeListController(model.shortName);
                                          if(_zipCodeListData.length>0){
                                            setState(() {
                                              settingRepo.zipCodeSelectedEntity.value =  _zipCodeListData[0];
                                              selectedZipCode = true;
                                              saveSearch("${json.encode(_zipCodeListData[0].toJson())}");
                                            });
                                            SharedPreferences sharedPref = await SharedPreferences.getInstance();
                                            sharedPref.setString("plzZipCode", _zipCodeListData[0].id.toString());
                                          }else{
                                            settingRepo.toastWidget("Diese Postleitzahl ist nicht verfügbar", Colors.red);
                                          }
                                        }
                                      }
                                    }
                                  }
                                }
                              }
                            }
                          }
                          print("result = $result");
                        }
                      },
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            FaIcon(
                              FontAwesomeIcons.mapMarkerAlt,
                              size: 16,
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 8.0),
                              child: Text(
                                "Verwenden Sie die Kartenhilfe",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w300),
                              ),
                            ),
                          ],
                        ),
                      ),
                      color: BeysionColors.orange,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(7)),
                      height: getSize(context, true, 50 / 415),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: getSize(context, true, 20 / 415),
                      left: getSize(context, true, 20 / 415),
                      right: getSize(context, true, 20 / 415),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                            child: Container(
                              height: 0.5,
                              color: Colors.grey,
                            )),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            "oder",
                            style: TextStyle(color: Colors.grey),
                          ),
                        ),
                        Expanded(
                            child: Container(
                              height: 0.5,
                              color: Colors.grey,
                            )),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                    EdgeInsets.only(top: getSize(context, true, 30 / 415)),
                    child: Center(
                      child: Text(
                        "Ihre Plz-Ort",
                        style: TextStyle(
                            color: BeysionColors.purple,
                            fontSize: 20,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: getSize(context, true, 20 / 415),
                      left: getSize(context, true, 20 / 415),
                      right: getSize(context, true, 20 / 415),
                    ),
                    child: FlatButton(
                      onPressed: () {
                        showFullScreenDialog(context, plzController);
                      },
                      child: Center(
                        child: Text(
                          "${selectedZipCode == false ? "Ihre PLZ" : settingRepo.zipCodeSelectedEntity.value.text}",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w300),
                        ),
                      ),
                      color: Colors.grey.shade200,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(7)),
                      height: getSize(context, true, 50 / 415),
                    ),
                  ),
                  SizedBox(height: 10,),
                  Container(
                    height: getSize(context, true, 50 / 415),
                    padding: EdgeInsets.symmetric(horizontal: getSize(context, true, 20 / 415),),
                    margin: EdgeInsets.only(bottom: getSize(context, true, 10 / 415)),
                    child: FlatButton(
                      color: BeysionColors.yellow,
                      onPressed: () {
                        if (selectedZipCode) {
                          zipCodeOrStreetNameController = new TextEditingController();
                          runApp(MyApp(MainPageView(), MainPageViewTablet()));
                          /*Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => HomePage()));*/
                        }else{
                          settingRepo.toastWidget("Bitte wählen Sie Ihre Postleitzahl!", Colors.red);
                        }
                      },
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            FaIcon(FontAwesomeIcons.user, size: 16,),
                            Padding(padding: EdgeInsets.only(left: 8.0),
                              child: Text("BEGINNE MIT DEM EINKAUF",
                                style: GoogleFonts.overpass(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(7),
                          side: BorderSide(color: Colors.grey.shade300)),
                      height: getSize(context, true, 50 / 415),
                    ),
                  ),
                  SizedBox(height: 65,),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding:
                EdgeInsets.only(bottom: getSize(context, true, 20 / 415)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      height: getSize(context, true, 50 / 415),
                      padding: EdgeInsets.symmetric(
                        horizontal: getSize(context, true, 20 / 415),
                      ),
                      margin: EdgeInsets.only(
                          bottom: getSize(context, true, 10 / 415)),
                      child: FlatButton(
                        onPressed: () {
                          if (settingRepo.sellerLoginInformationEntity.value != null) {
                            if (settingRepo.sellerLoginInformationEntity.value.token !=
                                null) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SellerDashboardPage()));
                            } else {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SellerLoginPage()));
                            }
                          } else {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SellerLoginPage()));
                          }

                        },
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              FaIcon(
                                FontAwesomeIcons.store,
                                size: 16,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 8.0),
                                child: Text(
                                  "FÜR VERKÄUFER",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w300),
                                ),
                              ),
                            ],
                          ),
                        ),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(7),
                            side: BorderSide(color: Colors.grey.shade400)),
                        height: getSize(context, true, 50 / 415),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: getSize(context, true, 10 / 415),
                        left: getSize(context, true, 20 / 415),
                        right: getSize(context, true, 20 / 415),
                      ),
                      child: Text(
                        "2020 beysi-on.de All rights reserved",
                        style: TextStyle(color: Colors.grey.shade700),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<List<ZipCodeEntity>> getAllZipCodeListController(String search) async {
    List<ZipCodeEntity> _zipCodeListData = new List();
    try {
      BaseResponse response = await ZipCodeService.operations().zipCodeSearch(search);
      if (response is OkResponse) {
        if (response.body != null) {
          if (response.body["data"] != null) {
            getData = false;
            List<dynamic> dataList = response.body["data"];
            for (var dataStr in dataList) {
              ZipCodeEntity model = new ZipCodeEntity.fromJson(dataStr);
              if (model != null) {
                setState(() {
                  _zipCodeListData.add(model);
                });
              }
            }
            getData = true;
            return _zipCodeListData;
          } return _zipCodeListData;
        } return _zipCodeListData;
      } return _zipCodeListData;
    } catch (e) {
      print('Exception Get All Zip Code Welcome List Data -- $e');
      return new List();
    }
  }


  void showFullScreenDialog(BuildContext context, TextEditingController testController) {
    List<ZipCodeEntity> _zipCodeListData = new List();
    bool loadingData = false;
    plzController.clear();
    showGeneralDialog(
      context: context,
      barrierColor: Colors.black12.withOpacity(0.6), // background color
      barrierDismissible: false, // should dialog be dismissed when tapped outside
      barrierLabel: "Dialog", // label for barrier
      transitionDuration: Duration(milliseconds: 400), // how long it takes to popup dialog after button click
      pageBuilder: (_, __, ___) {
        // your widget implementation
        return StatefulBuilder(
            builder: (context, setStateC) {
              return SizedBox.expand(
                child: Scaffold(
                  resizeToAvoidBottomInset: false,
                  body: Padding(
                    padding: EdgeInsets.symmetric(horizontal: getSize(context, true, 20 / 415)),
                    child: Container(
                      margin: EdgeInsets.only(
                        top: getSize(context, true, 20 / 415),
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Ihre Postleitzahl",
                                style: TextStyle(
                                    color: BeysionColors.purple,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700),
                              ),
                              IconButton(
                                icon: FaIcon(FontAwesomeIcons.times),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              )
                            ],
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(
                                top: getSize(context, true, 20 / 415),
                                bottom: 20,
                              ),
                              child: Container(
                                width: getSize(context, true, 1),
                                child: Stack(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(5),
                                          boxShadow: [BoxShadow(color: Colors.grey.shade300, blurRadius: 3, spreadRadius: 2)]
                                      ),
                                      child: loadingData == false ? SizedBox(
                                        child: zipCodeEntityRecentSearch!=null && zipCodeEntityRecentSearch.text!=null ? InkWell(
                                          onTap: () async {
                                            settingRepo.zipCodeSelectedEntity.value =  zipCodeEntityRecentSearch;
                                            selectedZipCode = true;
                                            SharedPreferences sharedPref = await SharedPreferences.getInstance();
                                            sharedPref.setString("plzZipCode", zipCodeEntityRecentSearch.id.toString());
                                            Navigator.pop(context);
                                          },
                                          child: Container(
                                            margin: EdgeInsets.only(top: 50),
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  child: Padding(
                                                    padding: const EdgeInsets.all(8.0),
                                                    child: Text("${zipCodeEntityRecentSearch!=null && zipCodeEntityRecentSearch.text!=null ? zipCodeEntityRecentSearch.text: ""}"),
                                                  ),
                                                ),
                                              ],
                                            ),),
                                        ): SizedBox(),
                                      ) :
                                      getData == false ? Container(
                                          margin: EdgeInsets.only(top: 50),
                                          child: Center(child: CircularProgressIndicator())) :
                                      ListView.builder(
                                          shrinkWrap: true,
                                          padding: EdgeInsets.only(top: getSize(context, true, 50/415),),
                                          itemCount: _zipCodeListData.length,
                                          itemBuilder: (context, index){
                                            return InkWell(
                                              onTap: () async {
                                                settingRepo.zipCodeSelectedEntity.value =  _zipCodeListData[index];
                                                selectedZipCode = true;
                                                saveSearch("${json.encode(_zipCodeListData[index].toJson())}");
                                                SharedPreferences sharedPref = await SharedPreferences.getInstance();
                                                sharedPref.setString("plzZipCode", _zipCodeListData[index].id.toString());
                                                Navigator.pop(context);
                                              },
                                              child: Container(
                                                height: getSize(context, true, 50/415),
                                                padding: EdgeInsets.symmetric(horizontal: 20),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  children: [
                                                    Expanded(
                                                      // TODO:
                                                      child: Text("${_zipCodeListData[index].text}",
                                                          overflow: TextOverflow.fade,
                                                          maxLines: 1,
                                                          softWrap: false
                                                      ),
                                                    ),
                                                    FaIcon(FontAwesomeIcons.locationArrow, color: Colors.grey.shade300,)
                                                  ],
                                                ),
                                              ),
                                            );
                                          }),
                                    ),
                                    Container(
                                      height: getSize(context, true, 50/415),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(5),
                                          boxShadow: [BoxShadow(color: Colors.grey.shade200, blurRadius: 3, spreadRadius: 2)]
                                      ),
                                      child: TextField(
                                        controller: testController,
                                        autofocus: true,
                                        decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: "Ihre PLZ",
                                            hintStyle: TextStyle(color: Colors.grey.shade300),
                                            contentPadding: EdgeInsets.only(left: 20)
                                        ),
                                        onChanged: (value) async {
                                          // setState TODO:
                                          if(value.length>2){
                                            setStateC(() {
                                              loadingData = true;
                                              getData = false;
                                            });
                                            _zipCodeListData.clear();
                                            _zipCodeListData = await getAllZipCodeListController(value);
                                            setStateC(() {
                                            });
                                          }else{
                                            setStateC(() {
                                              loadingData = false;
                                              getData = false;
                                              _zipCodeListData.clear();
                                            });
                                          }
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }
        );
      },
    );
  }

  void saveSearch(String search) {
    setRecentSearch(search);
  }

}
