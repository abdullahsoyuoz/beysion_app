import 'dart:convert';

import 'package:beysion/Utility/Colors.dart';
import 'package:beysion/Utility/Images.dart';
import 'package:beysion/Utility/Logos.dart';
import 'package:beysion/Utility/util.dart';
import 'package:beysion/rest/entity/seller/seller_login_entity.dart';
import 'package:beysion/rest/response_models/base_response.dart';
import 'package:beysion/rest/response_models/ok_response.dart';
import 'package:beysion/rest/service/seller/seller_service.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:beysion/constant/app_configurations.dart' as settingRepo;
import 'package:simpleprogressdialog/builders/material_dialog_builder.dart';
import 'package:simpleprogressdialog/simpleprogressdialog.dart';

import 'SellerSignUpTabletPage.dart';
import 'SellerDashboardTabletPage.dart';

class SellerLoginTabletPage extends StatefulWidget {
  @override
  _SellerLoginTabletPageState createState() => _SellerLoginTabletPageState();
}

class _SellerLoginTabletPageState extends State<SellerLoginTabletPage> {
  TextEditingController _emailTextFormFieldController = new TextEditingController();
  TextEditingController _passwordTextFormFieldController = new TextEditingController();
  ScrollController listViewController;
  final _formKey2 = GlobalKey<FormState>();

  ProgressDialog dialog;

  @override
  void initState() {
    super.initState();
  }


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
            height: getSize(context, true, 1) * 0.8,
            decoration: BoxDecoration(
                image: DecorationImage(
                  alignment: Alignment.center,
                  fit: BoxFit.fitWidth,
                  image: AssetImage(ImagesPath.loginBack),
                )),
            child: Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).padding.top),
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

  buildHomeForm(BuildContext context) {
    return Form(
      key: _formKey2,
      child: Container(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: getSize(context, true, 36 / 415)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(
                  bottom: getSize(context, true, 15/415)
                ),
                child: Text(
                  "Verkäufer Login",
                  style: GoogleFonts.overpass(
                      color: BeysionColors.purple,
                      fontWeight: FontWeight.w700,
                      fontSize: 28),
                ),
              ),
              SizedBox(
                height: getSize(context, true, 5 / 415),
              ),
              TextFormField(
                validator: validateEmail,
                controller: _emailTextFormFieldController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: BeysionColors.border,
                          width: getSize(context, true, 2 / 415)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: BeysionColors.border,
                          width: getSize(context, true, 2 / 415)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: BeysionColors.purple,
                          width: getSize(context, true, 2 / 415)),
                    ),
                    labelText: "E-mail",
                    labelStyle: GoogleFonts.overpass(color: BeysionColors.border)),
              ),
              SizedBox(
                height: getSize(context, true, 10 / 415),
              ),
              TextFormField(
                validator: (value) {
                  if (value.isEmpty) {
                    return "Bitte Passwort angeben.";
                  }
                  return null;
                },
                controller: _passwordTextFormFieldController,
                obscureText: true,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: BeysionColors.border,
                          width: getSize(context, true, 2 / 415)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: BeysionColors.border,
                          width: getSize(context, true, 2 / 415)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: BeysionColors.purple,
                          width: getSize(context, true, 2 / 415)),
                    ),
                    labelText: "Passwort",
                    labelStyle: GoogleFonts.overpass(color: BeysionColors.border)),
              ),
              SizedBox(
                height: getSize(context, true, 10 / 415),
              ),
              FlatButton(
                color: BeysionColors.orange,
                height: getSize(context, true, 30/415),
                minWidth: getSize(context, true, 1),
                child: Center(
                    child: Text(
                      "ANMELDEN",
                      style: GoogleFonts.overpass(fontSize: 16,
                          fontWeight: FontWeight.w600),
                    )),
                onPressed: () {
                  loginControler(_emailTextFormFieldController.text, _passwordTextFormFieldController.text);
                },
              ),
              SizedBox(height: getSize(context, true, 10 / 415),),
              InkWell(
                child: Text(
                  "Passwort vergessen",
                  style: GoogleFonts.overpass(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: BeysionColors.purple,
                    decoration: TextDecoration.underline),
                ),
                onTap: () {},
              ),
              Divider(),
              Center(child: Text("Kein Unternehmenskonto bei beysi-on?",
                style: GoogleFonts.overpass(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w700
                ),)),
              SizedBox(height: getSize(context, true, 10/415)),
              InkWell(
                child: Container(
                  width: getSize(context, true, 100/415),
                  height: getSize(context, true, 20/415),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.black.withOpacity(0.6))
                  ),
                  child: Center(
                      child: Text("Jetzt erstellen",
                              style: GoogleFonts.overpass(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                decoration: TextDecoration.underline),)),
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SellerSignUpTabletPage()));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  String validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'Bitte E-Mail-Adresse angeben.';
    else
      return null;
  }


  void loginControler(String email, String password) async {
   if(_formKey2.currentState.validate()){
     dialog.showMaterial(
       message: "Warten Sie mal...",
       title: "Einloggen",
       centerTitle: true,
       layout: MaterialProgressDialogLayout
           .columnReveredWithCircularProgressIndicator,
       messageStyle: GoogleFonts.overpass(color: Colors.green[900]),);
      BaseResponse response = await SellerService.operations().sellerLoginService(email, password);
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      try{
        if (response is OkResponse) {
          if (response.body != null) {
            print('GELEN SELLER LOGİN ${response.body}');
            if (response.body["response"] == "success") {
              if (response.body["result"] != null) {
                SellerLoginEntity tokenEntity = new SellerLoginEntity.fromJson(response.body["result"]);
                if(tokenEntity!=null){
                  settingRepo.toastWidget(("Anmeldung erfolgreich."), Colors.green);
                  sharedPreferences.setString("sellerLoginEntity", json.encode(tokenEntity.toJson()));
                  settingRepo.sellerLoginInformationEntity.value = tokenEntity;
                  Navigator.pop(context);
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SellerDashboardTabletPage()));
                }else{
                  Navigator.pop(context);
                  _showDialogLoginError();
                }
              }else{
                Navigator.pop(context);
                _showDialogLoginError();
              }
            }else{
              Navigator.pop(context);
              _showDialogLoginError();
            }

          }else{
            Navigator.pop(context);
            _showDialogLoginError();
          }
        }else{
          Navigator.pop(context);
          _showDialogLoginError();
        }
      }catch(e){
        Navigator.pop(context);
        _showDialogLoginError();
        print('Exception Create Session -- $e');
      }
    }
  }
  void _showDialogLoginError() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Error"),
          content: new Text("Ihre Angaben sind falsch, bitte überprüfen."),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Schließen"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

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
          style: GoogleFonts.overpass(fontSize: 16),
        ),
        onTap: () {

        },
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}

class TopLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top * 2),
      child: Padding(
        padding: EdgeInsets.only(
          //top: MediaQuery.of(context).padding.top * 1.5,
          left: getSize(context, true, 10 / 415),
          right: getSize(context, true, 10 / 415),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: getSize(context, true, 35 / 415),
              child: Image.asset(
                LogosPath.beysion,
                fit: BoxFit.fitHeight,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: getSize(context, true, 5 / 415)),
                  child: Text(
                    "Ihre Bestellung \nist bereit!",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.overpass(
                        color: BeysionColors.orange,
                        fontSize: 28,
                        fontWeight: FontWeight.w900),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: getSize(context, true, 5 / 415)),
                  child: Text(
                    "Abholen oder \nliefern lassen?",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.overpass(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.w900),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
