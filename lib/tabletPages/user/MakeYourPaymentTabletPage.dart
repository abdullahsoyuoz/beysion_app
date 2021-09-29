import 'package:auto_size_text/auto_size_text.dart';
import 'package:beysion/Utility/Colors.dart';
import 'package:beysion/Utility/FakeData.dart';
import 'package:beysion/Utility/Icons.dart';
import 'package:beysion/Utility/util.dart';
import 'package:beysion/utility/Widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../rest/controller/user/basket_provider.dart';
import 'package:beysion/rest/entity/user/basket/basket_detail_entity.dart';
import 'package:beysion/rest/entity/user/basket/basket_send_data.dart';
import 'package:beysion/rest/entity/user/basket/basket_to_accept_order_entity.dart';
import 'package:beysion/rest/response_models/base_response.dart';
import 'package:beysion/rest/response_models/ok_response.dart';
import 'package:beysion/rest/service/user_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:beysion/constant/app_configurations.dart' as settingRepo;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simpleprogressdialog/builders/material_dialog_builder.dart';
import 'package:simpleprogressdialog/simpleprogressdialog.dart';

import 'PaymentCompletedTabletPage.dart';

class MakeYourPaymentTabletPage extends StatefulWidget {
  @override
  _MakeYourPaymentTabletPageState createState() =>
      _MakeYourPaymentTabletPageState();
}

class _MakeYourPaymentTabletPageState extends State<MakeYourPaymentTabletPage> {
  final GlobalKey<FormState> _paymentFormKey = GlobalKey<FormState>();
  ScrollController _paymentListViewController;
  TextEditingController _cardNumberTextFormFieldController;
  TextEditingController _cardHolderNameTextFormFieldController;
  TextEditingController _securityCodeTextFormFieldController;
  bool isPaymentCompleted = false;
  bool checkRegisterCreditCard = false;
  bool checkIncludeItems = false;
  int allOrdersSelectedValue = 0;
  int dropSelectedLastMonth = 0;
  int dropSelectedLastYear = 2022;
  int checkCreditCardValue = 0;
  ProgressDialog dialog;

  @override
  void initState() {
    super.initState();
    _paymentListViewController = ScrollController();
    _securityCodeTextFormFieldController = MaskedTextController(mask: '000');
    _cardNumberTextFormFieldController =
        MaskedTextController(mask: '0000-0000-0000-0000');
  }

  @override
  Widget build(BuildContext context) {
    dialog = ProgressDialog(
        context: context, barrierDismissible: false, elevation: 10.0);

    return Scaffold(
      appBar: buildAppBarTablet(context),
      body: buildBody(context),
    );
  }

  buildBody(BuildContext context) {
    return Stack(
      children: [
        buildPaymentBody(context),
        buildMakeYourPaymentPageTopNavigationBar(context, 2),
        buildBottomSheet(context)
      ],
    );
  }

  buildMakeYourPaymentPageTopNavigationBar(BuildContext context, int index) {
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        width: getSize(context, true, 1),
        height: getSize(context, true, 40 / 415),
        decoration: BoxDecoration(
          color: BeysionColors.blueNavy,
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: getSize(context, true, 20 / 415)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Image.asset(IconsPath.basket,
                  width: getSize(context, true, 25 / 415),
                  height: getSize(context, true, 25 / 415),
                  color: index == 0
                      ? BeysionColors.yellow
                      : BeysionColors.overlay),
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
                color:
                index == 1 ? BeysionColors.yellow : BeysionColors.overlay,
                width: getSize(context, true, 25 / 415),
                height: getSize(context, true, 25 / 415),
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
                color:
                index == 2 ? BeysionColors.yellow : BeysionColors.overlay,
                width: getSize(context, true, 25 / 415),
                height: getSize(context, true, 25 / 415),
              ),
              SizedBox(
                width: getSize(context, true, 5 / 415),
              ),
              AutoSizeText(
                "Zahlungsinformationen",
                style: GoogleFonts.overpass(
                    color: index == 2 ? Colors.white : BeysionColors.overlay,
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
              FaIcon(
                FontAwesomeIcons.checkCircle,
                color: BeysionColors.overlay,
                size: getSize(context, true, 25 / 415),
              ),
            ],
          ),
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
                              "ZAHLUNG",
                              style: GoogleFonts.overpass(
                                  fontSize: 15, fontWeight: FontWeight.w400),
                            )),
                        onPressed: () async {
                          settingRepo.toastWidget(
                              "Ordnung schaffen...", Colors.green);

                          dialog.showMaterial(
                            message: "Ordnung schaffen...",
                            title: "Warten Sie mal",
                            centerTitle: true,
                            layout: MaterialProgressDialogLayout
                                .columnReveredWithCircularProgressIndicator,
                            messageStyle: GoogleFonts.overpass(color: Colors.green[900]),
                          );

                          SharedPreferences testPref =
                          await SharedPreferences.getInstance();
                          String tokenData =
                          testPref.getString("sessionToken");
                          BasketSendData sendDataEntity =
                          new BasketSendData();
                          List<BasketProductSelect> basketSelectList =
                          new List();
                          for(var dataIn in settingRepo.mapBasketSendDataEntity.value.entries.toList()){
                            BasketProductSelect basketSelectEntity = new BasketProductSelect();
                            basketSelectEntity.mid = dataIn.key;
                            basketSelectEntity.serviceType = dataIn.value.serviceType;
                            basketSelectEntity.time = "${dataIn.value.time}";
                            basketSelectList.add(basketSelectEntity);
                          }
                          sendDataEntity.token = tokenData;
                          sendDataEntity.paymentType = 1;
                          sendDataEntity.lieferService = settingRepo.lieferService.value;
                          sendDataEntity.abholService = settingRepo.abholService.value;
                          sendDataEntity.plz = settingRepo.zipCodeSelectedEntity.value.id;
                          sendDataEntity.addressType2 = settingRepo.selectedUserAddress.value.id;
                          sendDataEntity.addressType1 = settingRepo.selectedUserAddress.value.id;
                          sendDataEntity.basketSelect = basketSelectList;
                          BaseResponse baseResponse = await UserService.operations().basketOrderApproved(sendDataEntity);
                          if (baseResponse is OkResponse) {
                            settingRepo.toastWidget("Bestellung erfolgreich aufgegeben", Colors.green);
                            try {
                              if (baseResponse is OkResponse) {
                                if (baseResponse.body != null) {
                                  if (baseResponse.body["data"] != null) {
                                    List<dynamic> dataList = baseResponse.body["data"];
                                    List<BasketToAcceptOrderEntity>newDataList = new List();
                                    for (var dataStr in dataList) {
                                      BasketToAcceptOrderEntity model = new BasketToAcceptOrderEntity.fromJson(dataStr);
                                      if (model != null) {
                                        newDataList.add(model);
                                        Provider.of<BasketProvider>(context, listen: false).getBasketDetailDataController();
                                        Navigator.pop(context);
                                        Navigator.push(context,
                                            MaterialPageRoute(builder: (context) => PaymentCompletedTabletPage(newDataList),));
                                        print('YESSSSS');
                                        //print('Markets Category List Data -- ${model.name}');
                                      }
                                    }
                                  }
                                }
                              }
                            } catch (e) {
                              print('Exception Market List Data -- $e');
                            }
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
                      style:
                      GoogleFonts.overpass(fontSize: 17, fontWeight: FontWeight.w500),
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
                            "Gesamt (${basketDetailEntity.basketTotal.toString().replaceAll(".", ",")} Produkt)",
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
                              vertical: getSize(context, true, 10 / 415)),
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

  buildPaymentBody(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: getSize(context, true, 0 / 415),
      ),
      child: ListView(
        controller: _paymentListViewController,
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        padding: EdgeInsets.symmetric(
          //horizontal: getSize(context, true, 20 / 415),
          vertical: getSize(context, true, 60 / 415),
        ),
        children: [
          Padding(
            padding: EdgeInsets.only(
              left: getSize(context, true, 20 / 415),
              top: getSize(context, true, 10 / 415),
              bottom: getSize(context, true, 10 / 415),
            ),
            child: Text("Lieferauswahl",
                style: GoogleFonts.overpass(
                    color: Colors.black,
                    fontSize: 17,
                    fontWeight: FontWeight.w600)),
          ),
          buildPaymentBodyChild(context),
        ],
      ),
    );
  }

  buildPaymentBodyChild(BuildContext context) {
    return Form(
        key: _paymentFormKey,
        child: buildContainer(
            context,
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                buildNewCreditCard(context),
              ],
            )));
  }

  buildNewCreditCard(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(
              top: getSize(context, true, 10/415)
          ),
          child: Text("NEUE KREDITKARTE",style: GoogleFonts.overpass(
              color: BeysionColors.purple,
              fontSize: 17,
              fontWeight: FontWeight.w700
          ),),
        ),
        Divider(
          height: getSize(context, true, 25 / 415),
        ),
        Text("Kartennummer"),
        Padding(
          padding: EdgeInsets.only(
            top: getSize(context, true, 5/415),
            bottom: getSize(context, true, 20/415),
          ),
          child: TextFormField(
            textAlignVertical: TextAlignVertical.center,
            controller: _cardNumberTextFormFieldController,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderSide: BorderSide(
                    color: BeysionColors.gray1,
                    width: getSize(context, true, 2 / 415)),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: BeysionColors.gray1,
                    width: getSize(context, true, 2 / 415)),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: BeysionColors.purple,
                    width: getSize(context, true, 2 / 415)),
              ),
              contentPadding:
              EdgeInsets.only(left: getSize(context, true, 10 / 415)),
              suffixIcon: SizedBox(),
              suffix: SizedBox(),
              isCollapsed: true,
            ),
          ),
        ),
        Text("Name des Karteninhabers"),
        Padding(
          padding: EdgeInsets.only(
            top: getSize(context, true, 5/415),
            bottom: getSize(context, true, 20/415),
          ),
          child: TextFormField(
            textAlignVertical: TextAlignVertical.center,
            controller: _cardHolderNameTextFormFieldController,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(
                  horizontal: getSize(context, true, 10 / 415)),
              border: OutlineInputBorder(
                borderSide: BorderSide(
                    color: BeysionColors.gray1,
                    width: getSize(context, true, 2 / 415)),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: BeysionColors.gray1,
                    width: getSize(context, true, 2 / 415)),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: BeysionColors.purple,
                    width: getSize(context, true, 2 / 415)),
              ),
              suffixIcon: SizedBox(),
              suffix: SizedBox(),
              isCollapsed: true,
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Letztes Datum"),
                Container(
                  width: getSize(context, true, 90 / 415),
                  margin: EdgeInsets.only(
                    top: getSize(context, true, 5 / 415),
                    bottom: getSize(context, true, 20 / 415),
                  ),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      border: Border.all(
                          color: BeysionColors.gray1,
                          width: getSize(context, true, 2 / 415)
                      )
                  ),
                  child: Center(
                    child: DropdownButton(
                      underline: SizedBox(),
                      icon: Padding(
                        padding: EdgeInsets.only(
                            left: getSize(context, true, 10 / 415)),
                        child: Image.asset(
                          IconsPath.dropArrow,
                          color: Colors.black87,
                          width: getSize(context, true, 10 / 415),
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                      value: dropSelectedLastMonth,
                      items: [
                        DropdownMenuItem(value: 0, child: Text("01")),
                        DropdownMenuItem(value: 1, child: Text("02")),
                        DropdownMenuItem(value: 2, child: Text("03")),
                        DropdownMenuItem(value: 3, child: Text("04")),
                        DropdownMenuItem(value: 4, child: Text("05")),
                        DropdownMenuItem(value: 5, child: Text("06")),
                        DropdownMenuItem(value: 6, child: Text("07")),
                        DropdownMenuItem(value: 7, child: Text("08")),
                        DropdownMenuItem(value: 8, child: Text("09")),
                        DropdownMenuItem(value: 9, child: Text("10")),
                        DropdownMenuItem(value: 10, child: Text("11")),
                        DropdownMenuItem(value: 11, child: Text("12")),
                      ],
                      onChanged: (value) {
                        setState(() {
                          dropSelectedLastMonth = value;
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(""),
                Container(
                  width: getSize(context, true, 90 / 415),
                  margin: EdgeInsets.only(
                    top: getSize(context, true, 5 / 415),
                    bottom: getSize(context, true, 20 / 415),
                  ),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      border: Border.all(
                          color: BeysionColors.gray1,
                          width: getSize(context, true, 2 / 415)
                      )
                  ),
                  child: Center(
                    child: DropdownButton(
                      underline: SizedBox(),
                      icon: Padding(
                        padding: EdgeInsets.only(
                            left: getSize(context, true, 10 / 415)),
                        child: Image.asset(
                          IconsPath.dropArrow,
                          color: Colors.black87,
                          width: getSize(context, true, 10 / 415),
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                      value: dropSelectedLastYear,
                      items: [
                        DropdownMenuItem(value: 2022, child: Text("2022")),
                        DropdownMenuItem(value: 2023, child: Text("2023")),
                        DropdownMenuItem(value: 2024, child: Text("2024")),
                        DropdownMenuItem(value: 2025, child: Text("2025")),
                        DropdownMenuItem(value: 2026, child: Text("2026")),
                        DropdownMenuItem(value: 2027, child: Text("2027")),
                        DropdownMenuItem(value: 2028, child: Text("2028")),
                        DropdownMenuItem(value: 2029, child: Text("2029")),
                        DropdownMenuItem(value: 2030, child: Text("2030")),
                      ],
                      onChanged: (value) {
                        setState(() {
                          dropSelectedLastYear = value;
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Sicherheitscode"),
                Container(
                  width: getSize(context, true, 90 / 415),
                  color: Colors.white,
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: getSize(context, true, 5/415),
                      bottom: getSize(context, true, 20/415),
                    ),
                    child: TextFormField(
                      textAlignVertical: TextAlignVertical.center,
                      controller: _securityCodeTextFormFieldController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(
                            left: getSize(context, true, 5 / 415), right: 0),
                        isDense: true,
                        filled: true,
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: BeysionColors.gray1,
                              width: getSize(context, true, 2 / 415)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: BeysionColors.gray1,
                              width: getSize(context, true, 2 / 415)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: BeysionColors.purple,
                              width: getSize(context, true, 2 / 415)),
                        ),
                        suffixIcon: SizedBox(),
                        suffix: SizedBox(),
                        isCollapsed: false,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        Row(
          children: [
            Checkbox(
              value: checkRegisterCreditCard,
              onChanged: (value) {
                setState(() {
                  checkRegisterCreditCard = value;
                });
              },
            ),
            Expanded(
              child: Text(
                "Speichern Sie meine Kreditkarte für nächste Bestellungen",
                style: GoogleFonts.overpass(fontSize: 12),
              ),
            )
          ],
        )
      ],
    );
  }

  buildDoNotHaveRegisteredCreditCard(BuildContext context) {
    return Container(
      height: getSize(context, true, 120 / 415),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.max,
        children: [
          Text("Bitte geben Sie Ihre Kreditkarte ein."),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                IconsPath.visa,
                width: getSize(context, true, 50 / 415),
              ),
              SizedBox(
                width: getSize(context, true, 15 / 415),
              ),
              Image.asset(
                IconsPath.mastercard,
                width: getSize(context, true, 50 / 415),
              ),
              SizedBox(
                width: getSize(context, true, 15 / 415),
              ),
              Image.asset(
                IconsPath.amerikanexpress,
                width: getSize(context, true, 50 / 415),
              ),
            ],
          )
        ],
      ),
    );
  }

  buildCreditCard(BuildContext context, FakeCreditCard item, int index,
      int currentIndex, bool isSelected) {
    return InkWell(
      child: Container(
        //width: getSize(context, true, 342/415),
        height: getSize(context, true, 84 / 415),
        padding: EdgeInsets.only(
          top: getSize(context, true, 15 / 415),
          bottom: getSize(context, true, 15 / 415),
          left: getSize(context, true, 20 / 415),
          right: getSize(context, true, 20 / 415),
        ),
        margin: EdgeInsets.only(
          bottom: getSize(context, true, 20 / 415),
        ),
        decoration: BoxDecoration(
            border: Border.all(
              color: index == currentIndex
                  ? BeysionColors.yellow
                  : BeysionColors.textFieldBackground,
            ),
            borderRadius: BorderRadius.all(Radius.circular(5))),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              margin: EdgeInsets.only(right: getSize(context, true, 20 / 415)),
              child: index == currentIndex
                  ? Image.asset(
                IconsPath.tik,
                width: getSize(context, true, 30 / 415),
              )
                  : SizedBox(
                width: getSize(context, true, 30 / 415),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  item.imagePath,
                  width: getSize(context, true, 35 / 415),
                  fit: BoxFit.fitWidth,
                ),
                Text(
                  "${item.cardNumber}",
                  style: GoogleFonts.overpass(fontSize: 12),
                ),
                Text(
                  "${item.lastDate}",
                  style: GoogleFonts.overpass(fontSize: 12),
                ),
              ],
            )
          ],
        ),
      ),
      onTap: () {
        setState(() {
          if (index != currentIndex) {
            checkCreditCardValue = index;
          }
        });
      },
    );
  }
}
