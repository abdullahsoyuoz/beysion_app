/*
 *  DO NOT ALTER OR REMOVE COPYRIGHT NOTICES OR THIS FILE HEADER.
 *
 *  Copyright (C) 2020 Rich Design - All Rights Reserved
 *  Unauthorized copying of this file, via any medium is strictly prohibited
 *  Proprietary and confidential.
 *
 *  Written by Yakup Zengin <yakup@designsrich.com>, March 2020
 *
 */

import 'dart:async';

import 'package:beysion/constant/app_configurations.dart';
import 'package:beysion/utility/Icons.dart';
import 'package:beysion/utility/Logos.dart';
import 'package:beysion/utility/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class QRCodeScannerPage extends StatefulWidget {

  @override
  _QRCodeScannerPageState createState() => _QRCodeScannerPageState();
}

class _QRCodeScannerPageState extends State<QRCodeScannerPage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
  // ScanResult scanResult;
  //
  // final _flashOnController = TextEditingController(text: "Blitz");
  // final _flashOffController = TextEditingController(text: "Blitz aus");
  // final _cancelController = TextEditingController(text: "Schließen");
  // var _aspectTolerance = 0.00;
  // var _numberOfCameras = 0;
  // var _selectedCamera = -1;
  // var _useAutoFocus = true;
  // var _autoEnableFlash = false;
  // String _scanBarcode = 'Unknown';
  //
  // List<BarcodeFormat> selectedFormats = [BarcodeFormat.code39,BarcodeFormat.code93,BarcodeFormat.code128,
  // BarcodeFormat.qr,BarcodeFormat.dataMatrix,BarcodeFormat.aztec,BarcodeFormat.ean8,BarcodeFormat.pdf417,BarcodeFormat.upce];
  //
  // @override
  // void dispose() {
  //   super.dispose();
  // }
  //
  // @override
  // void initState() {
  //   super.initState();
  //   scan();
  // }
  //
  // @override
  // Widget build(BuildContext context) {
  //   return Container(
  //     child: new Scaffold(
  //         backgroundColor: Colors.white,
  //         appBar: new AppBar(
  //             backgroundColor: Color(0xff4a529d),
  //             leading: GestureDetector(
  //               child: Container(
  //               width: getSize(context, true, 20/415),
  //               height: AppBar().preferredSize.height,
  //               color: Color(0xff4a529d),
  //               child: Image.asset(IconsPath.dropArrowleft, color: Colors.white,),
  //               ),
  //               onTap: () => Navigator.pop(context,"error"),),
  //             title: Container(
  //               height: AppBar().preferredSize.height,
  //               child: Image.asset(
  //                 LogosPath.beysion,
  //                 width: getSize(context, true, 0.3),
  //                 fit: BoxFit.contain,
  //               ),
  //             ),),
  //         body: Container(
  //           color: Colors.white60,child: Center(child: CircularProgressIndicator(),),
  //         )),
  //   );
  // }
  //
  //
  // Future scan() async {
  //   try {
  //     var options = ScanOptions(
  //       strings: {
  //         "cancel": _cancelController.text,
  //         "flash_on": _flashOnController.text,
  //         "flash_off": _flashOffController.text,
  //       },
  //       restrictFormat: selectedFormats,
  //       useCamera: _selectedCamera,
  //       autoEnableFlash: _autoEnableFlash,
  //       android: AndroidOptions(
  //         aspectTolerance: _aspectTolerance,
  //         useAutoFocus: _useAutoFocus,
  //       ),
  //     );
  //
  //     var result = await BarcodeScanner.scan(options: options);
  //
  //     setState((){
  //       scanResult = result;
  //       if (result==null) {
  //         Navigator.of(context).pop("error");
  //       }else if(result.rawContent == null){
  //         Navigator.of(context).pop("error");
  //       }else if(result.rawContent.length>0){
  //         Navigator.of(context).pop("${result.rawContent}");
  //       }else if(result.rawContent.isEmpty){
  //         Navigator.of(context).pop("error");
  //       }else {
  //         Navigator.of(context).pop("true");
  //       }
  //
  //     });
  //   } on PlatformException catch (e) {
  //     var result = ScanResult(
  //       type: ResultType.Error,
  //       format: BarcodeFormat.unknown,
  //     );
  //
  //     if (e.code == BarcodeScanner.cameraAccessDenied) {
  //       setState(() {
  //         result.rawContent = 'The user did not grant the camera permission!';
  //       });
  //     } else {
  //       result.rawContent = 'Unknown error: $e';
  //     }
  //     setState(() {
  //       scanResult = result;
  //     });
  //   }
  // }


  /*Future<void> scanQR() async {
    String barcodeScanRes;

    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          "#ff6666", "KAPAT", true, ScanMode.QR);
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'hata';
    }

    if (!mounted) return;

    setState(() async {
      _scanBarcode = barcodeScanRes;

      if (_scanBarcode.contains("hata")) {
        toastWidget("QR Kod Okunamadı");
        Navigator.of(context).pop();
      }else if(_scanBarcode == "-1"){
        Navigator.of(context).pop();
      } else {
        int start = _scanBarcode.length-5;
        int end = _scanBarcode.length;
        String productIdScanner = _scanBarcode.substring(start,end);
        Pattern pattern = "/";
        var productResultLink = productIdScanner.split(pattern);
        int productIdComing = int.parse(productResultLink.last);
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ProductDetailsPage(productIdComing)),
        ).then((comingDeger) {
          if (comingDeger != null && comingDeger) {
            Navigator.of(context).pop();
          }else{
            Navigator.of(context).pop();
          }
        });
      }
    });
  }*/
}