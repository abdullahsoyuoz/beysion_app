/*
 *  DO NOT ALTER OR REMOVE COPYRIGHT NOTICES OR THIS FILE HEADER.
 *
 *  Copyright (C) 2021 Rich Design - All Rights Reserved
 *  Unauthorized copying of this file, via any medium is strictly prohibited
 *  Proprietary and confidential.
 *
 *  Written by Yakup Zengin <yakup@designsrich.com>, March 2021
 *
 */

import 'package:beysion/Utility/Icons.dart';
import 'package:beysion/Utility/Images.dart';

class FakeMarket {
  String brand;
  String type;
  String address;
  double rank;
  String speed;
  String service;
  String packaging;
  String mainaddress;
  double minimumAmount;
  String working;
  double preparationTime;
  double deliveryFee;
  String deliveryType;
  String image;
  String phoneNumber;

  FakeMarket(this.brand, this.type, this.address, this.rank,
      {this.speed,
      this.mainaddress,
      this.packaging,
      this.minimumAmount,
      this.preparationTime,
      this.service,
      this.working,
      this.deliveryFee,
      this.deliveryType,
      this.image,
      this.phoneNumber});
}

class FakeProduct {
  String title;
  String price;
  String oldPrice;
  String imagePath;
  int quantity;
  int alternativeMarkets;

  FakeProduct(
      this.title, this.price, this.oldPrice, this.imagePath, this.quantity, this.alternativeMarkets);
}

class FakeCreditCard {
  String cardNumber;
  String lastDate;
  String imagePath;
  String type;
  FakeCreditCard(this.cardNumber, this.lastDate, this.imagePath, this.type);
}

class FakeOrder {
  String orderNumber;
  String orderDate;
  String marketName;
  double marketRank;
  String deliveryType;
  String totalAmount;
  int state;

  FakeOrder(this.orderNumber, this.orderDate, this.marketName, this.marketRank,
      this.deliveryType, this.totalAmount, this.state);
}

class FakeOrderSales {
  String orderNumber;
  String orderDate;
  String clients;
  String deliveryType;
  String totalAmount;
  int state;

  FakeOrderSales(this.orderNumber, this.orderDate, this.clients, this.deliveryType, this.totalAmount, this.state);
}

class FakeUser{
  String name;
  String number;
  String address;
  String country;
  String xtr;
  FakeUser(this.name, this.number, this.address, this.country, this.xtr);
}

class FakePLZData{
  double liefergebuhren;
  double keineLiefergebuhrab;
  List<String> plzGroup;
  FakePLZData(this.liefergebuhren, this.keineLiefergebuhrab, this.plzGroup);
}

class FakeChartData{
  int x;
  int y;
  FakeChartData(this.x, this.y);
}

class FakeChartDataWithString{
  int y;
  String x;
  FakeChartDataWithString(this.y, this.x);
}

class FakePieChartData{
  String label;
  double value;
  FakePieChartData(this.label, this.value);
}

class FakeData {

  static List<FakePieChartData> FakePieChartLetzten7list = [
    new FakePieChartData("AbholService", 0),
    new FakePieChartData("Lieferservice", 2),
  ];

  static List<FakePieChartData> FakePieChartLetzten30list = [
    new FakePieChartData("AbholService", 1),
    new FakePieChartData("Lieferservice", 4),
  ];

  static List<FakePieChartData> FakePieChartLetzten360list = [
    new FakePieChartData("AbholService", 1),
    new FakePieChartData("Lieferservice", 4),
  ];

  static List<FakePieChartData> FakePieChartLetztenHeutelist = [
  ];

  static List<FakeChartDataWithString> fakeChartDataWithStringList = [
    new FakeChartDataWithString(200, "Jun"),
    new FakeChartDataWithString(350, "Aug"),
    new FakeChartDataWithString(170, "Oct"),
    new FakeChartDataWithString(460, "Dec"),
    new FakeChartDataWithString(1100, "Feb"),
    new FakeChartDataWithString(1000, "Apr"),
  ];

  static List<FakeChartData> fakeGesamtumsatzList = [
    new FakeChartData(0, 1),
    new FakeChartData(1, 1),
    new FakeChartData(2, 1),
    new FakeChartData(3, 2),
    new FakeChartData(4, 2),
    new FakeChartData(5, 3),
    new FakeChartData(6, 3),
  ];

  static List<FakeChartData> fakeUmsatz30TageList = [
    new FakeChartData(0, 1),
    new FakeChartData(1, 1),
    new FakeChartData(2, 1),
    new FakeChartData(3, 2),
    new FakeChartData(4, 2),
    new FakeChartData(5, 3),
    new FakeChartData(6, 3),
  ];

  static List<FakeChartData> fakeUmsatz7TageList = [
    new FakeChartData(0, 1),
    new FakeChartData(1, 1),
    new FakeChartData(2, 1),
    new FakeChartData(3, 1),
    new FakeChartData(4, 1),
    new FakeChartData(5, 1),
    new FakeChartData(6, 1),
  ];

  static List<FakeChartData> fakeHeuteList = [

  ];

  static List<FakePLZData> fakePlzDatalist = [
    new FakePLZData(7.79, 250.00, ["42389, Wuppertal, Fleute","60488, Frankfurt am Main, Hausen"]),
    new FakePLZData(8.00, 200.00, ["45659, Recklinghausen, Bockholt","24891, Struxdorf, RabenHolzlück", "74177, Friedrichshall Bad, Friedrichshall", "24891, Struxdorf, RabenHolzlück", "74177, Friedrichshall Bad, Friedrichshall"]),
    new FakePLZData(8.20, 220.00, ["60488, Frankfurt am Main, Hausen","24891, Struxdorf, RabenHolzlück", "45659, Recklinghausen, Bockholt"]),
  ];

  static List<double> fakeSliderValues = [74, 66, 70, 70];
  static List<double> fakeSliderRankValues = [3.7, 3.3, 3.5, 3.5];
  static List<int> fakeUmzatzsValue = [0, 2, 5, 5];
  static List<double> fakeUmzatzsPriceValue = [0, 349.30, 1063.67, 1063.67];

  static FakeMarket karfur = FakeMarket(
      "Carrefour", "Supermarket", "Billbrook Street, 1.3 km", 8.9,
      mainaddress: "Lange Reihe 110, 20099 Hamburg, Almanya",
      minimumAmount: 20,
      packaging: "9,6",
      preparationTime: 60,
      service: "8,3",
      speed: "9,0",
      working: "10:00 - 22:00",
      deliveryFee: 3,
      deliveryType: "Lieferservice and Abholservice",
      phoneNumber: "069/27134690",
      image: "assets/logos/karfur.png",
  );

  static final niemerszein = FakeMarket(
      "Niemerszein Market", "Supermarket", "Paradise Street, 2.3 km", 9.1,
      mainaddress: "Lange Reihe 110, 20099 Hamburg, Almanya",
      minimumAmount: 20,
      packaging: "9,6",
      preparationTime: 60,
      service: "8,3",
      speed: "9,0",
      working: "10:00 - 22:00",
      deliveryFee: 2,
      deliveryType: "Lieferservice and Abholservice",
      phoneNumber: "069/27134690",
      image: "assets/logos/niemerszein.jpg"
  );

  static final edeka = FakeMarket(
      "Edeka", "Supermarket", "Billbrook Street, 2.6 km", 8.2,
      mainaddress: "Lange Reihe 110, 20099 Hamburg, Almanya",
      minimumAmount: 20,
      packaging: "9,6",
      preparationTime: 60,
      service: "8,3",
      speed: "9,0",
      working: "10:00 - 22:00",
      deliveryFee: 4,
      deliveryType: "Lieferservice and Abholservice",
      phoneNumber: "069/27134690",
      image:  "assets/logos/edeka.jpg"
  );

  static final borderMarket = FakeMarket(
      "BorderMarket", "Shop", "Billbrook Street, 1.3 km", 7.2,
      mainaddress: "Lange Reihe 110, 20099 Hamburg, Almanya",
      minimumAmount: 20,
      packaging: "9,6",
      preparationTime: 60,
      service: "8,3",
      speed: "9,0",
      working: "10:00 - 22:00",
      deliveryFee: 3,
      deliveryType: "Lieferservice and Abholservice",
      phoneNumber: "069/27134690",
      image: "assets/logos/border.jpg"
  );

  static final product1 = FakeProduct("Heera Idli Rice 10 KG", "18.90", "22.90", ImagesPath.product1, 1, 2);
  static final product2 = FakeProduct("Ovaltine 300 G", "4.90", "5.90", ImagesPath.product2, 3, 1);
  static final product3 = FakeProduct("Perwoll", "15.50", "21.90", ImagesPath.product3, 2, 3);
  static final product4 = FakeProduct("Oil 500 G", "4.90", "5.90", ImagesPath.product4, 5, 5);
  static final product5 = FakeProduct("Uni Baby 1 L", "14.90", "16.90", ImagesPath.product5, 2, 4);
  static final product6 = FakeProduct("Ovaltine Original 300 G", "4.90", "5.90", ImagesPath.product6, 3, 1);

  static final card1 = FakeCreditCard("4155 65** **** **25", "11/25", IconsPath.visa, "Credit Card");
  static final card2 = FakeCreditCard("4155 65** **** **25", "11/25", IconsPath.mastercard, "Credit Card");
  static final card3 = FakeCreditCard("Elton John", "Euro Bank Germany", IconsPath.mastercard, "Bank Transfer");

  static final order1 = FakeOrder("215547", "21.08.2020 16:58", "Adeka", 8.9, "Will Take It Own", "€ 223,80  - 17 Items", 0);
  static final order2 = FakeOrder("215553", "21.08.2020 13:28", "Nicherguten", 9.1, "Will Take It Own", "€ 223,80  - 17 Items", 1);
  static final order3 = FakeOrder("215518", "21.08.2020 16:28", "Carrefoursa", 8.2, "Will Take It Own", "€ 223,80  - 17 Items", 2);
  static final order4 = FakeOrder("215241", "21.08.2020 16:28", "Carrefoursa", 8.2, "Will Take It Own", "€ 223,80  - 17 Items", 3);

  static final orders1 = FakeOrderSales("215547", "21.08.2020 16:58", "Rose Bloomberg", "Will Take It Own", "€ 223,80  - 17 Items", 0);
  static final orders2 = FakeOrderSales("215553", "21.08.2020 13:28", "Martin Luke", "Will Take It Own", "€ 223,80  - 17 Items", 1);
  static final orders3 = FakeOrderSales("215518", "21.08.2020 16:28", "Rugan Malowski", "Will Take It Own", "€ 223,80  - 17 Items", 2);
  static final orders4 = FakeOrderSales("215241", "21.08.2020 16:28", "Rose Juhanne", "Will Take It Own", "€ 223,80  - 17 Items", 3);
  
  static final user1 = FakeUser("Michael Roger", "+49 441 21 445", "Lorem Ipsum Street Lange Reihe 11020099", "Hamburg, Almanya", "Invoice: Individual");
  static final user2 = FakeUser("Rose Roger", "+49 441 21 445", "Lorem Ipsum Street Lange Reihe 11020099", "Hamburg, Almanya", "Invoice: Individual");

  static String tabContent = "Milder Bio Joghurt, cremig gerührt. Artgerechte Tierhaltung mit viel Bewegungsfreiheit und Weidegang sind garantiert: Die Milch für NaturWert Bio-Joghurt stammt von kontrollierten Bauernhöfen des ökologischen Landbaus.";
}

List<String> popupmenuItems = <String>["Heute", "Letzte 7 Tage", "Letzte 30 Tage", "Alle"];