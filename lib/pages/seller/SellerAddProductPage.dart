import 'package:beysion/Utility/Colors.dart';
import 'package:beysion/Utility/Icons.dart';
import 'package:beysion/Utility/util.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class SellerAddProductPage extends StatefulWidget {
  @override
  _SellerAddProductPageState createState() => _SellerAddProductPageState();
}

class _SellerAddProductPageState extends State<SellerAddProductPage> {
  TextEditingController _nameController;
  TextEditingController _listPriceController;
  TextEditingController _discountedPriceController;
  TextEditingController _brandController;
  TextEditingController _attachFileController;
  TextEditingController _weightController;
  TextEditingController _barcodeController;
  TextEditingController _departmentController;
  TextEditingController _propertiesController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: buildBody(context),
    );
  }

  buildBody(BuildContext context) {
    return Container(
      width: getSize(context, true, 1),
      height: getSize(context, false, 1),
      child: Stack(
        children: [
          buildBodyChild(context),
          Positioned(
            right: getSize(context, true, 5 / 415),
            top: MediaQuery.of(context).padding.top,
            child: FlatButton(
              minWidth: 5,
              child: Transform.rotate(
                  angle: math.pi / 4,
                  child: Image.asset(
                    IconsPath.plus,
                    color: BeysionColors.gray2,
                    width: getSize(context, true, 30 / 415),
                    height: getSize(context, true, 30 / 415),
                  )),
              splashColor: BeysionColors.gray1.withOpacity(0.3),
              highlightColor: BeysionColors.gray1.withOpacity(0),
              hoverColor: BeysionColors.gray1.withOpacity(0),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: getSize(context, true, 1),
              height: getSize(context, true, 72 / 415),
              decoration: BoxDecoration(color: BeysionColors.yellow),
              child: Center(
                child: Text("ADD"),
              ),
            ),
          )
        ],
      ),
    );
  }

  buildBodyChild(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: getSize(context, true, 30 / 415),
        vertical: getSize(context, true, 60 / 415),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Add Product",
              style: TextStyle(
                  fontSize: 20,
                  color: BeysionColors.purple,
                  fontWeight: FontWeight.w700),
            ),
            buildName(context),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: buildListPrice(context),
                ),
                SizedBox(
                  width: getSize(context, true, 15 / 415),
                ),
                Expanded(
                  flex: 1,
                  child: buildDiscountedPrice(context),
                )
              ],
            ),
            buildBrand(context),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: buildAttachFile(context),
                ),
                SizedBox(
                  width: getSize(context, true, 15 / 415),
                ),
                Expanded(
                  flex: 1,
                  child: buildWeight(context),
                ),
              ],
            ),
            buildBarcode(context),
            buildDepartment(context),
            buildProperties(context)
          ],
        ),
      ),
    );
  }

  buildName(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(
            top: getSize(context, true, 15 / 415),
            bottom: getSize(context, true, 5 / 415),
          ),
          child: Text("Name"),
        ),
        Container(
          height: getSize(context, true, 45 / 415),
          width: getSize(context, true, 355 / 415),
          margin: EdgeInsets.only(
            top: getSize(context, true, 5 / 415),
            bottom: getSize(context, true, 20 / 415),
          ),
          padding:
              EdgeInsets.symmetric(horizontal: getSize(context, true, 5 / 415)),
          decoration: BoxDecoration(
              color: BeysionColors.textFieldBackground,
              borderRadius: BorderRadius.all(Radius.circular(5))),
          child: Center(
            child: TextFormField(
              textAlignVertical: TextAlignVertical.center,
              controller: _nameController,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(
                    horizontal: getSize(context, true, 10 / 415)),
                border: InputBorder.none,
                isDense: true,
              ),
            ),
          ),
        ),
      ],
    );
  }

  buildListPrice(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(
            top: getSize(context, true, 15 / 415),
            bottom: getSize(context, true, 5 / 415),
          ),
          child: Text("List Price"),
        ),
        Container(
          height: getSize(context, true, 45 / 415),
          width: getSize(context, true, 355 / 415),
          margin: EdgeInsets.only(
            top: getSize(context, true, 5 / 415),
            bottom: getSize(context, true, 20 / 415),
          ),
          padding:
              EdgeInsets.symmetric(horizontal: getSize(context, true, 5 / 415)),
          decoration: BoxDecoration(
              color: BeysionColors.textFieldBackground,
              borderRadius: BorderRadius.all(Radius.circular(5))),
          child: Center(
            child: TextFormField(
              textAlignVertical: TextAlignVertical.center,
              controller: _listPriceController,
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 0),
                  border: InputBorder.none,
                  //suffixIcon: Align(alignment: Alignment.centerRight, child: Text("€")),
                  isDense: true),
            ),
          ),
        ),
      ],
    );
  }

  buildDiscountedPrice(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(
            top: getSize(context, true, 15 / 415),
            bottom: getSize(context, true, 5 / 415),
          ),
          child: Text("Discounted Price"),
        ),
        Container(
          height: getSize(context, true, 45 / 415),
          width: getSize(context, true, 355 / 415),
          margin: EdgeInsets.only(
            top: getSize(context, true, 5 / 415),
            bottom: getSize(context, true, 20 / 415),
          ),
          padding:
              EdgeInsets.symmetric(horizontal: getSize(context, true, 5 / 415)),
          decoration: BoxDecoration(
              color: BeysionColors.textFieldBackground,
              borderRadius: BorderRadius.all(Radius.circular(5))),
          child: Center(
            child: TextFormField(
              textAlignVertical: TextAlignVertical.center,
              controller: _discountedPriceController,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(
                    horizontal: getSize(context, true, 10 / 415)),
                border: InputBorder.none,
                isDense: true,
              ),
            ),
          ),
        ),
      ],
    );
  }

  buildBrand(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(
            top: getSize(context, true, 15 / 415),
            bottom: getSize(context, true, 5 / 415),
          ),
          child: Text("Brand"),
        ),
        Container(
          height: getSize(context, true, 45 / 415),
          width: getSize(context, true, 355 / 415),
          margin: EdgeInsets.only(
            top: getSize(context, true, 5 / 415),
            bottom: getSize(context, true, 20 / 415),
          ),
          padding:
              EdgeInsets.symmetric(horizontal: getSize(context, true, 5 / 415)),
          decoration: BoxDecoration(
              color: BeysionColors.textFieldBackground,
              borderRadius: BorderRadius.all(Radius.circular(5))),
          child: Center(
            child: TextFormField(
              textAlignVertical: TextAlignVertical.center,
              controller: _brandController,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(
                    horizontal: getSize(context, true, 10 / 415)),
                border: InputBorder.none,
                isDense: true,
              ),
            ),
          ),
        ),
      ],
    );
  }

  buildAttachFile(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(
            top: getSize(context, true, 15 / 415),
            bottom: getSize(context, true, 5 / 415),
          ),
          child: Text("Attach File"),
        ),
        Container(
          height: getSize(context, true, 45 / 415),
          width: getSize(context, true, 355 / 415),
          margin: EdgeInsets.only(
            top: getSize(context, true, 5 / 415),
            bottom: getSize(context, true, 20 / 415),
          ),
          padding:
              EdgeInsets.symmetric(horizontal: getSize(context, true, 5 / 415)),
          decoration: BoxDecoration(
              color: BeysionColors.textFieldBackground,
              borderRadius: BorderRadius.all(Radius.circular(5))),
          child: Center(
            child: TextFormField(
              textAlignVertical: TextAlignVertical.center,
              controller: _attachFileController,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(
                    horizontal: getSize(context, true, 10 / 415)),
                border: InputBorder.none,
                isDense: true,
              ),
            ),
          ),
        ),
      ],
    );
  }

  buildWeight(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(
            top: getSize(context, true, 15 / 415),
            bottom: getSize(context, true, 5 / 415),
          ),
          child: Text("Weight"),
        ),
        Container(
          height: getSize(context, true, 45 / 415),
          width: getSize(context, true, 355 / 415),
          margin: EdgeInsets.only(
            top: getSize(context, true, 5 / 415),
            bottom: getSize(context, true, 20 / 415),
          ),
          padding:
              EdgeInsets.symmetric(horizontal: getSize(context, true, 5 / 415)),
          decoration: BoxDecoration(
              color: BeysionColors.textFieldBackground,
              borderRadius: BorderRadius.all(Radius.circular(5))),
          child: Center(
            child: TextFormField(
              textAlignVertical: TextAlignVertical.center,
              controller: _weightController,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(
                    horizontal: getSize(context, true, 10 / 415)),
                border: InputBorder.none,
                isDense: true,
              ),
            ),
          ),
        ),
      ],
    );
  }

  buildBarcode(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(
            top: getSize(context, true, 15 / 415),
            bottom: getSize(context, true, 5 / 415),
          ),
          child: Text("Barcode"),
        ),
        Container(
          height: getSize(context, true, 45 / 415),
          width: getSize(context, true, 355 / 415),
          margin: EdgeInsets.only(
            top: getSize(context, true, 5 / 415),
            bottom: getSize(context, true, 20 / 415),
          ),
          padding:
              EdgeInsets.symmetric(horizontal: getSize(context, true, 5 / 415)),
          decoration: BoxDecoration(
              color: BeysionColors.textFieldBackground,
              borderRadius: BorderRadius.all(Radius.circular(5))),
          child: Center(
            child: TextFormField(
              textAlignVertical: TextAlignVertical.center,
              controller: _barcodeController,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(
                    horizontal: getSize(context, true, 10 / 415)),
                border: InputBorder.none,
                isDense: true,
              ),
            ),
          ),
        ),
      ],
    );
  }

  buildDepartment(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(
            top: getSize(context, true, 15 / 415),
            bottom: getSize(context, true, 5 / 415),
          ),
          child: Text("Department"),
        ),
        Container(
          height: getSize(context, true, 45 / 415),
          width: getSize(context, true, 355 / 415),
          margin: EdgeInsets.only(
            top: getSize(context, true, 5 / 415),
            bottom: getSize(context, true, 20 / 415),
          ),
          padding:
              EdgeInsets.symmetric(horizontal: getSize(context, true, 5 / 415)),
          decoration: BoxDecoration(
              color: BeysionColors.textFieldBackground,
              borderRadius: BorderRadius.all(Radius.circular(5))),
          child: Center(
            child: TextFormField(
              textAlignVertical: TextAlignVertical.center,
              controller: _departmentController,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(
                    horizontal: getSize(context, true, 10 / 415)),
                border: InputBorder.none,
                isDense: true,
              ),
            ),
          ),
        ),
      ],
    );
  }

  buildProperties(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(
            top: getSize(context, true, 15 / 415),
            bottom: getSize(context, true, 5 / 415),
          ),
          child: Text("Properties"),
        ),
        Container(
          height: getSize(context, true, 45 / 415),
          width: getSize(context, true, 355 / 415),
          margin: EdgeInsets.only(
            top: getSize(context, true, 5 / 415),
            bottom: getSize(context, true, 20 / 415),
          ),
          padding:
              EdgeInsets.symmetric(horizontal: getSize(context, true, 5 / 415)),
          decoration: BoxDecoration(
              color: BeysionColors.textFieldBackground,
              borderRadius: BorderRadius.all(Radius.circular(5))),
          child: Center(
            child: TextFormField(
              textAlignVertical: TextAlignVertical.center,
              controller: _propertiesController,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(
                    horizontal: getSize(context, true, 10 / 415)),
                border: InputBorder.none,
                isDense: true,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
