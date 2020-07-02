import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        width: 411.42857142857144,
        height: 774.8571428571429,
        allowFontScaling: true);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      resizeToAvoidBottomPadding: false,
      body: Container(
        width: ScreenUtil().setWidth(411),
        height: ScreenUtil().setHeight(775),
        color: Colors.white,
        // decoration: BoxDecoration(
        //   gradient: LinearGradient(
        //     colors: [
        //       Color(0xff52DED5),
        //       Color(0xff4B9FE1),
        //     ],
        //     stops: [0.35, 0.8],
        //     begin: Alignment.topCenter,
        //     end: Alignment.bottomCenter,
        //   ),
        // ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          // mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // SizedBox(
            //   height: ScreenUtil().setHeight(260),
            // ),
            Image.asset(
              "assets/images/logo_colour.png",
              fit: BoxFit.contain,
              height: ScreenUtil().setHeight(131),
              width: ScreenUtil().setWidth(131),
            ),
            // SizedBox(
            //   height: ScreenUtil().setHeight(30),
            // ),
            // Text(
            //   'GEMSTORY',
            //   style: TextStyle(
            //     fontFamily: 'Gilroy Black',
            //     color: Colors.black,
            //     fontSize: ScreenUtil().setSp(35, allowFontScalingSelf: true),
            //     fontWeight: FontWeight.w800,
            //   ),
            // ),
            // SizedBox(
            //   height: ScreenUtil().setHeight(110),
            // ),
            // Text(
            //   '"Craft of Perfection"',
            //   style: TextStyle(
            //       fontSize: ScreenUtil().setSp(24, allowFontScalingSelf: true),
            //       color: Colors.black,
            //       fontFamily: 'Gilroy'),
            // ),
          ],
        ),
      ),
    );
  }
}
