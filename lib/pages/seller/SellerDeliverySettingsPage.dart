import 'package:beysion/Utility/Colors.dart';
import 'package:beysion/Utility/Icons.dart';
import 'package:beysion/Utility/Widgets.dart';
import 'package:beysion/Utility/util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class SellerDeliverySettingsPage extends StatefulWidget {
  @override
  _SellerDeliverySettingsPageState createState() =>
      _SellerDeliverySettingsPageState();
}

class _SellerDeliverySettingsPageState
    extends State<SellerDeliverySettingsPage> {
  int selectedAppBarMarketItem = 0;
  bool selectedLieferung = true;
  bool selectedServicezeiten = false;
  int bestellungenDropValue = 0;
  int lieferzeitDropValue = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBarSeller(context),
      body: buildbody(context),
    );
  }

  buildbody(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: getSize(context, true, 20 / 415),
              vertical: getSize(context, true, 20 / 415),
            ),
            child: Text("Liefereinstellungen", style: GoogleFonts.overpass(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w600),),
          ),
          buildContainer(
              context,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: getSize(context, true, 10 / 415),
                      vertical: getSize(context, true, 20 / 415),
                    ),
                    child: Text(
                      "Auf diesem Bilgschirm können Sie Ihre Liefereinstellungen vornehmen",
                      style: GoogleFonts.overpass(color: Colors.black, fontWeight: FontWeight.w400),
                    ),
                  ),
                  Divider(),
                  buildOption(context, selectedLieferung, 0),
                  buildOption(context, selectedServicezeiten, 1),
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
        width: getSize(context, true, 1),
        height: getSize(context, true, 70 / 415),
        margin: EdgeInsets.only(bottom: getSize(context, true, 10 / 415)),
        padding:
            EdgeInsets.symmetric(horizontal: getSize(context, true, 10 / 415)),
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
                        size: getSize(context, true, 35 / 415),
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
                          width: getSize(context, true, 45 / 415),
                          height: getSize(context, true, 45 / 415),
                        ),
                      ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    value == 0
                        ? "Sofortige Lieferung"
                        : "Während der Servicezeiten",
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
      children: [
        Container(
          width: getSize(context, true, 1),
          height: getSize(context, true, 40 / 415),
          margin: EdgeInsets.only(
            top: getSize(context, true, 20 / 415,),
            bottom: getSize(context, true, 20 / 415,),),
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
                  child: Text(
                    "Bestellzeit und -nummer",
                    style: GoogleFonts.overpass(fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: getSize(context, true, 20 / 415)),
          child: Text(
            "Verarbeitbare Bestellungen",
            style: GoogleFonts.overpass(fontWeight: FontWeight.w500),
          ),
        ),
        DropdownButton(
          value: bestellungenDropValue,
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
            DropdownMenuItem(value: 0, child: Text("Unbegrenzte Bestellungen")),
            DropdownMenuItem(value: 1, child: Text("test_data")),
          ],
          onChanged: (value) {
            setState(() {
              bestellungenDropValue = value;
            });
          },
        ),
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
        Container(
          width: getSize(context, true, 1),
          height: getSize(context, true, 110 / 415),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            color: Colors.red.withOpacity(0.15),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Wenn die Anzahl der eingehenden Bestellungen die Anzahl der Bestellungen überschreitet,",
              style: GoogleFonts.overpass(color: Colors.brown),
            ),
          ),
        ),
        Padding(
          padding:
              EdgeInsets.symmetric(vertical: getSize(context, true, 10 / 415)),
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
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: getSize(context, true, 10 / 415)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            isActiveMonday == true ? buildServicezeitenItem(context,"Montag","8:00 - 21:00", mondayList) : SizedBox(),
            isActiveTuesday == true ? buildServicezeitenItem(context,"Dienstag","8:00 - 21:00", tuesdayList) : SizedBox(),
            isActiveWednesday == true ? buildServicezeitenItem(context,"Mittwoch","8:00 - 21:00", wednesdayList) : SizedBox(),
            isActiveThursday == true ? buildServicezeitenItem(context,"Donnerstag","8:00 - 21:00", thursdayList) : SizedBox(),
            isActiveFriday == true ? buildServicezeitenItem(context,"Freitag","8:00 - 21:00", fridayList) : SizedBox(),
            isActiveSaturday == true ? buildServicezeitenItem(context,"Samstag","8:00 - 21:00", saturdayList) : SizedBox(),
            isActiveSunday == true ? buildServicezeitenItem(context,"Sonntag","8:00 - 21:00", sundayList) : SizedBox(),

            Padding(
              padding:
              EdgeInsets.symmetric(vertical: getSize(context, true, 10 / 415)),
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
      ),
    );
  }

  buildServicezeitenItem(
      BuildContext context,String day, String timeInterval, List<String> dayList) {
    return Column(
      children: [
        Container(
          width: getSize(context, true, 1),
          height: getSize(context, true, 40 / 415),
          decoration: BoxDecoration(color: BeysionColors.textFieldBackground),
          margin:
          EdgeInsets.symmetric(vertical: getSize(context, true, 20 / 415)),
          padding: EdgeInsets.symmetric(
              horizontal: getSize(context, true, 15 / 415)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  FaIcon(
                    FontAwesomeIcons.calendarDay,
                    color: BeysionColors.purple,
                    size: getSize(context, true, 20 / 415),
                  ),
                  Padding(
                    padding:
                    EdgeInsets.only(left: getSize(context, true, 5 / 415)),
                    child: Text(day, style: GoogleFonts.overpass(fontWeight: FontWeight.w800),
                    ),
                  )
                ],
              ),
              Text(
                timeInterval,
                style: GoogleFonts.overpass(fontWeight: FontWeight.w800),
              ),
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
      padding: EdgeInsets.symmetric(
        vertical: getSize(context, true, 20 / 415),
        horizontal: 20
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Container(
                  height: getSize(context, true, 40 / 415),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            offset: Offset(0, 1))
                      ]),
                  child: TextFormField(
                    maxLines: 1,
                    textAlignVertical: TextAlignVertical.center,
                    style: GoogleFonts.overpass(),
                    controller: _startController,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: getSize(context, true, 10 / 415),
                          vertical: getSize(context, true, 10 / 415)),
                      border: InputBorder.none,
                      hintText: "Start",
                      hintStyle: GoogleFonts.overpass(color: BeysionColors.gray2),
                      isCollapsed: true,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("-"),
              ),
              Expanded(
                child: Container(
                  height: getSize(context, true, 40 / 415),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            offset: Offset(0, 1))
                      ]),
                  child: TextFormField(
                    maxLines: 1,
                    textAlignVertical: TextAlignVertical.center,
                    style: GoogleFonts.overpass(),
                    controller: _endController,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: getSize(context, true, 10 / 415),
                          vertical: getSize(context, true, 10 / 415)),
                      border: InputBorder.none,
                      hintText: "Ende",
                      hintStyle: GoogleFonts.overpass(color: BeysionColors.gray2),
                      isCollapsed: true,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Container(
            height: getSize(context, true, 40 / 415),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(5)),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      offset: Offset(0, 1))
                ]),
            margin: EdgeInsets.only(top: 15),
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
                      color: Colors.black,
                    ),
                  ),
                  iconEnabledColor: BeysionColors.yellow,
                  style: GoogleFonts.overpass(fontSize: 14, color: Colors.black),
                  hint: Align(
                      alignment: Alignment.centerLeft,
                      child: Text("Unbegrenzte Bestellungen")),
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
          )
        ],
      ),
    );
  }
}


