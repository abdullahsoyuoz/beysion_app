import 'package:beysion/Utility/Colors.dart';
import 'package:beysion/Utility/Icons.dart';
import 'package:beysion/Utility/Widgets.dart';
import 'package:beysion/Utility/util.dart';
import 'package:beysion/constant/app_configurations.dart';
import 'package:beysion/constant/text_field_search.dart';
import 'package:beysion/constant/zip_code_field_entity.dart';
import 'package:beysion/rest/controller/user/user_address_provider.dart';
import 'package:beysion/rest/entity/user/user_address_entity.dart';
import 'package:beysion/rest/entity/user/zip_code_entity.dart';
import 'package:beysion/rest/response_models/base_response.dart';
import 'package:beysion/rest/response_models/ok_response.dart';
import 'package:beysion/rest/service/user_address_service.dart';
import 'package:beysion/rest/service/zip_code_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';


class MyAddressPage extends StatefulWidget {
  @override
  _MyAddressPageState createState() => _MyAddressPageState();
}

class _MyAddressPageState extends State<MyAddressPage> {
  ScrollController _listViewController;

  TextEditingController dialogAdressTitle = new TextEditingController();
  TextEditingController dialogUserFirstName = new TextEditingController();
  TextEditingController dialogUserLastName = new TextEditingController();
  TextEditingController dialogMobilePhone = new TextEditingController();
  TextEditingController dialogZipPLZCode = new TextEditingController();
  TextEditingController dialogAddressDetail = new TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      Provider.of<UserAddressProvider>(context, listen: false).getUserAddressAllDataController();
    });
  }

  @override
  void dispose() {
    super.dispose();
    dialogAdressTitle.dispose();
    dialogUserFirstName.dispose();
    dialogUserLastName.dispose();
    dialogMobilePhone.dispose();
    dialogZipPLZCode.dispose();
    dialogAddressDetail.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: buildBody(),
    );
  }

  ZipCodeEntity selectedZipCode = new ZipCodeEntity();

  buildBody() {
    List<UserAddressEntity> userAddressList = Provider.of<UserAddressProvider>(context, listen: true).userAddressList;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: getSize(context, true, 20 / 415),
              horizontal: getSize(context, true, 20 / 415),
            ),
            child: Text("Meine Adresse"),
          ),
          ListView(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            scrollDirection: Axis.vertical,
            controller: _listViewController,
            children: userAddressList.map((addressEntity) => BuildAddressCard(addressEntity)).toList(),
          ),
          buildAddressNew()
        ],
      ),
    );
  }

  buildAddressNew() {
    return buildContainer(
        context,
        InkWell(
          onTap: () async{
            await Future.delayed(Duration(milliseconds: 50))
                .then((value) => showDialog(
                context: context,
                barrierDismissible: true,
                builder: (context) {
                  return StatefulBuilder(
                    builder: (context, setsState) {
                      return Dialog(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(getSize(context, true, 5 / 415))),
                        child: Container(
                          width: MediaQuery.of(context).size.width * 380 / 415,
                          height: MediaQuery.of(context).size.width * 600 / 415,
                          padding: EdgeInsets.symmetric(
                            vertical: getSize(context, true, 15 / 415),
                            horizontal: getSize(context, true, 10 / 415),
                          ),
                          decoration: BoxDecoration(
                              color: BeysionColors.background,
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.all(
                                  Radius.circular(getSize(context,true,5 / 415)))),
                          child: ListView(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Neue Adresse hinzufügen",
                                    style: GoogleFonts.overpass(
                                        color: BeysionColors.purple,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  IconButton(
                                    icon: FaIcon(FontAwesomeIcons.times,
                                      color: BeysionColors.gray2,
                                      size: getSize(context, true, 20 / 415),),
                                    onPressed: () => Navigator.pop(context),)],
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: RichText(text: TextSpan(
                                      text: "Adressname",
                                      style: GoogleFonts.overpass(
                                          color: Colors.black,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600),
                                      children: [
                                        TextSpan(
                                            text: "*",
                                            style: GoogleFonts.overpass(
                                                color: Colors.red))]),),),
                              Container(
                                margin: EdgeInsets.only(
                                  top: getSize(context, true, 5 / 415),
                                  bottom: getSize(context, true, 20 / 415),),
                                padding: EdgeInsets.symmetric(horizontal: getSize(context, true, 5 / 415)),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(color: BeysionColors.textFieldBackground, width: 4),
                                    borderRadius: BorderRadius.all(Radius.circular(getSize(context, true, 12/415)))),
                                child: TextField(
                                  controller: dialogAdressTitle,
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.symmetric(horizontal: getSize(context, true, 10 / 415)),
                                    border: InputBorder.none,),),),
                              Row(
                                children: [
                                  Flexible(
                                    flex: 1,
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: RichText(
                                            text: TextSpan(
                                                text: "Name",
                                                style: GoogleFonts.overpass(
                                                    color: Colors.black,
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w600),
                                                children: [
                                                  TextSpan(
                                                      text: "*",
                                                      style: GoogleFonts.overpass(color: Colors.red))]),),),
                                        Container(
                                          margin: EdgeInsets.only(
                                            top: getSize(context, true, 5 / 415),
                                            bottom: getSize(context, true, 20 / 415),),
                                          padding: EdgeInsets.symmetric(horizontal: getSize(context, true, 5 / 415)),
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              border: Border.all(color: BeysionColors.textFieldBackground, width: 4),
                                              borderRadius: BorderRadius.all(Radius.circular(getSize(context, true, 12/415)))),
                                          child: TextField(
                                            controller: dialogUserFirstName,
                                            decoration: InputDecoration(
                                              contentPadding: EdgeInsets.symmetric(horizontal: getSize(context, true, 10 / 415)),
                                              border: InputBorder.none,),),),],),),
                                  SizedBox(width: getSize(context, true, 10/415),),
                                  Flexible(
                                    flex: 1,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: RichText(text: TextSpan(
                                                text: "Nachname",
                                                style: GoogleFonts.overpass(color: Colors.black, fontSize: 15, fontWeight: FontWeight.w600),
                                                children: [
                                                  TextSpan(text: "*",
                                                      style: GoogleFonts.overpass(color: Colors.red))]),),),
                                        Container(
                                          margin: EdgeInsets.only(
                                            top: getSize(context, true, 5 / 415),
                                            bottom: getSize(context, true, 20 / 415),),
                                          padding: EdgeInsets.symmetric(
                                              horizontal: getSize(context, true, 5 / 415)),
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              border: Border.all(
                                                  color: BeysionColors
                                                      .textFieldBackground,
                                                  width: 4),
                                              borderRadius:
                                              BorderRadius.all(
                                                  Radius.circular(
                                                      getSize(context, true, 12/415)))),
                                          child: TextField(
                                            controller:
                                            dialogUserLastName,
                                            decoration: InputDecoration(
                                              contentPadding: EdgeInsets.symmetric(horizontal: getSize(context, true, 10 / 415)),
                                              border: InputBorder.none,),),),],),),],),
                              Row(
                                children: [
                                  Flexible(
                                    flex: 1,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: RichText(text: TextSpan(text: "Mobiltelefon",
                                                style: GoogleFonts.overpass(color: Colors.black, fontSize: 15, fontWeight: FontWeight.w600),
                                                children: [
                                                  TextSpan(text: "*",
                                                      style: GoogleFonts.overpass(color: Colors.red))]),),),
                                        Container(
                                          margin: EdgeInsets.only(
                                            top: getSize(context, true, 5 / 415),
                                            bottom: getSize(context, true, 20 / 415),),
                                          padding: EdgeInsets.symmetric(
                                              horizontal: getSize(context, true, 5 / 415)),
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              border: Border.all(color: BeysionColors.textFieldBackground, width: 4),
                                              borderRadius: BorderRadius.all(Radius.circular(getSize(context, true, 12/415)))),
                                          child: TextField(
                                            controller: dialogMobilePhone,
                                            decoration: InputDecoration(
                                              contentPadding: EdgeInsets.symmetric(horizontal: getSize(context, true, 10 / 415)),
                                              border: InputBorder.none,),),),],),),
                                  SizedBox(width: getSize(context, true, 10/415),),
                                  Flexible(
                                    flex: 1,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: RichText(text: TextSpan(text: "Postleitzahl",
                                                style: GoogleFonts.overpass(color: Colors.black, fontSize: 15, fontWeight: FontWeight.w600),
                                                children: [
                                                  TextSpan(text: "*", style: GoogleFonts.overpass(color: Colors.red))]),),),
                                        Container(
                                          margin: EdgeInsets.only(
                                            top: getSize(context,true,5 / 415),
                                            bottom: getSize(context,true,20 / 415),
                                          ),
                                          padding: EdgeInsets.symmetric(horizontal: getSize(context,true,5 / 415)),
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              border: Border.all(
                                                  color: BeysionColors
                                                      .textFieldBackground,
                                                  width: 4),
                                              borderRadius:
                                              BorderRadius.all(
                                                  Radius.circular(
                                                      getSize(context, true, 12/415)))),
                                          child: TextFieldSearch(
                                              decoration: InputDecoration(
                                                border: InputBorder.none
                                              ),
                                              label: 'Ihre PLZ',
                                              controller: dialogZipPLZCode,
                                              getSelectedValue: (item) {
                                                ZipCodeEntity zipCodeFirst = new ZipCodeEntity();
                                                zipCodeFirst.text = "${item.label}";
                                                zipCodeFirst.id = int.parse("${item.value}");
                                                selectedZipCode = zipCodeFirst;
                                              },
                                              future: () {return getAllZipCodeListController(dialogZipPLZCode.text);}),),],),),],),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: RichText(
                                  text: TextSpan(
                                      text: "Adresse",
                                      style: GoogleFonts.overpass(
                                          color: Colors.black,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600),
                                      children: [
                                        TextSpan(text: "*",
                                            style: GoogleFonts.overpass(color: Colors.red))]),),),
                              Container(
                                margin: EdgeInsets.only(
                                  top: getSize(context,
                                      true, 5 / 415),
                                  bottom: getSize(context,
                                      true, 20 / 415),
                                ),
                                padding:
                                EdgeInsets.symmetric(
                                    horizontal: getSize(
                                        context,
                                        true,
                                        5 / 415)),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                        color: BeysionColors
                                            .textFieldBackground,
                                        width: 4),
                                    borderRadius:
                                    BorderRadius.all(
                                        Radius.circular(
                                            getSize(context, true, 12/415)))),
                                child: TextField(
                                  controller:
                                  dialogAddressDetail,
                                  minLines: 3,
                                  maxLines: 3,
                                  decoration:
                                  InputDecoration(
                                    contentPadding:
                                    EdgeInsets.symmetric(
                                        horizontal:
                                        getSize(
                                            context,
                                            true,
                                            10 /
                                                415),
                                        vertical: getSize(
                                            context,
                                            true,
                                            10 / 415)),
                                    border:
                                    InputBorder.none,
                                  ),
                                ),
                              ),
                              FlatButton(
                                minWidth: getSize(context,
                                    true, 60 / 415),
                                padding: EdgeInsets.all(
                                    getSize(context, true,
                                        15 / 415)),
                                color: BeysionColors.orange,
                                child: Center(
                                  child: Text(
                                    "Adresse hinzufügen",
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.overpass(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight:
                                        FontWeight
                                            .w700),
                                  ),
                                ),
                                onPressed: () async {
                                  AddedAddressEntity addressEntity = new AddedAddressEntity();
                                  addressEntity.name =dialogAdressTitle.text;
                                  addressEntity.lastname = dialogUserLastName.text;
                                  addressEntity.firstname = dialogUserFirstName.text;
                                  addressEntity.phone = dialogMobilePhone.text;
                                  addressEntity.address = dialogAddressDetail.text;
                                  addressEntity.zipcode = selectedZipCode.id;
                                  addressEntity.defaultData = 0;
                                  UserAddressService addressService = new UserAddressService();
                                  BaseResponse responseData = await addressService.addAddress(addressEntity);
                                  if (responseData.body != null) {
                                    print('RESPONSEEE {${responseData.body}');
                                        if(responseData is OkResponse){
                                          Navigator.pop(context);
                                      Provider.of<UserAddressProvider>(context, listen: false).getUserAddressAllDataController();
                                          dialogZipPLZCode = new TextEditingController();

                                        }
                                  }

                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }));
          },
          child: Padding(
            padding: EdgeInsets.symmetric(
                vertical: getSize(context, true, 5 / 415)),
            child: Stack(
              children: [
                Container(
                    width: getSize(context, true, 1),
                    height: getSize(context, true, 100 / 415),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(
                          Radius.circular(
                              getSize(context, true, 5 / 415))),
                      border: Border.all(
                          color: BeysionColors.gray1, width: 3),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment:
                        MainAxisAlignment.center,
                        children: [
                          FaIcon(
                            FontAwesomeIcons.plus,
                            color: BeysionColors.orange,
                            size:
                            getSize(context, true, 30 / 415),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                top: getSize(
                                    context, true, 5 / 415)),
                            child: Text(
                              "Neue Adresse hinzufügen",
                              style: GoogleFonts.overpass(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500),
                            ),
                          )
                        ],
                      ),
                    )),
              ],
            ),
          ),
        ),
        bottomMargin: 50);
  }

  Future<List> getAllZipCodeListController(String search) async {
    List _listLabel = new List();
    try {
      BaseResponse response =
      await ZipCodeService.operations().zipCodeSearch(search);
      if (response is OkResponse) {
        if (response.body != null) {
          if (response.body["data"] != null) {
            List<dynamic> dataList = response.body["data"];
            for (var dataStr in dataList) {
              ZipCodeEntity model = new ZipCodeEntity.fromJson(dataStr);
              if (model != null) {
                dynamic json = {'label': '${model.text}', 'value': model.id};
                _listLabel.add(new ZipCodeTextFieldEntity.fromJson(json));
              }
            }
            return _listLabel;
          }
          return new List();
        }
        return new List();
      }
      return new List();
    } catch (e) {
      print('Exception Market List Data -- $e');
      return new List();
    }
  }

}

class BuildAddressCard extends StatefulWidget {
  UserAddressEntity item;
  int indexData;
  BuildAddressCard(this.item, {this.indexData});

  @override
  _BuildAddressCardState createState() => _BuildAddressCardState();
}

class _BuildAddressCardState extends State<BuildAddressCard> {

  TextEditingController dialogAdressName = new TextEditingController();
  TextEditingController dialogName = new TextEditingController();
  TextEditingController dialogLastName = new TextEditingController();
  TextEditingController dialogMobilTelefon = new TextEditingController();
  TextEditingController dialogZipCode = new TextEditingController();
  TextEditingController dialogAddress = new TextEditingController();


  @override
  void initState() {
   super.initState();
    /*setState(() {
      defaultAddressValue = widget.item.datumDefault;
    });*/
   dialogAdressName.text = widget.item.name;
   dialogAddress.text = widget.item.address;
   dialogMobilTelefon.text= widget.item.phone;
   dialogName.text = widget.item.firstname;
   dialogLastName.text = widget.item.lastname;
   dialogZipCode.text = widget.item.zipcode.toString();
  }

  int addressDef = 1;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return buildContainer(
        context,
        Container(
          //width: getSize(context, true, 372 / 415),
          //height: getSize(context, true, 304 / 415),
          padding:
          EdgeInsets.symmetric(vertical: getSize(context, true, 15 / 415)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.item.name,
                    style: GoogleFonts.overpass(fontWeight: FontWeight.w300),
                  ),
                  InkWell(
                    child: Image.asset(IconsPath.delete2),
                    onTap: () async {
                   UserAddressService userAddressService = new UserAddressService();
                    BaseResponse baseResponse = await userAddressService.deleteAddress(widget.item.id);
                    if(baseResponse.body!=null){
                      if(baseResponse is OkResponse){
                        toastWidget("Adresse wurde gelöscht", Colors.green);
                        Provider.of<UserAddressProvider>(context, listen: false).getUserAddressAllDataController();
                      }
                    }
                    },
                  ),
                ],
              ),
              Divider(
                color: BeysionColors.gray2,
              ),
              Text(
                widget.item.phone,
                style: GoogleFonts.overpass(fontWeight: FontWeight.w300, fontSize: 12),
              ),
              SizedBox(
                height: getSize(context, true, 5 / 415),
              ),
              Text(
                widget.item.address,
                style: GoogleFonts.overpass(fontWeight: FontWeight.w300, fontSize: 12),
              ),
              SizedBox(
                height: getSize(context, true, 5 / 415),
              ),
              Text(
                "${widget.item.zipcode}",
                style: GoogleFonts.overpass(fontWeight: FontWeight.w300, fontSize: 12),
              ),
              SizedBox(
                height: getSize(context, true, 5 / 415),
              ),
/*              Text(
                item.xtr,
                style: GoogleFonts.overpass(fontWeight: FontWeight.w300, fontSize: 12),
              )
              SizedBox(
                height: getSize(context, true, 15 / 415),
              ),*/
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Radio(
                        visualDensity: VisualDensity.standard,
                        value: widget.item.datumDefault,
                        groupValue: addressDef,
                        onChanged: (value) async {
                          setState(() {
                            addressDef = value;
                          });
                          /*UpdateAddressEntity updateAddressEntity = new UpdateAddressEntity();
                          updateAddressEntity.name =widget.item.name;
                          updateAddressEntity.lastname = widget.item.lastname;
                          updateAddressEntity.firstname = widget.item.firstname;
                          updateAddressEntity.phone = widget.item.phone;
                          updateAddressEntity.address = widget.item.address;
                          updateAddressEntity.addressId = widget.item.id;
                          updateAddressEntity.zipcode = widget.item.zipcode;
                          updateAddressEntity.defaultData = defaultAddressValue;

                          UserAddressService addressService = new UserAddressService();
                          BaseResponse responseData = await addressService.updateAddress(updateAddressEntity);
                          if (responseData.body != null) {
                            print('RESPONSEEE {${responseData.body}');
                            if(responseData is OkResponse){
                              Provider.of<UserAddressProvider>(context, listen: false).getUserAddressAllDataController();
                              Navigator.pop(context);
                            }
                          }*/
                        },
                      ),
                      Text(
                        "Standardadresse",
                        style: GoogleFonts.overpass(
                            fontWeight: FontWeight.w300, fontSize: 12),
                      ),
                    ],
                  ),
                  InkWell(
                    onTap: () async {
                      await Future.delayed(Duration(milliseconds: 50))
                          .then((value) => showDialog(
                          context: context,
                          barrierDismissible: true,
                          builder: (context) {
                            return StatefulBuilder(
                              builder: (context, setsState) {
                                return Dialog(
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                      BorderRadius.circular(
                                          getSize(context, true,
                                              5 / 415))),
                                  child: Container(
                                    width: MediaQuery.of(context).size.width * 380 / 415,
                                    height: MediaQuery.of(context).size.width * 600 / 415,
                                    padding: EdgeInsets.symmetric(
                                      vertical: getSize(context, true, 15 / 415),
                                      horizontal: getSize(context, true, 10 / 415),
                                    ),
                                    decoration: BoxDecoration(
                                        color: BeysionColors.background,
                                        shape: BoxShape.rectangle,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(getSize(context,true,5 / 415)))),
                                    child: ListView(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment
                                              .spaceBetween,
                                          children: [
                                            Text(
                                              "Neue Adresse hinzufügen",
                                              style: GoogleFonts.overpass(
                                                  color: BeysionColors
                                                      .purple,
                                                  fontSize: 18,
                                                  fontWeight:
                                                  FontWeight
                                                      .bold),
                                            ),
                                            IconButton(
                                              icon: FaIcon(
                                                FontAwesomeIcons
                                                    .times,
                                                color: BeysionColors
                                                    .gray2,
                                                size: getSize(context,
                                                    true, 20 / 415),
                                              ),
                                              onPressed: () =>
                                                  Navigator.pop(
                                                      context),
                                            )
                                          ],
                                        ),
                                        Align(
                                          alignment:
                                          Alignment.centerLeft,
                                          child: RichText(
                                            text: TextSpan(
                                                text: "Adressname",
                                                style: GoogleFonts.overpass(
                                                    color:
                                                    Colors.black,
                                                    fontSize: 15,
                                                    fontWeight:
                                                    FontWeight
                                                        .w600),
                                                children: [
                                                  TextSpan(
                                                      text: "*",
                                                      style: GoogleFonts.overpass(
                                                          color: Colors
                                                              .red))
                                                ]),
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(
                                            top: getSize(context,
                                                true, 5 / 415),
                                            bottom: getSize(context,
                                                true, 20 / 415),
                                          ),
                                          padding:
                                          EdgeInsets.symmetric(
                                              horizontal: getSize(
                                                  context,
                                                  true,
                                                  5 / 415)),
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              border: Border.all(
                                                  color: BeysionColors
                                                      .textFieldBackground,
                                                  width: 4),
                                              borderRadius:
                                              BorderRadius.all(
                                                  Radius.circular(
                                                      getSize(context, true, 12/415)))),
                                          child: TextField(
                                            controller:
                                            dialogAdressName,
                                            decoration:
                                            InputDecoration(
                                              contentPadding:
                                              EdgeInsets.symmetric(
                                                  horizontal:
                                                  getSize(
                                                      context,
                                                      true,
                                                      10 /
                                                          415)),
                                              border:
                                              InputBorder.none,
                                            ),
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Flexible(
                                              flex: 1,
                                              child: Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment
                                                    .start,
                                                children: [
                                                  Align(
                                                    alignment: Alignment
                                                        .centerLeft,
                                                    child: RichText(
                                                      text: TextSpan(
                                                          text:
                                                          "Name",
                                                          style: GoogleFonts.overpass(
                                                              color: Colors.black,
                                                              fontSize: 15,
                                                              fontWeight: FontWeight.w600),
                                                          children: [
                                                            TextSpan(
                                                                text:
                                                                "*",
                                                                style:
                                                                GoogleFonts.overpass(color: Colors.red))
                                                          ]),
                                                    ),
                                                  ),
                                                  Container(
                                                    margin: EdgeInsets
                                                        .only(
                                                      top: getSize(
                                                          context,
                                                          true,
                                                          5 / 415),
                                                      bottom: getSize(
                                                          context,
                                                          true,
                                                          20 / 415),
                                                    ),
                                                    padding: EdgeInsets
                                                        .symmetric(
                                                        horizontal: getSize(
                                                            context,
                                                            true,
                                                            5 / 415)),
                                                    decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        border: Border.all(
                                                            color: BeysionColors
                                                                .textFieldBackground,
                                                            width: 4),
                                                        borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                getSize(context, true, 12/415)))),
                                                    child: TextField(
                                                      controller:
                                                      dialogName,
                                                      decoration:
                                                      InputDecoration(
                                                        contentPadding: EdgeInsets.symmetric(
                                                            horizontal: getSize(
                                                                context,
                                                                true,
                                                                10 /
                                                                    415)),
                                                        border:
                                                        InputBorder
                                                            .none,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(width: getSize(context, true, 10/415),),
                                            Flexible(
                                              flex: 1,
                                              child: Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment
                                                    .start,
                                                children: [
                                                  Align(
                                                    alignment: Alignment
                                                        .centerLeft,
                                                    child: RichText(
                                                      text: TextSpan(
                                                          text:
                                                          "Nachname",
                                                          style: GoogleFonts.overpass(color: Colors.black, fontSize: 15, fontWeight: FontWeight.w600),
                                                          children: [
                                                            TextSpan(
                                                                text:
                                                                "*",
                                                                style:
                                                                GoogleFonts.overpass(color: Colors.red))
                                                          ]),
                                                    ),
                                                  ),
                                                  Container(
                                                    margin: EdgeInsets
                                                        .only(
                                                      top: getSize(
                                                          context,
                                                          true,
                                                          5 / 415),
                                                      bottom: getSize(
                                                          context,
                                                          true,
                                                          20 / 415),
                                                    ),
                                                    padding: EdgeInsets
                                                        .symmetric(
                                                        horizontal: getSize(
                                                            context,
                                                            true,
                                                            5 / 415)),
                                                    decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        border: Border.all(
                                                            color: BeysionColors
                                                                .textFieldBackground,
                                                            width: 4),
                                                        borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                getSize(context, true, 12/415)))),
                                                    child: TextField(
                                                      controller:
                                                      dialogLastName,
                                                      decoration:
                                                      InputDecoration(
                                                        contentPadding: EdgeInsets.symmetric(
                                                            horizontal: getSize(
                                                                context,
                                                                true,
                                                                10 /
                                                                    415)),
                                                        border:
                                                        InputBorder
                                                            .none,
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
                                            Flexible(
                                              flex: 1,
                                              child: Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment
                                                    .start,
                                                children: [
                                                  Align(
                                                    alignment: Alignment
                                                        .centerLeft,
                                                    child: RichText(
                                                      text: TextSpan(
                                                          text:
                                                          "Mobiltelefon",
                                                          style: GoogleFonts.overpass(color: Colors.black, fontSize: 15, fontWeight: FontWeight.w600),
                                                          children: [
                                                            TextSpan(
                                                                text:
                                                                "*",
                                                                style:
                                                                GoogleFonts.overpass(color: Colors.red))
                                                          ]),
                                                    ),
                                                  ),
                                                  Container(
                                                    margin: EdgeInsets
                                                        .only(
                                                      top: getSize(
                                                          context,
                                                          true,
                                                          5 / 415),
                                                      bottom: getSize(
                                                          context,
                                                          true,
                                                          20 / 415),
                                                    ),
                                                    padding: EdgeInsets
                                                        .symmetric(
                                                        horizontal: getSize(
                                                            context,
                                                            true,
                                                            5 / 415)),
                                                    decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        border: Border.all(
                                                            color: BeysionColors
                                                                .textFieldBackground,
                                                            width: 4),
                                                        borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                getSize(context, true, 12/415)))),
                                                    child: TextField(
                                                      controller:
                                                      dialogMobilTelefon,
                                                      decoration:
                                                      InputDecoration(
                                                        contentPadding: EdgeInsets.symmetric(
                                                            horizontal: getSize(
                                                                context,
                                                                true,
                                                                10 /
                                                                    415)),
                                                        border:
                                                        InputBorder
                                                            .none,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(width: getSize(context, true, 10/415),),
                                            Flexible(
                                              flex: 1,
                                              child: Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment
                                                    .start,
                                                children: [
                                                  Align(
                                                    alignment: Alignment
                                                        .centerLeft,
                                                    child: RichText(
                                                      text: TextSpan(
                                                          text:
                                                          "Postleitzahl",
                                                          style: GoogleFonts.overpass(color: Colors.black, fontSize: 15, fontWeight: FontWeight.w600),
                                                          children: [
                                                            TextSpan(
                                                                text:
                                                                "*",
                                                                style:
                                                                GoogleFonts.overpass(color: Colors.red))
                                                          ]),
                                                    ),
                                                  ),
                                                  Container(
                                                    margin: EdgeInsets.only(
                                                      top: getSize(context,true,5 / 415),
                                                      bottom: getSize(context,true,20 / 415),
                                                    ),
                                                    padding: EdgeInsets.symmetric(horizontal: getSize(context,true,5 / 415)),
                                                    decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        border: Border.all(
                                                            color: BeysionColors
                                                                .textFieldBackground,
                                                            width: 4),
                                                        borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                getSize(context, true, 12/415)))),
                                                    child: TextField(
                                                      controller:dialogZipCode,
                                                      decoration:InputDecoration(
                                                        contentPadding: EdgeInsets.symmetric(
                                                            horizontal: getSize(context,true,10 /415)),
                                                        border:InputBorder.none,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        Align(
                                          alignment:
                                          Alignment.centerLeft,
                                          child: RichText(
                                            text: TextSpan(
                                                text: "Adresse",
                                                style: GoogleFonts.overpass(
                                                    color:
                                                    Colors.black,
                                                    fontSize: 15,
                                                    fontWeight:
                                                    FontWeight
                                                        .w600),
                                                children: [
                                                  TextSpan(
                                                      text: "*",
                                                      style: GoogleFonts.overpass(
                                                          color: Colors
                                                              .red))
                                                ]),
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(
                                            top: getSize(context,
                                                true, 5 / 415),
                                            bottom: getSize(context,
                                                true, 20 / 415),
                                          ),
                                          padding:
                                          EdgeInsets.symmetric(
                                              horizontal: getSize(
                                                  context,
                                                  true,
                                                  5 / 415)),
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              border: Border.all(
                                                  color: BeysionColors
                                                      .textFieldBackground,
                                                  width: 4),
                                              borderRadius:
                                              BorderRadius.all(
                                                  Radius.circular(
                                                      getSize(context, true, 12/415)))),
                                          child: TextField(
                                            controller:
                                            dialogAddress,
                                            minLines: 3,
                                            maxLines: 3,
                                            decoration:
                                            InputDecoration(
                                              contentPadding:
                                              EdgeInsets.symmetric(
                                                  horizontal:
                                                  getSize(
                                                      context,
                                                      true,
                                                      10 /
                                                          415),
                                                  vertical: getSize(
                                                      context,
                                                      true,
                                                      10 / 415)),
                                              border:
                                              InputBorder.none,
                                            ),
                                          ),
                                        ),
                                        FlatButton(
                                          minWidth: getSize(context,
                                              true, 60 / 415),
                                          padding: EdgeInsets.all(
                                              getSize(context, true,
                                                  15 / 415)),
                                          color: BeysionColors.orange,
                                          child: Center(
                                            child: Text(
                                              "Adresse\nhinzufügen",
                                              textAlign: TextAlign.center,
                                              style: GoogleFonts.overpass(
                                                  color: Colors.black,
                                                  fontSize: 16,
                                                  fontWeight:
                                                  FontWeight
                                                      .w700),
                                            ),
                                          ),
                                          onPressed: () async {

                                            UpdateAddressEntity updateAddressEntity = new UpdateAddressEntity();
                                            updateAddressEntity.name =dialogAdressName.text;
                                            updateAddressEntity.lastname = dialogLastName.text;
                                            updateAddressEntity.firstname = dialogName.text;
                                            updateAddressEntity.phone = dialogMobilTelefon.text;
                                            updateAddressEntity.address = dialogAddress.text;
                                            updateAddressEntity.addressId = widget.item.id;
                                            updateAddressEntity.zipcode = int.parse(dialogZipCode.text);
                                            UserAddressService addressService = new UserAddressService();
                                            BaseResponse responseData = await addressService.updateAddress(updateAddressEntity);
                                            if (responseData.body != null) {
                                              print('RESPONSEEE {${responseData.body}');
                                              if(responseData is OkResponse){
                                                Provider.of<UserAddressProvider>(context, listen: false).getUserAddressAllDataController();
                                                Navigator.pop(context);
                                              }
                                            }

                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          }));
                    },
                    child: Text(
                      "Bearbeiten",
                      style: GoogleFonts.overpass(
                          decoration: TextDecoration.underline,
                          color: BeysionColors.blueNavy),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
        bottomMargin: 10);
  }
}

