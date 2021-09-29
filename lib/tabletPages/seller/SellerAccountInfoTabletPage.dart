import 'package:beysion/Utility/Colors.dart';
import 'package:beysion/Utility/Icons.dart';
import 'package:beysion/Utility/util.dart';
import 'package:beysion/rest/entity/seller/seller_login_entity.dart';
import 'package:beysion/utility/Widgets.dart';
import 'package:flutter/material.dart';
import 'package:beysion/constant/app_configurations.dart' as settingRepo;
import 'package:google_fonts/google_fonts.dart';

class SellerAccountInfoTabletPage extends StatefulWidget {
  @override
  _SellerAccountInfoTabletPageState createState() => _SellerAccountInfoTabletPageState();
}

class _SellerAccountInfoTabletPageState extends State<SellerAccountInfoTabletPage> {

  TextEditingController _companyNameController = new TextEditingController();
  TextEditingController _taxNumberController = new TextEditingController();

  TextEditingController _personNameController = new TextEditingController();
  TextEditingController _personSurnameController = new TextEditingController();
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _phoneNumberController = new TextEditingController();

  TextEditingController _marketNameController = new TextEditingController();
  TextEditingController _marketTelController = new TextEditingController();

  TextEditingController _zipCodeController = new TextEditingController();
  TextEditingController _addressController = new TextEditingController();


  int selectedDropDownValueCountry = 0;
  int selectedAppBarMarketItem = 0;
  int valueGender = 0;
  int dropDownValueUnternehmens = 0;

  @override
  void initState() {
    super.initState();
    SellerLoginEntity sellerLoginEntity =  settingRepo.sellerLoginInformationEntity.value;
    _companyNameController.text = sellerLoginEntity.detail.officialName;
    _taxNumberController.text = sellerLoginEntity.detail.officialName;

    _personNameController.text = sellerLoginEntity.detail.officialName;
    _personSurnameController.text = sellerLoginEntity.detail.officialSurname;
    _emailController.text = sellerLoginEntity.detail.officialName;
    _phoneNumberController.text= sellerLoginEntity.detail.mobiltelefon;

    _marketNameController.text = sellerLoginEntity.detail.name;
    _marketTelController.text = sellerLoginEntity.detail.phone;

    _zipCodeController.text = sellerLoginEntity.detail.zipcode;
    _addressController.text =sellerLoginEntity.detail.address;
    setState(() {
      valueGender = sellerLoginEntity.detail.officialGender;
    });

  }

  @override
  void dispose() {
    super.dispose();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBarSellerTablet(context),
      body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: getSize(context, true, 20/415),
                  vertical: getSize(context, true, 20/415),
                ),
                child: Text("Marktinformationen", style: GoogleFonts.overpass(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w600),),
              ),
              Container(
                margin: EdgeInsets.only(
                  left: getSize(context, true, 20 / 415),
                  right: getSize(context, true, 20 / 415),
                ),
                padding: EdgeInsets.only(
                  top: getSize(context, true, 15 / 415),
                  left: getSize(context, true, 15 / 415),
                  right: getSize(context, true, 15 / 415),
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  border:
                  Border.all(color: BeysionColors.border, width: 1),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //  --------------------------------- PERSÖNLICHE_INFORMATIONEN
                    Padding(
                      padding: const EdgeInsets.all(0),
                      child: Text("PERSÖNLICHE INFORMATIONEN",
                        style: GoogleFonts.overpass(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: BeysionColors.purple),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    RichText(text: TextSpan(
                                        text: "Geschlecht",
                                        style: GoogleFonts.overpass(color: Colors.black),
                                        children: [
                                          TextSpan(
                                              text: "*",
                                              style: GoogleFonts.overpass(color: Colors.red)
                                          )
                                        ]
                                    ),),
                                    Container(
                                      height: getSize(context, true, 30 / 415),
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
                                          icon: Padding(
                                            padding: const EdgeInsets.only(left: 8.0),
                                            child: Image.asset(
                                              IconsPath.dropArrow,
                                              color: Colors.black87,
                                              width: getSize(context, true, 10 / 415),
                                              fit: BoxFit.fitWidth,
                                            ),
                                          ),
                                          value: valueGender,
                                          items: [
                                            DropdownMenuItem(value: 1, child: Text("Herr")),
                                            DropdownMenuItem(value: 2, child: Text("Frau")),
                                            DropdownMenuItem(value: 3, child: Text("Divers")),
                                          ], onChanged: (int value) {
                                          setState(() {
                                            valueGender = value;
                                          });
                                        },
                                        ),
                                      ),
                                    ),

                                  ],
                                ),
                              ),
                              SizedBox(width: 10,),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    RichText(text: TextSpan(
                                        text: "Titel",
                                        style: GoogleFonts.overpass(color: Colors.black),
                                        children: [
                                          TextSpan(
                                            text: "*",
                                            style: GoogleFonts.overpass(color: Colors.red),
                                          )
                                        ]
                                    ),),
                                    Container(
                                      height: getSize(context, true, 30 / 415),
                                      margin: EdgeInsets.only(
                                        top: getSize(context, true, 5 / 415),
                                        bottom: getSize(context, true, 20 / 415),
                                      ),
                                      decoration: BoxDecoration(
                                          color: BeysionColors.textFieldBackground,
                                          borderRadius: BorderRadius.all(Radius.circular(5))),
                                      child: TextFormField(
                                        // controller: ,
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.symmetric(
                                              horizontal: 10),
                                          border: InputBorder.none,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(width: 20,),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    RichText(text: TextSpan(
                                        text: "Vorname",
                                        style: GoogleFonts.overpass(color: Colors.black),
                                        children: [
                                          TextSpan(
                                              text: "*",
                                              style: GoogleFonts.overpass(color: Colors.red)
                                          )
                                        ]
                                    ),),
                                    Container(
                                      height: getSize(context, true, 30 / 415),
                                      margin: EdgeInsets.only(
                                        top: getSize(context, true, 5 / 415),
                                        bottom: getSize(context, true, 20 / 415),
                                      ),
                                      decoration: BoxDecoration(
                                          color: BeysionColors.textFieldBackground,
                                          borderRadius: BorderRadius.all(Radius.circular(5))),
                                      child: TextFormField(
                                        controller: _personNameController,
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.symmetric(
                                              horizontal: 10),
                                          border: InputBorder.none,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(width: 10,),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    RichText(text: TextSpan(
                                        text: "Nachname",
                                        style: GoogleFonts.overpass(color: Colors.black),
                                        children: [
                                          TextSpan(
                                              text: "*",
                                              style: GoogleFonts.overpass(color: Colors.red)
                                          )
                                        ]
                                    ),),
                                    Container(
                                      height: getSize(context, true, 30 / 415),
                                      margin: EdgeInsets.only(
                                        top: getSize(context, true, 5 / 415),
                                        bottom: getSize(context, true, 20 / 415),
                                      ),
                                      decoration: BoxDecoration(
                                          color: BeysionColors.textFieldBackground,
                                          borderRadius: BorderRadius.all(Radius.circular(5))),
                                      child: TextFormField(
                                        controller: _personSurnameController,
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.symmetric(
                                              horizontal: 10),
                                          border: InputBorder.none,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    RichText(text: TextSpan(
                                        text: "E-Mail",
                                        style: GoogleFonts.overpass(color: Colors.black),
                                        children: [
                                          TextSpan(
                                              text: "*",
                                              style: GoogleFonts.overpass(color: Colors.red)
                                          )
                                        ]
                                    ),),
                                    Container(
                                      height: getSize(context, true, 30 / 415),
                                      margin: EdgeInsets.only(
                                        top: getSize(context, true, 5 / 415),
                                        bottom: getSize(context, true, 20 / 415),
                                      ),
                                      decoration: BoxDecoration(
                                          color: BeysionColors.textFieldBackground,
                                          borderRadius: BorderRadius.all(Radius.circular(5))),
                                      child: TextFormField(
                                        controller: _emailController,
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.symmetric(
                                              horizontal: 10),
                                          border: InputBorder.none,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(width: 20,),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    RichText(text: TextSpan(
                                        text: "Mobiltelefon",
                                        style: GoogleFonts.overpass(color: Colors.black),
                                        children: [
                                          TextSpan(
                                              text: "*",
                                              style: GoogleFonts.overpass(color: Colors.red)
                                          )
                                        ]
                                    ),),
                                    Container(
                                      height: getSize(context, true, 30 / 415),
                                      margin: EdgeInsets.only(
                                        top: getSize(context, true, 5 / 415),
                                        bottom: getSize(context, true, 20 / 415),
                                      ),
                                      decoration: BoxDecoration(
                                          color: BeysionColors.textFieldBackground,
                                          borderRadius: BorderRadius.all(Radius.circular(5))),
                                      child: TextFormField(
                                        controller: _phoneNumberController,
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.symmetric(
                                              horizontal: 10),
                                          border: InputBorder.none,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    //  --------------------------------- FIRMENINFORMATIONEN
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Text("FIRMENINFORMATIONEN",
                        style: GoogleFonts.overpass(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: BeysionColors.purple),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    RichText(text: TextSpan(
                                        text: "Name der Firma",
                                        style: GoogleFonts.overpass(color: Colors.black),
                                        children: [
                                          TextSpan(
                                              text: "*",
                                              style: GoogleFonts.overpass(color: Colors.red)
                                          )
                                        ]
                                    ),),
                                    Container(
                                      height: getSize(context, true, 30 / 415),
                                      margin: EdgeInsets.only(
                                        top: getSize(context, true, 5 / 415),
                                        bottom: getSize(context, true, 20 / 415),
                                      ),
                                      decoration: BoxDecoration(
                                          color: BeysionColors.textFieldBackground,
                                          borderRadius: BorderRadius.all(Radius.circular(5))),
                                      child: TextFormField(
                                        controller: _companyNameController,
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.symmetric(horizontal: 10),
                                          border: InputBorder.none,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: 20,),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    RichText(text: TextSpan(
                                        text: "Steuernummer",
                                        style: GoogleFonts.overpass(color: Colors.black),
                                        children: [
                                          TextSpan(
                                              text: "*",
                                              style: GoogleFonts.overpass(color: Colors.red)
                                          )
                                        ]
                                    ),),
                                    Container(
                                      height: getSize(context, true, 30 / 415),
                                      margin: EdgeInsets.only(
                                        top: getSize(context, true, 5 / 415),
                                        bottom: getSize(context, true, 20 / 415),
                                      ),
                                      decoration: BoxDecoration(
                                          color: BeysionColors.textFieldBackground,
                                          borderRadius: BorderRadius.all(Radius.circular(5))),
                                      child: TextFormField(
                                        controller: _taxNumberController,
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.symmetric(horizontal: 10),
                                          border: InputBorder.none,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    RichText(text: TextSpan(
                                        text: "Art des Unternehmens",
                                        style: GoogleFonts.overpass(color: Colors.black),
                                        children: [
                                          TextSpan(
                                              text: "*",
                                              style: GoogleFonts.overpass(color: Colors.transparent)
                                          )
                                        ]
                                    ),),
                                    Container(
                                      height: getSize(context, true, 30 / 415),
                                      margin: EdgeInsets.only(
                                        top: getSize(context, true, 5 / 415),
                                        bottom: getSize(context, true, 20 / 415),
                                      ),
                                      padding: EdgeInsets.symmetric(horizontal: 15),
                                      decoration: BoxDecoration(
                                          color: BeysionColors.textFieldBackground,
                                          borderRadius: BorderRadius.all(Radius.circular(5))),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: DropdownButton(
                                              underline: SizedBox(),
                                              icon: Padding(
                                                  padding: const EdgeInsets.only(left: 8.0),
                                                  child: SizedBox()
                                              ),
                                              value: dropDownValueUnternehmens,
                                              items: [
                                                DropdownMenuItem(value: 0, child: Text("GmbH")),
                                                DropdownMenuItem(value: 1, child: Text("GBR")),
                                                DropdownMenuItem(value: 2, child: Text("OHG")),
                                                DropdownMenuItem(value: 3, child: Text("Einzelunternehmen")),
                                              ], onChanged: (int value) {
                                              setState(() {
                                                dropDownValueUnternehmens = value;
                                              });
                                            },
                                            ),
                                          ),
                                          Image.asset(
                                            IconsPath.dropArrow,
                                            color: Colors.black87,
                                            width: getSize(context, true, 10 / 415),
                                            fit: BoxFit.fitWidth,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: 20,),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    RichText(text: TextSpan(
                                        text: "HRB Nummer",
                                        style: GoogleFonts.overpass(color: Colors.black),
                                        children: [
                                          TextSpan(
                                              text: "*",
                                              style: GoogleFonts.overpass(color: Colors.transparent)
                                          )
                                        ]
                                    ),),
                                    Container(
                                      height: getSize(context, true, 30 / 415),
                                      margin: EdgeInsets.only(
                                        top: getSize(context, true, 5 / 415),
                                        bottom: getSize(context, true, 20 / 415),
                                      ),
                                      decoration: BoxDecoration(
                                          color: BeysionColors.textFieldBackground,
                                          borderRadius: BorderRadius.all(Radius.circular(5))),
                                      child: TextFormField(
                                        // controller:
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.symmetric(horizontal: 10),
                                          border: InputBorder.none,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    RichText(text: TextSpan(
                                        text: "Registergericht",
                                        style: GoogleFonts.overpass(color: Colors.black),
                                        children: [
                                          TextSpan(
                                              text: "*",
                                              style: GoogleFonts.overpass(color: Colors.transparent)
                                          )
                                        ]
                                    ),),
                                    Container(
                                      height: getSize(context, true, 30 / 415),
                                      margin: EdgeInsets.only(
                                        top: getSize(context, true, 5 / 415),
                                        bottom: getSize(context, true, 20 / 415),
                                      ),
                                      decoration: BoxDecoration(
                                          color: BeysionColors.textFieldBackground,
                                          borderRadius: BorderRadius.all(Radius.circular(5))),
                                      child: TextFormField(
                                        // controller:
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.symmetric(horizontal: 10),
                                          border: InputBorder.none,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: 20,),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    RichText(text: TextSpan(
                                        text: "USt - IdNr.",
                                        style: GoogleFonts.overpass(color: Colors.black),
                                        children: [
                                          TextSpan(
                                              text: "*",
                                              style: GoogleFonts.overpass(color: Colors.transparent)
                                          )
                                        ]
                                    ),),
                                    Container(
                                      height: getSize(context, true, 30 / 415),
                                      margin: EdgeInsets.only(
                                        top: getSize(context, true, 5 / 415),
                                        bottom: getSize(context, true, 20 / 415),
                                      ),
                                      decoration: BoxDecoration(
                                          color: BeysionColors.textFieldBackground,
                                          borderRadius: BorderRadius.all(Radius.circular(5))),
                                      child: TextFormField(
                                        // controller:
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.symmetric(
                                              horizontal: 10),
                                          border: InputBorder.none,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    RichText(text: TextSpan(
                                        text: "Der Name der Bank",
                                        style: GoogleFonts.overpass(color: Colors.black),
                                        children: [
                                          TextSpan(
                                              text: "*",
                                              style: GoogleFonts.overpass(color: Colors.red)
                                          )
                                        ]
                                    ),),
                                    Container(
                                      height: getSize(context, true, 30 / 415),
                                      margin: EdgeInsets.only(
                                        top: getSize(context, true, 5 / 415),
                                        bottom: getSize(context, true, 20 / 415),
                                      ),
                                      decoration: BoxDecoration(
                                          color: BeysionColors.textFieldBackground,
                                          borderRadius: BorderRadius.all(Radius.circular(5))),
                                      child: TextFormField(
                                        // controller:
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.symmetric(
                                              horizontal: 10),
                                          border: InputBorder.none,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: 20,),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    RichText(text: TextSpan(
                                        text: "iban",
                                        style: GoogleFonts.overpass(color: Colors.black),
                                        children: [
                                          TextSpan(
                                              text: "*",
                                              style: GoogleFonts.overpass(color: Colors.red)
                                          )
                                        ]
                                    ),),
                                    Container(
                                      height: getSize(context, true, 30 / 415),
                                      margin: EdgeInsets.only(
                                        top: getSize(context, true, 5 / 415),
                                        bottom: getSize(context, true, 20 / 415),
                                      ),
                                      decoration: BoxDecoration(
                                          color: BeysionColors.textFieldBackground,
                                          borderRadius: BorderRadius.all(Radius.circular(5))),
                                      child: TextFormField(
                                        // controller:
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.symmetric(horizontal: 10),
                                          border: InputBorder.none,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              RichText(text: TextSpan(
                                  text: "Der Vor- oder Nachname des Kontoinhabers. oder Titel in der Firma",
                                  style: GoogleFonts.overpass(color: Colors.black),
                                  children: [
                                    TextSpan(
                                        text: "*",
                                        style: GoogleFonts.overpass(color: Colors.red)
                                    )
                                  ]
                              ),),
                              Container(
                                height: getSize(context, true, 30 / 415),
                                margin: EdgeInsets.only(
                                  top: getSize(context, true, 5 / 415),
                                  bottom: getSize(context, true, 20 / 415),
                                ),
                                decoration: BoxDecoration(
                                    color: BeysionColors.textFieldBackground,
                                    borderRadius: BorderRadius.all(Radius.circular(5))),
                                child: TextFormField(
                                  // controller:
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.symmetric(horizontal: 10),
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    //  --------------------------------- MARKTINFO
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Text(
                        "MARKTINFO",
                        style: GoogleFonts.overpass(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: BeysionColors.purple),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                RichText(text: TextSpan(
                                    text: "Marktname",
                                    style: GoogleFonts.overpass(color: Colors.black),
                                    children: [
                                      TextSpan(
                                          text: "*",
                                          style: GoogleFonts.overpass(color: Colors.red)
                                      )
                                    ]
                                ),),
                                Container(
                                  height: getSize(context, true, 30 / 415),
                                  margin: EdgeInsets.only(
                                    top: getSize(context, true, 5 / 415),
                                    bottom: getSize(context, true, 20 / 415),
                                  ),
                                  decoration: BoxDecoration(
                                      color: BeysionColors.textFieldBackground,
                                      borderRadius: BorderRadius.all(Radius.circular(5))),
                                  child: TextFormField(
                                    controller: _marketNameController,
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.symmetric(horizontal: 10),
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 20,),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                RichText(text: TextSpan(
                                    text: "Markttelefon",
                                    style: GoogleFonts.overpass(color: Colors.black),
                                    children: [
                                      TextSpan(
                                          text: "*",
                                          style: GoogleFonts.overpass(color: Colors.red)
                                      )
                                    ]
                                ),),
                                Container(
                                  height: getSize(context, true, 30 / 415),
                                  margin: EdgeInsets.only(
                                    top: getSize(context, true, 5 / 415),
                                    bottom: getSize(context, true, 20 / 415),
                                  ),
                                  decoration: BoxDecoration(
                                      color: BeysionColors.textFieldBackground,
                                      borderRadius: BorderRadius.all(Radius.circular(5))),
                                  child: TextFormField(
                                    controller: _marketTelController,
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.symmetric(horizontal: 10),
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    //  --------------------------------- MARKTADRESSE
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Text(
                        "MARKTADRESSE",
                        style: GoogleFonts.overpass(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: BeysionColors.purple),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    RichText(text: TextSpan(
                                        text: "Straße",
                                        style: GoogleFonts.overpass(color: Colors.black),
                                        children: [
                                          TextSpan(
                                              text: "*",
                                              style: GoogleFonts.overpass(color: Colors.red)
                                          )
                                        ]
                                    ),),
                                    Container(
                                      height: getSize(context, true, 30 / 415),
                                      margin: EdgeInsets.only(
                                        top: getSize(context, true, 5 / 415),
                                        bottom: getSize(context, true, 20 / 415),
                                      ),
                                      decoration: BoxDecoration(
                                          color: BeysionColors.textFieldBackground,
                                          borderRadius: BorderRadius.all(Radius.circular(5))),
                                      child: TextFormField(
                                        // controller:
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.symmetric(
                                              horizontal: 10),
                                          border: InputBorder.none,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: 20,),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    RichText(text: TextSpan(
                                        text: "Haus Nr.",
                                        style: GoogleFonts.overpass(color: Colors.black),
                                        children: [
                                          TextSpan(
                                              text: "*",
                                              style: GoogleFonts.overpass(color: Colors.red)
                                          )
                                        ]
                                    ),),
                                    Container(
                                      height: getSize(context, true, 30 / 415),
                                      margin: EdgeInsets.only(
                                        top: getSize(context, true, 5 / 415),
                                        bottom: getSize(context, true, 20 / 415),
                                      ),
                                      decoration: BoxDecoration(
                                          color: BeysionColors.textFieldBackground,
                                          borderRadius: BorderRadius.all(Radius.circular(5))),
                                      child: TextFormField(
                                        // controller:
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.symmetric(
                                              horizontal: 10),
                                          border: InputBorder.none,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    RichText(text: TextSpan(
                                        text: "Postleitzahl",
                                        style: GoogleFonts.overpass(color: Colors.black),
                                        children: [
                                          TextSpan(
                                              text: "*",
                                              style: GoogleFonts.overpass(color: Colors.red)
                                          )
                                        ]
                                    ),),
                                    Container(
                                      height: getSize(context, true, 30 / 415),
                                      margin: EdgeInsets.only(
                                        top: getSize(context, true, 5 / 415),
                                        bottom: getSize(context, true, 20 / 415),
                                      ),
                                      decoration: BoxDecoration(
                                          color: BeysionColors.textFieldBackground,
                                          borderRadius: BorderRadius.all(Radius.circular(5))),
                                      child: TextFormField(
                                        controller: _zipCodeController,
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.symmetric(
                                              horizontal: 10),
                                          border: InputBorder.none,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: 20,),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    RichText(text: TextSpan(
                                        text: "Ort",
                                        style: GoogleFonts.overpass(color: Colors.black),
                                        children: [
                                          TextSpan(
                                              text: "*",
                                              style: GoogleFonts.overpass(color: Colors.red)
                                          )
                                        ]
                                    ),),
                                    Container(
                                      height: getSize(context, true, 30 / 415),
                                      margin: EdgeInsets.only(
                                        top: getSize(context, true, 5 / 415),
                                        bottom: getSize(context, true, 20 / 415),
                                      ),
                                      decoration: BoxDecoration(
                                          color: BeysionColors.textFieldBackground,
                                          borderRadius: BorderRadius.all(Radius.circular(5))),
                                      child: TextFormField(
                                        controller: _addressController,
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.symmetric(
                                              horizontal: 10),
                                          border: InputBorder.none,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    //  --------------------------------- SUBMIT_BUTTON
                    Padding(
                      padding: EdgeInsets.only(top: getSize(context, true, 5 / 415), bottom: 35),
                      child: RaisedButton(
                        color: BeysionColors.yellow,
                        child: Center(
                            child: Text(
                              "Speichern",
                              style: GoogleFonts.overpass(fontSize: 14, fontWeight: FontWeight.bold),
                            )),
                        onPressed: () {

                        },
                      ),
                    ),
                  ],
                ),
              )
            ],
          )
      ),
    );
  }


}
