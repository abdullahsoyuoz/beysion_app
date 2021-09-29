import 'package:beysion/Utility/Colors.dart';
import 'package:beysion/Utility/Images.dart';
import 'package:beysion/Utility/Logos.dart';
import 'package:beysion/Utility/util.dart';
import 'package:beysion/constant/app_configurations.dart';
import 'package:beysion/pages/seller/SellerLoginPage.dart';
import 'package:beysion/rest/entity/user/user_register_entity.dart';
import 'package:beysion/rest/response_models/base_response.dart';
import 'package:beysion/rest/response_models/ok_response.dart';
import 'package:beysion/rest/service/user_service.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simpleprogressdialog/builders/material_dialog_builder.dart';
import 'package:simpleprogressdialog/simpleprogressdialog.dart';
import 'package:url_launcher/url_launcher.dart';

class UserSignUpPage extends StatefulWidget {
  @override
  _UserSignUpPageState createState() => _UserSignUpPageState();
}

class _UserSignUpPageState extends State<UserSignUpPage> {
  TextEditingController nameController;
  TextEditingController nicknameController;
  TextEditingController emailController;
  TextEditingController phoneNumberController;
  TextEditingController passwordController;
  TextEditingController passwordAgainController;
  bool checkboxValue = false;
  ProgressDialog dialog;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nameController = TextEditingController();
    nicknameController = TextEditingController();
    emailController = TextEditingController();
    phoneNumberController = TextEditingController();
    passwordController = TextEditingController();
    passwordAgainController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    nameController.dispose();
    nicknameController.dispose();
    emailController.dispose();
    phoneNumberController.dispose();
    passwordController.dispose();
    passwordAgainController.dispose();
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
            child: ListView(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              children: [
                Center(
                  child: buildHomeForm(context),
                ),
                SizedBox(
                  height: getSize(context, true, 50 / 415),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: AllRightsWidget(),
                )
              ],
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
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Neues Benutzerkonto",
            style: GoogleFonts.overpass(
                color: BeysionColors.purple,
                fontWeight: FontWeight.w600,
                fontSize: 24),
          ),
          SizedBox(
            height: getSize(context, true, 20 / 415),
          ),
          TextFormField(
            controller: nameController,
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
                labelText: "Name *",
                labelStyle: GoogleFonts.overpass(color: BeysionColors.gray2)),
          ),
          SizedBox(
            height: getSize(context, true, 20 / 415),
          ),
          TextFormField(
            controller: nicknameController,
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
                labelText: "Vorname *",
                labelStyle: GoogleFonts.overpass(color: BeysionColors.gray2)),
          ),
          SizedBox(
            height: getSize(context, true, 20 / 415),
          ),
          TextFormField(
            controller: emailController,
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
                labelText: "E-Mail *",
                labelStyle: GoogleFonts.overpass(color: BeysionColors.gray2)),
          ),
          SizedBox(
            height: getSize(context, true, 20 / 415),
          ),
          TextFormField(
            controller: phoneNumberController,
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
                labelText: "Mobiltelefon *",
                labelStyle: GoogleFonts.overpass(color: BeysionColors.gray2)),
          ),
          SizedBox(
            height: getSize(context, true, 20 / 415),
          ),
          TextFormField(
            controller: passwordController,
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
                labelText: "Passwort *",
                labelStyle: GoogleFonts.overpass(color: BeysionColors.gray2)),
          ),
          SizedBox(
            height: getSize(context, true, 20 / 415),
          ),
          TextFormField(
            controller: passwordAgainController,
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
          SizedBox(
            height: getSize(context, true, 15/415),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                flex: 1,
                child: Checkbox(
                  value: checkboxValue,
                  onChanged: (value) {
                    setState(() {
                      checkboxValue = value;
                    });
                  },
                  activeColor: BeysionColors.purple,
                  checkColor: BeysionColors.border,
                  visualDensity: VisualDensity.standard,

                ),
              ),
              Flexible(
                flex: 10,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: getSize(context, true, 5/415)
                  ),
                  child: Text("Ich habe die Datenschutzrichtlinien, die Nutzungsbedingungen gelesen und akzeptiert"),
                )
              )
            ],
          ),
          SizedBox(
            height: getSize(context, true, 10 / 415),
          ),
          FlatButton(
            child: Text(
              "REGISTRIEREN",
              style: GoogleFonts.overpass(fontSize: 16,
                  fontWeight: FontWeight.w600),
            ),
            color: BeysionColors.orange,
            minWidth: getSize(context, true, 1),
            onPressed: () async {
              if(checkboxValue){
                dialog.showMaterial(
                  message: "Wird bearbeitet ...",
                  title: "Warten Sie mal",
                  centerTitle: true,
                  layout: MaterialProgressDialogLayout
                      .columnReveredWithCircularProgressIndicator,
                  messageStyle: GoogleFonts.overpass(color: Colors.green[900]),);
                if(nameController.text.length>1 && nicknameController.text.length>1 && phoneNumberController.text.length>1){
                  if(emailController.text.length>1 && emailController.text.contains("@")){
                    if(passwordController.text.compareTo(passwordAgainController.text) == 0){
                      UserRegisterEntity userRegisterEntity = new UserRegisterEntity();
                      userRegisterEntity.name = nameController.text;
                      userRegisterEntity.nachname = nicknameController.text;
                      userRegisterEntity.email = emailController.text;
                      userRegisterEntity.mobil = phoneNumberController.text;
                      userRegisterEntity.password = passwordController.text;
                      userRegisterEntity.passwordConfirm = passwordAgainController.text;
                      UserService userService = new UserService();
                      BaseResponse baseResponse = await userService.userRegister(userRegisterEntity);
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
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => SellerLoginPage()));
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
            padding: EdgeInsets.only(top: getSize(context, true, 25 / 415)),
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
