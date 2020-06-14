import 'package:Flutter/constant/const.dart';
import 'package:Flutter/providers/options.dart';
import 'package:Flutter/widgets/OptCert.dart';
import 'package:Flutter/widgets/filterChipWidget.dart';

import 'package:Flutter/widgets/optBuild.dart';
import 'package:Flutter/widgets/optColor.dart';
import 'package:Flutter/widgets/optPrice.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class AppUI extends StatefulWidget {
  final void Function(int) onButtonTapped;

  const AppUI({Key key, this.onButtonTapped}) : super(key: key);
  @override
  _AppUIState createState() => _AppUIState();
}

int color;
int buildd;
bool isLoading = false;
int certt;
int diamond;

class _AppUIState extends State<AppUI> {
  void initState() {
    super.initState();
    setState(() {
      isLoading = true;
    });

    new Future.delayed(Duration.zero, () async {
      await Provider.of<Options>(context, listen: false).getStringValuesSF();
      if (Provider.of<Options>(context, listen: false).color != null) {
        color = Provider.of<Options>(context, listen: false).color;
      }
      if (Provider.of<Options>(context, listen: false).build != null) {
        buildd = Provider.of<Options>(context, listen: false).build;
      }
      if (Provider.of<Options>(context, listen: false).certificate != null) {
        certt = Provider.of<Options>(context, listen: false).certificate;
      }
      if (Provider.of<Options>(context, listen: false).diamondQuality != null) {
        diamond = Provider.of<Options>(context, listen: false).diamondQuality;
      }
      setState(() {
        isLoading = false;
        certt = Provider.of<Options>(context, listen: false).certificate;
        color = Provider.of<Options>(context, listen: false).color;
        buildd = Provider.of<Options>(context, listen: false).build;
        diamond = Provider.of<Options>(context, listen: false).diamondQuality;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    ScreenUtil.init(context,
        width: 411.42857142857144,
        height: 774.8571428571429,
        allowFontScaling: true);
    return isLoading
        ? Center(child: CircularProgressIndicator())
        : Scaffold(
            body: Container(
              child: Stack(
                children: <Widget>[
                  Positioned(
                    top: ScreenUtil().setHeight(116.25),
                    left: 0.0,
                    child: Container(
                      width: ScreenUtil().setWidth(411),
                      height: ScreenUtil().setHeight(658.75),
                      decoration: BoxDecoration(
                        // color: Color(0xFFE9FFFF),
                        gradient: LinearGradient(
                          colors: <Color>[
                            // Color(0xFF0F2985),
                            // Colors.blue[400]
                            kPrimaryLightColor,
                            Colors.white
                          ],
                          stops: [0.4, 1],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomCenter,
                        ),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(100.0),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 100.0, top: 30.0),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'Home / Nose-Pin / Product Options',
                                style: TextStyle(
                                  fontFamily: 'Gilroy',
                                  fontSize: ScreenUtil().setSp(
                                    15,
                                    allowFontScalingSelf: true,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: ScreenUtil().setHeight(19.375),
                              ),
                              Text(
                                'Nose Pin',
                                style: TextStyle(
                                  fontFamily: 'Gilroy Black',
                                  fontSize: ScreenUtil()
                                      .setSp(40, allowFontScalingSelf: true),
                                ),
                              ),
                              Text(
                                '130 Products',
                                style: TextStyle(
                                  fontFamily: 'Gilroy',
                                  fontSize: ScreenUtil().setSp(
                                    15,
                                    allowFontScalingSelf: true,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: ScreenUtil().setHeight(54.25),
                              ),
                              Text(
                                'Build: ',
                                style: TextStyle(
                                  fontFamily: 'Gilroy',
                                  fontSize: ScreenUtil()
                                      .setSp(17, allowFontScalingSelf: true),
                                ),
                              ),
                              Container(
                                width: ScreenUtil().setWidth(411),
                                height: ScreenUtil().setHeight(62),
                                child: Container(
                                  margin: EdgeInsets.only(right: 3.0),
                                  child: Opt1(buildd,false,null),
                                ),
                              ),
                              Text(
                                'Color: ',
                                style: TextStyle(
                                  fontFamily: 'Gilroy',
                                  fontSize: ScreenUtil()
                                      .setSp(17, allowFontScalingSelf: true),
                                ),
                              ),
                              Container(
                                width: ScreenUtil().setWidth(411),
                                height: ScreenUtil().setHeight(62),
                                child: Container(
                                  margin: EdgeInsets.only(right: 3.0),
                                  child: OptColor(color,false,null),
                                ),
                              ),
                              Text(
                                'Certification: ',
                                style: TextStyle(
                                  fontFamily: 'Gilroy',
                                  fontSize: ScreenUtil()
                                      .setSp(17, allowFontScalingSelf: true),
                                ),
                              ),
                              Container(
                                width: ScreenUtil().setWidth(1000),
                                height: ScreenUtil().setHeight(75),
                                child: Container(
                                  margin: EdgeInsets.only(right: 3.0),
                                  child: OptCert(certt,false,null),
                                ),
                              ),
                                Container(
                                width: ScreenUtil().setWidth(411),
                                height: ScreenUtil().setHeight(100),
                                child: Container(
                                  margin: EdgeInsets.only(right: 3.0),
                                  child: OptDiamond(diamond,false,null)
                                ),
                              ),
                              // Text(
                              //   'Color: ',
                              //   style: TextStyle(
                              //     fontFamily: 'Gilroy',
                              //     fontSize: ScreenUtil()
                              //         .setSp(17, allowFontScalingSelf: true),
                              //   ),
                              // ),
                              // Container(
                              //   width: ScreenUtil().setWidth(411),
                              //   height: ScreenUtil().setHeight(62),
                              //   child: ListView.builder(
                              //     // shrinkWrap: true,
                              //     scrollDirection: Axis.horizontal,
                              //     itemCount: color.length,
                              //     itemBuilder: (BuildContext context, int index) {
                              //       return Container(
                              //         margin: EdgeInsets.only(right: 3.0),
                              //         child:
                              //             FilterChipWidget(chipName: color[index],option: 'color',),
                              //       );
                              //     },
                              //   ),
                              // ),
                              // Text(
                              //   'Certification: ',
                              //   style: TextStyle(
                              //     fontFamily: 'Gilroy',
                              //     fontSize: ScreenUtil()
                              //         .setSp(17, allowFontScalingSelf: true),
                              //   ),
                              // ),
                              // Container(
                              //   width: ScreenUtil().setWidth(411),
                              //   height: ScreenUtil().setHeight(62),
                              //   child: ListView.builder(
                              //     // shrinkWrap: true,
                              //     scrollDirection: Axis.horizontal,
                              //     itemCount: certi.length,
                              //     itemBuilder: (BuildContext context, int index) {
                              //       return Container(
                              //         margin: EdgeInsets.only(right: 3.0),
                              //         child:
                              //             FilterChipWidget(chipName: certi[index],option: 'certificate',),
                              //       );
                              //     },
                              //   ),
                              // ),
                              // Text(
                              //   'Diamond Quality: ',
                              //   style: TextStyle(
                              //     fontFamily: 'Gilroy',
                              //     fontSize: ScreenUtil()
                              //         .setSp(17, allowFontScalingSelf: true),
                              //   ),
                              // ),
                              // Container(
                              //   width: ScreenUtil().setWidth(411),
                              //   height: ScreenUtil().setHeight(62),
                              //   child: ListView.builder(
                              //     // shrinkWrap: true,
                              //     scrollDirection: Axis.horizontal,
                              //     itemCount: diamond.length,
                              //     itemBuilder: (BuildContext context, int index) {
                              //       return Container(
                              //         margin: EdgeInsets.only(right: 3.0),
                              //         child:
                              //             FilterChipWidget(chipName: diamond[index],option: 'diamondQuality',),
                              //       );
                              //     },
                              //   ),
                              // ),
                              // SizedBox(
                              //   height: ScreenUtil().setHeight(7.75),
                              // ),
                              // Container(
                              //   width: ScreenUtil().setWidth(246.6),
                              //   child: RaisedButton(
                              //     onPressed: () {},
                              //     shape: RoundedRectangleBorder(
                              //       borderRadius: BorderRadius.circular(18.0),
                              //     ),
                              //     child: Text(
                              //       'Show Products',
                              //       style: TextStyle(
                              //         fontFamily: 'Gilroy',
                              //         fontSize: ScreenUtil()
                              //             .setSp(17, allowFontScalingSelf: true),
                              //         color: Colors.white,
                              //       ),
                              //     ),
                              //     color: kPrimaryColor,
                              //   ),
                              // )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 0.0,
                    top: ScreenUtil().setHeight(325.5),
                    child: Container(
                      width: ScreenUtil().setWidth(48.32),
                      height: ScreenUtil().setHeight(310),
                      margin: EdgeInsets.only(left: 20.0),
                      child: Wrap(
                        direction: Axis.vertical,
                        children: <Widget>[
                          RotatedBox(
                            quarterTurns: -1,
                            child: Text(
                              'Product Options',
                              style: TextStyle(
                                fontFamily: 'Gilroy',
                                fontSize: ScreenUtil()
                                    .setSp(25, allowFontScalingSelf: true),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    left: ScreenUtil().setWidth(4.11),
                    top: ScreenUtil().setHeight(90),
                    child: Container(
                      width: ScreenUtil().setWidth(98.64),
                      height: ScreenUtil().setHeight(178.25),
                      // color: Colors.amber,
                      child: RotatedBox(
                        quarterTurns: 1,
                        child: Image.network(
                          'https://api.nakoda.daxy.in/images/products/nosepin5.webp',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Column(
                    children: <Widget>[
                      Padding(
                        padding:
                            const EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 10.0),
                        child: Container(
                          margin: EdgeInsets.only(
                              top: MediaQuery.of(context).padding.top),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  IconButton(
                                    icon: Icon(Icons.arrow_back_ios),
                                    onPressed: () {
                                      print(MediaQuery.of(context).padding.top);
                                      print(size.width);
                                      print(size.height);
                                      Navigator.of(context).pop();
                                    },
                                    color: Colors.grey,
                                  ),
                                  Text(
                                    'Options',
                                    style: TextStyle(
                                      fontFamily: 'Gilroy',
                                      fontSize: ScreenUtil().setSp(21,
                                          allowFontScalingSelf: true),
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  IconButton(
                                    icon: Icon(Icons.search),
                                    iconSize: ScreenUtil()
                                        .setSp(30, allowFontScalingSelf: true),
                                    onPressed: () {},
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.shopping_cart),
                                    iconSize: ScreenUtil()
                                        .setSp(30, allowFontScalingSelf: true),
                                    onPressed: () {
                                      widget.onButtonTapped(3);
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.person_outline),
                                    iconSize: ScreenUtil()
                                        .setSp(30, allowFontScalingSelf: true),
                                    onPressed: () {
                                      widget.onButtonTapped(0);
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
  }
}
