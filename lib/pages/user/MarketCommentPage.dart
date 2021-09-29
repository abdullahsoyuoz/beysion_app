import 'package:beysion/utility/Colors.dart';
import 'package:beysion/utility/util.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class MarketCommentPage extends StatefulWidget {
  @override
  _EditMarketCommentPageState createState() => _EditMarketCommentPageState();
}

class _EditMarketCommentPageState extends State<MarketCommentPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 246, 246, 246),
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Shop-Bewertungen", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
            Text(" (147)", style: TextStyle(color: Colors.grey.shade400, fontWeight: FontWeight.normal),),
          ],
        ),
        centerTitle: false,
        automaticallyImplyLeading: true,
        elevation: 0.5,
        leading: InkWell(
            onTap: () => Navigator.pop(context),
            child: Icon(FontAwesomeIcons.arrowLeft, color: Colors.black,)),
      ),
      body: CustomScrollView(
        shrinkWrap: true,
        physics: ClampingScrollPhysics(),
        slivers: [
          SliverAppBar(
            toolbarHeight: 0,
            expandedHeight: getSize(context, true, 140/360),
            backgroundColor: Colors.white,
            flexibleSpace: FlexibleSpaceBar(
              background: Padding(
                padding: EdgeInsets.symmetric(horizontal: getSize(context, true, 20/360)),
                child: Column(
                  children: [
                    Container(
                      height: getSize(context, true, 30/360),
                      margin: EdgeInsets.only(top: getSize(context, true, 10/360)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("zufälliger Marktname", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),),
                          Container(
                            width: getSize(context, true, 35/360),
                            height: getSize(context, true, 20/360),
                            margin: EdgeInsets.only(left: 10),
                            decoration: BoxDecoration(
                                color: BeysionColors.orange,
                                borderRadius: BorderRadius.circular(5)
                            ),
                            child: Center(child: Text("8.9", style: TextStyle(color: BeysionColors.purple, fontWeight: FontWeight.w700),)),
                          )
                        ],
                      ),
                    ),
                    Container(
                      height: getSize(context, true, 60/360),
                      margin: EdgeInsets.only(
                        top: getSize(context, true, 20/360),
                        bottom: getSize(context, true, 20/360),
                      ),
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                  color: Colors.grey.shade100,
                                  borderRadius: BorderRadius.circular(5)
                              ),
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text("Reaktionszeit", style: GoogleFonts.overpass(color: Colors.black, fontSize: 13, fontWeight: FontWeight.w500),),
                                    Text("8.9", style: GoogleFonts.overpass(color: BeysionColors.purple, fontSize: 16, fontWeight: FontWeight.w800),),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 7),
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                  color: Colors.grey.shade100,
                                  borderRadius: BorderRadius.circular(5)
                              ),
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text("Bedienung", style: GoogleFonts.overpass(color: Colors.black, fontSize: 13, fontWeight: FontWeight.w500),),
                                    Text("8.9", style: GoogleFonts.overpass(color: BeysionColors.purple, fontSize: 16, fontWeight: FontWeight.w800),),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 7),
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                  color: Colors.grey.shade100,
                                  borderRadius: BorderRadius.circular(5)
                              ),
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text("Verpackung", style: GoogleFonts.overpass(color: Colors.black, fontSize: 13, fontWeight: FontWeight.w500),),
                                    Text("8.9", style: GoogleFonts.overpass(color: BeysionColors.purple, fontSize: 16, fontWeight: FontWeight.w800),),
                                  ],
                                ),
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
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.only(
                bottom: getSize(context, true, 20/360),
              ),
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    physics: NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.only(
                      top: getSize(context, true, 10/360),
                    ),
                    itemCount: 9,
                    itemBuilder: (context, index){
                      return Container(
                        width: getSize(context, true, 90/360),
                        margin: EdgeInsets.only(bottom: getSize(context, true, 10/360)),
                        padding: EdgeInsets.only(
                          top: getSize(context, true, 20/360),
                          bottom: getSize(context, true, 20/360),
                        ),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey.shade300,
                                  blurRadius: 2,
                                  offset: Offset(0,0))]
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: getSize(context, true, 20/360)),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(child: Text("Reaktionszeit: 10", textAlign: TextAlign.start, style: TextStyle(fontSize: 12),)),
                                  SizedBox(width: 3,),
                                  Expanded(child: Center(child: Text("Bedienung: 10", style: TextStyle(fontSize: 12)))),
                                  SizedBox(width: 3,),
                                  Expanded(child: Text("Verpackung: 10", textAlign: TextAlign.end, style: TextStyle(fontSize: 12))),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                top: getSize(context, true, 10/360),
                                left: getSize(context, true, 20/360),
                                right: getSize(context, true, 20/360),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      FaIcon(FontAwesomeIcons.solidUser, size: getSize(context, true, 10/360),),
                                      Padding(
                                        padding: EdgeInsets.only(left: 8.0),
                                        child: Text("Nutzername", style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),),
                                      )
                                    ],
                                  ),
                                  Text("03.05.2021", style: TextStyle(color: Colors.grey),)
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                top: 8.0,
                                left: getSize(context, true, 20/360),
                                right: getSize(context, true, 20/360),
                              ),
                              child: Text("Lorem Ipsum ist ein einfacher Demo-Text für die Print- und Schriftindustrie. Lorem Ipsum ist in der Industrie bereits der Standard Demo-Text seit 1500"),
                            )
                          ],
                        ),
                      );
                    }
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
