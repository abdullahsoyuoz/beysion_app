import 'package:beysion/Utility/Colors.dart';
import 'package:beysion/Utility/FakeData.dart';
import 'package:beysion/Utility/Icons.dart';
import 'package:beysion/Utility/Widgets.dart';
import 'package:beysion/Utility/util.dart';
import 'package:flutter/material.dart';

class MyPaymentMethodsPage extends StatefulWidget {
  @override
  _MyPaymentMethodsPageState createState() => _MyPaymentMethodsPageState();
}

class _MyPaymentMethodsPageState extends State<MyPaymentMethodsPage> {
  ScrollController _listViewController;
  int defaultCardValue = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: buildBody(context),
    );
  }

  buildBody(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
                vertical: getSize(context, true, 20 / 415),
                horizontal: getSize(context, true, 15 / 415)),
            child: Text("Meine Zahlungsmethoden"),
          ),
          ListView(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            scrollDirection: Axis.vertical,
            controller: _listViewController,
            children: [
              buildPaymentMethodCard(context, FakeData.card1, 0),
              buildPaymentMethodCard(context, FakeData.card2, 1),
              buildPaymentMethodCard(context, FakeData.card3, 2),
            ],
          ),
          buildMethodNew(context)
        ],
      ),
    );
  }

  buildPaymentMethodCard(BuildContext context, FakeCreditCard item, int index) {
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
                    item.type,
                    style: TextStyle(fontWeight: FontWeight.w300),
                  ),
                  InkWell(
                    child: Image.asset(IconsPath.delete2),
                    onTap: () {},
                  ),
                ],
              ),
              Divider(
                color: BeysionColors.gray2,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    item.cardNumber,
                    style: TextStyle(fontWeight: FontWeight.w300, fontSize: 12),
                  ),
                  Container(
                    width: getSize(context, true, 56/415),
                    height: getSize(context, true, 17/415),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.fitHeight,
                        image: AssetImage(item.imagePath)
                      )
                    ),
                  )
                ],
              ),
              SizedBox(
                height: getSize(context, true, 5 / 415),
              ),
              Text(
                item.lastDate,
                style: TextStyle(fontWeight: FontWeight.w300, fontSize: 12),
              ),
              SizedBox(
                height: getSize(context, true, 5 / 415),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Radio(
                        visualDensity: VisualDensity.standard,
                        value: index,
                        groupValue: defaultCardValue,
                        onChanged: (value) {
                          setState(() {
                            defaultCardValue = value;
                          });
                        },
                      ),
                      Text(
                        "Standardzahlungsmethode",
                        style: TextStyle(
                            fontWeight: FontWeight.w300, fontSize: 12),
                      ),
                    ],
                  ),
                  Text(
                    "Bearbeiten",
                    style: TextStyle(
                        decoration: TextDecoration.underline,
                        color: BeysionColors.blueNavy),
                  )
                ],
              )
            ],
          ),
        ),
        bottomMargin: 10);
  }

  buildMethodNew(BuildContext context) {
    return buildContainer(
        context,
        Container(
          height: getSize(context, true, 304 / 415),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(IconsPath.plus),
                SizedBox(
                  height: getSize(context, true, 10 / 415),
                ),
                Text(
                  "Neue Zahlungsmethode hinzufügen",
                  style: TextStyle(fontWeight: FontWeight.w300, fontSize: 12),
                ),
              ],
            ),
          ),
        ),
        bottomMargin: 50);
  }
}
