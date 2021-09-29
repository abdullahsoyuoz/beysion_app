import 'package:beysion/Utility/Colors.dart';
import 'package:beysion/Utility/Icons.dart';
import 'package:beysion/Utility/util.dart';
import 'package:beysion/pages/MainPageView.dart';
import 'package:beysion/rest/controller/user/user_login_information_provider.dart';
import 'package:beysion/rest/entity/user/user_login_entity.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:math' as math;
import 'package:beysion/constant/app_configurations.dart' as settingRepo;

import 'HomePage.dart';
import 'MyAddressPage.dart';
import 'MyFavoritesPage.dart';
import 'MyOrdersPage.dart';
import 'MyPaymentMethodsPage.dart';
import 'MyProfileAccountInfoPage.dart';

class MyProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: buildBody(context),
      ),
    );
  }

  buildBody(BuildContext context) {
    UserLoginInformationEntity userLoginInformationEntity = Provider.of<UserLoginInformationProvider>(context, listen: false).userLoginInformationEntity;
    return Stack(
      children: [
        Container(
          width: getSize(context, true, 1),
          height: getSize(context, false, 1),
          margin: EdgeInsets.only(
            left: getSize(context, true, 36 / 415),
            right: getSize(context, true, 36 / 415),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Willkommen",
                style: GoogleFonts.overpass(
                  color: BeysionColors.gray2,
                  fontSize: 15,
                ),
              ),
              Text(
                "${userLoginInformationEntity.name} ${userLoginInformationEntity.surname}",
                style: GoogleFonts.overpass(
                  color: Colors.black,
                  fontSize: 18,
                ),
              ),
              Divider(
                height: getSize(context, true, 50 / 415),
              ),
              InkWell(
                splashColor: BeysionColors.yellow,
                highlightColor: Colors.transparent,
                child: Text(
                  "Kontoinformation",
                  style: GoogleFonts.overpass(
                    color: Colors.black,
                    fontSize: 20,
                  ),
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MyProfileAccountInfoPage()));
                },
              ),
              SizedBox(
                height: getSize(context, true, 10 / 415),
              ),
              InkWell(
                splashColor: BeysionColors.yellow,
                highlightColor: Colors.transparent,
                child: Text(
                  "Meine Bestellungen",
                  style: GoogleFonts.overpass(
                    color: Colors.black,
                    fontSize: 20,
                  ),
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MyOrdersPage()));
                },
              ),
              SizedBox(
                height: getSize(context, true, 10 / 415),
              ),
              InkWell(
                splashColor: BeysionColors.yellow,
                highlightColor: Colors.transparent,
                child: Text(
                  "Meine Adresse",
                  style: GoogleFonts.overpass(
                    color: Colors.black,
                    fontSize: 20,
                  ),
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MyAddressPage()));
                },
              ),
              SizedBox(
                height: getSize(context, true, 10 / 415),
              ),
              InkWell(
                splashColor: BeysionColors.yellow,
                highlightColor: Colors.transparent,
                child: Text(
                  "Meine Favoriten",
                  style: GoogleFonts.overpass(
                    color: Colors.black,
                    fontSize: 20,
                  ),
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MyFavoritesPage()));
                },
              ),
              SizedBox(
                height: getSize(context, true, 10 / 415),
              ),
              /*InkWell(
                splashColor: BeysionColors.yellow,
                highlightColor: Colors.transparent,
                child: Text(
                  "Meine Zahlungsmethoden",
                  style: GoogleFonts.overpass(
                    color: Colors.black,
                    fontSize: 20,
                  ),
                )
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MyPaymentMethodsPage()));
                },
              ),
              SizedBox(
                height: getSize(context, true, 10 / 415),
              ),*/
              InkWell(
                splashColor: BeysionColors.yellow,
                highlightColor: Colors.transparent,
                child: Text(
                  "Ausloggen",
                  style: GoogleFonts.overpass(
                    color: Colors.black,
                    fontSize: 20,
                  ),
                ),
                onTap: () async {
                  SharedPreferences sharedPref = await SharedPreferences.getInstance();
                  await sharedPref.remove("userTokenEntity");
                  settingRepo.currentUserTokenEntity.value.token = null;
                  Provider.of<UserLoginInformationProvider>(context, listen: false).userLoginInformationEntity = null;
                  settingRepo.toastWidget(("Beenden Sie erfolgreich..."), Colors.green);
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MainPageView()));
                },
              ),
            ],
          ),
        ),

      ],
    );
  }
}
