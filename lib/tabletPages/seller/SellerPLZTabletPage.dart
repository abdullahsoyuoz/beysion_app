import 'package:beysion/utility/Colors.dart';
import 'package:beysion/utility/FakeData.dart';
import 'package:beysion/utility/Widgets.dart';
import 'package:beysion/utility/util.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class SellerPLZTabletPage extends StatefulWidget {
  @override
  _SellerPLZTabletPageState createState() => _SellerPLZTabletPageState();
}

class _SellerPLZTabletPageState extends State<SellerPLZTabletPage> {
  TextEditingController postleitzahlController;
  TextEditingController versandkostenController;
  TextEditingController kostenloserVersandbetragController;

  @override
  void initState() {
    super.initState();
    postleitzahlController = new TextEditingController();
    versandkostenController = new TextEditingController();
    kostenloserVersandbetragController = new TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBarSellerTablet(context),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: ListView(
          shrinkWrap: true,
          physics: ClampingScrollPhysics(),
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 24,
                left: 16.0,
              ),
              child: Text("PLZ-Einstellungen", style: GoogleFonts.overpass(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w600
              ),),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: 8,
                left: 16,
                right: 16,
              ),
              child: Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: Colors.grey.shade300)
                ),
                child: Column(
                  children: [
                    Text("Welche Postleitzahlgebiete werden Sie beliefern? Und zu welchen Liefergebühren?",style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w600
                    ),),
                    Align(
                      alignment: Alignment.topRight,
                      child: FittedBox(
                        fit: BoxFit.fitWidth,
                        child: FlatButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return StatefulBuilder(
                                  builder: (context, setState) {
                                    double dialogHeight = MediaQuery.of(context).size.height;
                                    double dialogWidth = MediaQuery.of(context).size.width;
                                    return _showDialog(setState, dialogWidth, dialogHeight);
                                  },
                                );
                              },
                            );
                          },
                          color: BeysionColors.orange,
                          child: Center(
                            child: Text("+ PLZ hinzufügen", style: GoogleFonts.overpass(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w700),),
                          ),
                        ),
                      ),
                    ),
                    Divider(color: BeysionColors.purple, thickness: 1,),
                    ListView.separated(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      separatorBuilder: (context, index) => Divider(color: BeysionColors.purple, thickness: 1,),
                      itemCount: FakeData.fakePlzDatalist.length,
                      itemBuilder: (context, index) {
                        var item = FakeData.fakePlzDatalist[index];
                        return PlzItem(item.liefergebuhren, item.keineLiefergebuhrab, item.plzGroup);
                      },
                    )
                  ],
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }

  Widget _showDialog(setState, double width, double height){
    return Dialog(
      child: FittedBox(
        fit: BoxFit.fitHeight,
        child: Container(
          width: width * 0.9,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  onPressed: (){
                    Navigator.pop(context);
                  },
                  icon: FaIcon(FontAwesomeIcons.times, color: Colors.grey,),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Text("PLZ HINZUFÜGEN", style: GoogleFonts.overpass(
                    color: BeysionColors.purple,
                    fontSize: 18,
                    fontWeight: FontWeight.w800
                ),),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16.0, right: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(text: TextSpan(
                        text: "Postleitzahl",
                        style: GoogleFonts.overpass(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w500),
                        children: [
                          TextSpan(
                              text: "*",
                              style: TextStyle(color: Colors.red)
                          )
                        ]
                    ),),
                    TextField(
                      controller: postleitzahlController,
                      decoration: InputDecoration(
                          isDense: true,
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          )
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: RichText(text: TextSpan(
                          text: "Versandkosten",
                          style: GoogleFonts.overpass(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w500),
                          children: [
                            TextSpan(
                                text: "*",
                                style: TextStyle(color: Colors.red)
                            )
                          ]
                      ),),
                    ),
                    TextField(
                      controller: versandkostenController,
                      decoration: InputDecoration(
                          isDense: true,
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          )
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: RichText(text: TextSpan(
                          text: "Kostenloser Versandkosten",
                          style: GoogleFonts.overpass(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w500),
                          children: [
                          ]
                      ),),
                    ),
                    TextField(
                      controller: kostenloserVersandbetragController,
                      decoration: InputDecoration(
                          isDense: true,
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          )
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 16, bottom: 16),
                      child: FlatButton(
                        onPressed: () {

                        },
                        color: BeysionColors.orange,
                        child: Center(
                          child: Text("HINZUFÜGEN", style: TextStyle(fontWeight: FontWeight.w700),),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class PlzItem extends StatefulWidget {
  double liefergebuhren;
  double keineLiefergebuhrab;
  List<String> plzGroup;
  PlzItem(this.liefergebuhren, this.keineLiefergebuhrab, this.plzGroup);

  @override
  _PlzItemState createState() => _PlzItemState();
}

class _PlzItemState extends State<PlzItem> {
  final navigatorKey = GlobalKey<NavigatorState>();
  double liefergebuhren;
  double keineLiefergebuhrab;

  TextEditingController postleitzahlController;
  TextEditingController versandkostenController;
  TextEditingController kostenloserVersandbetragController;

  @override
  void initState() {
    super.initState();
    postleitzahlController = new TextEditingController();
    versandkostenController = new TextEditingController(text: widget.liefergebuhren.toString());
    kostenloserVersandbetragController = new TextEditingController(text: widget.keineLiefergebuhrab.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              Expanded(
                child: Text("Liefergebühren",
                  style: GoogleFonts.overpass(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w600
                  ),
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  softWrap: true,
                  maxLines: 2,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: Text("Keine Liefergebühr ab",
                  style: GoogleFonts.overpass(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w600
                  ),
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  softWrap: true,
                  maxLines: 2,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: Text("#",
                  style: GoogleFonts.overpass(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w600
                  ),
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  softWrap: true,
                  maxLines: 2,
                ),
              ),
            ],
          ),
          Divider(color: Colors.grey,),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Row(
              children: [
                Expanded(
                  child: Center(
                    child: Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: Colors.grey.shade300)
                      ),
                      child: Text("${widget.liefergebuhren} €",
                        style: GoogleFonts.overpass(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w600
                        ),
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        softWrap: true,
                        maxLines: 2,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Center(
                    child: Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: Colors.grey.shade300)
                      ),
                      child: Text("${widget.keineLiefergebuhrab} €",
                        style: GoogleFonts.overpass(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w600
                        ),
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        softWrap: true,
                        maxLines: 2,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        IconButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return StatefulBuilder(
                                  builder: (context, setState) {
                                    double dialogHeight = MediaQuery.of(context).size.height;
                                    double dialogWidth = MediaQuery.of(context).size.width;
                                    return _showDeleteDialog(setState, dialogWidth, dialogHeight);
                                  },
                                );
                              },
                            );
                          },
                          icon: FaIcon(FontAwesomeIcons.timesCircle, color: Colors.red,),
                        ),
                        IconButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return StatefulBuilder(
                                  builder: (context, setState) {
                                    double dialogHeight = MediaQuery.of(context).size.height;
                                    double dialogWidth = MediaQuery.of(context).size.width;
                                    return _showDialog(setState, dialogWidth, dialogHeight);
                                  },
                                );
                              },
                            );
                          },
                          icon: FaIcon(FontAwesomeIcons.edit, color: BeysionColors.purple,),
                        ),
                      ],
                    )
                ),
              ],
            ),
          ),
          Divider(color: Colors.grey,),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text("PLZ-Gruppe",
              style: GoogleFonts.overpass(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w600
              ),
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              softWrap: true,
              maxLines: 2,
            ),
          ),
          Container(
            height: getSize(context, true, 120/415),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: widget.plzGroup.length,
              itemBuilder: (context, index) {
                var item = widget.plzGroup[index];
                return Container(
                  width: 120,
                  margin: EdgeInsets.only(right: 20),
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(5)
                  ),
                  child: Text(item,
                    style: GoogleFonts.overpass(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w600
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 4,
                    softWrap: false,
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }

  Widget _showDialog(setState, double width, double height){
    return Dialog(
      child: FittedBox(
        fit: BoxFit.fitHeight,
        child: Container(
          width: width * 0.9,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  onPressed: (){
                    Navigator.pop(context);
                  },
                  icon: FaIcon(FontAwesomeIcons.times, color: Colors.grey,),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Text("PLZ BEARBEITEN", style: GoogleFonts.overpass(
                    color: BeysionColors.purple,
                    fontSize: 18,
                    fontWeight: FontWeight.w800
                ),),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16.0, right: 16, bottom: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(text: TextSpan(
                        text: "Postleitzahl",
                        style: GoogleFonts.overpass(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w500),
                        children: [
                          TextSpan(
                              text: "*",
                              style: TextStyle(color: Colors.red)
                          )
                        ]
                    ),),
                    TextField(
                      controller: postleitzahlController,
                      decoration: InputDecoration(
                          isDense: true,
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          )
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: RichText(text: TextSpan(
                          text: "Versandkosten",
                          style: GoogleFonts.overpass(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w500),
                          children: [
                            TextSpan(
                                text: "*",
                                style: TextStyle(color: Colors.red)
                            )
                          ]
                      ),),
                    ),
                    TextField(
                      controller: versandkostenController,
                      decoration: InputDecoration(
                          isDense: true,
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          )
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: RichText(text: TextSpan(
                          text: "Kostenloser Versandkosten",
                          style: GoogleFonts.overpass(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w500),
                          children: [
                          ]
                      ),),
                    ),
                    TextField(
                      controller: kostenloserVersandbetragController,
                      decoration: InputDecoration(
                          isDense: true,
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          )
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 16),
                      child: FlatButton(
                        onPressed: () {

                        },
                        color: BeysionColors.orange,
                        child: Center(
                          child: Text("AKTUALISIEREN", style: TextStyle(fontWeight: FontWeight.w700),),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _showDeleteDialog(setState, double width, double height){
    return Dialog(
      child: FittedBox(
        fit: BoxFit.fitHeight,
        child: Container(
          width: width * 0.9,
          margin: EdgeInsets.symmetric(vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FaIcon(FontAwesomeIcons.exclamationCircle, color: Colors.red.withOpacity(0.4), size: 100,),
              Text("Bist du sicher?", style: GoogleFonts.overpass(
                  color: Colors.grey.shade700,
                  fontSize: 34,
                  fontWeight: FontWeight.w700),),
              Text("Sie können dies nicht\nrückgängig machen!", style: GoogleFonts.overpass(
                  color: Colors.grey.shade700,
                  fontSize: 22, fontWeight:
              FontWeight.w700),
                softWrap: true,
                maxLines: 2,
                textAlign: TextAlign.center,
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 16.0,
                  right: 16.0,
                  top: 24,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: FlatButton(
                        onPressed: () {

                        },
                        height: 50,
                        color: BeysionColors.purple,
                        child: Center(
                          child: Text("Ja, lösche es!", style: GoogleFonts.overpass(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),),
                        ),
                      ),
                    ),
                    SizedBox(width: 10,),
                    Expanded(
                      child: FlatButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        height: 50,
                        color: BeysionColors.orange,
                        child: Center(
                          child: Text("Cancel", style: GoogleFonts.overpass(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w500),),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
