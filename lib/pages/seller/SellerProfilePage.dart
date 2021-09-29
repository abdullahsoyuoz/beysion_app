import 'package:beysion/Utility/Colors.dart';
import 'package:beysion/Utility/Icons.dart';
import 'package:beysion/Utility/util.dart';
import 'package:beysion/pages/WelcomePage.dart';
import 'package:beysion/pages/seller/SellerPLZPage.dart';
import 'package:beysion/rest/entity/seller/seller_login_entity.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:math' as math;
import 'package:beysion/constant/app_configurations.dart' as settingRepo;

import 'SellerAccountInfoPage.dart';
import 'SellerDeliverySettingsPage.dart';
import 'SellerLoginPage.dart';
import 'SellerProductsPage.dart';
import 'SellerSalesPage.dart';
import 'SellerSettingsPage.dart';
import 'SellerDashboardPage.dart';

class SellerProfilePage extends StatefulWidget {
  @override
  _SellerProfilePageState createState() => _SellerProfilePageState();
}

class _SellerProfilePageState extends State<SellerProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: buildBody(context),
    );
  }

  buildBody(BuildContext context) {
    SellerLoginEntity sellerLoginEntity =  settingRepo.sellerLoginInformationEntity.value;
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
                style: TextStyle(
                  color: BeysionColors.gray2,
                  fontSize: 15,
                ),
              ),
              Text(
                "${sellerLoginEntity.detail.name}",
                style: TextStyle(
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
                  "Dashboard",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SellerDashboardPage()));
                  },
              ),
              SizedBox(
                height: getSize(context, true, 10 / 415),
              ),
              InkWell(
                splashColor: BeysionColors.yellow,
                highlightColor: Colors.transparent,
                child: Text(
                  "Bestellungen",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SellerSalesPage()));
                },
              ),
              SizedBox(
                height: getSize(context, true, 10 / 415),
              ),
              InkWell(
                splashColor: BeysionColors.yellow,
                highlightColor: Colors.transparent,
                child: Text(
                  "Produkte",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SellerProductsPage()));
                  },
              ),
              SizedBox(
                height: getSize(context, true, 10 / 415),
              ),
              InkWell(
                splashColor: BeysionColors.yellow,
                highlightColor: Colors.transparent,
                child: Text(
                  "Allgemeine Einstellungen",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SellerSettingsPage()));
                  },
              ),
              SizedBox(
                height: getSize(context, true, 10 / 415),
              ),
              InkWell(
                splashColor: BeysionColors.yellow,
                highlightColor: Colors.transparent,
                child: Text(
                  "Liefereinstellungen",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SellerDeliverySettingsPage()));
                  },
              ),
              SizedBox(
                height: getSize(context, true, 10 / 415),
              ),
              InkWell(
                splashColor: BeysionColors.yellow,
                highlightColor: Colors.transparent,
                child: Text(
                  "PLZ-Einstellungen",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                  ),
                ),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => SellerPlzPage(),));
                },
              ),
              SizedBox(
                height: getSize(context, true, 10 / 415),
              ),
              InkWell(
                splashColor: BeysionColors.yellow,
                highlightColor: Colors.transparent,
                child: Text(
                  "Kontoinformatioenen",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                  ),
                ),
                onTap: () {
                  //Navigator.pushNamed(context, "/sellerAccountInfo");
                  Navigator.pop(context);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SellerAccountInfoPage()));
                  },
              ),
              SizedBox(
                height: getSize(context, true, 10 / 415),
              ),
              InkWell(
                splashColor: BeysionColors.yellow,
                highlightColor: Colors.transparent,
                child: Text(
                  "Abmelden",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                  ),
                ),
                onTap: () async {
                  SharedPreferences sharedPref = await SharedPreferences.getInstance();
                  await sharedPref.remove("sellerLoginEntity");
                  Navigator.pop(context);
                  settingRepo.toastWidget(("Beenden Sie erfolgreich. Seller.."), Colors.green);
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => WelcomePage()));
                  },
              ),
            ],
          ),
        ),
        Positioned(
          right: getSize(context, true, 5 / 415),
          top: MediaQuery.of(context).padding.top,
          child: FlatButton(
            minWidth: 5,
            child: Transform.rotate(
                angle: math.pi / 4,
                child: Image.asset(
                  IconsPath.plus,
                  color: BeysionColors.gray2,
                  width: getSize(context, true, 30 / 415),
                  height: getSize(context, true, 30 / 415),
                )),
            splashColor: BeysionColors.gray1.withOpacity(0.3),
            highlightColor: BeysionColors.gray1.withOpacity(0),
            hoverColor: BeysionColors.gray1.withOpacity(0),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        )
      ],
    );
  }
}
