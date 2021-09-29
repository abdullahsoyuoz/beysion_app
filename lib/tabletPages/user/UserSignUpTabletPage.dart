import 'package:beysion/Utility/Colors.dart';
import 'package:beysion/Utility/Images.dart';
import 'package:beysion/Utility/Logos.dart';
import 'package:beysion/Utility/util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:beysion/tabletPages/seller/SellerLoginTabletPage.dart';
import 'package:url_launcher/url_launcher.dart';

class UserSignUpTabletPage extends StatefulWidget {
  @override
  _UserSignUpTabletPageState createState() => _UserSignUpTabletPageState();
}

class _UserSignUpTabletPageState extends State<UserSignUpTabletPage> {
  TextEditingController nameController;
  TextEditingController nicknameController;
  TextEditingController emailController;
  TextEditingController phoneNumberController;
  TextEditingController passwordController;
  TextEditingController passwordAgainController;
  bool checkboxValue = false;

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
                fontWeight: FontWeight.w700,
                fontSize: 28),
          ),
          SizedBox(
            height: getSize(context, true, 5 / 415),
          ),
          TextFormField(
            controller: nameController,
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
                      width: getSize(context, true, 2/415)),
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
                      width: getSize(context, true, 2/415)),
                ),
                labelText: "Nachname *",
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
                      width: getSize(context, true, 2/415)),
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
                      width: getSize(context, true, 2/415)),
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
                      width: getSize(context, true, 2/415)),
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
                      width: getSize(context, true, 2/415)),
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
                  child: Text("Ich habe die Datenschutzrichtlinien, und die Nutzungsbedingungen gelesen und akzeptiert"),
                )
              )
            ],
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
                  "REGISTRIEREN",
                  style: GoogleFonts.overpass(fontSize: 16,
                      fontWeight: FontWeight.w600),
                )),
            onPressed: () {},
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
    );
  }
}
