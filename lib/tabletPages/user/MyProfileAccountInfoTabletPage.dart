import 'package:beysion/Utility/Colors.dart';
import 'package:beysion/Utility/Icons.dart';
import 'package:beysion/Utility/util.dart';
import 'package:beysion/constant/app_configurations.dart';
import 'package:beysion/rest/controller/user/user_login_information_provider.dart';
import 'package:beysion/rest/entity/user/user_login_entity.dart';
import 'package:beysion/rest/response_models/base_response.dart';
import 'package:beysion/rest/response_models/ok_response.dart';
import 'package:beysion/rest/service/user_service.dart';
import 'package:beysion/utility/Widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'MakeYourPaymentTabletPage.dart';
import 'package:beysion/constant/app_configurations.dart' as settingRepo;

class MyProfileAccountInfoTabletPage extends StatefulWidget {
  @override
  _ProfileAccountInfoTabletPageState createState() =>
      _ProfileAccountInfoTabletPageState();
}

class _ProfileAccountInfoTabletPageState
    extends State<MyProfileAccountInfoTabletPage> {
  ScrollController _singleChildScrollViewController;
  TextEditingController _nameTextFormFieldController =
      new TextEditingController();
  TextEditingController _emailTextFormFieldController =
      new TextEditingController();
  TextEditingController _passwordTextFormFieldController =
      new TextEditingController();
  TextEditingController _passwordValidateTextFormFieldController =
      new TextEditingController();
  TextEditingController _surnameTextFormFieldController =
      new TextEditingController();
  TextEditingController _phoneNumberTextFormFieldController =
      new TextEditingController();
  int selectedGender = 0;
  bool checkBeysionSms = false;
  bool checkBeysionNewsletter = false;
  bool checkPrivacyPolicy = false;

  @override
  void initState() {
    super.initState();
    UserLoginInformationEntity userLoginInformationEntity =
        Provider.of<UserLoginInformationProvider>(context, listen: false)
            .userLoginInformationEntity;
    _nameTextFormFieldController.text = userLoginInformationEntity.name;
    _surnameTextFormFieldController.text = userLoginInformationEntity.surname;
    _emailTextFormFieldController.text = userLoginInformationEntity.email;
    _phoneNumberTextFormFieldController.text = userLoginInformationEntity.mobil;
    selectedGender = userLoginInformationEntity.gender;
  }

  @override
  Widget build(BuildContext context) {
    print('GGGGGGGG ');
    return Scaffold(
      appBar: buildAppBarTablet(context),
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
                top: getSize(context, true, 10 / 415),
                bottom: getSize(context, true, 10 / 415),
              ),
              child: Text("Kontoinformation",
                  style: GoogleFonts.overpass(
                      color: Colors.black,
                      fontSize: 17,
                      fontWeight: FontWeight.w600))),
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
              Expanded(
                  flex: 2,
                  child: Container(
                      child: Text("Geschlecht",
                          style: GoogleFonts.overpass(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w400)))),
              SizedBox(
                width: getSize(context, true, 10 / 415),
              ),
              Expanded(
                  flex: 4,
                  child: Container(
                      child: Text("Name",
                          style: GoogleFonts.overpass(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w400)))),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  height: getSize(context, true, 25 / 415),
                  margin: EdgeInsets.only(
                    top: getSize(context, true, 5 / 415),
                    bottom: getSize(context, true, 20 / 415),
                  ),
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: BeysionColors.gray1,
                          width: getSize(context, true, 2 / 415)),
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
                        DropdownMenuItem(value: 1, child: Text("Mr.")),
                        DropdownMenuItem(value: 0, child: Text("Mrs.")),
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
                  height: getSize(context, true, 25 / 415),
                  margin: EdgeInsets.only(
                    top: getSize(context, true, 5 / 415),
                    bottom: getSize(context, true, 20 / 415),
                  ),
                  padding: EdgeInsets.symmetric(
                      horizontal: getSize(context, true, 0 / 415)),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                  child: TextFormField(
                    textAlignVertical: TextAlignVertical.center,
                    controller: _nameTextFormFieldController,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: getSize(context, true, 10 / 415)),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: BeysionColors.gray1,
                            width: getSize(context, true, 2 / 415)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: BeysionColors.gray1,
                            width: getSize(context, true, 2 / 415)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: BeysionColors.purple,
                            width: getSize(context, true, 2 / 415)),
                      ),
                      suffixIconConstraints: BoxConstraints.tightFor(),
                    ),
                  ),
                ),
              )
            ],
          ),
          Container(
              child: Text("Nachname",
                  style: GoogleFonts.overpass(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w400))),
          Container(
            height: getSize(context, true, 25 / 415),
            width: getSize(context, true, 355 / 415),
            margin: EdgeInsets.only(
              top: getSize(context, true, 5 / 415),
              bottom: getSize(context, true, 20 / 415),
            ),
            padding: EdgeInsets.symmetric(
                horizontal: getSize(context, true, 0 / 415)),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(5))),
            child: TextFormField(
              textAlignVertical: TextAlignVertical.center,
              controller: _surnameTextFormFieldController,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(
                    horizontal: getSize(context, true, 10 / 415)),
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: BeysionColors.gray1,
                      width: getSize(context, true, 2 / 415)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: BeysionColors.gray1,
                      width: getSize(context, true, 2 / 415)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: BeysionColors.purple,
                      width: getSize(context, true, 2 / 415)),
                ),
                suffixIconConstraints: BoxConstraints.tightFor(),
              ),
            ),
          ),
          Container(
              child: Text("E-Mail",
                  style: GoogleFonts.overpass(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w400))),
          Container(
            height: getSize(context, true, 25 / 415),
            width: getSize(context, true, 355 / 415),
            margin: EdgeInsets.only(
              top: getSize(context, true, 5 / 415),
              bottom: getSize(context, true, 20 / 415),
            ),
            padding: EdgeInsets.symmetric(
                horizontal: getSize(context, true, 0 / 415)),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(5))),
            child: TextFormField(
              textAlignVertical: TextAlignVertical.center,
              controller: _emailTextFormFieldController,
              enabled: false,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(
                    horizontal: getSize(context, true, 10 / 415)),
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: BeysionColors.gray1,
                      width: getSize(context, true, 2 / 415)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: BeysionColors.gray1,
                      width: getSize(context, true, 2 / 415)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: BeysionColors.purple,
                      width: getSize(context, true, 2 / 415)),
                ),
                suffixIcon: SizedBox(),
                suffix: SizedBox(),
                isCollapsed: true,
              ),
            ),
          ),
          Container(
              child: Text("Mobiltelefon",
                  style: GoogleFonts.overpass(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w400))),
          Container(
            height: getSize(context, true, 25 / 415),
            width: getSize(context, true, 355 / 415),
            margin: EdgeInsets.only(
              top: getSize(context, true, 5 / 415),
              bottom: getSize(context, true, 20 / 415),
            ),
            padding: EdgeInsets.symmetric(
                horizontal: getSize(context, true, 0 / 415)),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(5))),
            child: TextFormField(
              textAlignVertical: TextAlignVertical.center,
              controller: _phoneNumberTextFormFieldController,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(
                    horizontal: getSize(context, true, 10 / 415)),
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: BeysionColors.gray1,
                      width: getSize(context, true, 2 / 415)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: BeysionColors.gray1,
                      width: getSize(context, true, 2 / 415)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: BeysionColors.purple,
                      width: getSize(context, true, 2 / 415)),
                ),
                suffixIcon: SizedBox(),
                suffix: SizedBox(),
                isCollapsed: true,
              ),
            ),
          ),
          Container(
              child: Text("Neues Kennwort",
                  style: GoogleFonts.overpass(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w400))),
          Container(
            height: getSize(context, true, 25 / 415),
            width: getSize(context, true, 355 / 415),
            margin: EdgeInsets.only(
              top: getSize(context, true, 5 / 415),
              bottom: getSize(context, true, 20 / 415),
            ),
            padding: EdgeInsets.symmetric(
                horizontal: getSize(context, true, 0 / 415)),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(5))),
            child: TextFormField(
              textAlignVertical: TextAlignVertical.center,
              controller: _passwordTextFormFieldController,
              obscureText: true,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(
                    horizontal: getSize(context, true, 10 / 415)),
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: BeysionColors.gray1,
                      width: getSize(context, true, 2 / 415)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: BeysionColors.gray1,
                      width: getSize(context, true, 2 / 415)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: BeysionColors.purple,
                      width: getSize(context, true, 2 / 415)),
                ),
                suffixIcon: SizedBox(),
                suffix: SizedBox(),
                isCollapsed: true,
              ),
            ),
          ),
          Container(
              child: Text("Neues Kennwort (Nochmal)",
                  style: GoogleFonts.overpass(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w400))),
          Container(
            height: getSize(context, true, 25 / 415),
            width: getSize(context, true, 355 / 415),
            margin: EdgeInsets.only(
              top: getSize(context, true, 5 / 415),
              bottom: getSize(context, true, 20 / 415),
            ),
            padding: EdgeInsets.symmetric(
                horizontal: getSize(context, true, 0 / 415)),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(5))),
            child: TextFormField(
              obscureText: true,
              textAlignVertical: TextAlignVertical.center,
              controller: _passwordValidateTextFormFieldController,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(
                    horizontal: getSize(context, true, 10 / 415)),
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: BeysionColors.gray1,
                      width: getSize(context, true, 2 / 415)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: BeysionColors.gray1,
                      width: getSize(context, true, 2 / 415)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: BeysionColors.purple,
                      width: getSize(context, true, 2 / 415)),
                ),
                suffixIcon: SizedBox(),
                suffix: SizedBox(),
                isCollapsed: true,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              top: getSize(context, true, 0 / 415),
              bottom: getSize(context, true, 10 / 415),
            ),
            child: FlatButton(
              color: BeysionColors.orange,
              child: Center(
                  child: Text(
                "SPEICHERN",
                style: GoogleFonts.overpass(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w700),
              )),
              onPressed: () async {
                if(_nameTextFormFieldController.text.length>2 && _surnameTextFormFieldController.text.length>2 && _phoneNumberTextFormFieldController.text.length>3 && _emailTextFormFieldController.text.length>3 && _passwordTextFormFieldController.text.length<1 && _passwordValidateTextFormFieldController.text.length<1){
                  String name = _nameTextFormFieldController.text;
                  String surname = _surnameTextFormFieldController.text;
                  String phone = _phoneNumberTextFormFieldController.text;
                  String email = _emailTextFormFieldController.text;
                  int gender = selectedGender;
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
