import 'package:Flutter/constant/const.dart';
import 'package:flutter/material.dart';
import 'package:flushbar/flushbar.dart';

void showFloatingFlushbar(BuildContext context, text, productName) {
  Flushbar(
    borderRadius: 8,
    // backgroundGradient: LinearGradient(
    //   colors: [Colors.green.shade800, Colors.greenAccent.shade700],
    //   stops: [0.6, 1],
    // ),
    backgroundColor: kPrimaryColor,
    boxShadows: [
      BoxShadow(
        color: Colors.black45,
        offset: Offset(3, 3),
        blurRadius: 3,
      ),
    ],
    margin: EdgeInsets.all(10.0),
    animationDuration: Duration(seconds: 2),
    duration: Duration(seconds: 1),
    dismissDirection: FlushbarDismissDirection.HORIZONTAL,
    forwardAnimationCurve: Curves.elasticOut,
    title: text,
    // message: 'Product Name',
    messageText: Text(
      productName,
      style: TextStyle(fontFamily: 'Gilroy', color: Colors.white),
    ),
    blockBackgroundInteraction: true,
    icon: Icon(Icons.add_shopping_cart),
    mainButton: Container(
      margin: EdgeInsets.all(5.0),
      child: FlatButton(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
            side: BorderSide(color: kPrimaryLightColor, width: 1.0)),
        child: Text(
          'Undo',
          style: TextStyle(color: kPrimaryLightColor),
        ),
        onPressed: () {},
      ),
    ),
  )..show(context);
}
