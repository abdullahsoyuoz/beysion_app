import 'dart:convert';

import 'package:beysion/Utility/Colors.dart';
import 'package:beysion/Utility/Icons.dart';
import 'package:beysion/Utility/Images.dart';
import 'package:beysion/Utility/Logos.dart';
import 'package:beysion/rest/controller/user/user_login_information_provider.dart';
import 'package:beysion/rest/entity/user/user_token_entity.dart';
import 'package:beysion/rest/response_models/base_response.dart';
import 'package:beysion/rest/response_models/ok_response.dart';
import 'package:beysion/rest/service/user_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:beysion/Utility/util.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:beysion/constant/app_configurations.dart' as settingRepo;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simpleprogressdialog/builders/material_dialog_builder.dart';
import 'package:simpleprogressdialog/simpleprogressdialog.dart';

import 'package:beysion/tabletPages/seller/SellerLoginTabletPage.dart';
import 'UserSignUpTabletPage.dart';

class UserLoginTabletPageBasket extends StatefulWidget {
  @override
  _UserLoginTabletPageBasketState createState() => _UserLoginTabletPageBasketState();
}

class _UserLoginTabletPageBasketState extends State<UserLoginTabletPageBasket> {
  TextEditingController emailController;
  TextEditingController passwordController;
  final _formKey2 = GlobalKey<FormState>();
  ProgressDialog dialog;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
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
                    top: MediaQuery.of(context).padding.top * 2),
                child: TopLogo(),
              ),
            ),
          ),
          Container(
            child: Form(
              key: _formKey2,
              child: ListView(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                children: [
                  Center(
                    child: buildHomeForm(context),
                  ),
                  SizedBox(
                    height: getSize(context, true, 30 / 415),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: AllRightsWidget(),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  buildHomeForm(BuildContext context) {
    return Padding(
      padding:
      EdgeInsets.symmetric(horizontal: getSize(context, true, 40 / 415)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Jetzt anmelden",
            style: GoogleFonts.overpass(
                color: BeysionColors.purple,
                fontWeight: FontWeight.w700,
                fontSize: 28),
          ),
          SizedBox(
            height: getSize(context, true, 5 / 415),
          ),
          TextFormField(
            validator: validateEmail,
            controller: emailController,
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
            obscureText: true,
            controller: passwordController,
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
              loginControler(emailController.text, passwordController.text);
            },
          ),
          SizedBox(height: getSize(context, true, 10 / 415),),
          InkWell(
            child: Text(
              "Passwort vergessen",
              style: GoogleFonts.overpass(
                  color: BeysionColors.purple,
                  decoration: TextDecoration.underline),
            ),
            onTap: () {},
          ),
          SizedBox(height: getSize(context, true, 10 / 415),),
          Divider(),
          buildSocialButton(context),
          Divider(),
          InkWell(
              onTap: () {
                //Navigator.pushNamed(context, "/userSignup");
                Navigator.pop(context);
              },
              child: Padding(
                padding: const EdgeInsets.all(7.0),
                child: Text(
                  "Zum Startbildschirm gehen",
                  style: GoogleFonts.overpass(
                      color: BeysionColors.purple),
                ),
              )),
          Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Text("Sie haben kein Konto bei uns ! "),
              InkWell(
                  onTap: () {
                    //Navigator.pushNamed(context, "/userSignup");
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => UserSignUpTabletPage()));
                  },
                  child: Text(
                    "Jetzt erstellen",
                    style: GoogleFonts.overpass(
                        decoration: TextDecoration.underline,
                        color: BeysionColors.purple),
                  ))
            ],
          ),
        ],
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
      BaseResponse response = await UserService.operations().loginUser(email, password);
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      try{
        if (response is OkResponse) {
          if (response.body != null) {
            if (response.body["response"] == "success") {
              if (response.body["result"] != null) {
                UserTokenEntity tokenEntity = new UserTokenEntity.fromJson(response.body["result"]);
                if(tokenEntity!=null){
                  settingRepo.toastWidget(("Benutzeranmeldung erfolgreich"), Colors.green);
                  sharedPreferences.setString("userTokenEntity", json.encode(tokenEntity.toJson()));
                  settingRepo.currentUserTokenEntity.value = tokenEntity;
                  Provider.of<UserLoginInformationProvider>(context, listen: false).getUserInformationDataController();
                  Navigator.pop(context);
                  Navigator.of(context).pop();
                }
              }
            }else{
              _showDialogLoginError();
            }

          }
        }
      }catch(e){
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


  buildSocialButton(BuildContext context) {
    return Container(
      width: getSize(context, true, 1),
      padding: EdgeInsets.only(
        bottom: getSize(context, true, 10 / 415),
      ),
      margin: EdgeInsets.only(top: getSize(context, true, 10 / 415)),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Container(
                  height: getSize(context, true, 31 / 415),
                  margin:
                      EdgeInsets.only(right: getSize(context, true, 5 / 415)),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    border: Border.all(
                        color: BeysionColors.border.withOpacity(0.5), width: 1),
                  ),
                  child: OutlineButton(
                    borderSide: BorderSide(color: BeysionColors.gray1),
                    highlightedBorderColor: BeysionColors.orange,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Einloggen mit",
                          style: GoogleFonts.overpass(
                              fontSize: 14, fontWeight: FontWeight.normal),
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(left: 5),
                            child: Image.asset(
                              IconsPath.facebook,
                              height: getSize(context, true, 20 / 415),
                            ),
                          ),
                        ),
                      ],
                    ),
                    onPressed: () {},
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  height: getSize(context, true, 31 / 415),
                  margin:
                      EdgeInsets.only(left: getSize(context, true, 5 / 415)),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    border: Border.all(
                        color: BeysionColors.border.withOpacity(0.5), width: 1),
                  ),
                  child: OutlineButton(
                    borderSide: BorderSide(color: BeysionColors.gray1),
                    highlightedBorderColor: BeysionColors.orange,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Einloggen mit",
                          style: GoogleFonts.overpass(
                              fontSize: 14, fontWeight: FontWeight.normal),
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(left: 5),
                            child: Image.asset(
                              IconsPath.google,
                              height: getSize(context, true, 20 / 415),
                            ),
                          ),
                        ),
                      ],
                    ),
                    onPressed: () {},
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class AllRightsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: getSize(context, false, 0.02),
        bottom: getSize(context, false, 0.02),
      ),
      child: InkWell(
        child: Column(
          children: [
            Text(
              "© 2021 Beysi-on.de  All rights reserved",
              textAlign: TextAlign.center,
              style: GoogleFonts.overpass(fontSize: 12),
            ),
            Text(
              "Impressum",
              textAlign: TextAlign.center,
              style: GoogleFonts.overpass(fontSize: 12),
            ),
            Text(
              "Datenschutz",
              textAlign: TextAlign.center,
              style: GoogleFonts.overpass(fontSize: 12),
            ),
            Text(
              "Nutzungsrichtlinien",
              textAlign: TextAlign.center,
              style: GoogleFonts.overpass(fontSize: 12),
            ),
            Text(
              "Powered by getucon",
              textAlign: TextAlign.center,
              style: GoogleFonts.overpass(fontSize: 12),
            ),
          ],
        ),
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => SellerLoginTabletPage()));
          },
      ),
    );
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
