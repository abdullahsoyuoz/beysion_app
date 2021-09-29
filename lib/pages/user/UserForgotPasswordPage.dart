import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:beysion/Utility/Colors.dart';
import 'package:beysion/Utility/Icons.dart';
import 'package:beysion/Utility/Images.dart';
import 'package:beysion/Utility/Logos.dart';
import 'package:beysion/pages/seller/SellerLoginPage.dart';
import 'package:beysion/pages/user/HomePage.dart';
import 'package:beysion/pages/user/UserSignUpPage.dart';
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
import 'package:url_launcher/url_launcher.dart';

import '../../main.dart';
import '../MainPageView.dart';

class UserForgotPasswordPage extends StatefulWidget {
  @override
  _UserForgotPasswordPageState createState() => _UserForgotPasswordPageState();
}

class _UserForgotPasswordPageState extends State<UserForgotPasswordPage> {
  TextEditingController emailController;
  final _formKey2 = GlobalKey<FormState>();
  ProgressDialog dialog;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    emailController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    dialog = ProgressDialog(
        context: context, barrierDismissible: false, elevation: 10.0);
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
            "Passwort vergessen",
            style: GoogleFonts.overpass(
                color: BeysionColors.purple,
                fontWeight: FontWeight.w600,
                fontSize: 22),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: getSize(context, true, 20 / 415),
          ),
          TextFormField(
            validator: validateEmail,
            controller: emailController,
            decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: BeysionColors.border,
                      width: getSize(context, true, 3 / 415)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: BeysionColors.border,
                      width: getSize(context, true, 3 / 415)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: BeysionColors.border,
                      width: getSize(context, true, 3 / 415)),
                ),
                labelText: "E-mail",
                labelStyle: GoogleFonts.overpass(color: BeysionColors.border)),
          ),
          SizedBox(
            height: getSize(context, true, 10 / 415),
          ),
          FlatButton(
            child: Text(
              "SENDEN",
              style: GoogleFonts.overpass(
                  fontSize: 16, fontWeight: FontWeight.w600),
            ),
            color: BeysionColors.orange,
            minWidth: getSize(context, true, 1),
            onPressed: () {
              forgotPasswordController(emailController.text);
            },
          ),
          SizedBox(
            height: getSize(context, true, 10 / 415),
          ),
          Divider(),
          InkWell(
              onTap: () {
                settingRepo.pageViewState.value.oneParam = null;
                settingRepo.pageViewState.value.twoParam = null;
                settingRepo.pageViewState.value.pageController.animateToPage(3, duration: Duration(milliseconds: 100), curve: Curves.easeInOutExpo);
              },
              child: Padding(
                padding: const EdgeInsets.all(7.0),
                child: Text(
                  "Zum Startbildschirm gehen",
                  style: GoogleFonts.overpass(color: BeysionColors.purple),
                ),
              )),
          Divider(),
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

  void forgotPasswordController(String email) async {
    if (_formKey2.currentState.validate()) {
      dialog.showMaterial(
        message: "Warten Sie mal...",
        title: "Passwort vergessen",
        centerTitle: true,
        layout: MaterialProgressDialogLayout
            .columnReveredWithCircularProgressIndicator,
        messageStyle: GoogleFonts.overpass(color: Colors.green[900]),
      );

      try {
        BaseResponse response = await UserService.operations().userReset(email);
        if (response is OkResponse) {
          if (response.body != null) {
            print('GELEN FORGTO ${response.body}');
            if (response.body["status"]!=null) {
              if (response.body["status"].toString().compareTo("true")==0) {
                settingRepo.toastWidget(("Erfolgreich gesendet."), Colors.green);
                emailController.clear();
                Navigator.pop(context);
                showSuccessSendEmailResponse();
              } else {
                Navigator.pop(context);
                _showDialogForgotError();
              }
            } else {
              Navigator.pop(context);
              _showDialogForgotError();
            }
          } else {
            Navigator.pop(context);
            _showDialogForgotError();
          }
        } else {
          Navigator.pop(context);
          _showDialogForgotError();
        }
      } catch (e) {
        Navigator.pop(context);
        _showDialogForgotError();
        print('Exception Create Session -- $e');
      }
    }
  }

  void showSuccessSendEmailResponse() async {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.SUCCES,
      animType: AnimType.BOTTOMSLIDE,
      dismissOnBackKeyPress: false,
      dismissOnTouchOutside: false,
      title: 'Einreichung erfolgreich',
      desc: 'Die Anforderung zum Zurücksetzen des Passworts wurde erfolgreich gesendet. Bitte überprüfen Sie Ihre E-Mail.',
      btnOkText: "CANCEL",
      btnOkOnPress: () async {

      },
    )..show();
  }

  void _showDialogForgotError() {
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
              "© 2021 beysi-on.de  All rights reserved",
              textAlign: TextAlign.center,
              style: GoogleFonts.overpass(fontSize: 12),
            ),
            InkWell(
              onTap: () async{
                if (await canLaunch("https://beysion.getusoft.com/Impressum")) {
                  await launch("https://beysion.getusoft.com/Impressum");
                }
              },
              child: Text(
                "Impressum",
                textAlign: TextAlign.center,
                style: GoogleFonts.overpass(fontSize: 12),
              ),
            ),
            InkWell(
              onTap: () async{
                if (await canLaunch("https://beysion.getusoft.com/Datenschutzrichtlinien")) {
                  await launch("https://beysion.getusoft.com/Datenschutzrichtlinien");
                }
              },
              child: Text(
                "Datenschutz",
                textAlign: TextAlign.center,
                style: GoogleFonts.overpass(fontSize: 12),
              ),
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
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => SellerLoginPage()));
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
        //top: MediaQuery.of(context).padding.top * 1.5,
        left: getSize(context, true, 45 / 415),
        right: getSize(context, true, 45 / 415),
      ),
      child: Column(
        children: [
          Container(
            height: getSize(context, true, 50.63 / 415),
            width: getSize(context, true, 243.4 / 415),
            child: Image.asset(
              LogosPath.beysion,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: getSize(context, true, 30 / 415)),
            child: Text(
              "Ihre Bestellung \nist bereit!",
              textAlign: TextAlign.center,
              style: GoogleFonts.overpass(
                  color: BeysionColors.orange,
                  fontSize: 30,
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
                  fontSize: 25,
                  fontWeight: FontWeight.w900),
            ),
          ),
        ],
      ),
    );
  }
}
