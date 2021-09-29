import 'package:beysion/Utility/Colors.dart';
import 'package:beysion/Utility/Icons.dart';
import 'package:beysion/Utility/util.dart';
import 'package:beysion/rest/controller/user/user_login_information_provider.dart';
import 'package:beysion/rest/entity/user/user_login_entity.dart';
import 'package:beysion/tabletPages/MainPageViewTablet.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:math' as math;
import 'package:beysion/constant/app_configurations.dart' as settingRepo;

import 'HomeTabletPage.dart';
import 'MyAddressTabletPage.dart';
import 'MyFavoritesTabletPage.dart';
import 'MyOrdersTabletPage.dart';
import 'MyProfileAccountInfoTabletPage.dart';

class MyProfileTabletPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: buildBody(context),
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
                height: getSize(context, true, 40 / 415),
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
                          builder: (context) => MyProfileAccountInfoTabletPage()));
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
                          builder: (context) => MyOrdersTabletPage()));
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
                          builder: (context) => MyAddressTabletPage()));
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
                          builder: (context) => MyFavoritesTabletPage()));
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
                  Navigator.pop(context);
                  settingRepo.toastWidget(("Beenden Sie erfolgreich..."), Colors.green);
                  settingRepo.currentUserTokenEntity.value = null;
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MainPageViewTablet()));
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
