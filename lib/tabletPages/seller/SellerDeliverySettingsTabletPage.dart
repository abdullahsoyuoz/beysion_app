import 'package:beysion/Utility/Colors.dart';
import 'package:beysion/Utility/Icons.dart';
import 'package:beysion/Utility/util.dart';
import 'package:beysion/utility/Widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class SellerDeliverySettingsTabletPage extends StatefulWidget {
  @override
  _SellerDeliverySettingsTabletPageState createState() =>
      _SellerDeliverySettingsTabletPageState();
}

class _SellerDeliverySettingsTabletPageState
    extends State<SellerDeliverySettingsTabletPage> {
  int selectedAppBarMarketItem = 0;
  bool selectedLieferung = true;
  bool selectedServicezeiten = false;
  int bestellungenDropValue = 0;
  int lieferzeitDropValue = 0;

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
            child: Text("Liefereinstellungen",
              style: GoogleFonts.overpass(
                fontSize: 15,
                fontWeight: FontWeight.w600
              ),),
          ),
          buildContainer(
              context,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      top: getSize(context, true, 10 / 415),
                    ),
                    child: Text(
                      "Auf diesem Bilgschirm können Sie Ihre Liefereinstellungen vornehmen",
                      style: GoogleFonts.overpass(fontWeight: FontWeight.w400),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: getSize(context, true, 5/415)),
                    child: Divider(),
                  ),
                  Row(
                    children: [
                      Expanded(child: buildOption(context, selectedLieferung, 0),),
                      SizedBox(width: getSize(context, true, 10 / 415),),
                      Expanded(child: buildOption(context, selectedServicezeiten, 1),),
                    ],
                  ),
                  selectedLieferung == true
                      ? SizedBox()
                      : Container(
                    width: getSize(context, true, 1),
                    margin: EdgeInsets.only(bottom: getSize(context, true, 10/415)),
                    padding: EdgeInsets.symmetric(
                      vertical: getSize(context, true, 5/415),
                      horizontal: getSize(context, true, 10/415),
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      color: Colors.green.withOpacity(0.15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "An welchen Tagen und zwischen welchen Uhrzeiten liefern Sie Ihre eingegangenen Bestellungen aus? Ihre Kunden werden dann diese möglichen Liefertermine auswählen können.",
                        style: GoogleFonts.overpass(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: Colors.green.shade900),
                      ),
                    ),
                  ),
                  selectedLieferung == true
                      ? buildLieferung(context)
                      : BuildServicezeiten(),
                ],
              ))
        ],
      ),
    );
  }

  buildOption(BuildContext context, bool selectedDelivery, int value) {
    return InkWell(
      child: Container(
        height: getSize(context, true, 70 / 415),
        margin: EdgeInsets.only(bottom: getSize(context, true, 10 / 415)),
        padding:
            EdgeInsets.symmetric(horizontal: getSize(context, true, 5 / 415)),
        decoration: BoxDecoration(
            color: selectedDelivery == true
                ? BeysionColors.purple
                : BeysionColors.textFieldBackground,
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                value == 0
                    ? FaIcon(
                        FontAwesomeIcons.shippingFast,
                        size: getSize(context, true, 25 / 415),
                        color: selectedDelivery == true
                            ? Colors.white
                            : BeysionColors.gray2,
                      )
                    : Container(
                        child: Image.asset(
                          IconsPath.deliveryTime,
                          fit: BoxFit.fill,
                          color: selectedDelivery == true
                              ? Colors.white
                              : BeysionColors.gray2,
                          width: getSize(context, true, 35 / 415),
                          height: getSize(context, true, 35 / 415),
                        ),
                      ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    value == 0
                        ? "Sofortige Lieferung"
                        : "Während der Servicezeiten",
                    overflow: TextOverflow.fade,
                    softWrap: false,
                    maxLines: 1,
                    style: GoogleFonts.overpass(
                        color: selectedDelivery == true
                            ? Colors.white
                            : BeysionColors.gray2),
                  ),
                )
              ],
            ),
            selectedDelivery == true
                ? FaIcon(
                    FontAwesomeIcons.checkCircle,
                    color: Colors.white,
                  )
                : SizedBox()
          ],
        ),
      ),
      onTap: () {
        setState(() {
          if (value == 0) {
            selectedLieferung = true;
            selectedServicezeiten = false;
          }
          if (value == 1) {
            selectedLieferung = false;
            selectedServicezeiten = true;
          }
        });
      },
    );
  }

  buildLieferung(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          width: getSize(context, true, 1),
          height: getSize(context, true, 40 / 415),
          decoration: BoxDecoration(
            color: BeysionColors.textFieldBackground,
            borderRadius: BorderRadius.all(Radius.circular(5))),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FaIcon(FontAwesomeIcons.clock, color: BeysionColors.purple,),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Bestellzeit und -nummer",
                    style: GoogleFonts.overpass(
                      fontSize: 16,
                      fontWeight: FontWeight.w700),),),],),),),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: getSize(context, true, 20 / 415)),
                  child: Text("Verarbeitbare Bestellungen",
                    style: GoogleFonts.overpass(fontWeight: FontWeight.w500),),),
                DropdownButton(
                  value: bestellungenDropValue,
                  icon: Padding(
                    padding: EdgeInsets.only(left: getSize(context, true, 4 / 415)),
                    child: Image.asset(
                      IconsPath.dropArrow,
                      color: Colors.black,),),
                  iconEnabledColor: BeysionColors.yellow,
                  style: GoogleFonts.overpass(fontSize: 14, color: Colors.black),
                  items: [
                    DropdownMenuItem(value: 0, child: Text("Unbegrenzte Bestellungen")),
                    DropdownMenuItem(value: 1, child: Text("test_data")),
                  ],
                  onChanged: (value) {
                    setState(() {
                      bestellungenDropValue = value;
                    });
                  },
                ),
              ],
            ),
            Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: getSize(context, true, 20 / 415)),
                  child: Text(
                    "Durchschnittliche Lieferzeit",
                    style: GoogleFonts.overpass(fontWeight: FontWeight.w500),
                  ),
                ),
                DropdownButton(
                  value: lieferzeitDropValue,
                  icon: Padding(
                    padding: EdgeInsets.only(left: getSize(context, true, 4 / 415)),
                    child: Image.asset(
                      IconsPath.dropArrow,
                      color: Colors.black,
                    ),
                  ),
                  iconEnabledColor: BeysionColors.yellow,
                  style: GoogleFonts.overpass(fontSize: 14, color: Colors.black),
                  //underline: SizedBox(),
                  items: [
                    DropdownMenuItem(value: 0, child: Text("1.5 Stunde.")),
                    DropdownMenuItem(value: 1, child: Text("test_data")),
                  ],
                  onChanged: (value) {
                    setState(() {
                      lieferzeitDropValue = value;
                    });
                  },
                ),
              ],
            ),
          ],
        ),
        Container(
          width: getSize(context, true, 1),
          margin: EdgeInsets.only(
            bottom: getSize(context, true, 10/415),
            top: getSize(context, true, 10/415),
          ),
          padding: EdgeInsets.symmetric(
            vertical: getSize(context, true, 5/415),
            horizontal: getSize(context, true, 10/415),
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            color: Colors.red.withOpacity(0.15),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Wenn die Anzahl der eingehenden Bestellungen die Anzahl der Bestellungen überschreitet,",
              style: GoogleFonts.overpass(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Colors.red.shade900),
            ),
          ),
        ),
        FlatButton(
          color: BeysionColors.yellow,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          child: Center(
              child: Text(
            "SENDEN",
            style: GoogleFonts.overpass(fontSize: 14, fontWeight: FontWeight.bold),
          )),
          onPressed: () {},
        ),
      ],
    );
  }
}

class BuildServicezeiten extends StatefulWidget {
  @override
  BuildServicezeitenState createState() => BuildServicezeitenState();
}

class BuildServicezeitenState extends State<BuildServicezeiten> {
  final _formKey = GlobalKey<FormState>();
  bool isActiveMonday = true;
  bool isActiveTuesday = false;
  bool isActiveWednesday = true;
  bool isActiveThursday = false;
  bool isActiveFriday = false;
  bool isActiveSaturday = true;
  bool isActiveSunday = false;
  static List<String> mondayList = [null];
  static List<String> tuesdayList = [null];
  static List<String> wednesdayList = [null];
  static List<String> thursdayList = [null];
  static List<String> fridayList = [null];
  static List<String> saturdayList = [null];
  static List<String> sundayList = [null];
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          isActiveMonday == true ? buildServicezeitenItem(context,"Montags","8:00 - 21:00", mondayList) : SizedBox(),
          isActiveTuesday == true ? buildServicezeitenItem(context,"Dienstags","8:00 - 21:00", tuesdayList) : SizedBox(),
          isActiveWednesday == true ? buildServicezeitenItem(context,"Mittwochs","8:00 - 21:00", wednesdayList) : SizedBox(),
          isActiveThursday == true ? buildServicezeitenItem(context,"Donnerstags","8:00 - 21:00", thursdayList) : SizedBox(),
          isActiveFriday == true ? buildServicezeitenItem(context,"Freitags","8:00 - 21:00", fridayList) : SizedBox(),
          isActiveSaturday == true ? buildServicezeitenItem(context,"Samstags","8:00 - 21:00", saturdayList) : SizedBox(),
          isActiveSunday == true ? buildServicezeitenItem(context,"Sonntags","8:00 - 21:00", sundayList) : SizedBox(),
        ],
      ),
    );
  }

  buildServicezeitenItem(
      BuildContext context,String day, String timeInterval, List<String> dayList) {
    return Column(
      children: [
        Container(
          width: getSize(context, true, 1),
          height: getSize(context, true, 30 / 415),
          decoration: BoxDecoration(
            color: BeysionColors.textFieldBackground,
            borderRadius: BorderRadius.circular(5)
          ),
          margin: EdgeInsets.only(bottom: getSize(context, true, 5 / 415)),
          padding: EdgeInsets.symmetric(horizontal: getSize(context, true, 15 / 415)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  FaIcon(FontAwesomeIcons.calendarDay,
                    color: BeysionColors.purple,
                    size: getSize(context, true, 12 / 415),),
                  Padding(
                    padding: EdgeInsets.only(left: getSize(context, true, 3 / 415)),
                    child: Text(day,
                      style: GoogleFonts.overpass(
                        fontSize: 24,
                        fontWeight: FontWeight.w600),),)],),
              Text(timeInterval, style: GoogleFonts.overpass(fontSize: 24,fontWeight: FontWeight.w600),),
            ],
          ),
        ),
        ..._getFields(dayList),
      ],
    );
  }

  List<Widget> _getFields(List<String> dayList){
    List<Widget> tempList = [];
    for(int i=0; i<dayList.length;i++){
      tempList.add(
        StatefulBuilder(builder: (context, setState) {
          return BuildServicezeitenItemChild(this, dayList, setState, index: i, isAdd: i == dayList.length-1);
        },)
      );
    }
    return tempList;
  }
}

class BuildServicezeitenItemChild extends StatefulWidget {
  int index;
  final bool isAdd;
  List<String> dayList;
  BuildServicezeitenState parent;
  BuildServicezeitenItemChild(this.parent, this.dayList, setState, {Key key, this.index, this.isAdd}) : super(key: key);
  @override
  _BuildServicezeitenItemChildState createState() => _BuildServicezeitenItemChildState();
}

class _BuildServicezeitenItemChildState extends State<BuildServicezeitenItemChild> {
  int dropLie;
  TextEditingController _startController;
  TextEditingController _endController;
  @override
  void initState() {
    super.initState();
    _startController = MaskedTextController(mask: '00:00');
    _endController = MaskedTextController(mask: '00:00');
  }
  @override
  void dispose() {
    super.dispose();
    _startController.dispose();
    _endController.dispose();
  }
  @override
  void setState(fn) {
    // TODO: implement setState
    super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      //
    });
    return Padding(
      padding: EdgeInsets.only(
        top: getSize(context, true, 5 / 415),
        bottom: getSize(context, true, 10 / 415),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  height: getSize(context, true, 25 / 415),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          blurRadius: 1,
                          offset: Offset(0, 1))
                      ]),
                  child: Center(
                    child: TextFormField(
                      maxLines: 1,
                      textAlignVertical: TextAlignVertical.center,
                      style: GoogleFonts.overpass(),
                      controller: _startController,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: getSize(context, true, 10 / 415),),
                        border: InputBorder.none,
                        hintText: "Uhrzeit Beginn",
                        hintStyle: GoogleFonts.overpass(color: BeysionColors.purple.withOpacity(0.9)),
                        isCollapsed: true,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(padding: const EdgeInsets.all(8.0), child: Text("-"),),
              Expanded(
                flex: 2,
                child: Container(
                  height: getSize(context, true, 25 / 415),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            blurRadius: 1,
                            offset: Offset(0, 1))
                      ]),
                  child: Center(
                    child: TextFormField(
                      maxLines: 1,
                      textAlignVertical: TextAlignVertical.center,
                      style: GoogleFonts.overpass(),
                      controller: _endController,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(horizontal: getSize(context, true, 10 / 415),),
                        border: InputBorder.none,
                        hintText: "Uhrzeit Ende",
                        hintStyle: GoogleFonts.overpass(color: BeysionColors.purple.withOpacity(0.9)),
                        isCollapsed: true,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(padding: const EdgeInsets.all(8.0), child: Text("-"),),
              Expanded(
                flex: 3,
                child: Container(
                  height: getSize(context, true, 25 / 415),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            blurRadius: 1,
                            offset: Offset(0, 1))
                      ]),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      DropdownButton(
                        value: dropLie,
                        icon: Padding(
                          padding:
                          EdgeInsets.only(left: getSize(context, true, 4 / 415)),
                          child: Image.asset(
                            IconsPath.dropArrow,
                            color: BeysionColors.purple.withOpacity(0.9),
                          ),
                        ),
                        iconEnabledColor: BeysionColors.yellow,
                        style: GoogleFonts.overpass(fontSize: 14, color: Colors.black),
                        hint: Align(
                            alignment: Alignment.centerLeft,
                            child: Text("Unbegrenzte Bestellungen",
                              softWrap: false,
                              maxLines: 1,
                              overflow: TextOverflow.fade,
                              style: GoogleFonts.overpass(
                                color: BeysionColors.purple.withOpacity(0.9),
                              ),
                            )),
                        underline: SizedBox(),
                        items: [
                          DropdownMenuItem(value: 0, child: Text("10")),
                          DropdownMenuItem(value: 1, child: Text("test_data")),
                        ],
                        onChanged: (value) {
                          setState(() {
                            dropLie = value;
                          });
                        },
                      ),
                      IconButton(
                        icon: FaIcon(
                          widget.isAdd == true
                              ? FontAwesomeIcons.plusCircle
                              : FontAwesomeIcons.minusCircle,
                          color: widget.isAdd == true
                              ? BeysionColors.purple
                              : BeysionColors.red,
                        ),
                        onPressed: () {
                          if(widget.isAdd){
                            widget.dayList.insert(0, null);
                          }
                          else{
                            widget.dayList.removeAt(widget.index);
                          }
                          widget.parent.setState(() {

                          });
                        },
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}


