import 'package:beysion/Utility/Colors.dart';
import 'package:beysion/Utility/Icons.dart';

import 'package:beysion/Utility/util.dart';
import 'package:beysion/utility/Widgets.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class SellerSettingsTabletPage extends StatefulWidget {
  @override
  _SellerSettingsTabletPageState createState() =>
      _SellerSettingsTabletPageState();
}

class _SellerSettingsTabletPageState extends State<SellerSettingsTabletPage> {
  int selectedAppBarMarketItem = 0;
  int valueErsteSeite = 0;
  int valueLieferart = 0;
  int valueMinimumPacketAmountHaus = 0;
  int valueMinimumPacketAmountKomm = 0;
  int valueWorkHourS = 0;
  int valueWorkHourE = 0;
  int valuePreparing = 0;
  int valueFirstPage = 0;
  int valueLoremIpsum = 0;
  bool checkCorporateInvoice = false;
  bool checkBeysionNewsletter = false;
  bool checkPrivacyPolicy = false;
  bool montagSwitch = true;
  bool dienstagSwitch = true;
  bool mittwochSwitch = true;
  bool donnerstagSwitch = true;
  bool freitagSwitch = true;
  bool samstagSwitch = true;
  bool sontagSwitch = false;
  TextEditingController _addressTextFormFieldController;
  TextEditingController _montagStartTextFormFieldController;
  TextEditingController _montagEndTextFormFieldController;
  TextEditingController _dienstagStartTextFormFieldController;
  TextEditingController _dienstagEndTextFormFieldController;
  TextEditingController _mittwochStartTextFormFieldController;
  TextEditingController _mittwochEndTextFormFieldController;
  TextEditingController _donnerstagStartTextFormFieldController;
  TextEditingController _donnerstagEndTextFormFieldController;
  TextEditingController _freitagStartTextFormFieldController;
  TextEditingController _freitagEndTextFormFieldController;
  TextEditingController _samstagStartTextFormFieldController;
  TextEditingController _samstagEndTextFormFieldController;
  TextEditingController _sonntagStartTextFormFieldController;
  TextEditingController _sonntagEndTextFormFieldController;

  @override
  void initState() {
    super.initState();
    _montagStartTextFormFieldController = MaskedTextController(mask: '00:00');
    _montagEndTextFormFieldController = MaskedTextController(mask: '00:00');
    _dienstagStartTextFormFieldController = MaskedTextController(mask: '00:00');
    _dienstagEndTextFormFieldController = MaskedTextController(mask: '00:00');
    _mittwochStartTextFormFieldController = MaskedTextController(mask: '00:00');
    _mittwochEndTextFormFieldController = MaskedTextController(mask: '00:00');
    _donnerstagStartTextFormFieldController =
        MaskedTextController(mask: '00:00');
    _donnerstagEndTextFormFieldController = MaskedTextController(mask: '00:00');
    _freitagStartTextFormFieldController = MaskedTextController(mask: '00:00');
    _freitagEndTextFormFieldController = MaskedTextController(mask: '00:00');
    _samstagStartTextFormFieldController = MaskedTextController(mask: '00:00');
    _samstagEndTextFormFieldController = MaskedTextController(mask: '00:00');
    _sonntagStartTextFormFieldController = MaskedTextController(mask: '00:00');
    _sonntagEndTextFormFieldController = MaskedTextController(mask: '00:00');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBarSellerTablet(context),
      body: buildBody(context),
    );
  }

  List buildAction(BuildContext context) {
    return <Widget>[
      Container(
        width: getSize(context, true, 120 / 415),
        height: getSize(context, true, 5 / 415),
        margin: EdgeInsets.only(right: getSize(context, true, 15 / 415)),
        child: Center(
          child: DropdownButton(
              icon: Padding(
                padding: EdgeInsets.only(left: getSize(context, true, 4 / 415)),
                child: Image.asset(IconsPath.dropArrow),
              ),
              iconEnabledColor: BeysionColors.yellow,
              style: GoogleFonts.overpass(fontSize: 14, color: Colors.white),
              underline: SizedBox(),
              items: [
                DropdownMenuItem(value: 0, child: Text("Niemerszein")),
                DropdownMenuItem(value: 1, child: Text("Carrefour")),
              ],
              dropdownColor: BeysionColors.purple,
              onChanged: (value) {
                setState(() {
                  selectedAppBarMarketItem = value;
                });
              },
              value: selectedAppBarMarketItem),
        ),
      ),
    ];
  }

  buildBody(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: getSize(context, true, 20 / 415),
              vertical: getSize(context, true, 10 / 415),
            ),
            child: Text("Allgemeine Einstellungen", style: GoogleFonts.overpass(fontSize: 15, fontWeight: FontWeight.w600),),
          ),
          buildContainer(
              context,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Auf dieser Seite können Sie alle Verkaufseinstellungen für Ihre Unternehmen vornehmen.",
                    style: GoogleFonts.overpass(
                        fontSize: 15, fontWeight: FontWeight.w600),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: getSize(context, true, 5 / 415)),
                    child: Divider(),
                  ),
                  Row(
                    children: [
                      Container(
                        width: getSize(context, true, 110/415),
                        child: Text(
                          "Marktlogo (180x80 px)",
                          style: GoogleFonts.overpass(fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                      ),
                      SizedBox(width: getSize(context, true, 10 / 415),),
                      OutlineButton(
                        child: Center(
                          child: Text("Datei Aussuchen"),
                        ),
                        onPressed: () {

                        },
                      )
                    ],
                  ),
                  SizedBox(height: getSize(context, true, 20 / 415),),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: getSize(context, true, 110/415),
                        child: Text(
                          "Marktbilder (max. 3 Bilder)",
                          style: GoogleFonts.overpass(fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                      ),
                      SizedBox(width: getSize(context, true, 10 / 415),),
                      Expanded(
                        child: Container(
                          height: getSize(context, true, 140 / 415),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            border: Border.all(color: BeysionColors.border, width: 1),
                            color: Colors.white,
                            // image: DecorationImage(
                            //     fit: BoxFit.fitWidth,
                            //     image: AssetImage(LogosPath.niemerszein))
                          ),
                          child: Stack(
                            children: [
                              Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    FaIcon(
                                      FontAwesomeIcons.cloudUploadAlt,
                                      color: BeysionColors.overlay,
                                      size: getSize(context, true, 30 / 415),
                                    ),
                                    Text(
                                      "Ziehen Sie Bilder hierher.",
                                      style: GoogleFonts.overpass(
                                          color: BeysionColors.overlay, fontSize: 20),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                        top: getSize(context, true, 10 / 415),
                                        bottom: getSize(context, true, 10 / 415),
                                      ),
                                      child: Text(
                                        "or",
                                        style: GoogleFonts.overpass(
                                            color: BeysionColors.overlay,
                                            fontSize: 18),
                                      ),
                                    ),
                                    Container(
                                      width: getSize(context, true, 120/415),
                                      child: OutlineButton(
                                        color: BeysionColors.overlay,
                                        child: Center(
                                          child: Text("Bilder durchsuchen", style: GoogleFonts.overpass(color: BeysionColors.purple),),
                                        ),
                                        onPressed: () {},
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              // Align( -- isHave logo? delete buton
                              //   alignment: Alignment.topRight,
                              //   child: Padding(
                              //     padding: EdgeInsets.symmetric(
                              //       horizontal: getSize(context, true, 5 / 415),
                              //       vertical: getSize(context, true, 5 / 415),
                              //     ),
                              //     child: IconButton(
                              //       icon: FaIcon(FontAwesomeIcons.trash, color: Colors.red, size: getSize(context, true, 10/415),),
                              //       onPressed: () {},
                              //     )
                              //   ),
                              // ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: getSize(context, true, 20 / 415),),
                  Row(
                    children: [
                      Container(
                        width: getSize(context, true, 110/415),
                        child: Text("Erste Seite*",
                          style: GoogleFonts.overpass(fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                      ),
                      SizedBox(width: getSize(context, true, 10 / 415),),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: BeysionColors.border),
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                          ),
                          child: Center(
                            child: DropdownButton(
                              underline: SizedBox(),
                              icon: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: FaIcon(FontAwesomeIcons.chevronDown),
                              ),
                              value: valueErsteSeite,
                              items: [
                                DropdownMenuItem(
                                    value: 0, child: Text("Normale Auflistung")),
                                DropdownMenuItem(value: 1, child: Text("test_data")),
                              ],
                              onChanged: (value) {
                                setState(() {
                                  valueErsteSeite = value;
                                });
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: getSize(context, true, 20 / 415),),
                  Row(
                    children: [
                      Container(
                        width: getSize(context, true, 110/415),
                        child: Text(
                          "Lieferart*",
                          style: GoogleFonts.overpass(fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                      ),
                      SizedBox(width: getSize(context, true, 10 / 415),),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: BeysionColors.border),
                            borderRadius: BorderRadius.all(Radius.circular(5))),
                          child: Center(
                            child: DropdownButton(
                              underline: SizedBox(),
                              icon: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: FaIcon(FontAwesomeIcons.chevronDown),
                              ),
                              value: valueLieferart,
                              items: [
                                DropdownMenuItem(
                                    value: 0, child: Text("Lieferung an Adresse")),
                                DropdownMenuItem(value: 1, child: Text("test_data")),
                              ],
                              onChanged: (value) {
                                setState(() {
                                  valueLieferart = value;
                                });
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: getSize(context, true, 20 / 415),),
                  Row(
                    children: [
                      Container(
                          width: getSize(context, true, 110/415),
                          child: Text("Mindestpaketmenge (Hauslieferung)*",maxLines: 2, style: GoogleFonts.overpass(fontSize: 16, fontWeight: FontWeight.w600),)),
                      SizedBox(width: getSize(context, true, 10 / 415),),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: BeysionColors.border),
                            borderRadius: BorderRadius.all(Radius.circular(5))),
                          child: Center(
                            child: DropdownButton(
                              underline: SizedBox(),
                              icon: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: FaIcon(FontAwesomeIcons.chevronDown),
                              ),
                              value: valueMinimumPacketAmountHaus,
                              items: [
                                DropdownMenuItem(value: 0, child: Text("20 €")),
                                DropdownMenuItem(value: 1, child: Text("test_data")),
                              ],
                              onChanged: (value) {
                                setState(() {
                                  valueMinimumPacketAmountHaus = value;
                                });
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: getSize(context, true, 20 / 415),),
                  Row(
                    children: [
                      Container(
                        width: getSize(context, true, 110/415),
                        child: Text(
                          "Mindestpaketmenge (Komm und hol es dir)*",
                          maxLines: 2,
                          style: GoogleFonts.overpass(fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                      ),
                      SizedBox(width: getSize(context, true, 10 / 415),),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: BeysionColors.border),
                              borderRadius: BorderRadius.all(Radius.circular(5))),
                          child: Center(
                            child: DropdownButton(
                              underline: SizedBox(),
                              icon: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: FaIcon(FontAwesomeIcons.chevronDown),
                              ),
                              value: valueMinimumPacketAmountKomm,
                              items: [
                                DropdownMenuItem(value: 0, child: Text("20 €")),
                                DropdownMenuItem(value: 1, child: Text("test_data")),
                              ],
                              onChanged: (value) {
                                setState(() {
                                  valueMinimumPacketAmountKomm = value;
                                });
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: getSize(context, true, 20 / 415),),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: getSize(context, true, 110/415),
                        child: Text(
                          "Durchschnittliche Vorbereitungszeit \n(Komm und hol es dir)*",
                          style: GoogleFonts.overpass(fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                      ),
                      SizedBox(width: getSize(context, true, 10 / 415),),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: BeysionColors.border),
                              borderRadius: BorderRadius.all(Radius.circular(5))),
                          child: Center(
                            child: DropdownButton(
                              underline: SizedBox(),
                              icon: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: FaIcon(FontAwesomeIcons.chevronDown),
                              ),
                              value: valuePreparing,
                              items: [
                                DropdownMenuItem(value: 0, child: Text("60 Min.")),
                                DropdownMenuItem(value: 1, child: Text("test_data")),
                              ],
                              onChanged: (value) {
                                setState(() {
                                  valuePreparing = value;
                                });
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: getSize(context, true, 10 / 415),),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          width: getSize(context, true, 110/415),
                          child: Text("Über uns", style: GoogleFonts.overpass(fontSize: 16, fontWeight: FontWeight.w600),)),
                      SizedBox(width: getSize(context, true, 10 / 415),),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: BeysionColors.border),
                              borderRadius: BorderRadius.all(Radius.circular(5))),
                          child: TextFormField(
                            maxLines: 4,
                            textAlignVertical: TextAlignVertical.center,
                            controller: _addressTextFormFieldController,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: getSize(context, true, 10 / 415),
                                vertical: getSize(context, true, 10 / 415),
                              ),
                              border: InputBorder.none,
                              suffixIcon: SizedBox(),
                              suffix: SizedBox(),
                              isCollapsed: true,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: getSize(context, true, 20 / 415),),
                  DottedBorder(
                    radius: Radius.circular(50),
                    padding: EdgeInsets.zero,
                    strokeWidth: 2,
                    color: BeysionColors.border,
                    child: Container(
                        width: getSize(context, true, 1),
                        decoration: BoxDecoration(
                          color: BeysionColors.textFieldBackground,
                        ),
                        padding: EdgeInsets.only(
                          left: getSize(context, true, 20 / 415),
                          right: getSize(context, true, 20 / 415),
                          bottom: getSize(context, true, 45 / 415),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: getSize(context, true, 15 / 415)),
                              child: Text(
                                "Öffnungszeiten des Marktes",
                                style: GoogleFonts.overpass(
                                    color: BeysionColors.purple,
                                    fontSize: 22,
                                    fontWeight: FontWeight.w800),
                              ),
                            ),
                            DottedLine(
                              dashColor: BeysionColors.purple,
                              direction: Axis.horizontal,
                              lineThickness: 2,
                              lineLength: getSize(context, true, 325 / 415),
                              dashGapLength: getSize(context, true, 5 / 415),
                            ),
                            SizedBox(
                              height: getSize(context, true, 10 / 415),
                            ),
                            buildTimes(
                                context,
                                "Montag",
                                _montagStartTextFormFieldController,
                                _montagEndTextFormFieldController,
                                montagSwitch),
                            buildTimes(
                                context,
                                "Dienstag",
                                _dienstagStartTextFormFieldController,
                                _dienstagEndTextFormFieldController,
                                dienstagSwitch),
                            buildTimes(
                                context,
                                "Mittwoch",
                                _mittwochStartTextFormFieldController,
                                _mittwochEndTextFormFieldController,
                                mittwochSwitch),
                            buildTimes(
                                context,
                                "Donnerstag",
                                _donnerstagStartTextFormFieldController,
                                _donnerstagEndTextFormFieldController,
                                donnerstagSwitch),
                            buildTimes(
                                context,
                                "Freitag",
                                _freitagStartTextFormFieldController,
                                _freitagEndTextFormFieldController,
                                freitagSwitch),
                            buildTimes(
                                context,
                                "Samstag",
                                _samstagStartTextFormFieldController,
                                _samstagEndTextFormFieldController,
                                samstagSwitch),
                            buildTimes(
                                context,
                                "Sontag",
                                _sonntagStartTextFormFieldController,
                                _sonntagEndTextFormFieldController,
                                sontagSwitch),
                            buildValidate(context)
                          ],
                        )),
                  ),
                ],
              )),
        ],
      ),
    );
  }

  buildTimes(
      BuildContext context,
      String day,
      TextEditingController controllerStart,
      TextEditingController controllerEnd,
      bool switchValue) {
    return StatefulBuilder(
      builder: (context, setState) {
        return Container(
          margin: EdgeInsets.only(bottom: getSize(context, true, 10 / 415)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(flex: 1, child: Text(day, style: GoogleFonts.overpass(fontSize: 16, fontWeight: FontWeight.w600),)),
                  Expanded(
                    flex: 1,
                    child: CupertinoSwitch(
                      activeColor: BeysionColors.purple,
                      value: switchValue,
                      onChanged: (val) {
                        setState(() {
                          switchValue = val;
                        });
                      },
                    ),
                  ),
                  SizedBox(width: getSize(context, true, 5 / 415),),
                  Expanded(
                    flex: 3,
                    child: switchValue == true
                        ? Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          width: getSize(context, true, 50/415),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: BeysionColors.border, width: 2),
                              borderRadius: BorderRadius.all(Radius.circular(5))),
                          child: Center(
                            child: TextFormField(
                              textAlign: TextAlign.center,
                              controller: controllerStart,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "21:00",
                                hintStyle: GoogleFonts.overpass(
                                    color: BeysionColors.gray2),
                                //suffixIconConstraints: BoxConstraints.tightForFinite(height: 0, width: 0),
                              ),
                            ),
                          ),
                        ),
                        Container(
                            width: 50,
                            child: Center(child: Text("-"))),
                        Container(
                          width: getSize(context, true, 50/415),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: BeysionColors.border, width: 2),
                              borderRadius: BorderRadius.all(Radius.circular(5))),
                          child: Center(
                            child: TextFormField(
                              textAlign: TextAlign.center,
                              controller: controllerEnd,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "21:00",
                                hintStyle: GoogleFonts.overpass(
                                    color: BeysionColors.gray2),
                                //suffixIconConstraints: BoxConstraints.tightForFinite(height: 0, width: 0),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                        : SizedBox(),
                  )
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  buildValidate(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: getSize(context, true, 10 / 415)),
      child: FlatButton(
        color: BeysionColors.yellow,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        child: Center(
            child: Text(
          "SENDEN",
          style: GoogleFonts.overpass(
              fontSize: 16, fontWeight: FontWeight.bold),
        )),
        onPressed: () {},
      ),
    );
  }
}
