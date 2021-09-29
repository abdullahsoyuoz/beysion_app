/*
 *  DO NOT ALTER OR REMOVE COPYRIGHT NOTICES OR THIS FILE HEADER.
 *
 *  Copyright (C) 2019 Rich Design - All Rights Reserved
 *  Unauthorized copying of this file, via any medium is strictly prohibited
 *  Proprietary and confidential.
 *
 *  Written by Rich Design <info@designsrich.com>, August 2019
 *
 */

import 'dart:async';
import 'package:beysion/tabletPages/WelcomeTabletPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../main.dart';
import 'WelcomePage.dart';


class SplashScreen extends StatefulWidget {
  @override
  SplashScreenState createState() => new SplashScreenState();
}

class SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {

  startTime() async {
    var _duration = new Duration(seconds: 3);
    return new Timer(_duration, run);
  }

  Future run() async {
    runApp(MyApp(WelcomePage(), WelcomeTabletPage()));
  }

  @override
  void initState() {
    super.initState();
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        fit: StackFit.loose,
        children: <Widget>[
          Container(
            decoration: new BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/logos/splash.jpg'), fit: BoxFit.cover),
            ),

          ),
        ],
      ),
    );
  }
}
