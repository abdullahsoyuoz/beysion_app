import 'package:beysion/Utility/Colors.dart';
import 'package:beysion/Utility/Icons.dart';
import 'package:beysion/Utility/Widgets.dart';
import 'package:beysion/Utility/util.dart';
import 'package:beysion/rest/controller/seller/seller_order_provider.dart';
import 'package:beysion/utility/CustomShape.dart';
import 'package:beysion/utility/FakeData.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:timelines/timelines.dart';

import 'SellerSalesPage.dart';

class SellerDashboardPage extends StatefulWidget {
  @override
  _SellerDashboardPageState createState() => _SellerDashboardPageState();
}

class _SellerDashboardPageState extends State<SellerDashboardPage> {
  int selectedPopupmenuValue = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      Provider.of<SellerOrderProvider>(context, listen: false)
          .getSellerOrdersListDataController();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBarSeller(context),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: ListView(
          shrinkWrap: true,
          children: [
            Padding(
              padding: EdgeInsets.only(
                top: 24,
                left: 24,
                right: 24,
              ),
              child: Text(
                "Kurzbericht",
                style: GoogleFonts.overpass(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: 8,
                left: 16,
                right: 16,
              ),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(5)),
                padding: EdgeInsets.only(
                  top: 24,
                  bottom: 24,
                  left: 16,
                  right: 16,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //  ----------------------------------------  Kundenbewertungen
                    FittedBox(
                      fit: BoxFit.fitWidth,
                      child: Container(
                          height: getSize(context, true, 50 / 415),
                          padding: EdgeInsets.only(
                            top: 8,
                            bottom: 8,
                            right: 8,
                          ),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.grey.shade300),
                              borderRadius: BorderRadius.circular(5),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey.shade200,
                                    blurRadius: 5,
                                    spreadRadius: 2,
                                    offset: Offset(0, 3))
                              ]),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                width: getSize(context, true, 10 / 415),
                                height: getSize(context, true, 30 / 415),
                                decoration: BoxDecoration(
                                    color: BeysionColors.purple,
                                    borderRadius: BorderRadius.horizontal(
                                        right: Radius.circular(5))),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Text(
                                  "Kundenbewertungen",
                                  style: GoogleFonts.overpass(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                            ],
                          )),
                    ),
                    //  ----------------------------------------  SLIDERS
                    Container(
                      margin: EdgeInsets.only(top: 32),
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.grey.shade300),
                          borderRadius: BorderRadius.circular(5),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey.shade200,
                                blurRadius: 5,
                                spreadRadius: 2,
                                offset: Offset(0, 3))
                          ]),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Lieferzeit",
                                  style: GoogleFonts.overpass(
                                    color: Colors.grey.shade600,
                                    fontSize: 22,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                Text(
                                  "${FakeData.fakeSliderRankValues[0]}",
                                  style: GoogleFonts.overpass(
                                      color: Colors.black,
                                      fontSize: 42,
                                      fontWeight: FontWeight.w800),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: SleekCircularSlider(
                              initialValue: FakeData.fakeSliderValues[0],
                              appearance: CircularSliderAppearance(
                                  angleRange: 360,
                                  startAngle: 270,
                                  infoProperties: InfoProperties(
                                      mainLabelStyle: GoogleFonts.overpass(
                                          fontSize: 28,
                                          fontWeight: FontWeight.w600)),
                                  customColors: CustomSliderColors(
                                    dynamicGradient: false,
                                    dotColor: Colors.transparent,
                                    progressBarColor:
                                        Color.fromARGB(255, 92, 76, 149),
                                    hideShadow: true,
                                    trackColor: Colors.grey.shade200,
                                  ),
                                  customWidths: CustomSliderWidths(
                                      progressBarWidth: 16, trackWidth: 16)),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 32),
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.grey.shade300),
                          borderRadius: BorderRadius.circular(5),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey.shade200,
                                blurRadius: 5,
                                spreadRadius: 2,
                                offset: Offset(0, 3))
                          ]),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Service",
                                  style: GoogleFonts.overpass(
                                    color: Colors.grey.shade600,
                                    fontSize: 22,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                Text(
                                  "${FakeData.fakeSliderRankValues[1]}",
                                  style: GoogleFonts.overpass(
                                      color: Colors.black,
                                      fontSize: 42,
                                      fontWeight: FontWeight.w800),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: SleekCircularSlider(
                              initialValue: FakeData.fakeSliderValues[1],
                              appearance: CircularSliderAppearance(
                                  angleRange: 360,
                                  startAngle: 270,
                                  infoProperties: InfoProperties(
                                      mainLabelStyle: GoogleFonts.overpass(
                                          fontSize: 28,
                                          fontWeight: FontWeight.w600)),
                                  customColors: CustomSliderColors(
                                    dynamicGradient: false,
                                    dotColor: Colors.transparent,
                                    progressBarColor:
                                        Color.fromARGB(255, 101, 202, 143),
                                    hideShadow: true,
                                    trackColor: Colors.grey.shade200,
                                  ),
                                  customWidths: CustomSliderWidths(
                                      progressBarWidth: 16, trackWidth: 16)),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 32),
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.grey.shade300),
                          borderRadius: BorderRadius.circular(5),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey.shade200,
                                blurRadius: 5,
                                spreadRadius: 2,
                                offset: Offset(0, 3))
                          ]),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Freundlichkeit",
                                  style: GoogleFonts.overpass(
                                    color: Colors.grey.shade600,
                                    fontSize: 22,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                Text(
                                  "${FakeData.fakeSliderRankValues[2]}",
                                  style: GoogleFonts.overpass(
                                      color: Colors.black,
                                      fontSize: 42,
                                      fontWeight: FontWeight.w800),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: SleekCircularSlider(
                              initialValue: FakeData.fakeSliderValues[2],
                              appearance: CircularSliderAppearance(
                                  angleRange: 360,
                                  startAngle: 270,
                                  infoProperties: InfoProperties(
                                      mainLabelStyle: GoogleFonts.overpass(
                                          fontSize: 28,
                                          fontWeight: FontWeight.w600)),
                                  customColors: CustomSliderColors(
                                    dynamicGradient: false,
                                    dotColor: Colors.transparent,
                                    progressBarColor:
                                        Color.fromARGB(255, 228, 72, 109),
                                    hideShadow: true,
                                    trackColor: Colors.grey.shade200,
                                  ),
                                  customWidths: CustomSliderWidths(
                                      progressBarWidth: 16, trackWidth: 16)),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 32),
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.grey.shade300),
                          borderRadius: BorderRadius.circular(5),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey.shade200,
                                blurRadius: 5,
                                spreadRadius: 2,
                                offset: Offset(0, 3))
                          ]),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Durchschnitt",
                                  style: GoogleFonts.overpass(
                                    color: Colors.grey.shade600,
                                    fontSize: 22,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                Text(
                                  "${FakeData.fakeSliderRankValues[3]}",
                                  style: GoogleFonts.overpass(
                                      color: Colors.black,
                                      fontSize: 42,
                                      fontWeight: FontWeight.w800),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: SleekCircularSlider(
                              initialValue: FakeData.fakeSliderValues[3],
                              appearance: CircularSliderAppearance(
                                  angleRange: 360,
                                  startAngle: 270,
                                  infoProperties: InfoProperties(
                                      mainLabelStyle: GoogleFonts.overpass(
                                          fontSize: 28,
                                          fontWeight: FontWeight.w600)),
                                  customColors: CustomSliderColors(
                                    dynamicGradient: false,
                                    dotColor: Colors.transparent,
                                    progressBarColor:
                                        Color.fromARGB(255, 247, 202, 85),
                                    hideShadow: true,
                                    trackColor: Colors.grey.shade200,
                                  ),
                                  customWidths: CustomSliderWidths(
                                      progressBarWidth: 16, trackWidth: 16)),
                            ),
                          )
                        ],
                      ),
                    ),
                    //  ----------------------------------------  CHART GRAPHICS
                    Container(
                      margin: EdgeInsets.only(top: 32),
                      padding: EdgeInsets.only(top: 16,),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.grey.shade300),
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey.shade200,
                                blurRadius: 5,
                                spreadRadius: 2,
                                offset: Offset(0, 3))
                          ]),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 16,),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Umsatz Heute",
                                  style: GoogleFonts.overpass(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600),
                                ),
                                Container(
                                  padding: EdgeInsets.only(
                                    top: 8,
                                    bottom: 8,
                                    right: 8,
                                    left: 16,
                                  ),
                                  decoration: BoxDecoration(
                                      color: Color.fromARGB(255, 97, 129, 247),
                                      borderRadius: BorderRadius.horizontal(
                                          left: Radius.circular(100))),
                                  child: Text(
                                    "${FakeData.fakeUmzatzsValue[0]}",
                                    style: GoogleFonts.overpass(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 16,),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  FakeData.fakeUmzatzsValue[0] == 0
                                      ? "kein Umsatz"
                                      : "€ ${FakeData.fakeUmzatzsPriceValue[0]}",
                                  style: GoogleFonts.overpass(
                                      color: Colors.black,
                                      fontSize: 26,
                                      fontWeight: FontWeight.w900),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: Text(
                                    "Aufträge",
                                    style: GoogleFonts.overpass(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 16,),
                            child: Text(
                              "Heutige Verkäufe.",
                              style: GoogleFonts.overpass(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                          FakeData.fakeHeuteList.length == 0
                              ? SizedBox()
                              : ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: SfCartesianChart(
                                    borderColor: Colors.transparent,
                                    plotAreaBorderColor: Colors.transparent,
                                    margin: EdgeInsets.zero,
                                    primaryXAxis: CategoryAxis(
                                      isVisible: false,
                                      maximum: 4,
                                      minimum: 1,
                                    ),
                                    primaryYAxis: CategoryAxis(
                                      isVisible: false,
                                      maximum: 3,
                                      minimum: 1,
                                    ),
                                    series: <ChartSeries>[
                                      SplineAreaSeries<FakeChartData, String>(
                                        dataSource: FakeData.fakeHeuteList,
                                        xValueMapper: (FakeChartData data, _) => data.x.toString(),
                                        yValueMapper: (FakeChartData data, _) => data.y,
                                        gradient: LinearGradient(
                                            begin: Alignment.topCenter,
                                            end: Alignment.bottomCenter,
                                            stops: [
                                              0.5, 1
                                            ],
                                            colors: [
                                              Color.fromARGB(255, 97, 129, 247),
                                              Color.fromARGB(120, 97, 129, 247),
                                            ]
                                        ),
                                        borderColor: Color.fromARGB(255, 97, 129, 247),
                                        borderWidth: 2,
                                        borderDrawMode: BorderDrawMode.excludeBottom,
                                      )
                                    ],
                                  ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 32),
                      padding: EdgeInsets.only(
                        top: 16,
                      ),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.grey.shade300),
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey.shade200,
                                blurRadius: 5,
                                spreadRadius: 2,
                                offset: Offset(0, 3))
                          ]),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 16.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Umsatz letzte 7 Tage",
                                  style: GoogleFonts.overpass(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600),
                                ),
                                Container(
                                  padding: EdgeInsets.only(
                                    top: 8,
                                    bottom: 8,
                                    right: 8,
                                    left: 16,
                                  ),
                                  decoration: BoxDecoration(
                                      color: Color.fromARGB(255, 205, 106, 102),
                                      borderRadius: BorderRadius.horizontal(
                                          left: Radius.circular(100))),
                                  child: Text(
                                    "${FakeData.fakeUmzatzsValue[1]}",
                                    style: GoogleFonts.overpass(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 16.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  FakeData.fakeUmzatzsValue[1] == 0
                                      ? "kein Umsatz"
                                      : "€ ${FakeData.fakeUmzatzsPriceValue[1]}",
                                  style: GoogleFonts.overpass(
                                      color: Colors.black,
                                      fontSize: 26,
                                      fontWeight: FontWeight.w900),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: Text(
                                    "Aufträge",
                                    style: GoogleFonts.overpass(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 16.0),
                            child: Text(
                              "Einkommen für die letzten 1 Woche.",
                              style: GoogleFonts.overpass(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                          FakeData.fakeUmsatz7TageList.length == 0
                              ? SizedBox()
                              : ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: SfCartesianChart(
                                    borderColor: Colors.transparent,
                                    plotAreaBorderColor: Colors.transparent,
                                    margin: EdgeInsets.zero,
                                    primaryXAxis: CategoryAxis(
                                      isVisible: false,
                                      maximum: 4,
                                      minimum: 1,
                                    ),
                                    primaryYAxis: CategoryAxis(
                                      isVisible: false,
                                      maximum: 3,
                                      minimum: 1,
                                    ),
                                    series: <ChartSeries>[
                                      SplineAreaSeries<FakeChartData, String>(
                                        dataSource: FakeData.fakeUmsatz7TageList,
                                        xValueMapper: (FakeChartData data, _) => data.x.toString(),
                                        yValueMapper: (FakeChartData data, _) => data.y,
                                        gradient: LinearGradient(
                                            begin: Alignment.topCenter,
                                            end: Alignment.bottomCenter,
                                            stops: [
                                              0.5, 1
                                            ],
                                            colors: [
                                              Color.fromARGB(255, 205, 106, 102),
                                              Color.fromARGB(120, 205, 106, 102),
                                            ]
                                        ),
                                        borderColor: Color.fromARGB(255, 205, 106, 102),
                                        borderWidth: 2,
                                        borderDrawMode: BorderDrawMode.excludeBottom,
                                      )
                                    ],
                                  ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 32),
                      padding: EdgeInsets.only(
                        top: 16,
                      ),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.grey.shade300),
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey.shade200,
                                blurRadius: 5,
                                spreadRadius: 2,
                                offset: Offset(0, 3))
                          ]),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 16,),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Umsatz letzte 30 Tage",
                                  style: GoogleFonts.overpass(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600),
                                ),
                                Container(
                                  padding: EdgeInsets.only(
                                    top: 8,
                                    bottom: 8,
                                    right: 8,
                                    left: 16,
                                  ),
                                  decoration: BoxDecoration(
                                      color: Color.fromARGB(255, 243, 173, 61),
                                      borderRadius: BorderRadius.horizontal(
                                          left: Radius.circular(100))),
                                  child: Text(
                                    "${FakeData.fakeUmzatzsValue[2]}",
                                    style: GoogleFonts.overpass(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 16,),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  FakeData.fakeUmzatzsValue[2] == 0
                                      ? "kein Umsatz"
                                      : "€ ${FakeData.fakeUmzatzsPriceValue[2]}",
                                  style: GoogleFonts.overpass(
                                      color: Colors.black,
                                      fontSize: 26,
                                      fontWeight: FontWeight.w900),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: Text(
                                    "Aufträge",
                                    style: GoogleFonts.overpass(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 16,),
                            child: Text(
                              "Einkommen für die letzten 30 Tage.",
                              style: GoogleFonts.overpass(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                          FakeData.fakeUmsatz30TageList.length == 0
                              ? SizedBox()
                              : ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: SfCartesianChart(
                                borderColor: Colors.transparent,
                                plotAreaBorderColor: Colors.transparent,
                                margin: EdgeInsets.zero,
                                primaryXAxis: CategoryAxis(
                                  isVisible: false,
                                  maximum: 4,
                                  minimum: 1,
                                ),
                                primaryYAxis: CategoryAxis(
                                  isVisible: false,
                                  maximum: 3,
                                  minimum: 1,
                                ),
                                series: <ChartSeries>[
                                  SplineAreaSeries<FakeChartData, String>(
                                    dataSource: FakeData.fakeUmsatz30TageList,
                                    xValueMapper: (FakeChartData data, _) => data.x.toString(),
                                    yValueMapper: (FakeChartData data, _) => data.y,
                                    gradient: LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        stops: [
                                          0.5, 1
                                        ],
                                        colors: [
                                          Color.fromARGB(255, 243, 173, 61),
                                          Color.fromARGB(120, 243, 173, 61),
                                        ]
                                    ),
                                    borderColor: Color.fromARGB(255, 243, 173, 61),
                                    borderWidth: 2,
                                    borderDrawMode: BorderDrawMode.excludeBottom,
                                  )
                                ],
                              )
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 32),
                      padding: EdgeInsets.only(
                        top: 16,
                      ),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.grey.shade300),
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey.shade200,
                                blurRadius: 5,
                                spreadRadius: 2,
                                offset: Offset(0, 3))
                          ]),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 16,),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Gesamtumsatz",
                                  style: GoogleFonts.overpass(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600),
                                ),
                                Container(
                                  padding: EdgeInsets.only(
                                    top: 8,
                                    bottom: 8,
                                    right: 8,
                                    left: 16,
                                  ),
                                  decoration: BoxDecoration(
                                      color: Color.fromARGB(255, 101, 202, 143),
                                      borderRadius: BorderRadius.horizontal(
                                          left: Radius.circular(100))),
                                  child: Text(
                                    "${FakeData.fakeUmzatzsValue[3]}",
                                    style: GoogleFonts.overpass(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 16,),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  FakeData.fakeUmzatzsValue[3] == 0
                                    ? "kein Umsatz"
                                      : "€ ${FakeData.fakeUmzatzsPriceValue[3]}",
                                  style: GoogleFonts.overpass(
                                      color: Colors.black,
                                      fontSize: 26,
                                      fontWeight: FontWeight.w900),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: Text(
                                    "Aufträge",
                                    style: GoogleFonts.overpass(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 16,),
                            child: Text(
                              "",
                              style: GoogleFonts.overpass(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                          FakeData.fakeGesamtumsatzList.length == 0
                              ? SizedBox()
                              : ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: SfCartesianChart(
                              borderColor: Colors.transparent,
                              plotAreaBorderColor: Colors.transparent,
                              margin: EdgeInsets.zero,
                              primaryXAxis: CategoryAxis(
                                isVisible: false,
                                maximum: 4,
                                minimum: 1,
                              ),
                              primaryYAxis: CategoryAxis(
                                isVisible: false,
                                maximum: 3,
                                minimum: 1,
                              ),
                              series: <ChartSeries>[
                                SplineAreaSeries<FakeChartData, String>(
                                  dataSource: FakeData.fakeGesamtumsatzList,
                                  xValueMapper: (FakeChartData data, _) => data.x.toString(),
                                  yValueMapper: (FakeChartData data, _) => data.y,
                                  gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      stops: [
                                        0.5, 1
                                      ],
                                      colors: [
                                        Color.fromARGB(255, 101, 202, 143),
                                        Color.fromARGB(120, 101, 202, 143),
                                      ]
                                  ),
                                  borderColor: Color.fromARGB(255, 101, 202, 143),
                                  borderWidth: 2,
                                  borderDrawMode: BorderDrawMode.excludeBottom,
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    //  ----------------------------------------  VERKAUFSANALYSE CHART
                    Padding(
                      padding: const EdgeInsets.only(top: 32.0),
                      child: Container(
                          padding: EdgeInsets.only(
                            top: 16,
                            bottom: 16,
                          ),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.grey.shade300),
                              borderRadius: BorderRadius.circular(5),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey.shade200,
                                    blurRadius: 5,
                                    spreadRadius: 2,
                                    offset: Offset(0, 3))
                              ]),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: getSize(context, true, 10 / 415),
                                        height:
                                            getSize(context, true, 30 / 415),
                                        decoration: BoxDecoration(
                                            color: BeysionColors.purple,
                                            borderRadius:
                                                BorderRadius.horizontal(
                                                    right: Radius.circular(5))),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 8.0),
                                        child: Text(
                                          "Kundenbewertungen",
                                          style: GoogleFonts.overpass(
                                              color: Colors.black,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 16.0),
                                    child: FittedBox(
                                      fit: BoxFit.fitWidth,
                                      child: OutlineButton(
                                        onPressed: () {},
                                        child: Text("Jahr"),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              Divider(),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            "Anzahl\nBestellungen",
                                            style: GoogleFonts.overpass(
                                                color: Colors.black,
                                                fontSize: 15,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                        Expanded(
                                          child: Text(
                                            "Anzahl\nVerkaufter",
                                            style: GoogleFonts.overpass(
                                                color: Colors.black,
                                                fontSize: 15,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8.0),
                                            child: Text(
                                              "5",
                                              style: GoogleFonts.overpass(
                                                color: Colors.black,
                                                fontSize: 26,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8.0),
                                            child: Text(
                                              "8",
                                              style: GoogleFonts.overpass(
                                                color: Colors.black,
                                                fontSize: 26,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Row(
                                            children: [
                                              FaIcon(
                                                FontAwesomeIcons.arrowUp,
                                                size: 14,
                                                color: Colors.green,
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 8.0),
                                                child: Text(
                                                  "dieses Jahr",
                                                  style: GoogleFonts.overpass(
                                                      color:
                                                          Colors.grey.shade600),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          child: Row(
                                            children: [
                                              FaIcon(
                                                FontAwesomeIcons.arrowUp,
                                                size: 14,
                                                color: Colors.green,
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 8.0),
                                                child: Text(
                                                  "dieses Jahr",
                                                  style: GoogleFonts.overpass(
                                                      color:
                                                          Colors.grey.shade600),
                                                ),
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: 16),
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            child: Text("Summe\nLiefergebühren", style: GoogleFonts.overpass(
                                              color: Colors.black,
                                              fontSize: 15,
                                              fontWeight: FontWeight.w600),
                                            ),),
                                          Expanded(
                                            child: Text("Summe\nverkaufer\nProduckte", style: GoogleFonts.overpass(
                                                color: Colors.black,
                                                fontSize: 15,
                                                fontWeight: FontWeight.w600,
                                            ),),
                                          )
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: 8),
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            child: Text("€ 22,47", style: GoogleFonts.overpass(
                                              color: Colors.black,
                                              fontSize: 26,
                                              fontWeight: FontWeight.w700,
                                            ),),
                                          ),
                                          Expanded(
                                            child: Text("€ 1.041,20", style: GoogleFonts.overpass(
                                              color: Colors.black,
                                              fontSize: 26,
                                              fontWeight: FontWeight.w700,
                                            ),),
                                          )
                                        ],
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Row(
                                            children: [
                                              FaIcon(
                                                FontAwesomeIcons.arrowUp,
                                                size: 14,
                                                color: Colors.green,
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 8.0),
                                                child: Text(
                                                  "dieses Jahr",
                                                  style: GoogleFonts.overpass(
                                                      color:
                                                      Colors.grey.shade600),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          child: Row(
                                            children: [
                                              FaIcon(
                                                FontAwesomeIcons.arrowUp,
                                                size: 14,
                                                color: Colors.green,
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 8.0),
                                                child: Text(
                                                  "dieses Jahr",
                                                  style: GoogleFonts.overpass(
                                                      color:
                                                      Colors.grey.shade600),
                                                ),
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 16.0),
                                      child: SfCartesianChart(
                                        primaryXAxis: CategoryAxis(),
                                        series: <ChartSeries>[
                                          ColumnSeries<FakeChartDataWithString, String>(
                                            dataSource: FakeData.fakeChartDataWithStringList,
                                            xValueMapper: (FakeChartDataWithString data, _) =>
                                                data.x.toString(),
                                            yValueMapper: (FakeChartDataWithString data, _) => data.y,
                                            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                                            gradient: LinearGradient(
                                              begin: Alignment.bottomCenter,
                                              end: Alignment.topCenter,
                                              colors: [
                                                Color.fromARGB(255, 89, 189, 243),
                                                Color.fromARGB(255, 107, 99, 194),
                                              ]
                                            )
                                          )
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: 8),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Center(
                                              child: Row(
                                                children: [
                                                  CircleAvatar(
                                                    backgroundColor: Color.fromARGB(255, 107, 99, 194),
                                                    radius: 10,
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.only(left: 8.0),
                                                    child: Text("Gesamtumsatz"),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Center(
                                              child: Row(
                                                children: [
                                                  CircleAvatar(
                                                    backgroundColor: Color.fromARGB(255, 230, 53, 122),
                                                    radius: 10,
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.only(left: 8.0),
                                                    child: Text("Bestellungen"),
                                                  )
                                                ],
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          )),
                    ),
                    //  ----------------------------------------  BESTELLSTATUS TIMELINE
                    Padding(
                      padding: const EdgeInsets.only(top: 32.0),
                      child: Container(
                          padding: EdgeInsets.only(
                            top: 16,
                            bottom: 16,
                          ),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.grey.shade300),
                              borderRadius: BorderRadius.circular(5),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey.shade200,
                                    blurRadius: 5,
                                    spreadRadius: 2,
                                    offset: Offset(0, 3))
                              ]),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: getSize(context, true, 10 / 415),
                                        height:
                                        getSize(context, true, 30 / 415),
                                        decoration: BoxDecoration(
                                            color: BeysionColors.purple,
                                            borderRadius:
                                            BorderRadius.horizontal(
                                                right: Radius.circular(5))),
                                      ),
                                      Padding(
                                        padding:
                                        const EdgeInsets.only(left: 8.0),
                                        child: Text(
                                          "Bestellstatus",
                                          style: GoogleFonts.overpass(
                                              color: Colors.black,
                                              fontSize: 18,
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 16.0),
                                    child: PopupMenuButton<String>(
                                      icon: Container(
                                          padding: EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              shape: BoxShape.circle,
                                              boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 3)]
                                          ),
                                          child: Center(child: Text("...", style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w800),))),
                                      padding: EdgeInsets.zero,
                                      onSelected: (value) {
                                        if (value == popupmenuItems[0]) {
                                          setState(() {
                                            selectedPopupmenuValue = 0;
                                          });
                                        }
                                        if (value == popupmenuItems[1]) {
                                          setState(() {
                                            selectedPopupmenuValue = 1;
                                          });
                                        }
                                        if (value == popupmenuItems[2]) {
                                          setState(() {
                                            selectedPopupmenuValue = 2;
                                          });
                                        }
                                        if (value == popupmenuItems[3]) {
                                          setState(() {
                                            selectedPopupmenuValue = 3;
                                          });
                                        }
                                        print(selectedPopupmenuValue.toString());
                                      },
                                      itemBuilder: (BuildContext context) {
                                        return popupmenuItems.map((String choice) {
                                          return PopupMenuItem<String>(
                                            value: choice,
                                            child: Text(choice),
                                          );
                                        }).toList();
                                      },
                                    ),
                                  )
                                ],
                              ),
                              Divider(),
                              SizedBox(
                                height: MediaQuery.of(context).size.height * 0.5,
                                child: SingleChildScrollView(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                    child: FixedTimeline.tileBuilder(
                                      mainAxisSize: MainAxisSize.min,
                                      theme: TimelineTheme.of(context).copyWith(
                                        nodePosition: 0,
                                        connectorTheme: TimelineTheme.of(context).connectorTheme.copyWith(
                                          color: Colors.grey.shade200,
                                        ),
                                        indicatorTheme: TimelineTheme.of(context).indicatorTheme.copyWith(
                                          size: 10.0,
                                          position: 0.5,
                                        ),
                                      ),
                                      builder: TimelineTileBuilder(
                                        indicatorBuilder: (_, index) => Indicator.outlined(
                                          color: index % 2 == 0 ? Colors.grey : BeysionColors.purple,
                                          borderWidth: 3,
                                          backgroundColor: Colors.white,
                                          size: 16,
                                        ),
                                        startConnectorBuilder: (_, index) => Connector.dashedLine(),
                                        endConnectorBuilder: (_, index) => Connector.dashedLine(),
                                        contentsBuilder: (_, index) {
                                          return Padding(
                                              padding: EdgeInsets.only(
                                                top: 8.0,
                                                bottom: 8,
                                                left: 16.0,
                                              ),
                                              child: Column(
                                                children: [
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Text("warte auf Bestätigung",
                                                        softWrap: true,
                                                        overflow: TextOverflow.ellipsis,
                                                        maxLines: 2,
                                                        style: GoogleFonts.overpass(
                                                          color: Colors.black,
                                                          fontSize: 14,
                                                          fontWeight: FontWeight.w700,
                                                        ),),
                                                      Text("29.05.2021", style: GoogleFonts.overpass(
                                                          color: Colors.grey,
                                                          fontSize: 14,
                                                          fontWeight: FontWeight.w600
                                                      ),),
                                                    ],
                                                  ),
                                                  RichText(
                                                    text: TextSpan(
                                                        text: "Lieferservice ",
                                                        style: GoogleFonts.overpass(
                                                            color: Colors.grey,
                                                            fontSize: 14
                                                        ),
                                                        children: [
                                                          TextSpan(
                                                              text: "Klicken Sie hier für Bestelldetails",
                                                              style: GoogleFonts.overpass(
                                                                  color: BeysionColors.purple,
                                                                  fontSize: 14, fontWeight:
                                                                  FontWeight.w600)
                                                          )
                                                        ]
                                                    ),
                                                  )
                                                ],
                                              )
                                          );
                                        },
                                        nodeItemOverlapBuilder: (_, index) => false,
                                        itemCount: 10,
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          )),
                    ),
                    //  ----------------------------------------  PIE CHART WIDGETS
                    Padding(
                      padding: const EdgeInsets.only(top: 32.0),
                      child: Container(
                          padding: EdgeInsets.only(
                            top: 16,
                            bottom: 16,
                          ),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.grey.shade300),
                              borderRadius: BorderRadius.circular(5),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey.shade200,
                                    blurRadius: 5,
                                    spreadRadius: 2,
                                    offset: Offset(0, 3))
                              ]),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: getSize(context, true, 10 / 415),
                                        height:
                                        getSize(context, true, 30 / 415),
                                        decoration: BoxDecoration(
                                            color: BeysionColors.purple,
                                            borderRadius:
                                            BorderRadius.horizontal(
                                                right: Radius.circular(5))),
                                      ),
                                      Padding(
                                        padding:
                                        const EdgeInsets.only(left: 8.0),
                                        child: Text(
                                          "Heute.",
                                          style: GoogleFonts.overpass(
                                              color: Colors.black,
                                              fontSize: 18,
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Divider(),
                              FakeData.FakePieChartLetztenHeutelist.length == 0
                                  ? SizedBox( height: 40,)
                                  : Column(
                                children: [
                                  SfCircularChart(
                                      legend: Legend(
                                        isVisible: true,
                                        alignment: ChartAlignment.center,
                                        position: LegendPosition.top,
                                      ),
                                      margin: EdgeInsets.zero,
                                      palette: [
                                        Color.fromARGB(255, 101, 202, 143),
                                        BeysionColors.orange,
                                      ],
                                      series: <DoughnutSeries<FakePieChartData, String>>[
                                        DoughnutSeries<FakePieChartData, String>(
                                            dataSource: FakeData.FakePieChartLetztenHeutelist,
                                            xValueMapper: (FakePieChartData data, _) => data.label,
                                            yValueMapper: (FakePieChartData data, _) => data.value,
                                            enableTooltip: true,
                                            dataLabelSettings: DataLabelSettings(
                                                showZeroValue: true
                                            )
                                        ),
                                      ]
                                  ),
                                  ListView.separated(
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    separatorBuilder: (context, index) => Divider(),
                                    itemCount: FakeData.FakePieChartLetztenHeutelist.length,
                                    itemBuilder: (context, index) {
                                      var item = FakeData.FakePieChartLetztenHeutelist[index];
                                      if(item.value == 0){
                                        return SizedBox();
                                      }
                                      return Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              CircleAvatar(
                                                radius: 10,
                                                backgroundColor: index == 0 ? Color.fromARGB(255, 101, 202, 143) : BeysionColors.orange,
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(left: 5.0),
                                                child: Text(item.label, style: GoogleFonts.overpass(
                                                    color: Colors.black,
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.w600
                                                ),),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              FaIcon(FontAwesomeIcons.handPointDown, color: index == 0 ? Color.fromARGB(255, 101, 202, 143) : BeysionColors.orange,),
                                              Padding(
                                                padding: const EdgeInsets.only(left: 5.0),
                                                child: Text("Bestellungen", style: GoogleFonts.overpass(
                                                    color: Colors.black,
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.w600
                                                ),),
                                              ),
                                            ],
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(top: 8.0),
                                            child: CircleAvatar(
                                              backgroundColor: index == 0 ? Color.fromARGB(255, 101, 202, 143) : BeysionColors.orange,
                                              child: Text("${item.value.toInt()}", style: GoogleFonts.overpass(
                                                  color: Colors.white,
                                                  fontSize: 24,
                                                  fontWeight: FontWeight.w600
                                              ),),
                                              radius: 30,
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(top: 8),
                                            child: Text("Gesamtumsatz", style: GoogleFonts.overpass(
                                                color: Colors.black,
                                                fontSize: 20,
                                                fontWeight: FontWeight.w700
                                            ),),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(top: 8),
                                            child: Text("245,60 €", style: GoogleFonts.overpass(
                                                color: Colors.black,
                                                fontSize: 20,
                                                fontWeight: FontWeight.w700
                                            ),),
                                          ),
                                        ],
                                      );
                                    },
                                  )
                                ],
                              ),
                            ],
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 32.0),
                      child: Container(
                          padding: EdgeInsets.only(
                            top: 16,
                            bottom: 16,
                          ),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.grey.shade300),
                              borderRadius: BorderRadius.circular(5),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey.shade200,
                                    blurRadius: 5,
                                    spreadRadius: 2,
                                    offset: Offset(0, 3))
                              ]),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: getSize(context, true, 10 / 415),
                                        height:
                                        getSize(context, true, 30 / 415),
                                        decoration: BoxDecoration(
                                            color: BeysionColors.purple,
                                            borderRadius:
                                            BorderRadius.horizontal(
                                                right: Radius.circular(5))),
                                      ),
                                      Padding(
                                        padding:
                                        const EdgeInsets.only(left: 8.0),
                                        child: Text(
                                          "Letzten 1 Woche.",
                                          style: GoogleFonts.overpass(
                                              color: Colors.black,
                                              fontSize: 18,
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Divider(),
                              FakeData.FakePieChartLetzten7list.length == 0
                                  ? SizedBox( height: 40,)
                                  : Column(
                                      children: [
                                        SfCircularChart(
                                            legend: Legend(
                                              isVisible: true,
                                              alignment: ChartAlignment.center,
                                              position: LegendPosition.top,
                                            ),
                                            margin: EdgeInsets.zero,
                                            palette: [
                                              Color.fromARGB(255, 205, 106, 102),
                                              BeysionColors.orange,
                                            ],
                                            series: <DoughnutSeries<FakePieChartData, String>>[
                                              DoughnutSeries<FakePieChartData, String>(
                                                  dataSource: FakeData.FakePieChartLetzten7list,
                                                  xValueMapper: (FakePieChartData data, _) => data.label,
                                                  yValueMapper: (FakePieChartData data, _) => data.value,
                                                  enableTooltip: true,
                                                  dataLabelSettings: DataLabelSettings(
                                                      showZeroValue: true
                                                  )
                                              ),
                                            ]
                                        ),
                                        ListView.separated(
                                          shrinkWrap: true,
                                          physics: NeverScrollableScrollPhysics(),
                                          separatorBuilder: (context, index) => Divider(),
                                          itemCount: FakeData.FakePieChartLetzten7list.length,
                                          itemBuilder: (context, index) {
                                            var item = FakeData.FakePieChartLetzten7list[index];
                                            if(item.value == 0){
                                              return SizedBox();
                                            }
                                            return Column(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    CircleAvatar(
                                                      radius: 10,
                                                      backgroundColor: index == 0 ? Color.fromARGB(255, 205, 106, 102) : BeysionColors.orange,
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets.only(left: 5.0),
                                                      child: Text(item.label, style: GoogleFonts.overpass(
                                                          color: Colors.black,
                                                          fontSize: 20,
                                                          fontWeight: FontWeight.w600
                                                      ),),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    FaIcon(FontAwesomeIcons.handPointDown, color: index == 0 ? Color.fromARGB(255, 205, 106, 102) : BeysionColors.orange,),
                                                    Padding(
                                                      padding: const EdgeInsets.only(left: 5.0),
                                                      child: Text("Bestellungen", style: GoogleFonts.overpass(
                                                          color: Colors.black,
                                                          fontSize: 20,
                                                          fontWeight: FontWeight.w600
                                                      ),),
                                                    ),
                                                  ],
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.only(top: 8.0),
                                                  child: CircleAvatar(
                                                    backgroundColor: index == 0 ? Color.fromARGB(255, 205, 106, 102) : BeysionColors.orange,
                                                    child: Text("${item.value.toInt()}", style: GoogleFonts.overpass(
                                                        color: Colors.white,
                                                        fontSize: 24,
                                                        fontWeight: FontWeight.w600
                                                    ),),
                                                    radius: 30,
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(top: 8),
                                                  child: Text("Gesamtumsatz", style: GoogleFonts.overpass(
                                                      color: Colors.black,
                                                      fontSize: 20,
                                                      fontWeight: FontWeight.w700
                                                  ),),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(top: 8),
                                                  child: Text("245,60 €", style: GoogleFonts.overpass(
                                                      color: Colors.black,
                                                      fontSize: 20,
                                                      fontWeight: FontWeight.w700
                                                  ),),
                                                ),
                                              ],
                                            );
                                          },
                                        )
                                      ],
                              ),
                            ],
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 32.0),
                      child: Container(
                          padding: EdgeInsets.only(
                            top: 16,
                            bottom: 16,
                          ),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.grey.shade300),
                              borderRadius: BorderRadius.circular(5),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey.shade200,
                                    blurRadius: 5,
                                    spreadRadius: 2,
                                    offset: Offset(0, 3))
                              ]),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: getSize(context, true, 10 / 415),
                                        height:
                                        getSize(context, true, 30 / 415),
                                        decoration: BoxDecoration(
                                            color: BeysionColors.purple,
                                            borderRadius:
                                            BorderRadius.horizontal(
                                                right: Radius.circular(5))),
                                      ),
                                      Padding(
                                        padding:
                                        const EdgeInsets.only(left: 8.0),
                                        child: Text(
                                          "Letzten 30 Tage.",
                                          style: GoogleFonts.overpass(
                                              color: Colors.black,
                                              fontSize: 18,
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Divider(),
                              SfCircularChart(
                                  legend: Legend(
                                    isVisible: true,
                                    alignment: ChartAlignment.center,
                                    position: LegendPosition.top,
                                  ),
                                  margin: EdgeInsets.zero,
                                  palette: [
                                    BeysionColors.orange,
                                    BeysionColors.purple,
                                  ],
                                  series: <DoughnutSeries<FakePieChartData, String>>[
                                    DoughnutSeries<FakePieChartData, String>(
                                      dataSource: FakeData.FakePieChartLetzten30list,
                                      xValueMapper: (FakePieChartData data, _) => data.label,
                                      yValueMapper: (FakePieChartData data, _) => data.value,
                                      enableTooltip: true,
                                    ),
                                  ]
                              ),
                              ListView.separated(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                separatorBuilder: (context, index) => Divider(),
                                itemCount: FakeData.FakePieChartLetzten30list.length,
                                itemBuilder: (context, index) {
                                  var item = FakeData.FakePieChartLetzten30list[index];
                                  if(item.value == 0){
                                    return SizedBox();
                                  }
                                  return Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          CircleAvatar(
                                            radius: 10,
                                            backgroundColor: index == 0 ? BeysionColors.orange : BeysionColors.purple,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(left: 5.0),
                                            child: Text(item.label, style: GoogleFonts.overpass(
                                              color: Colors.black,
                                              fontSize: 20,
                                              fontWeight: FontWeight.w600
                                            ),),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          FaIcon(FontAwesomeIcons.handPointDown, color: index == 0 ? BeysionColors.orange : BeysionColors.purple,),
                                          Padding(
                                            padding: const EdgeInsets.only(left: 5.0),
                                            child: Text("Bestellungen", style: GoogleFonts.overpass(
                                                color: Colors.black,
                                                fontSize: 20,
                                                fontWeight: FontWeight.w600
                                            ),),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 8.0),
                                        child: CircleAvatar(
                                          backgroundColor: index == 0 ? BeysionColors.orange : BeysionColors.purple,
                                          child: Text("${item.value.toInt()}", style: GoogleFonts.overpass(
                                            color: Colors.white,
                                            fontSize: 24,
                                            fontWeight: FontWeight.w600
                                          ),),
                                          radius: 30,
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(top: 8),
                                        child: Text("Gesamtumsatz", style: GoogleFonts.overpass(
                                          color: Colors.black,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w700
                                        ),),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(top: 8),
                                        child: Text("245,60 €", style: GoogleFonts.overpass(
                                            color: Colors.black,
                                            fontSize: 20,
                                            fontWeight: FontWeight.w700
                                        ),),
                                      ),
                                    ],
                                  );
                                },
                              )
                            ],
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 32.0),
                      child: Container(
                          padding: EdgeInsets.only(
                            top: 16,
                            bottom: 16,
                          ),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.grey.shade300),
                              borderRadius: BorderRadius.circular(5),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey.shade200,
                                    blurRadius: 5,
                                    spreadRadius: 2,
                                    offset: Offset(0, 3))
                              ]),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: getSize(context, true, 10 / 415),
                                        height:
                                        getSize(context, true, 30 / 415),
                                        decoration: BoxDecoration(
                                            color: BeysionColors.purple,
                                            borderRadius:
                                            BorderRadius.horizontal(
                                                right: Radius.circular(5))),
                                      ),
                                      Padding(
                                        padding:
                                        const EdgeInsets.only(left: 8.0),
                                        child: Text(
                                          "Letzten 1 Jahr.",
                                          style: GoogleFonts.overpass(
                                              color: Colors.black,
                                              fontSize: 18,
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Divider(),
                              SfCircularChart(
                                  legend: Legend(
                                    isVisible: true,
                                    alignment: ChartAlignment.center,
                                    position: LegendPosition.top,
                                  ),
                                  margin: EdgeInsets.zero,
                                  palette: [
                                    Color.fromARGB(255, 101, 202, 143),
                                    Color.fromARGB(255, 237, 103, 89),
                                  ],
                                  series: <DoughnutSeries<FakePieChartData, String>>[
                                    DoughnutSeries<FakePieChartData, String>(
                                      dataSource: FakeData.FakePieChartLetzten30list,
                                      xValueMapper: (FakePieChartData data, _) => data.label,
                                      yValueMapper: (FakePieChartData data, _) => data.value,
                                    ),
                                  ]
                              ),
                              ListView.separated(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                separatorBuilder: (context, index) => Divider(),
                                itemCount: FakeData.FakePieChartLetzten30list.length,
                                itemBuilder: (context, index) {
                                  var item = FakeData.FakePieChartLetzten30list[index];
                                  if(item.value == 0){
                                    SizedBox();
                                  }
                                  return Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          CircleAvatar(
                                            radius: 10,
                                            backgroundColor: index == 0 ? Color.fromARGB(255, 101, 202, 143) : Color.fromARGB(255, 237, 103, 89),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(left: 5.0),
                                            child: Text(item.label, style: GoogleFonts.overpass(
                                                color: Colors.black,
                                                fontSize: 20,
                                                fontWeight: FontWeight.w600
                                            ),),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          FaIcon(FontAwesomeIcons.handPointDown, color: index == 0 ? Color.fromARGB(255, 101, 202, 143) : Color.fromARGB(255, 237, 103, 89),),
                                          Padding(
                                            padding: const EdgeInsets.only(left: 5.0),
                                            child: Text("Bestellungen", style: GoogleFonts.overpass(
                                                color: Colors.black,
                                                fontSize: 20,
                                                fontWeight: FontWeight.w600
                                            ),),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 8.0),
                                        child: CircleAvatar(
                                          backgroundColor: index == 0 ? Color.fromARGB(255, 101, 202, 143) : Color.fromARGB(255, 237, 103, 89),
                                          child: Text("${item.value.toInt()}", style: GoogleFonts.overpass(
                                              color: Colors.white,
                                              fontSize: 24,
                                              fontWeight: FontWeight.w600
                                          ),),
                                          radius: 30,
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(top: 8),
                                        child: Text("Gesamtumsatz", style: GoogleFonts.overpass(
                                            color: Colors.black,
                                            fontSize: 20,
                                            fontWeight: FontWeight.w700
                                        ),),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(top: 8),
                                        child: Text("245,60 €", style: GoogleFonts.overpass(
                                            color: Colors.black,
                                            fontSize: 20,
                                            fontWeight: FontWeight.w700
                                        ),),
                                      ),
                                    ],
                                  );
                                },
                              )
                            ],
                          )),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

}
