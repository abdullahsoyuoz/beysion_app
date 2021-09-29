import 'package:auto_size_text/auto_size_text.dart';
import 'package:beysion/Utility/Colors.dart';
import 'package:beysion/Utility/Icons.dart';
import 'package:beysion/Utility/Widgets.dart';
import 'package:beysion/Utility/util.dart';
import 'package:beysion/constant/app_configurations.dart';
import 'package:beysion/rest/controller/user/user_login_information_provider.dart';
import 'package:beysion/rest/entity/user/user_login_entity.dart';
import 'package:beysion/rest/response_models/base_response.dart';
import 'package:beysion/rest/response_models/ok_response.dart';
import 'package:beysion/rest/service/user_service.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'MakeYourPaymentPage.dart';
import 'package:beysion/constant/app_configurations.dart' as settingRepo;

class MyProfileAccountInfoPage extends StatefulWidget {
  @override
  _ProfileAccountInfoPageState createState() => _ProfileAccountInfoPageState();
}

class _ProfileAccountInfoPageState extends State<MyProfileAccountInfoPage> {
  ScrollController _singleChildScrollViewController;
  TextEditingController _nameTextFormFieldController= new TextEditingController();
  TextEditingController _emailTextFormFieldController= new TextEditingController();
  TextEditingController _passwordTextFormFieldController= new TextEditingController();
  TextEditingController _passwordValidateTextFormFieldController= new TextEditingController();
  TextEditingController _surnameTextFormFieldController= new TextEditingController();
  TextEditingController _phoneNumberTextFormFieldController= new TextEditingController();
  int selectedGender =0;
  bool checkBeysionSms = false;
  bool checkBeysionNewsletter = false;
  bool checkPrivacyPolicy = false;


  @override
  void initState() {
    super.initState();
    UserLoginInformationEntity userLoginInformationEntity = Provider.of<UserLoginInformationProvider>(context, listen: false).userLoginInformationEntity;
    _nameTextFormFieldController.text = userLoginInformationEntity.name;
    _surnameTextFormFieldController.text = userLoginInformationEntity.surname;
    _emailTextFormFieldController.text = userLoginInformationEntity.email;
    _phoneNumberTextFormFieldController.text = userLoginInformationEntity.mobil;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      print('${userLoginInformationEntity.gender}');
      setState(() {
       selectedGender = userLoginInformationEntity.gender;
     });
    });
  }

  @override
  Widget build(BuildContext context) {
    print('GGGGGGGG ');
    return Scaffold(
      appBar: buildAppBar(context),
      body: buildBody(context),
    );
  }

  buildBody(BuildContext context) {
    return SingleChildScrollView(
      controller: _singleChildScrollViewController,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(
              left: getSize(context, true, 20 / 415),
              top: getSize(context, true, 20 / 415),
              bottom: getSize(context, true, 20 / 415),
            ),
            child: Text("Kontoinformation", style: GoogleFonts.overpass(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w600),),
          ),
          buildContainer(context, buildAccountInfoChild(context)),
        ],
      ),
    );
  }

  buildAccountInfoChild(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: getSize(context, true, 20 / 415)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(flex: 2, child: RichText(text: TextSpan(
                  text: "Geschlecht",
                  style: GoogleFonts.overpass(color: Colors.black),
                  children: [
                    TextSpan(
                        text: "*",
                        style: GoogleFonts.overpass(color: Colors.red)
                    )
                  ]
              ),),),
              SizedBox(
                width: getSize(context, true, 10 / 415),
              ),
              Expanded(flex: 4, child: RichText(text: TextSpan(
                  text: "Vorname",
                  style: GoogleFonts.overpass(color: Colors.black),
                  children: [
                    TextSpan(
                        text: "*",
                        style: GoogleFonts.overpass(color: Colors.red)
                    )
                  ]
              ),),),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  height: getSize(context, true, 45 / 415),
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
                      value: selectedGender,
                      items: [
                        DropdownMenuItem(value: 1, child: Text("Mr.", style: GoogleFonts.overpass()),),
                        DropdownMenuItem(value: 0, child: Text("Mrs.", style: GoogleFonts.overpass()),),
                      ],
                      onChanged: (value) {
                        setState(() {
                          selectedGender = value;
                        });
                      },
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: getSize(context, true, 10 / 415),
              ),
              Expanded(
                flex: 4,
                child: Container(
                  height: getSize(context, true, 45 / 415),
                  margin: EdgeInsets.only(
                    top: getSize(context, true, 5 / 415),
                    bottom: getSize(context, true, 20 / 415),
                  ),
                  padding: EdgeInsets.symmetric(
                      horizontal: getSize(context, true, 5 / 415)),
                  decoration: BoxDecoration(
                      color: BeysionColors.textFieldBackground,
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                  child: Center(
                    child: TextFormField(
                      textAlignVertical: TextAlignVertical.center,
                      controller: _nameTextFormFieldController,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: getSize(context, true, 10 / 415)),
                        border: InputBorder.none,
                        suffixIconConstraints: BoxConstraints.tightFor(),
                        isDense: true,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
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
            height: getSize(context, true, 45 / 415),
            width: getSize(context, true, 355 / 415),
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
              textAlignVertical: TextAlignVertical.center,
              controller: _surnameTextFormFieldController,
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
          Text("E-Mail", style: GoogleFonts.overpass()),
          Container(
            height: getSize(context, true, 45 / 415),
            width: getSize(context, true, 355 / 415),
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
              textAlignVertical: TextAlignVertical.center,
              controller: _emailTextFormFieldController,
              enabled: false,
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
            height: getSize(context, true, 45 / 415),
            width: getSize(context, true, 355 / 415),
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
              textAlignVertical: TextAlignVertical.center,
              controller: _phoneNumberTextFormFieldController,
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
          Text("Neues Kennwort", style: GoogleFonts.overpass()),
          Container(
            height: getSize(context, true, 45 / 415),
            width: getSize(context, true, 355 / 415),
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
              textAlignVertical: TextAlignVertical.center,
              controller: _passwordTextFormFieldController,
              obscureText: true,
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
          Text("Neues Kennwort (Nochmal)", style: GoogleFonts.overpass()),
          Container(
            height: getSize(context, true, 45 / 415),
            width: getSize(context, true, 355 / 415),
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
              obscureText: true,
              textAlignVertical: TextAlignVertical.center,
              controller: _passwordValidateTextFormFieldController,
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
          Padding(
            padding: EdgeInsets.only(top: 10, bottom: 20),
            child: RaisedButton(
              color: BeysionColors.yellow,
              child: Center(
                  child: Text(
                    "Speichern",
                    style: GoogleFonts.overpass(fontSize: 15, fontWeight: FontWeight.w300),
                  )),
              onPressed: () async {
                if(_nameTextFormFieldController.text.length>2 && _surnameTextFormFieldController.text.length>2 && _phoneNumberTextFormFieldController.text.length>3 && _emailTextFormFieldController.text.length>3 && _passwordTextFormFieldController.text.length<1 && _passwordValidateTextFormFieldController.text.length<1){
                  String name = _nameTextFormFieldController.text;
                  String surname = _surnameTextFormFieldController.text;
                  String phone = _phoneNumberTextFormFieldController.text;
                  String email = _emailTextFormFieldController.text;
                  int gender = selectedGender;
                  print('DDDDDDDDD $selectedGender');
                  UserService userService = new UserService();
                  BaseResponse responseData = await userService.userUpdate(name,surname,phone,gender);
                  if (responseData.body != null) {
                    if(responseData is OkResponse){
                      toastWidget("Update ist erfolgreich", Colors.green);
                      Provider.of<UserLoginInformationProvider>(context, listen: false).getUserInformationDataController();
                    }
                  }
                } else if(_nameTextFormFieldController.text.length>2 && _surnameTextFormFieldController.text.length>2 && _phoneNumberTextFormFieldController.text.length>3 && _emailTextFormFieldController.text.length>3 && _passwordTextFormFieldController.text.length>1 && _passwordValidateTextFormFieldController.text.length>1){
                  String name = _nameTextFormFieldController.text;
                  String surname = _surnameTextFormFieldController.text;
                  String phone = _phoneNumberTextFormFieldController.text;
                  int gender = selectedGender;
                  String password = _passwordTextFormFieldController.text;
                  String passwordConfirm = _passwordValidateTextFormFieldController.text;
                  if(_passwordTextFormFieldController.text.compareTo(_passwordValidateTextFormFieldController.text)== 0){
                    UserService userService = new UserService();
                    BaseResponse responseData = await userService.userUpdate(name,surname,phone,gender, password: password, passwordConfirm: passwordConfirm);
                    if (responseData.body != null) {
                      if(responseData is OkResponse){
                        toastWidget("Update ist erfolgreich", Colors.green);
                        Provider.of<UserLoginInformationProvider>(context, listen: false).getUserInformationDataController();
                      }
                    }
                  }else{
                    toastWidget("Passwörter stimmen nicht überein", Colors.red);
                  }
                } else{
                  settingRepo.toastWidget("Bitte füllen Sie die Felder aus", Colors.red);
                }

              },
            ),
          ),
        ],
      ),
    );
  }
}
