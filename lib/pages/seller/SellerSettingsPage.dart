import 'package:beysion/Utility/Colors.dart';
import 'package:beysion/Utility/Icons.dart';
import 'package:beysion/Utility/Logos.dart';
import 'package:beysion/Utility/Widgets.dart';
import 'package:beysion/Utility/util.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:google_fonts/google_fonts.dart';

class SellerSettingsPage extends StatefulWidget {
  @override
  _SellerSettingsPageState createState() => _SellerSettingsPageState();
}

class _SellerSettingsPageState extends State<SellerSettingsPage> {
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
      appBar: buildAppBarSeller(context),
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
              vertical: getSize(context, true, 20 / 415),
            ),
            child: Text("Allgemeine Einstellungen", style: GoogleFonts.overpass(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w600),),
          ),
          buildContainer(
              context,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus venenatis bibendum interdum.",
                    style: GoogleFonts.overpass(fontSize: 14, fontWeight: FontWeight.w300),
                  ),
                  Divider(),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: getSize(context, true, 10 / 415)),
                    child: Text(
                      "MarktLogo (180x80)",
                      textAlign: TextAlign.start,
                      style: GoogleFonts.overpass(fontWeight: FontWeight.w400),
                    ),
                  ),
                  Container(
                    width: getSize(context, true, 1),
                    height: getSize(context, true, 140 / 415),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        border:
                            Border.all(color: BeysionColors.border, width: 1),
                        color: Colors.white,
                        image: DecorationImage(
                            fit: BoxFit.fitWidth,
                            image: AssetImage(LogosPath.niemerszein))),
                    child: Align(
                      alignment: Alignment.topRight,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: getSize(context, true, 10 / 415),
                          vertical: getSize(context, true, 10 / 415),
                        ),
                        child: InkWell(
                          child: Container(
                            width: getSize(context, true, 20 / 415),
                            height: getSize(context, true, 20 / 415),
                            padding: EdgeInsets.all(2),
                            decoration: BoxDecoration(
                              color: BeysionColors.gray1,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(2)),
                              // image: DecorationImage(
                              //   colorFilter: ColorFilter.mode(BeysionColors.red, BlendMode.srcIn),
                              //   image: AssetImage(IconsPath.delete)
                              // )
                            ),
                            child: Image.asset(
                              IconsPath.delete,
                              color: Colors.red,
                            ),
                          ),
                          onTap: () {
                            // TODO: delete
                          },
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: getSize(context, true, 10 / 415),
                  ),
                  Text(
                    "Erste Seite*",
                    textAlign: TextAlign.start,
                    style: GoogleFonts.overpass(fontWeight: FontWeight.w400),
                  ),
                  SizedBox(
                    height: getSize(context, true, 10 / 415),
                  ),
                  Container(
                    height: getSize(context, true, 45 / 415),
                    width: getSize(context, true, 240 / 415),
                    margin: EdgeInsets.only(
                      top: getSize(context, true, 5 / 415),
                      bottom: getSize(context, true, 20 / 415),
                    ),
                    decoration: BoxDecoration(
                        color: BeysionColors.textFieldBackground,
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                    child: Center(
                      child: DropdownButton(
                        underline: SizedBox(),
                        icon: Image.asset(
                          IconsPath.dropArrow,
                          color: Colors.black87,
                          width: getSize(context, true, 10 / 415),
                          fit: BoxFit.fitWidth,
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
                  Text(
                    "Lieferart*",
                    textAlign: TextAlign.start,
                    style: GoogleFonts.overpass(fontWeight: FontWeight.w400),
                  ),
                  SizedBox(
                    height: getSize(context, true, 10 / 415),
                  ),
                  Container(
                    height: getSize(context, true, 45 / 415),
                    width: getSize(context, true, 240 / 415),
                    margin: EdgeInsets.only(
                      top: getSize(context, true, 5 / 415),
                      bottom: getSize(context, true, 20 / 415),
                    ),
                    decoration: BoxDecoration(
                        color: BeysionColors.textFieldBackground,
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                    child: Center(
                      child: DropdownButton(
                        underline: SizedBox(),
                        icon: Image.asset(
                          IconsPath.dropArrow,
                          color: Colors.black87,
                          width: getSize(context, true, 10 / 415),
                          fit: BoxFit.fitWidth,
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
                  Text(
                    "Mindestpaketmenge (Hauslieferung)*",
                    textAlign: TextAlign.start,
                    style: GoogleFonts.overpass(fontWeight: FontWeight.w400),
                  ),
                  SizedBox(
                    height: getSize(context, true, 10 / 415),
                  ),
                  Container(
                    height: getSize(context, true, 45 / 415),
                    width: getSize(context, true, 120 / 415),
                    margin: EdgeInsets.only(
                      top: getSize(context, true, 5 / 415),
                      bottom: getSize(context, true, 20 / 415),
                    ),
                    decoration: BoxDecoration(
                        color: BeysionColors.textFieldBackground,
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                    child: Center(
                      child: DropdownButton(
                        underline: SizedBox(),
                        icon: Image.asset(
                          IconsPath.dropArrow,
                          color: Colors.black87,
                          width: getSize(context, true, 10 / 415),
                          fit: BoxFit.fitWidth,
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
                  Text(
                    "Mindestpaketmenge (Komm und hol es dir)*",
                    textAlign: TextAlign.start,
                    style: GoogleFonts.overpass(fontWeight: FontWeight.w400),
                  ),
                  SizedBox(
                    height: getSize(context, true, 10 / 415),
                  ),
                  Container(
                    height: getSize(context, true, 45 / 415),
                    width: getSize(context, true, 120 / 415),
                    margin: EdgeInsets.only(
                      top: getSize(context, true, 5 / 415),
                      bottom: getSize(context, true, 20 / 415),
                    ),
                    decoration: BoxDecoration(
                        color: BeysionColors.textFieldBackground,
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                    child: Center(
                      child: DropdownButton(
                        underline: SizedBox(),
                        icon: Image.asset(
                          IconsPath.dropArrow,
                          color: Colors.black87,
                          width: getSize(context, true, 10 / 415),
                          fit: BoxFit.fitWidth,
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
                  SizedBox(
                    height: getSize(context, true, 10 / 415),
                  ),
                  Text(
                    "Durchschnittliche Vorbereitungszeit \n(Komm und hol es dir)*",
                    textAlign: TextAlign.start,
                    style: GoogleFonts.overpass(fontWeight: FontWeight.w400),
                  ),
                  SizedBox(
                    height: getSize(context, true, 10 / 415),
                  ),
                  Container(
                    height: getSize(context, true, 45 / 415),
                    width: getSize(context, true, 120 / 415),
                    margin: EdgeInsets.only(
                      top: getSize(context, true, 5 / 415),
                      bottom: getSize(context, true, 20 / 415),
                    ),
                    decoration: BoxDecoration(
                        color: BeysionColors.textFieldBackground,
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                    child: Center(
                      child: DropdownButton(
                        underline: SizedBox(),
                        icon: Image.asset(
                          IconsPath.dropArrow,
                          color: Colors.black87,
                          width: getSize(context, true, 10 / 415),
                          fit: BoxFit.fitWidth,
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
                  SizedBox(
                    height: getSize(context, true, 10 / 415),
                  ),
                  Text(
                    "About Us",
                    textAlign: TextAlign.start,
                    style: GoogleFonts.overpass(fontWeight: FontWeight.w400),
                  ),
                  Container(
                    height: getSize(context, true, 90 / 415),
                    margin: EdgeInsets.only(
                      top: getSize(context, true, 5 / 415),
                      bottom: getSize(context, true, 20 / 415),
                    ),
                    padding: EdgeInsets.symmetric(
                        horizontal: getSize(context, true, 5 / 415)),
                    decoration: BoxDecoration(
                        color: BeysionColors.textFieldBackground,
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                    child: TextFormField(
                      maxLines: 4,
                      textAlignVertical: TextAlignVertical.center,
                      controller: _addressTextFormFieldController,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: getSize(context, true, 10 / 415)),
                        border: InputBorder.none,
                        suffixIcon: SizedBox(),
                        suffix: SizedBox(),
                        isCollapsed: true,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: getSize(context, true, 20 / 415),
                  ),
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
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                            DottedLine(
                              dashColor: BeysionColors.border,
                              direction: Axis.horizontal,
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
          margin: EdgeInsets.only(bottom: getSize(context, true, 5 / 415)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(day),
                  CupertinoSwitch(
                    activeColor: BeysionColors.purple,
                    value: switchValue,
                    onChanged: (val) {
                      setState(() {
                        switchValue = val;
                      });
                    },
                  )
                ],
              ),
              SizedBox(
                height: getSize(context, true, 5 / 415),
              ),
              switchValue == true
                  ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: getSize(context, true, 120 / 415),
                    height: getSize(context, true, 40 / 415),
                    decoration: BoxDecoration(
                        color: BeysionColors.border,
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                    child: TextFormField(
                      textAlignVertical: TextAlignVertical.center,
                      textAlign: TextAlign.start,
                      controller: controllerStart,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: getSize(context, true, 10 / 415),
                            vertical: 10),
                        border: InputBorder.none,
                        hintText: "09:00",
                        hintStyle: GoogleFonts.overpass(color: BeysionColors.gray2),
                        //suffixIconConstraints: BoxConstraints.tightForFinite(height: 0, width: 0),
                        isCollapsed: true,
                        isDense: false,
                      ),
                    ),
                  ),
                  Text("-"),
                  Container(
                    width: getSize(context, true, 120 / 415),
                    height: getSize(context, true, 40 / 415),
                    decoration: BoxDecoration(
                        color: BeysionColors.border,
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                    child: TextFormField(
                      textAlignVertical: TextAlignVertical.center,
                      textAlign: TextAlign.start,
                      controller: controllerEnd,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: getSize(context, true, 10 / 415),
                            vertical: 10),
                        border: InputBorder.none,
                        hintText: "21:00",
                        hintStyle: GoogleFonts.overpass(color: BeysionColors.gray2),
                        //suffixIconConstraints: BoxConstraints.tightForFinite(height: 0, width: 0),
                        isCollapsed: true,
                        isDense: false,
                      ),
                    ),
                  ),
                ],
              )
                  : SizedBox()
            ],
          ),
        );
      },
    );
  }

  buildValidate(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: getSize(context, true, 15 / 415),
        left: getSize(context, true, 15 / 415),
        right: getSize(context, true, 15 / 415),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
                vertical: getSize(context, true, 20 / 415)),
            child: RaisedButton(
              color: BeysionColors.yellow,
              child: Center(
                  child: Text(
                "Speichern",
                style: GoogleFonts.overpass(fontSize: 15, fontWeight: FontWeight.w500),
              )),
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}
