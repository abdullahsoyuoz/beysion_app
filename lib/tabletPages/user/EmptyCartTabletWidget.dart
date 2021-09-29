import 'package:beysion/constant/app_configurations.dart';
import 'package:beysion/utility/Colors.dart';
import 'package:flutter/material.dart';

class EmptyCartTabletWidget extends StatelessWidget {

  const EmptyCartTabletWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: AlignmentDirectional.center,
      padding: EdgeInsets.symmetric(horizontal: 30),
      height: App(context).appHeight(60),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                width: 170,
                height: 170,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                        begin: Alignment.bottomLeft,
                        end: Alignment.topRight,
                        colors: [
                          Theme.of(context).focusColor,
                          Theme.of(context).focusColor.withOpacity(0.1),
                        ])),
                child: Icon(
                  Icons.shopping_cart,
                  color: BeysionColors.gray1,
                  size: 95,
                ),
              ),
            ],
          ),
          SizedBox(height: 15),
          Opacity(
            opacity: 0.4,
            child: Text("Sie haben keine Artikel\nin Ihrem Warenkorb.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 30),
            ),
          ),
        ],
      ),
    );
  }
}
