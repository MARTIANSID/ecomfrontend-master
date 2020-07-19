import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:giffy_dialog/giffy_dialog.dart';

void showFloatingFlushbar(BuildContext context, text, productName, cartIcon) {
  Flushbar(
    borderRadius: 8,
    backgroundGradient: LinearGradient(
      colors: [
        Color(0xFF34B0D9),
        Color(0xFF3685CB),
      ],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    // backgroundColor: kPrimaryColor,
    boxShadows: [
      BoxShadow(
        color: Colors.black45,
        offset: Offset(3, 3),
        blurRadius: 3,
      ),
    ],
    margin: EdgeInsets.all(10.0),
    animationDuration: Duration(milliseconds: 500),
    duration: Duration(seconds: 1, milliseconds: 500),
    dismissDirection: FlushbarDismissDirection.HORIZONTAL,
    forwardAnimationCurve: Curves.easeOut,
    title: text,
    messageText: Text(
      productName,
      style: TextStyle(
          fontFamily: 'Gilroy Regular',
          color: Colors.white,
          fontSize: ScreenUtil().setSp(15, allowFontScalingSelf: true)),
    ),
    blockBackgroundInteraction: true,
    icon: Padding(
      padding: EdgeInsets.only(left: 13.0),
      child: Text(
        cartIcon,
        style: TextStyle(
            fontFamily: 'Gilroy Regular',
            color: Colors.white,
            fontSize: ScreenUtil().setSp(20, allowFontScalingSelf: true)),
      ),
    ),
    // mainButton: Container(
    //   margin: EdgeInsets.all(5.0),
    //   child: FlatButton(
    //     shape: RoundedRectangleBorder(
    //         borderRadius: BorderRadius.circular(18.0),
    //         side: BorderSide(color: kPrimaryLightColor, width: 1.0)),
    //     child: Text(
    //       'Undo',
    //       style: TextStyle(color: kPrimaryLightColor),
    //     ),
    //     onPressed: () {},
    //   ),
    // ),
  )..show(context);
}

void dataSelect({
  context,
  titleText,
  contentText,
  buttonText,
  onPressed,
  gif,
}) {
  if (context != null) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return alertDialog;
        return AssetGiffyDialog(
          // key: keys[5],
          buttonRadius: 20,

          image: Image.asset(
            gif,
            fit: BoxFit.cover,
          ),
          title: Text(
            titleText,
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'Gilroy Medium',
              fontWeight: FontWeight.bold,
              fontSize: ScreenUtil().setSp(
                19,
                allowFontScalingSelf: true,
              ),
            ),
            textAlign: TextAlign.center,
          ),
          entryAnimation: EntryAnimation.BOTTOM_RIGHT,
          description: Text(
            contentText,
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'Gilroy Regular',
              fontSize: ScreenUtil().setSp(
                16,
                allowFontScalingSelf: true,
              ),
            ),
            textAlign: TextAlign.center,
          ),
          onlyOkButton: true,
          cornerRadius: 20,
          onOkButtonPressed: onPressed,
          buttonOkText: Text(
            buttonText,
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'Gilroy Regular',
            ),
          ),
          buttonOkColor: titleText != 'Alert!' || titleText != 'Important!'
              ? Colors.cyan
              : Color(0xFFFF7C80),
        );
      },
    );
  }
}

Widget dataSelect1(context, titleText, contentText, buttonText, onPressed) {
  return BackdropFilter(
    filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
    child: Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFF34B0D9).withOpacity(0.2),
            Color(0xFF3685CB).withOpacity(0.2),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            blurRadius: 7,
            color: Color(0xFF3BB96D).withOpacity(0.25),
            offset: Offset(-10, -10),
          ),
        ],
      ),
      child: Center(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            boxShadow: <BoxShadow>[
              BoxShadow(
                blurRadius: 7,
                color: Color(0xFF3BB96D).withOpacity(0.25),
                offset: Offset(10, 10),
              ),
            ],
          ),
          constraints: BoxConstraints(
            minHeight: ScreenUtil().setHeight(50),
            maxHeight: ScreenUtil().setHeight(150),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                contentText,
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Gilroy Regular',
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
                      fontSize:
                          ScreenUtil().setSp(15, allowFontScalingSelf: true)),
                ),
                borderSide: BorderSide(color: Colors.black, width: 1.0),
                shape: RoundedRectangleBorder(
                    // side: BorderSide(color: kPrimaryColor, width: 1.0),
                    borderRadius: BorderRadius.circular(18.0)),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

Future<bool> dataSelectConfirmMessage(
    {context, titleText, contentText, gif}) async {
  bool value1 = false;
  // var alertDialog =
  value1 = await showDialog(
    context: context,
    builder: (BuildContext context) {
      return AssetGiffyDialog(
        // key: keys[5],
        buttonRadius: 20,
        image: Image.asset(
          gif,
          fit: BoxFit.cover,
        ),
        title: Text(
          titleText,
          style: TextStyle(
            color: Colors.black,
            fontFamily: 'Gilroy Medium',
            fontWeight: FontWeight.bold,
            fontSize: ScreenUtil().setSp(
              19,
              allowFontScalingSelf: true,
            ),
          ),
          textAlign: TextAlign.center,
        ),
        entryAnimation: EntryAnimation.BOTTOM_RIGHT,
        description: Text(
          contentText,
          style: TextStyle(
            color: Colors.black,
            fontFamily: 'Gilroy Regular',
            fontSize: ScreenUtil().setSp(
              16,
              allowFontScalingSelf: true,
            ),
          ),
          textAlign: TextAlign.center,
        ),
        buttonCancelColor: Colors.cyan,

        onCancelButtonPressed: () {
          Navigator.pop(context, false);

          value1 = false;
          return false;
        },
        onOkButtonPressed: () {
          Navigator.pop(context, true);

          value1 = true;
          return true;
        },
        buttonOkText: Text(
          "Yes",
          style: TextStyle(
            color: Colors.black,
            fontFamily: 'Gilroy Regular',
          ),
        ),
        buttonCancelText: Text(
          "No",
          style: TextStyle(
            color: Colors.black,
            fontFamily: 'Gilroy Regular',
          ),
        ),
        buttonOkColor: Colors.cyan,
      );
    },
  );
  return value1;
}

Future<bool> dataSelectConfirmMessage1(
    {context, titleText, contentText, gif}) async {
  bool value1 = false;
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
            fontFamily: 'Gilroy Medium',
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
          textAlign: TextAlign.left,
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
}

Future<bool> dataSelectConfirmMessageTNC(
    {context, titleText, contentText, gif}) async {
  bool value1 = false;
  // var alertDialog =
  value1 = await showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        scrollable: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        title: Text(
          titleText,
          style: TextStyle(
            color: Colors.black,
            fontFamily: 'Gilroy Medium',
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
          textAlign: TextAlign.left,
        ),
        actions: <Widget>[
          // FlatButton(
          //   onPressed: () {
          //     Navigator.pop(context, false);
          //     // Navigator.of(context).pop();
          //     value1 = false;
          //     return false;
          //   },
          //   child: Text("No",
          //       style: TextStyle(
          //           fontSize: ScreenUtil().setSp(
          //             16,
          //             allowFontScalingSelf: true,
          //           ),
          //           color: Colors.black,
          //           fontFamily: 'Gilroy Medium')),
          // ),
          FlatButton(
            onPressed: () {
              Navigator.pop(context, true);
              // value1 = true;
              // return true;
            },
            child: Text("Okay",
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
}
