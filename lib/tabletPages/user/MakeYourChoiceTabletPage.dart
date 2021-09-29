import 'package:auto_size_text/auto_size_text.dart';
import 'package:beysion/Utility/Colors.dart';
import 'package:beysion/Utility/Icons.dart';
import 'package:beysion/Utility/util.dart';
import 'package:beysion/constant/app_configurations.dart';
import 'package:beysion/constant/text_field_search.dart';
import 'package:beysion/constant/zip_code_field_entity.dart';
import 'package:beysion/rest/service/user_address_service.dart';
import 'package:beysion/utility/Widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../rest/controller/user/basket_provider.dart';
import 'package:beysion/rest/controller/user/user_address_provider.dart';
import 'package:beysion/rest/entity/user/basket/basket_detail_entity.dart';
import 'package:beysion/rest/entity/user/user_address_entity.dart';
import 'package:beysion/rest/entity/user/zip_code_entity.dart';
import 'package:beysion/rest/response_models/base_response.dart';
import 'package:beysion/rest/response_models/ok_response.dart';
import 'package:beysion/rest/service/zip_code_service.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:beysion/constant/app_configurations.dart' as settingRepo;
import 'MakeYourPaymentTabletPage.dart';

class MakeYourChoiceTabletPage extends StatefulWidget {
  @override
  _MakeYourChoiceTabletPageState createState() =>
      _MakeYourChoiceTabletPageState();
}

class _MakeYourChoiceTabletPageState extends State<MakeYourChoiceTabletPage> {
  ScrollController _choiceListViewController;
  final GlobalKey<FormState> _choiceFormKey = GlobalKey<FormState>();
  bool checkCorporateInvoice = false;
  bool checkBeysionNewsletter = false;
  bool checkPrivacyPolicy = false;
  bool isLoginVisible = true;
  bool isYourAddressVisible = true;
  int checkRadioDelivery;
  int checkPaymentType = 0;
  int selectedDropDownValueGender = 0;
  int selectedDropDownValueCountry = 0;

  int selectedAddress = 0;

  TextEditingController zipCodeOrStreetNameController = new TextEditingController();

  @override
  void initState() {
    super.initState();
    _choiceListViewController = ScrollController();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      Provider.of<UserAddressProvider>(context, listen: false)
          .getUserAddressAllDataController();
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
    return Stack(
      children: [
        buildChoiceBody(context),
        buildMakeYourChoicePageTopNavigationBar(context, 1),
        buildBottomSheet(context),
      ],
    );
  }

  buildMakeYourChoicePageTopNavigationBar(BuildContext context, int index) {
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        width: getSize(context, true, 1),
        height: getSize(context, true, 40 / 415),
        decoration: BoxDecoration(
          color: BeysionColors.blueNavy,
        ),
        padding:
            EdgeInsets.symmetric(horizontal: getSize(context, true, 20 / 415)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Image.asset(IconsPath.basket,
                width: getSize(context, true, 15 / 415),
                height: getSize(context, true, 15 / 415),
                fit: BoxFit.fitWidth,
                color:
                    index == 0 ? BeysionColors.yellow : BeysionColors.overlay),
            SizedBox(
              width: getSize(context, true, 5 / 415),
            ),
            FaIcon(
              FontAwesomeIcons.chevronRight,
              color: BeysionColors.overlay,
              size: getSize(context, true, 15 / 415),
            ),
            SizedBox(
              width: getSize(context, true, 5 / 415),
            ),
            Image.asset(
              IconsPath.sign,
              color: index == 1 ? BeysionColors.yellow : BeysionColors.overlay,
              width: getSize(context, true, 15 / 415),
              height: getSize(context, true, 15 / 415),
            ),
            SizedBox(
              width: getSize(context, true, 5 / 415),
            ),
            AutoSizeText(
              "Registrierung - Anmeldung",
              style: GoogleFonts.overpass(
                  color: index == 1 ? Colors.white : BeysionColors.overlay,
                  fontSize: 16),
              minFontSize: 5,
            ),
            SizedBox(
              width: getSize(context, true, 5 / 415),
            ),
            FaIcon(
              FontAwesomeIcons.chevronRight,
              color: BeysionColors.overlay,
              size: getSize(context, true, 15 / 415),
            ),
            SizedBox(
              width: getSize(context, true, 5 / 415),
            ),
            Image.asset(
              IconsPath.wallet,
              color: index == 2 ? BeysionColors.yellow : BeysionColors.overlay,
              width: getSize(context, true, 15 / 415),
              height: getSize(context, true, 15 / 415),
            ),
            SizedBox(
              width: getSize(context, true, 5 / 415),
            ),
            FaIcon(
              FontAwesomeIcons.chevronRight,
              color: BeysionColors.overlay,
              size: getSize(context, true, 15 / 415),
            ),
            SizedBox(
              width: getSize(context, true, 5 / 415),
            ),
            FaIcon(
              FontAwesomeIcons.checkCircle,
              color: BeysionColors.overlay,
              size: getSize(context, true, 25 / 415),
            ),
          ],
        ),
      ),
    );
  }

  buildBottomSheet(BuildContext context) {
    BasketDetailEntity basketDetailEntity =
        Provider.of<BasketProvider>(context, listen: true).basketDetailEntity;
    return Align(
      alignment: Alignment.bottomCenter,
      child: DraggableScrollableSheet(
        initialChildSize: 0.1,
        minChildSize: 0.1,
        maxChildSize: 0.6,
        builder: (context, scrollController) {
          return Container(
            color: Colors.white,
            width: getSize(context, true, 1),
            height: getSize(context, true, 1),
            padding: EdgeInsets.only(
                left: getSize(context, true, 20 / 415),
                right: getSize(context, true, 20 / 415),
                top: getSize(context, true, 10 / 415)),
            child: ListView(
              shrinkWrap: true,
              controller: scrollController,
              physics: ClampingScrollPhysics(),
              padding: EdgeInsets.symmetric(
                  horizontal: getSize(context, true, 15 / 415)),
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          FaIcon(
                            FontAwesomeIcons.chevronUp,
                            color: BeysionColors.orange,
                            size: getSize(context, true, 20 / 415),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Text(
                                "Gesamtmenge",
                                style: GoogleFonts.overpass(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                "${basketDetailEntity.basketTotalPrice.toString().replaceAll(".", ",")} €",
                                style: GoogleFonts.overpass(
                                    fontSize: 17, fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: RaisedButton(
                        color: BeysionColors.yellow,
                        child: Center(
                            child: Text(
                          "AUSCHECKEN",
                          style: GoogleFonts.overpass(
                              fontSize: 15, fontWeight: FontWeight.w400),
                        )),
                        onPressed: () {
                          if (checkPrivacyPolicy) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        MakeYourPaymentTabletPage()));
                          } else {
                            toastWidget("Akzeptiere den Vertrag", Colors.red);
                          }
                        },
                      ),
                    )
                  ],
                ),
                Divider(),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: getSize(context, true, 20 / 415),
                    ),
                    child: Text(
                      "General Info",
                      style: GoogleFonts.overpass(
                          fontSize: 17, fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
                Divider(),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                      padding: EdgeInsets.only(
                        top: getSize(context, true, 10 / 415),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Total (${basketDetailEntity.basketMarketDataList.length} Items)",
                            style: GoogleFonts.overpass(
                                fontSize: 15, fontWeight: FontWeight.w400),
                          ),
                          Text(
                            "${basketDetailEntity.basketTotalPrice} €",
                            style: GoogleFonts.overpass(
                                fontSize: 15, fontWeight: FontWeight.w400),
                          ),
                        ],
                      )),
                ),
                Divider(),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: getSize(context, true, 20 / 415),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          "Our Delivery Costs:",
                          style: GoogleFonts.overpass(
                              fontSize: 20, fontWeight: FontWeight.w500),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: getSize(context, true, 2 / 415)),
                          child: Text(
                            "From 90 € we deliver for free Up to € 90 purchase value from € 1.90",
                            style: GoogleFonts.overpass(
                                fontSize: 16, fontWeight: FontWeight.w400),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              bottom: getSize(context, true, 15 / 415)),
                          child: Text(
                            "Enter Promo Code",
                            style: GoogleFonts.overpass(
                                fontSize: 15,
                                fontWeight: FontWeight.w300,
                                decoration: TextDecoration.underline,
                                color: BeysionColors.purple),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }

  buildChoiceBody(BuildContext context) {
    return ListView(
      controller: _choiceListViewController,
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      padding: EdgeInsets.only(
        //horizontal: getSize(context, true, 20 / 415),
        top: getSize(context, true, 50 / 415),
        bottom: getSize(context, true, 70 / 415),
      ),
      children: [
        Padding(
          padding: EdgeInsets.only(
            left: getSize(context, true, 20 / 415),
            top: getSize(context, true, 10 / 415),
            bottom: getSize(context, true, 10 / 415),
          ),
          child: Text(
            isYourAddressVisible == true
                ? "Lieferauswahl"
                : "Treffen Sie Ihre Wahl",
            style: GoogleFonts.overpass(
                color: Colors.black, fontSize: 17, fontWeight: FontWeight.w600),
          ),
        ),
        buildChoiceBodyChild(context),
      ],
    );
  }

  ScrollController _listViewController;
  UserAddressEntity selectedUserAddressEntity;
  ZipCodeEntity selectedZipCode = new ZipCodeEntity();

  buildChoiceBodyChild(BuildContext context) {
    TextEditingController dialogZipPLZCode = new TextEditingController();
    TextEditingController dialogAdressName = new TextEditingController();
    TextEditingController dialogAdresses = new TextEditingController();
    TextEditingController dialogName = new TextEditingController();
    TextEditingController dialogNachname = new TextEditingController();
    TextEditingController dialogMobilTelefon = new TextEditingController();
    List<UserAddressEntity> userAddressList = Provider.of<UserAddressProvider>(context, listen: true).userAddressList;
    return Form(
        key: _choiceFormKey,
        child: buildContainer(
            context,
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                userAddressList.length > 0
                    ? GridView.count(
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        physics: NeverScrollableScrollPhysics(),
                        childAspectRatio: 1.75,
                        crossAxisSpacing: getSize(context, true, 5 / 415),
                        mainAxisSpacing: getSize(context, true, 5 / 415),
                        crossAxisCount: 2,
                        children: List<Widget>.generate(userAddressList.length,(index)=> buildAddressCard(context, index, userAddressList[index])))
                    : SizedBox(),
                InkWell(
                  onTap: () async {
                    await Future.delayed(Duration(milliseconds: 50))
                        .then((value) => showDialog(
                            context: context,
                            barrierDismissible: true,
                            builder: (context) {
                              return StatefulBuilder(
                                builder: (context, setsState) {
                                  return Dialog(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(getSize(context, true, 5 / 415))),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width * 380 / 415,
                                      height: MediaQuery.of(context).size.width * 400 / 415,
                                      padding: EdgeInsets.symmetric(
                                        vertical: getSize(context, true, 15 / 415),
                                        horizontal: getSize(context, true, 10 / 415),
                                      ),
                                      decoration: BoxDecoration(
                                          color: BeysionColors.background,
                                          shape: BoxShape.rectangle,
                                          borderRadius: BorderRadius.all(Radius.circular(getSize(context, true, 5 / 415)))),
                                      child: ListView(
                                        children: [
                                          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "Neue Adresse hinzufügen",
                                                style: GoogleFonts.overpass(
                                                    color: BeysionColors.purple,
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              IconButton(
                                                icon: FaIcon(
                                                  FontAwesomeIcons.times,
                                                  color: BeysionColors.gray2,
                                                  size: getSize(
                                                      context, true, 20 / 415),
                                                ),
                                                onPressed: () {
                                                  dialogZipPLZCode = new TextEditingController();
                                                  Navigator.pop(context);
                                                },
                                              )
                                            ],
                                          ),
                                          Align(
                                            alignment: Alignment.centerLeft,
                                            child: RichText(
                                              text: TextSpan(
                                                  text: "Adressname",
                                                  style: GoogleFonts.overpass(
                                                      color: Colors.black,
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                  children: [
                                                    TextSpan(
                                                        text: "*",
                                                        style: GoogleFonts
                                                            .overpass(
                                                                color:
                                                                    Colors.red))
                                                  ]),
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(
                                              top: getSize(
                                                  context, true, 5 / 415),
                                              bottom: getSize(
                                                  context, true, 20 / 415),
                                            ),
                                            padding: EdgeInsets.symmetric(
                                                horizontal: getSize(
                                                    context, true, 5 / 415)),
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                border: Border.all(
                                                    color: BeysionColors
                                                        .textFieldBackground,
                                                    width: 4),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(getSize(
                                                        context,
                                                        true,
                                                        12 / 415)))),
                                            child: TextField(
                                              controller: dialogAdressName,
                                              decoration: InputDecoration(
                                                contentPadding:
                                                    EdgeInsets.symmetric(
                                                        horizontal: getSize(
                                                            context,
                                                            true,
                                                            10 / 415)),
                                                border: InputBorder.none,
                                              ),
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              Flexible(
                                                flex: 1,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Align(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: RichText(
                                                        text: TextSpan(
                                                            text: "Name",
                                                            style: GoogleFonts
                                                                .overpass(
                                                                    color: Colors
                                                                        .black,
                                                                    fontSize: 15,
                                                                    fontWeight: FontWeight.w600),
                                                            children: [
                                                              TextSpan(
                                                                  text: "*",
                                                                  style: GoogleFonts
                                                                      .overpass(
                                                                          color:
                                                                              Colors.red))
                                                            ]),
                                                      ),
                                                    ),
                                                    Container(
                                                      margin: EdgeInsets.only(
                                                        top: getSize(context,
                                                            true, 5 / 415),
                                                        bottom: getSize(context,
                                                            true, 20 / 415),
                                                      ),
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal:
                                                                  getSize(
                                                                      context,
                                                                      true,
                                                                      5 / 415)),
                                                      decoration: BoxDecoration(
                                                          color: Colors.white,
                                                          border: Border.all(
                                                              color: BeysionColors
                                                                  .textFieldBackground,
                                                              width: 4),
                                                          borderRadius: BorderRadius
                                                              .all(Radius.circular(
                                                                  getSize(
                                                                      context,
                                                                      true,
                                                                      12 /
                                                                          415)))),
                                                      child: TextField(
                                                        controller: dialogName,
                                                        decoration:
                                                            InputDecoration(
                                                          contentPadding:
                                                              EdgeInsets.symmetric(
                                                                  horizontal: getSize(
                                                                      context,
                                                                      true,
                                                                      10 /
                                                                          415)),
                                                          border:
                                                              InputBorder.none,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                width: getSize(
                                                    context, true, 10 / 415),
                                              ),
                                              Flexible(
                                                flex: 1,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Align(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: RichText(
                                                        text: TextSpan(
                                                            text: "Nachname",
                                                            style: GoogleFonts
                                                                .overpass(
                                                                    color: Colors
                                                                        .black,
                                                                    fontSize: 15,
                                                                    fontWeight: FontWeight.w600),
                                                            children: [
                                                              TextSpan(
                                                                  text: "*",
                                                                  style: GoogleFonts
                                                                      .overpass(
                                                                          color:
                                                                              Colors.red))
                                                            ]),
                                                      ),
                                                    ),
                                                    Container(
                                                      margin: EdgeInsets.only(
                                                        top: getSize(context,
                                                            true, 5 / 415),
                                                        bottom: getSize(context,
                                                            true, 20 / 415),
                                                      ),
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal:
                                                                  getSize(
                                                                      context,
                                                                      true,
                                                                      5 / 415)),
                                                      decoration: BoxDecoration(
                                                          color: Colors.white,
                                                          border: Border.all(
                                                              color: BeysionColors
                                                                  .textFieldBackground,
                                                              width: 4),
                                                          borderRadius: BorderRadius
                                                              .all(Radius.circular(
                                                                  getSize(
                                                                      context,
                                                                      true,
                                                                      12 /
                                                                          415)))),
                                                      child: TextField(
                                                        controller: dialogNachname,
                                                        decoration:
                                                            InputDecoration(
                                                          contentPadding:
                                                              EdgeInsets.symmetric(
                                                                  horizontal: getSize(
                                                                      context,
                                                                      true,
                                                                      10 /
                                                                          415)),
                                                          border:
                                                              InputBorder.none,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Flexible(
                                                flex: 1,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Align(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: RichText(
                                                        text: TextSpan(
                                                            text:
                                                                "Mobiltelefon",
                                                            style: GoogleFonts
                                                                .overpass(
                                                                    color: Colors
                                                                        .black,
                                                                    fontSize: 15,
                                                                    fontWeight: FontWeight.w600),
                                                            children: [
                                                              TextSpan(
                                                                  text: "*",
                                                                  style: GoogleFonts
                                                                      .overpass(
                                                                          color:
                                                                              Colors.red))
                                                            ]),
                                                      ),
                                                    ),
                                                    Container(
                                                      margin: EdgeInsets.only(
                                                        top: getSize(context,
                                                            true, 5 / 415),
                                                        bottom: getSize(context,
                                                            true, 20 / 415),
                                                      ),
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal:
                                                                  getSize(
                                                                      context,
                                                                      true,
                                                                      5 / 415)),
                                                      decoration: BoxDecoration(
                                                          color: Colors.white,
                                                          border: Border.all(
                                                              color: BeysionColors
                                                                  .textFieldBackground,
                                                              width: 4),
                                                          borderRadius: BorderRadius
                                                              .all(Radius.circular(
                                                                  getSize(
                                                                      context,
                                                                      true,
                                                                      12 /
                                                                          415)))),
                                                      child: TextField(
                                                        controller: dialogMobilTelefon,
                                                        decoration: InputDecoration(contentPadding: EdgeInsets.symmetric(horizontal: getSize(context, true, 10 / 415)),
                                                          border: InputBorder.none,
                                                        ),
                                                        keyboardType: TextInputType.phone,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                width: getSize(
                                                    context, true, 10 / 415),
                                              ),
                                              Flexible(
                                                flex: 1,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Align(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: RichText(
                                                        text: TextSpan(
                                                            text:
                                                                "Postleitzahl",
                                                            style: GoogleFonts
                                                                .overpass(
                                                                    color: Colors
                                                                        .black,
                                                                    fontSize: 15,
                                                                    fontWeight: FontWeight.w600),
                                                            children: [
                                                              TextSpan(
                                                                  text: "*",
                                                                  style: GoogleFonts
                                                                      .overpass(
                                                                          color:
                                                                              Colors.red))
                                                            ]),
                                                      ),
                                                    ),
                                                    Container(
                                                      margin: EdgeInsets.only(
                                                        top: getSize(context,true,5 / 415),
                                                        bottom: getSize(context,true,20 / 415),
                                                      ),
                                                      padding: EdgeInsets.symmetric(horizontal: getSize(context,true,5 / 415)),
                                                      decoration: BoxDecoration(
                                                          color: Colors.white,
                                                          border: Border.all(
                                                              color: BeysionColors
                                                                  .textFieldBackground,
                                                              width: 4),
                                                          borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  getSize(context, true, 12/415)))),
                                                      child: TextFieldSearch(
                                                          decoration: InputDecoration(
                                                              border: InputBorder.none
                                                          ),
                                                          label: 'Ihre PLZ',
                                                          controller: dialogZipPLZCode,
                                                          getSelectedValue: (item) {
                                                            ZipCodeEntity zipCodeFirst = new ZipCodeEntity();
                                                            zipCodeFirst.text = "${item.label}";
                                                            zipCodeFirst.id = int.parse("${item.value}");
                                                            selectedZipCode = zipCodeFirst;
                                                          },
                                                          future: () {
                                                            return getAllZipCodeListController(dialogZipPLZCode.text);
                                                          }),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          Align(
                                            alignment: Alignment.centerLeft,
                                            child: RichText(
                                              text: TextSpan(
                                                  text: "Adresse",
                                                  style: GoogleFonts.overpass(
                                                      color: Colors.black,
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                  children: [
                                                    TextSpan(
                                                        text: "*",
                                                        style: GoogleFonts
                                                            .overpass(
                                                                color:
                                                                    Colors.red))
                                                  ]),
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(
                                              top: getSize(
                                                  context, true, 5 / 415),
                                              bottom: getSize(
                                                  context, true, 20 / 415),
                                            ),
                                            padding: EdgeInsets.symmetric(
                                                horizontal: getSize(
                                                    context, true, 5 / 415)),
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                border: Border.all(
                                                    color: BeysionColors
                                                        .textFieldBackground,
                                                    width: 4),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(getSize(
                                                        context,
                                                        true,
                                                        12 / 415)))),
                                            child: TextField(
                                              controller: dialogAdresses,
                                              minLines: 3,
                                              maxLines: 3,
                                              decoration: InputDecoration(
                                                contentPadding:
                                                    EdgeInsets.symmetric(
                                                        horizontal: getSize(
                                                            context,
                                                            true,
                                                            10 / 415),
                                                        vertical: getSize(
                                                            context,
                                                            true,
                                                            10 / 415)),
                                                border: InputBorder.none,
                                              ),
                                            ),
                                          ),
                                          FlatButton(
                                            minWidth: getSize(
                                                context, true, 50 / 415),
                                            padding: EdgeInsets.all(getSize(
                                                context, true, 15 / 415)),
                                            color: BeysionColors.orange,
                                            child: Center(
                                              child: Text(
                                                "Adresse hinzufügen",
                                                textAlign: TextAlign.center,
                                                style: GoogleFonts.overpass(
                                                    color: Colors.black,
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.w700),
                                              ),
                                            ),
                                            onPressed: () async {
                                              AddedAddressEntity addressEntity = new AddedAddressEntity();
                                              addressEntity.name = dialogAdressName.text;
                                              addressEntity.lastname = dialogNachname.text;
                                              addressEntity.firstname = dialogName.text;
                                              addressEntity.phone = dialogMobilTelefon.text;
                                              addressEntity.address = dialogAdresses.text;
                                              addressEntity.zipcode = selectedZipCode.id;
                                              addressEntity.defaultData = 0;
                                              UserAddressService addressService = new UserAddressService();
                                              BaseResponse responseData = await addressService.addAddress(addressEntity);
                                              if (responseData.body != null) {
                                                print('RESPONSEEE {${responseData.body}');
                                                if(responseData is OkResponse){
                                                  Navigator.pop(context);
                                                  Provider.of<UserAddressProvider>(context, listen: false).getUserAddressAllDataController();
                                                  dialogZipPLZCode = new TextEditingController();
                                                }
                                              }else{
                                                toastWidget("Die Adresse konnte nicht hinzugefügt werden. Bitte versuche es erneut!", Colors.red);
                                              }
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                            }));
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: getSize(context, true, 5 / 415)),
                    child: Stack(
                      children: [
                        Container(
                            width: getSize(context, true, 1),
                            height: getSize(context, true, 100 / 415),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(Radius.circular(
                                  getSize(context, true, 5 / 415))),
                              border: Border.all(
                                  color: BeysionColors.gray1, width: 3),
                            ),
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  FaIcon(
                                    FontAwesomeIcons.plus,
                                    color: BeysionColors.orange,
                                    size: getSize(context, true, 30 / 415),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        top: getSize(context, true, 5 / 415)),
                                    child: Text(
                                      "Neue Adresse hinzufügen",
                                      style: GoogleFonts.overpass(
                                          color: Colors.black,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  )
                                ],
                              ),
                            )),
                      ],
                    ),
                  ),
                ),
                buildSelectPayment(context),
                Padding(
                  padding: EdgeInsets.only(
                    top: getSize(context, true, 15 / 415),
                    left: getSize(context, true, 15 / 415),
                    right: getSize(context, true, 15 / 415),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Checkbox(
                            value: checkPrivacyPolicy,
                            onChanged: (value) {
                              setState(() {
                                checkPrivacyPolicy = value;
                              });
                            },
                          ),
                          Expanded(
                            child: AutoSizeText(
                              "Ich habe die Datenschutzrichtlinie und die Nutzungsbedingungen gelesen und akzeptiert",
                              style: GoogleFonts.overpass(
                                  fontSize: 15, fontWeight: FontWeight.w300),
                              maxLines: 2,
                              minFontSize: 10,
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 60,
                )
              ],
            )));
  }

  buildSelectPayment(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: getSize(context, true, 15 / 415),
        left: getSize(context, true, 15 / 415),
        right: getSize(context, true, 15 / 415),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "ZAHLUNG AUSWÄHLEN",
            style: GoogleFonts.overpass(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: BeysionColors.purple),
          ),
          buildSelectPaymentChild(context),
        ],
      ),
    );
  }

  buildAddressCard(
      BuildContext context, int index, UserAddressEntity userAddress) {
    return InkWell(
      onTap: () {
        setState(() {
          selectedAddress = index;
          selectedUserAddressEntity = userAddress;
          settingRepo.selectedUserAddress.value = userAddress;
        });
      },
      child: Stack(
        children: [
          Container(
            width: getSize(context, true, 1),
            height: getSize(context, true, 100 / 415),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                  Radius.circular(getSize(context, true, 5 / 415))),
              border: Border.all(
                  color: selectedAddress == index
                      ? BeysionColors.purple
                      : BeysionColors.gray1,
                  width: 3),
            ),
            child: Padding(
              padding: EdgeInsets.only(
                left: getSize(context, true, 10 / 415),
                top: getSize(context, true, 10 / 415),
                bottom: getSize(context, true, 10 / 415),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "${userAddress.name}",
                    style: GoogleFonts.overpass(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w700),
                  ),
                  SizedBox(
                    height: getSize(context, true, 5 / 415),
                  ),
                  Text(
                    "${userAddress.firstname} ${userAddress.lastname}",
                    style: GoogleFonts.overpass(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w400),
                  ),
                  Text(
                    "${userAddress.phone}",
                    style: GoogleFonts.overpass(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w400),
                  ),
                  Expanded(
                    child: Text(
                      "${userAddress.address}",
                      maxLines: 2,
                      overflow: TextOverflow.fade,
                      softWrap: false,
                      style: GoogleFonts.overpass(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      "${userAddress.zipcode}",
                      style: GoogleFonts.overpass(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Align(
              alignment: Alignment.topRight,
              child: FaIcon(
                FontAwesomeIcons.solidCheckSquare,
                color: selectedAddress == index
                    ? BeysionColors.purple
                    : BeysionColors.gray1,
                size: getSize(context, true, 25 / 415),
              )),
        ],
      ),
    );
  }

  buildSelectPaymentChild(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: getSize(context, true, 20 / 415)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Column(
            children: [
              DottedLine(
                dashColor: BeysionColors.gray2,
                direction: Axis.horizontal,
                lineLength: getSize(context, true, 325 / 415),
                dashGapLength: getSize(context, true, 5 / 415),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: getSize(context, true, 10 / 415),
                  bottom: getSize(context, true, 10 / 415),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Radio(
                      value: 0,
                      groupValue: checkPaymentType,
                      onChanged: (value) {
                        setState(() {
                          checkPaymentType = value;
                        });
                      },
                    ),
                    Container(
                      child: Image.asset(
                        IconsPath.creditCard,
                        width: getSize(context, true, 30 / 415),
                        height: getSize(context, true, 30 / 415),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        left: getSize(context, true, 10 / 415),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            //height: getSize(context, true, 40/415),
                            width: getSize(context, true, 225 / 415),
                            child: AutoSizeText(
                              "Kreditkarte",
                              style: GoogleFonts.overpass(fontSize: 16),
                              maxLines: 2,
                              minFontSize: 10,
                            ),
                          ),
                          Text(
                            "Kreditkarte eingeben",
                            style: GoogleFonts.overpass(
                                fontSize: 14, fontWeight: FontWeight.w300),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              DottedLine(
                dashColor: BeysionColors.gray2,
                direction: Axis.horizontal,
                lineLength: getSize(context, true, 325 / 415),
                dashGapLength: getSize(context, true, 5 / 415),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: getSize(context, true, 10 / 415),
                  bottom: getSize(context, true, 10 / 415),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Radio(
                      value: 1,
                      groupValue: checkPaymentType,
                      onChanged: (value) {
                        setState(() {
                          checkPaymentType = value;
                        });
                      },
                    ),
                    Container(
                      child: Image.asset(
                        IconsPath.paypal,
                        width: getSize(context, true, 30 / 415),
                        height: getSize(context, true, 30 / 415),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        left: getSize(context, true, 10 / 415),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            //height: getSize(context, true, 40/415),
                            width: getSize(context, true, 225 / 415),
                            child: AutoSizeText(
                              "Paypal",
                              style: GoogleFonts.overpass(fontSize: 16),
                              maxLines: 2,
                              minFontSize: 10,
                            ),
                          ),
                          Text(
                            "4 € Gebühr, Lieferzeit 2-6 Stunden",
                            style: GoogleFonts.overpass(
                                fontSize: 14, fontWeight: FontWeight.w300),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              DottedLine(
                dashColor: BeysionColors.gray2,
                direction: Axis.horizontal,
                lineLength: getSize(context, true, 325 / 415),
                dashGapLength: getSize(context, true, 5 / 415),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: getSize(context, true, 10 / 415),
                  bottom: getSize(context, true, 10 / 415),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Radio(
                      value: 2,
                      groupValue: checkPaymentType,
                      onChanged: (value) {
                        setState(() {
                          checkPaymentType = value;
                        });
                      },
                    ),
                    Container(
                      child: Image.asset(
                        IconsPath.euro,
                        width: getSize(context, true, 30 / 415),
                        height: getSize(context, true, 30 / 415),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        left: getSize(context, true, 10 / 415),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            //height: getSize(context, true, 40/415),
                            width: getSize(context, true, 225 / 415),
                            child: AutoSizeText(
                              "Banküberweisung",
                              style: GoogleFonts.overpass(fontSize: 16),
                              maxLines: 2,
                              minFontSize: 10,
                            ),
                          ),
                          Text(
                            "Klassische Überweisung",
                            style: GoogleFonts.overpass(
                                fontSize: 14, fontWeight: FontWeight.w300),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              DottedLine(
                dashColor: BeysionColors.gray2,
                direction: Axis.horizontal,
                lineLength: getSize(context, true, 325 / 415),
                dashGapLength: getSize(context, true, 5 / 415),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: getSize(context, true, 10 / 415),
                  bottom: getSize(context, true, 10 / 415),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Radio(
                      value: 3,
                      groupValue: checkPaymentType,
                      onChanged: (value) {
                        setState(() {
                          checkPaymentType = value;
                        });
                      },
                    ),
                    Container(
                      child: Image.asset(
                        IconsPath.transfer,
                        width: getSize(context, true, 30 / 415),
                        height: getSize(context, true, 30 / 415),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        left: getSize(context, true, 10 / 415),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            //height: getSize(context, true, 40/415),
                            width: getSize(context, true, 225 / 415),
                            child: AutoSizeText(
                              "Genehmigte Geldüberweisung",
                              style: GoogleFonts.overpass(fontSize: 16),
                              maxLines: 2,
                              minFontSize: 10,
                            ),
                          ),
                          Text(
                            "Interbank money transfer",
                            style: GoogleFonts.overpass(
                                fontSize: 14, fontWeight: FontWeight.w300),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              DottedLine(
                dashColor: BeysionColors.gray2,
                direction: Axis.horizontal,
                lineLength: getSize(context, true, 325 / 415),
                dashGapLength: getSize(context, true, 5 / 415),
              ),
            ],
          ),
        ],
      ),
    );
  }


  Future<List> getAllZipCodeListController(String search) async {
    List _listLabel = new List();
    try {
      BaseResponse response =
      await ZipCodeService.operations().zipCodeSearch(search);
      if (response is OkResponse) {
        if (response.body != null) {
          if (response.body["data"] != null) {
            List<dynamic> dataList = response.body["data"];
            for (var dataStr in dataList) {
              ZipCodeEntity model = new ZipCodeEntity.fromJson(dataStr);
              if (model != null) {
                dynamic json = {'label': '${model.text}', 'value': model.id};
                _listLabel.add(new ZipCodeTextFieldEntity.fromJson(json));
              }
            }
            return _listLabel;
          }
          return new List();
        }
        return new List();
      }
      return new List();
    } catch (e) {
      print('Exception Zip Controller Data -- $e');
      return new List();
    }
  }
}
