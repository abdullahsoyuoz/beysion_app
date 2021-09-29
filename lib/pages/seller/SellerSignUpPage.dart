import 'package:auto_size_text/auto_size_text.dart';
import 'package:beysion/Utility/Colors.dart';
import 'package:beysion/Utility/Icons.dart';
import 'package:beysion/Utility/Images.dart';
import 'package:beysion/Utility/Logos.dart';
import 'package:beysion/Utility/util.dart';
import 'package:beysion/constant/app_configurations.dart';
import 'package:beysion/pages/user/MyProfilePage.dart';
import 'package:beysion/rest/entity/seller/seller_register_entity.dart';
import 'package:beysion/rest/entity/user/zip_code_entity.dart';
import 'package:beysion/rest/response_models/base_response.dart';
import 'package:beysion/rest/response_models/ok_response.dart';
import 'package:beysion/rest/service/seller/seller_service.dart';
import 'package:beysion/rest/service/zip_code_service.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simpleprogressdialog/builders/material_dialog_builder.dart';
import 'package:simpleprogressdialog/simpleprogressdialog.dart';

import 'SellerLoginPage.dart';
import 'SellerProfilePage.dart';

class SellerSignUpPage extends StatefulWidget {
  @override
  _SellerSignUpPageState createState() => _SellerSignUpPageState();
}

class _SellerSignUpPageState extends State<SellerSignUpPage> {
  ScrollController listViewController;
  TextEditingController marketTextFormFieldController = new TextEditingController();
  TextEditingController zipcodeTextFormFieldController = new TextEditingController();
  TextEditingController addressTextFormFieldController = new TextEditingController();
  TextEditingController emailTextFormFieldController = new TextEditingController();
  TextEditingController passwordTextFormFieldController = new TextEditingController();
  TextEditingController passwordAgainTextFormFieldController = new TextEditingController();
  int selectedDropDownValueCountry = 0;
  bool checkPrivacyPolicy = false;
  ProgressDialog dialog;
  bool getData = false;

  @override
  Widget build(BuildContext context) {
    dialog = ProgressDialog(context: context, barrierDismissible: false, elevation: 10.0);

    return Scaffold(
      backgroundColor: Colors.white,
      body: buildBody(context),
    );
  }

  buildBody(BuildContext context) {
    return SingleChildScrollView(
      physics: ClampingScrollPhysics(),
      child: Column(
        children: [
          Container(
            width: getSize(context, true, 1),
            height: getSize(context, true, 1) * 1.4,
            decoration: BoxDecoration(
                image: DecorationImage(
                  alignment: Alignment.topCenter,
                  fit: BoxFit.fitWidth,
                  image: AssetImage(ImagesPath.loginBack),
                )),
            child: Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).padding.top * 1.5),
                child: TopLogo(),
              ),
            ),
          ),
          ListView(
            physics: NeverScrollableScrollPhysics(),
            scrollDirection: Axis.vertical,
            controller: listViewController,
            shrinkWrap: true,
            children: [
              buildHomeForm(context),
              buildAllRights(context)
            ],
          )
        ],
      ),
    );
  }

  buildTop(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        //top: MediaQuery.of(context).padding.top * 1.5,
        left: getSize(context, true, 45 / 415),
        right: getSize(context, true, 45 / 415),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: getSize(context, true, 50.63 / 415),
            width: getSize(context, true, 243.4 / 415),
            child: Image.asset(
              LogosPath.beysion,
            ),
          ),
          IconButton(
            icon: Image.asset(
              IconsPath.user,
              filterQuality: FilterQuality.high,
              height: getSize(context, true, 30 / 415),
              width: getSize(context, true, 30 / 415),
            ),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => SellerProfilePage()));
              },
          )
        ],
      ),
    );
  }

  buildHomeForm(BuildContext context) {
    return Container(
      child: Padding(
        padding:
        EdgeInsets.symmetric(horizontal: getSize(context, true, 36 / 415)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Neues Unternehmenskonto",
              style: GoogleFonts.overpass(
                  color: BeysionColors.purple,
                  fontWeight: FontWeight.w600,
                  fontSize: 24),
            ),
            SizedBox(
              height: getSize(context, true, 15 / 415),
            ),
            TextFormField(
              controller: marketTextFormFieldController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: BeysionColors.gray1,
                        width: getSize(context, true, 3 / 415)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: BeysionColors.gray1,
                        width: getSize(context, true, 3 / 415)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: BeysionColors.gray1,
                        width: getSize(context, true, 3 / 415)),
                  ),
                  labelText: "Name der Firma*",
                  labelStyle: GoogleFonts.overpass(color: BeysionColors.gray2)),
            ),
            SizedBox(
              height: getSize(context, true, 10 / 415),
            ),
            InkWell(
              onTap: (){
                showFullScreenDialog(context);
              },
              child: TextFormField(
                enabled: false,
                controller: zipcodeTextFormFieldController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: BeysionColors.gray1,
                          width: getSize(context, true, 3 / 415)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: BeysionColors.gray1,
                          width: getSize(context, true, 3 / 415)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: BeysionColors.gray1,
                          width: getSize(context, true, 3 / 415)),
                    ),
                    labelText: "Postleitzahl*",
                    labelStyle: GoogleFonts.overpass(color: BeysionColors.gray2)),
              ),
            ),
            SizedBox(
              height: getSize(context, true, 10 / 415),
            ),
            TextFormField(
              controller: addressTextFormFieldController,
              maxLines: 2,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: BeysionColors.gray1,
                        width: getSize(context, true, 3 / 415)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: BeysionColors.gray1,
                        width: getSize(context, true, 3 / 415)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: BeysionColors.gray1,
                        width: getSize(context, true, 3 / 415)),
                  ),
                  labelText: "Adresse*",
                  labelStyle: GoogleFonts.overpass(color: BeysionColors.gray2)),
            ),
            SizedBox(
              height: getSize(context, true, 10 / 415),
            ),
            TextFormField(
              controller: emailTextFormFieldController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: BeysionColors.gray1,
                        width: getSize(context, true, 3 / 415)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: BeysionColors.gray1,
                        width: getSize(context, true, 3 / 415)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: BeysionColors.gray1,
                        width: getSize(context, true, 3 / 415)),
                  ),
                  labelText: "E-Mail*",
                  labelStyle: GoogleFonts.overpass(color: BeysionColors.gray2)),
            ),
            SizedBox(
              height: getSize(context, true, 10 / 415),
            ),
            TextFormField(
              controller: passwordTextFormFieldController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: BeysionColors.gray1,
                        width: getSize(context, true, 3 / 415)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: BeysionColors.gray1,
                        width: getSize(context, true, 3 / 415)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: BeysionColors.gray1,
                        width: getSize(context, true, 3 / 415)),
                  ),
                  labelText: "Passwort*",
                  labelStyle: GoogleFonts.overpass(color: BeysionColors.gray2)),
            ),
            SizedBox(
              height: getSize(context, true, 10 / 415),
            ),
            TextFormField(
              controller: passwordAgainTextFormFieldController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: BeysionColors.gray1,
                        width: getSize(context, true, 3 / 415)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: BeysionColors.gray1,
                        width: getSize(context, true, 3 / 415)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: BeysionColors.gray1,
                        width: getSize(context, true, 3 / 415)),
                  ),
                  labelText: "Passwort (wiederholen *)",
                  labelStyle: GoogleFonts.overpass(color: BeysionColors.gray2)),
            ),
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
                    style: GoogleFonts.overpass(fontSize: 15, fontWeight: FontWeight.w300),
                    maxLines: 2,
                    minFontSize: 10,
                  ),
                )
              ],
            ),
            SizedBox(
              height: getSize(context, true, 20/415),
            ),
            FlatButton(
              child: Text(
                "REGISTRIEREN",
                style: GoogleFonts.overpass(
                  fontSize: 16,
                  fontWeight: FontWeight.w600
                ),
              ),
              color: BeysionColors.orange,
              minWidth: getSize(context, true, 1),
              onPressed: () async {
                if(checkPrivacyPolicy){
                  dialog.showMaterial(
                    message: "Wird bearbeitet ...",
                    title: "Warten Sie mal",
                    centerTitle: true,
                    layout: MaterialProgressDialogLayout
                        .columnReveredWithCircularProgressIndicator,
                    messageStyle: GoogleFonts.overpass(color: Colors.green[900]),);
                  if(marketTextFormFieldController.text.length>1 && addressTextFormFieldController.text.length>1){
                    if(emailTextFormFieldController.text.length>1 && emailTextFormFieldController.text.contains("@")){
                      if(passwordTextFormFieldController.text.compareTo(passwordAgainTextFormFieldController.text) == 0){
                        SellerRegisterEntity userRegisterEntity = new SellerRegisterEntity();
                        userRegisterEntity.companyName = marketTextFormFieldController.text;
                        userRegisterEntity.zipCode = selectedZipCode.id.toString();
                        userRegisterEntity.email = emailTextFormFieldController.text;
                        userRegisterEntity.address = addressTextFormFieldController.text;
                        userRegisterEntity.password = passwordTextFormFieldController.text;
                        userRegisterEntity.passwordConfirm = passwordAgainTextFormFieldController.text;
                        SellerService sellerService = new SellerService();
                        BaseResponse baseResponse = await sellerService.sellerRegister(userRegisterEntity);
                        if(baseResponse is OkResponse){
                          toastWidget("Die Registrierung wurde erfolgreich durchgeführt.", Colors.green);
                          Navigator.pop(context);
                          Navigator.pop(context);
                        }else{
                          if(baseResponse.body!=null && baseResponse.body["message"]!=null){
                            toastWidget("${baseResponse.body["message"].toString()}", Colors.red);
                            Navigator.pop(context);
                          }else{
                            toastWidget("Konnte nicht aufnehmen. Bitte versuche es erneut!", Colors.red);
                            Navigator.pop(context);
                          }
                        }
                      }else{
                        toastWidget("Ihr Passwort stimmt nicht überein. Prüfen.", Colors.red);
                        Navigator.pop(context);
                      }
                    }else{
                      toastWidget("Bitte geben Sie eine gültige E-Mail-Adresse ein.", Colors.red);
                      Navigator.pop(context);
                    }
                  }else{
                    toastWidget("Name, Nachname und Telefonnummer eingeben!", Colors.red);
                    Navigator.pop(context);
                  }
                }else{
                  toastWidget("Akzeptiere den Vertrag!", Colors.red);
                }
              },
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


  void showFullScreenDialog(BuildContext context) {
    List<ZipCodeEntity> _zipCodeListData = new List();
    bool loadingData = false;
    TextEditingController plzController = new TextEditingController();
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
                                      child: loadingData == false ? SizedBox() :
                                      getData == false ? Container(
                                          margin: EdgeInsets.only(top: 50),
                                          child: Center(child: CircularProgressIndicator())) :
                                      ListView.builder(
                                          shrinkWrap: true,
                                          padding: EdgeInsets.only(top: getSize(context, true, 50/415),),
                                          itemCount: _zipCodeListData.length,
                                          itemBuilder: (context, index){
                                            return InkWell(
                                              onTap: () {
                                                selectedZipCode = _zipCodeListData[index];
                                                zipcodeTextFormFieldController.text = selectedZipCode.text;
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
                                        controller: plzController,
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

  ZipCodeEntity selectedZipCode = new ZipCodeEntity();
  buildAllRights(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          top: getSize(context, false, 0.02),
          bottom: getSize(context, false, 0.02),
      ),
      child: InkWell(
        child: Text(
          "© 2020 beysi-on.de  All rights reserved",
          textAlign: TextAlign.center,
          style: GoogleFonts.overpass(fontSize: 10),
        ),
        onTap: () {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => SellerLoginPage()));
          },
      ),
    );
  }
}
