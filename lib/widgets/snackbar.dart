import 'package:Flutter/constant/const.dart';
import 'package:Flutter/providers/pagination.dart';
import 'package:flutter/material.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

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

void dataSelect(context, titleText, contentText, buttonText, onPressed) {
  var alertDialog = AlertDialog(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20.0),
    ),
    title: Text(
      titleText,
      style: TextStyle(
        color: Colors.black,
        fontFamily: 'Gilroy Black',
        fontWeight: FontWeight.bold,
        fontSize: ScreenUtil().setSp(
          19,
          allowFontScalingSelf: true,
        ),
      ),
      textAlign: TextAlign.center,
    ),
    content: Container(
      constraints: BoxConstraints(
        minHeight: ScreenUtil().setHeight(50),
        maxHeight: ScreenUtil().setHeight(150),
      ),
      // height: ScreenUtil().setHeight(150.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            contentText,
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'Gilroy',
              fontSize: ScreenUtil().setSp(
                16,
                allowFontScalingSelf: true,
              ),
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: ScreenUtil().setHeight(20),
          ),
          OutlineButton(
            onPressed: onPressed,
            child: Text(
              buttonText,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: ScreenUtil().setSp(15, allowFontScalingSelf: true)),
            ),
            // color: kPrimaryLightColor,
            borderSide: BorderSide(color: Colors.black, width: 1.0),
            shape: RoundedRectangleBorder(
                // side: BorderSide(color: kPrimaryColor, width: 1.0),
                borderRadius: BorderRadius.circular(18.0)),
          ),
        ],
      ),
    ),
  );
  if (context != null) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alertDialog;
      },
    );
  }
}

Future<bool> dataSelectConfirmMessage(
    context, titleText, contentText, buttonText) async {
  bool value1;
  // var alertDialog =
  value1 = await showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        title: Text(
          titleText,
          style: TextStyle(
            color: Colors.black,
            fontFamily: 'Gilroy Black',
            fontWeight: FontWeight.bold,
            fontSize: ScreenUtil().setSp(
              19,
              allowFontScalingSelf: true,
            ),
          ),
          textAlign: TextAlign.center,
        ),
        content: Text(
          contentText,
          style: TextStyle(
            color: Colors.black,
            fontFamily: 'Gilroy Medium',
            fontSize: ScreenUtil().setSp(
              16,
              allowFontScalingSelf: true,
            ),
          ),
          textAlign: TextAlign.center,
        ),
        actions: <Widget>[
          FlatButton(
            onPressed: () {
              Navigator.pop(context, false);
              // Navigator.of(context).pop();
              value1 = false;
              return false;
            },
            child: Text("No",
                style: TextStyle(
                    fontSize: ScreenUtil().setSp(
                      16,
                      allowFontScalingSelf: true,
                    ),
                    color: Colors.black,
                    fontFamily: 'Gilroy Medium')),
          ),
          FlatButton(
            onPressed: () {
              Navigator.pop(context, true);
              value1 = true;
              return true;
            },
            child: Text("Yes",
                style: TextStyle(
                    fontSize: ScreenUtil().setSp(
                      16,
                      allowFontScalingSelf: true,
                    ),
                    color: Colors.black,
                    fontFamily: 'Gilroy Medium')),
          )
        ],
      );
    },
  );
  return value1;
  // return false;
}
