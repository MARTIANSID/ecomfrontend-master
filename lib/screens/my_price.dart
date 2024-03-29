import 'dart:async';
import 'dart:ui';
import 'package:Flutter/constant/const.dart';
import 'package:Flutter/providers/cart.dart';
import 'package:Flutter/providers/options.dart';
import 'package:Flutter/providers/pagination.dart';
import 'package:Flutter/providers/search.dart';
import 'package:Flutter/providers/user.dart';
import 'package:Flutter/widgets/snackbar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_advanced_networkimage/provider.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import 'product_detail.dart';

class MyPrice extends StatefulWidget {
  final void Function(int) onButtonTapped;

  const MyPrice({Key key, this.onButtonTapped}) : super(key: key);
  @override
  _MyPriceState createState() => _MyPriceState();
}

class _MyPriceState extends State<MyPrice> {
  double age;
  double prevage;
  int valueOf = 0;

  int _defaultChoiceIndex4;

  int _defaultChoiceIndex3;

  int _defaultChoiceIndex2;

  int _defaultChoiceIndex1;
  bool flag;

  bool searchSelected = false;

  String searchValue = "";

  TextEditingController textEditingController = TextEditingController();

  bool searchSelectedDoneButton = false;

  bool value2 = false;

  bool isListLoading = false;

  bool isloading = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      setState(() {
        isloading = true;
      });
      age = Provider.of<Pagination>(context, listen: false).comm.toDouble();
      setState(() {
        isloading = false;
      });
    });
  }

  void _onValueChange(int value, int index) {
    // await Provider.of<Options>(context, listen: false).setBuild(build: value);
    setState(() {
      Provider.of<Cart>(context, listen: false).buildChange(value, index);
      // asdasdadadadada(value);
    });
  }

  void _onValueChangeColor(int value, int index) {
    // await Provider.of<Options>(context, listen: false).setColor(color: value);
    setState(() {
      flag = false;
      Provider.of<Cart>(context, listen: false).colorChange(value, index);
    });
  }

  void _onValueChangeCerti(int value, int index) {
    // await Provider.of<Options>(context, listen: false).setCert(cert: value);
    setState(() {
      flag = false;
      Provider.of<Cart>(context, listen: false).certChange(value, index);
    });
  }

  void _onValueChangeDQ(int value, int index) {
    // await Provider.of<Options>(context, listen: false).setDiamond(diamond: value);
    setState(() {
      flag = false;
      Provider.of<Cart>(context, listen: false).diamondChange(value, index);
    });
  }

  List<dynamic> suggestion;
  bool isLoadingSearch = false;
  Future<void> getSearch(query) async {
    setState(() {
      isLoadingSearch = true;
    });
    try {
      await Provider.of<Searchh>(context, listen: false)
          .getSearch(query: query.toUpperCase(), context: context)
          .then((value) {
        setState(() {
          suggestion = Provider.of<Searchh>(context, listen: false)
              .searchResult
              .where((element) =>
                  element.styleNumber.contains(searchValue.toUpperCase()))
              .toList();
          isLoadingSearch = false;
          // asdasdadadadada('DC SEARCH');
        });
      });
    } catch (err) {
      dataSelect(
          context: context,
          titleText: 'Alert!',
          buttonText: 'Okay',
          contentText: err.toString(),
          onPressed: () {
            Navigator.pop(context);
          },
          gif: "assets/images/alert.gif");
    } finally {
      setState(() {
        isLoadingSearch = false;
      });
    }

    // asdasdadadadada(suggestion);
    // setState(() {

    // });
  }

  final scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    prevage = Provider.of<Pagination>(context, listen: true).comm.toDouble();
    ScreenUtil.init(context,
        width: 411.42857142857144,
        height: 774.8571428571429,
        allowFontScaling: true);
    List<String> info = [];
    _defaultChoiceIndex1 =
        Provider.of<Options>(context, listen: false).build == null
            ? 0
            : Provider.of<Options>(context, listen: false).build;
    _defaultChoiceIndex2 =
        Provider.of<Options>(context, listen: false).color == null
            ? 0
            : Provider.of<Options>(context, listen: false).color;
    _defaultChoiceIndex3 =
        Provider.of<Options>(context, listen: false).certificate == null
            ? 0
            : Provider.of<Options>(context, listen: false).certificate;
    _defaultChoiceIndex4 =
        Provider.of<Options>(context, listen: false).diamondQuality == null
            ? 0
            : Provider.of<Options>(context, listen: false).diamondQuality;
    return Scaffold(
      key: scaffoldKey,
      resizeToAvoidBottomInset: false,
      resizeToAvoidBottomPadding: false,
      body: isloading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              color: Color(0xFFF4F4F4),
              child: Stack(
                children: <Widget>[
                  Container(
                    height: ScreenUtil().setHeight(775),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                          height: ScreenUtil().setHeight(22 + 11 + 20 + 40),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(24, 15, 25, 0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ShaderMask(
                                shaderCallback: (bounds) => LinearGradient(
                                  colors: [
                                    Color(0xFF34B0D9),
                                    Color(0xFF3685CB),
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ).createShader(
                                  Rect.fromLTWH(
                                      0, 0, bounds.width, bounds.height),
                                ),
                                child: Text(
                                  'PRICES',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Gilroy Bold',
                                    fontSize: ScreenUtil()
                                        .setSp(20, allowFontScalingSelf: true),
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    "Gold Rate: ",
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontFamily: 'Gilroy Medium',
                                      fontSize: ScreenUtil().setSp(20,
                                          allowFontScalingSelf: true),
                                    ),
                                  ),
                                  SizedBox(
                                    width: ScreenUtil().setWidth(5),
                                  ),
                                  ShaderMask(
                                    shaderCallback: (bounds) => LinearGradient(
                                      colors: [
                                        Color(0xFFF4C53B),
                                        Color(0xFFF4C53B),
                                        // Color(0xFFB97012),
                                      ],
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight,
                                    ).createShader(
                                      Rect.fromLTWH(
                                          0, 0, bounds.width, bounds.height),
                                    ),
                                    child: Text(
                                      Provider.of<Pagination>(context,
                                                  listen: true)
                                              .goldPrice
                                              .toString() +
                                          ' ₹',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'Gilroy Bold',
                                        fontSize: ScreenUtil().setSp(20,
                                            allowFontScalingSelf: true),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: ScreenUtil().setHeight(27),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            SizedBox(
                              width: ScreenUtil().setWidth(43),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'Labour: ',
                                  style: TextStyle(
                                    fontFamily: 'Gilroy Medium',
                                    color: Colors.black,
                                    fontSize: ScreenUtil()
                                        .setSp(18, allowFontScalingSelf: true),
                                  ),
                                ),
                                SizedBox(
                                  height: ScreenUtil().setHeight(12),
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 9.0),
                                  width: ScreenUtil().setWidth(290),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                        width: ScreenUtil().setWidth(150),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Container(
                                              width: ScreenUtil().setWidth(140),
                                              child: ListView.builder(
                                                physics:
                                                    NeverScrollableScrollPhysics(),
                                                itemCount:
                                                    Provider.of<UserInfo>(
                                                            context,
                                                            listen: false)
                                                        .buildPrices
                                                        .length,
                                                shrinkWrap: true,
                                                scrollDirection: Axis.vertical,
                                                itemBuilder: (context, index) {
                                                  return Container(
                                                    margin: EdgeInsets.only(
                                                        bottom: 5.0),
                                                    child: Text(
                                                      Provider.of<UserInfo>(
                                                              context,
                                                              listen: false)
                                                          .buildPrices
                                                          .keys
                                                          .toList()[index]
                                                          .toString()
                                                          .toUpperCase(),
                                                      style: TextStyle(
                                                        fontFamily:
                                                            'Gilroy Light',
                                                        color: Colors.black,
                                                        fontSize: ScreenUtil()
                                                            .setSp(14,
                                                                allowFontScalingSelf:
                                                                    true),
                                                      ),
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Container(
                                            width: ScreenUtil().setWidth(140),
                                            child: ListView.builder(
                                              physics:
                                                  NeverScrollableScrollPhysics(),
                                              itemCount: Provider.of<UserInfo>(
                                                      context,
                                                      listen: false)
                                                  .buildPrices
                                                  .length,
                                              shrinkWrap: true,
                                              scrollDirection: Axis.vertical,
                                              itemBuilder: (context, index) {
                                                return Container(
                                                  margin: EdgeInsets.only(
                                                      bottom: 5.0),
                                                  child: Text(
                                                    Provider.of<UserInfo>(
                                                                context,
                                                                listen: false)
                                                            .buildPrices
                                                            .values
                                                            .toList()[index]
                                                            .toString()
                                                            .toUpperCase() +
                                                        ' ₹',
                                                    style: TextStyle(
                                                      fontFamily:
                                                          'Gilroy Light',
                                                      color: Colors.black,
                                                      fontSize: ScreenUtil().setSp(
                                                          14,
                                                          allowFontScalingSelf:
                                                              true),
                                                    ),
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: ScreenUtil().setHeight(21),
                                ),
                                Text(
                                  'Diamond Quality: ',
                                  style: TextStyle(
                                    fontFamily: 'Gilroy Medium',
                                    color: Colors.black,
                                    fontSize: ScreenUtil()
                                        .setSp(18, allowFontScalingSelf: true),
                                  ),
                                ),
                                SizedBox(
                                  height: ScreenUtil().setHeight(12),
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 9.0),
                                  width: ScreenUtil().setWidth(290),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                        width: ScreenUtil().setWidth(150),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Container(
                                              width: ScreenUtil().setWidth(140),
                                              child: ListView.builder(
                                                physics:
                                                    NeverScrollableScrollPhysics(),
                                                itemCount:
                                                    Provider.of<UserInfo>(
                                                            context,
                                                            listen: false)
                                                        .diamondPrices
                                                        .length,
                                                shrinkWrap: true,
                                                scrollDirection: Axis.vertical,
                                                itemBuilder: (context, index) {
                                                  return Container(
                                                    margin: EdgeInsets.only(
                                                        bottom: 5.0),
                                                    child: Text(
                                                      Provider.of<UserInfo>(
                                                              context,
                                                              listen: false)
                                                          .diamondPrices
                                                          .keys
                                                          .toList()[index]
                                                          .toString()
                                                          .toUpperCase(),
                                                      style: TextStyle(
                                                        fontFamily:
                                                            'Gilroy Light',
                                                        color: Colors.black,
                                                        fontSize: ScreenUtil()
                                                            .setSp(14,
                                                                allowFontScalingSelf:
                                                                    true),
                                                      ),
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Container(
                                            width: ScreenUtil().setWidth(140),
                                            child: ListView.builder(
                                              physics:
                                                  NeverScrollableScrollPhysics(),
                                              itemCount: Provider.of<UserInfo>(
                                                      context,
                                                      listen: false)
                                                  .diamondPrices
                                                  .length,
                                              shrinkWrap: true,
                                              scrollDirection: Axis.vertical,
                                              itemBuilder: (context, index) {
                                                return Container(
                                                  margin: EdgeInsets.only(
                                                      bottom: 5.0),
                                                  child: Text(
                                                    Provider.of<UserInfo>(
                                                                context,
                                                                listen: false)
                                                            .diamondPrices
                                                            .values
                                                            .toList()[index]
                                                            .toString()
                                                            .toUpperCase() +
                                                        ' ₹',
                                                    style: TextStyle(
                                                      fontFamily:
                                                          'Gilroy Light',
                                                      color: Colors.black,
                                                      fontSize: ScreenUtil().setSp(
                                                          14,
                                                          allowFontScalingSelf:
                                                              true),
                                                    ),
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: ScreenUtil().setHeight(21),
                                ),
                                Text(
                                  'Certification: ',
                                  style: TextStyle(
                                    fontFamily: 'Gilroy Medium',
                                    color: Colors.black,
                                    fontSize: ScreenUtil()
                                        .setSp(18, allowFontScalingSelf: true),
                                  ),
                                ),
                                SizedBox(
                                  height: ScreenUtil().setHeight(12),
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 9.0),
                                  width: ScreenUtil().setWidth(290),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                        width: ScreenUtil().setWidth(150),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Container(
                                              width: ScreenUtil().setWidth(140),
                                              child: ListView.builder(
                                                physics:
                                                    NeverScrollableScrollPhysics(),
                                                itemCount:
                                                    Provider.of<UserInfo>(
                                                            context,
                                                            listen: false)
                                                        .certPrices
                                                        .length,
                                                shrinkWrap: true,
                                                scrollDirection: Axis.vertical,
                                                itemBuilder: (context, index) {
                                                  if (Provider.of<UserInfo>(
                                                              context,
                                                              listen: false)
                                                          .certPrices
                                                          .keys
                                                          .toList()[index]
                                                          .toString()
                                                          .toUpperCase() ==
                                                      'NONE') {
                                                    return Container(
                                                      height: 0,
                                                    );
                                                  } else {
                                                    return Container(
                                                      margin: EdgeInsets.only(
                                                          bottom: 5.0),
                                                      child: Text(
                                                        Provider.of<UserInfo>(
                                                                context,
                                                                listen: false)
                                                            .certPrices
                                                            .keys
                                                            .toList()[index]
                                                            .toString()
                                                            .toUpperCase(),
                                                        style: TextStyle(
                                                          fontFamily:
                                                              'Gilroy Light',
                                                          color: Colors.black,
                                                          fontSize: ScreenUtil()
                                                              .setSp(14,
                                                                  allowFontScalingSelf:
                                                                      true),
                                                        ),
                                                      ),
                                                    );
                                                  }
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Container(
                                            width: ScreenUtil().setWidth(140),
                                            child: ListView.builder(
                                              physics:
                                                  NeverScrollableScrollPhysics(),
                                              itemCount: Provider.of<UserInfo>(
                                                      context,
                                                      listen: false)
                                                  .certPrices
                                                  .length,
                                              shrinkWrap: true,
                                              scrollDirection: Axis.vertical,
                                              itemBuilder: (context, index) {
                                                if (Provider.of<UserInfo>(
                                                            context,
                                                            listen: false)
                                                        .certPrices
                                                        .keys
                                                        .toList()[index]
                                                        .toString()
                                                        .toUpperCase() ==
                                                    'NONE') {
                                                  return Container(
                                                    height: 0,
                                                  );
                                                } else {
                                                  return Container(
                                                    margin: EdgeInsets.only(
                                                        bottom: 5.0),
                                                    child: Text(
                                                      Provider.of<UserInfo>(
                                                                  context,
                                                                  listen: false)
                                                              .certPrices
                                                              .values
                                                              .toList()[index]
                                                              .toString()
                                                              .toUpperCase() +
                                                          ' ₹',
                                                      style: TextStyle(
                                                        fontFamily:
                                                            'Gilroy Light',
                                                        color: Colors.black,
                                                        fontSize: ScreenUtil()
                                                            .setSp(14,
                                                                allowFontScalingSelf:
                                                                    true),
                                                      ),
                                                    ),
                                                  );
                                                }
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Provider.of<Pagination>(context, listen: false)
                                        .isPriced
                                    ? SizedBox(
                                        height: ScreenUtil().setHeight(21),
                                      )
                                    : SizedBox(
                                        height: ScreenUtil().setHeight(57),
                                      ),
                                Provider.of<Pagination>(context, listen: false)
                                        .isPriced
                                    ? Text(
                                        'Commission: ',
                                        style: TextStyle(
                                          fontFamily: 'Gilroy',
                                          fontSize: ScreenUtil().setSp(17,
                                              allowFontScalingSelf: true),
                                        ),
                                      )
                                    : SizedBox(
                                        height: 0.0,
                                      ),
                                Provider.of<Pagination>(context, listen: false)
                                        .isPriced
                                    ? Center(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Container(
                                              margin: EdgeInsets.symmetric(
                                                  vertical: 10),
                                              width: ScreenUtil().setWidth(300),
                                              decoration: BoxDecoration(
                                                color: Colors.transparent,
                                                borderRadius:
                                                    BorderRadius.circular(29),
                                              ),
                                              child: NeumorphicSlider(
                                                min: 0,
                                                max: 100,
                                                value: this.age,
                                                onChanged: (percent) {
                                                  setState(() {
                                                    age = percent;
                                                  });
                                                },
                                                onChangeEnd: (value) async {
                                                  // setState(() {
                                                  //   age = value;
                                                  // });
                                                  bool value2 = false;
                                                  await dataSelectConfirmMessage(
                                                    context: context,
                                                    titleText: 'Alert!',
                                                    contentText:
                                                        "Are you sure you want to change the Commission?",
                                                    gif:
                                                        'assets/images/commission.gif',
                                                  ).then((value) =>
                                                      value2 = value);
                                                  if (value2 != null &&
                                                      value2) {
                                                    try {
                                                      setState(() {
                                                        prevage = age;
                                                        age = value;
                                                      });
                                                      // dataSelect(
                                                      //     context: context,
                                                      //     titleText:
                                                      //         'Commission Changed Succesfully!',
                                                      //     buttonText: 'Okay',
                                                      //     contentText:
                                                      //         "Your commission has been changed successfully.",
                                                      //     onPressed: () {
                                                      //       Navigator.of(
                                                      //               context)
                                                      //           .pop();
                                                      //     },
                                                      //     gif:
                                                      //         "assets/images/success.gif");
                                                      await Provider.of<
                                                                  Pagination>(
                                                              context,
                                                              listen: false)
                                                          .setCom(
                                                              comm:
                                                                  value.toInt(),
                                                              context: context);
                                                      final futures = [
                                                        Provider.of<Pagination>(
                                                                context,
                                                                listen: false)
                                                            .getFav(context),
                                                      ];
                                                      try {
                                                        await Future.delayed(
                                                            Duration(
                                                                milliseconds:
                                                                    200),
                                                            () async {
                                                          await Provider
                                                                  .of<Pagination>(
                                                                      context,
                                                                      listen:
                                                                          false)
                                                              .getProducts(
                                                                  addition:
                                                                      false,
                                                                  page: 1,
                                                                  context:
                                                                      context,
                                                                  select:
                                                                      'featured',
                                                                  sortby: Provider.of<
                                                                              Pagination>(
                                                                          context,
                                                                          listen:
                                                                              false)
                                                                      .count,
                                                                  sort: Provider.of<
                                                                              Pagination>(
                                                                          context,
                                                                          listen:
                                                                              false)
                                                                      .sort);
                                                        });
                                                        await Future.delayed(
                                                            Duration(
                                                                milliseconds:
                                                                    200),
                                                            () async {
                                                          await Provider.of<
                                                                      Pagination>(
                                                                  context,
                                                                  listen: false)
                                                              .getProducts(
                                                                  addition:
                                                                      false,
                                                                  page: 1,
                                                                  context:
                                                                      context,
                                                                  select: 'all',
                                                                  sortby: Provider.of<
                                                                              Pagination>(
                                                                          context,
                                                                          listen:
                                                                              false)
                                                                      .count,
                                                                  sort: Provider.of<
                                                                              Pagination>(
                                                                          context,
                                                                          listen:
                                                                              false)
                                                                      .sort);
                                                        });
                                                        await Future.delayed(
                                                            Duration(
                                                                milliseconds:
                                                                    200),
                                                            () async {
                                                          await Provider
                                                                  .of<Pagination>(
                                                                      context,
                                                                      listen:
                                                                          false)
                                                              .getProducts(
                                                                  addition:
                                                                      false,
                                                                  page: 1,
                                                                  context:
                                                                      context,
                                                                  select:
                                                                      'isnew',
                                                                  sortby: Provider.of<
                                                                              Pagination>(
                                                                          context,
                                                                          listen:
                                                                              false)
                                                                      .count,
                                                                  sort: Provider.of<
                                                                              Pagination>(
                                                                          context,
                                                                          listen:
                                                                              false)
                                                                      .sort);
                                                        });
                                                        await Future.delayed(
                                                            Duration(
                                                                milliseconds:
                                                                    200),
                                                            () async {
                                                          await Provider
                                                                  .of<Pagination>(
                                                                      context,
                                                                      listen:
                                                                          false)
                                                              .getProducts(
                                                                  addition:
                                                                      false,
                                                                  page: 1,
                                                                  context:
                                                                      context,
                                                                  select:
                                                                      'navratna',
                                                                  sortby: Provider.of<
                                                                              Pagination>(
                                                                          context,
                                                                          listen:
                                                                              false)
                                                                      .count,
                                                                  sort: Provider.of<
                                                                              Pagination>(
                                                                          context,
                                                                          listen:
                                                                              false)
                                                                      .sort);
                                                        });
                                                        await Future.delayed(
                                                            Duration(
                                                                milliseconds:
                                                                    200),
                                                            () async {
                                                          await Provider
                                                                  .of<Pagination>(
                                                                      context,
                                                                      listen:
                                                                          false)
                                                              .getProducts(
                                                                  addition:
                                                                      false,
                                                                  page: 1,
                                                                  context:
                                                                      context,
                                                                  select:
                                                                      'fancyDiamond',
                                                                  sortby: Provider.of<
                                                                              Pagination>(
                                                                          context,
                                                                          listen:
                                                                              false)
                                                                      .count,
                                                                  sort: Provider.of<
                                                                              Pagination>(
                                                                          context,
                                                                          listen:
                                                                              false)
                                                                      .sort);
                                                        });
                                                      } catch (err) {
                                                        // dataSelect(
                                                        //     context: context,
                                                        //     titleText: 'Alert!',
                                                        //     buttonText: 'Okay',
                                                        //     contentText:
                                                        //         err.toString(),
                                                        //     onPressed: () {
                                                        //       Navigator.pop(
                                                        //           context);
                                                        //     },
                                                        //     gif:
                                                        //         "assets/images/alert.gif");
                                                      }
                                                      await Future.wait(
                                                          futures);
                                                      dataSelect(
                                                          context: context,
                                                          titleText:
                                                              'Commission Changed!',
                                                          buttonText: 'Okay',
                                                          contentText:
                                                              "Your commission has been changed successfully.",
                                                          onPressed: () {
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                          },
                                                          gif:
                                                              "assets/images/success.gif");
                                                    } catch (err) {
                                                      dataSelect(
                                                          context: context,
                                                          titleText: 'Alert!',
                                                          buttonText: 'Okay',
                                                          contentText:
                                                              err.toString(),
                                                          onPressed: () {
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          gif:
                                                              "assets/images/alert.gif");
                                                    }
                                                  } else {
                                                    if (value2 == null ||
                                                        !value2)
                                                      setState(() {
                                                        age = prevage;
                                                      });
                                                  }
                                                },
                                                style: SliderStyle(
                                                  accent: Color(0xFF34B0D9),
                                                  variant: Color(0xFF3685CB),
                                                ),
                                                // thumb: Text('$age'),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.all(10.0),
                                              child: Text(
                                                "${age.floor()} %",
                                                style: TextStyle(
                                                    fontSize: ScreenUtil().setSp(
                                                        17,
                                                        allowFontScalingSelf:
                                                            true),
                                                    color: kPrimaryColor,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    : Center(
                                        child: Material(
                                          type: MaterialType.transparency,
                                          elevation: 6.0,
                                          color: Colors.transparent,
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          child: InkWell(
                                            splashColor: Colors.cyan[50],
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            onTap: () {},
                                            child: Container(
                                              width: ScreenUtil().setWidth(250),
                                              height: ScreenUtil().setWidth(43),
                                              // padding: EdgeInsets.all(20.0),
                                              child: Center(
                                                child: Text(
                                                  'Request Prices',
                                                  style: TextStyle(
                                                    fontFamily: 'Gilroy Bold',
                                                    color: Colors.white,
                                                    fontSize: ScreenUtil().setSp(
                                                        18,
                                                        allowFontScalingSelf:
                                                            true),
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ),
                                              decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                image: AssetImage(
                                                    'assets/images/vector17.png'),
                                                fit: BoxFit.contain,
                                              )),
                                            ),
                                          ),
                                        ),
                                      ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: ScreenUtil().setHeight(10),
                        ),
                      ],
                    ),
                  ),
                  !searchSelected
                      ? SizedBox(
                          height: 0.0,
                          width: 0.0,
                        )
                      : Container(
                          height: ScreenUtil().setHeight(775),
                          width: ScreenUtil().setWidth(411),
                          color: Colors.transparent,
                          child: GestureDetector(
                            onTap: () {},
                            child: Container(
                              height: ScreenUtil().setHeight(775),
                              width: ScreenUtil().setWidth(411),
                            ),
                          ),
                        ),
                  Container(
                    width: ScreenUtil().setWidth(412),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(
                          sigmaX: searchSelected ? 5 : 0,
                          sigmaY: searchSelected ? 5 : 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(
                            height: ScreenUtil().setHeight(22),
                          ),
                          Container(
                            width: ScreenUtil().setWidth(360),
                            height: ScreenUtil().setHeight(45),
                            margin: EdgeInsets.fromLTRB(
                                26, 17, 0, searchSelected ? 0 : 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                AnimatedContainer(
                                  duration: Duration(milliseconds: 600),
                                  curve: Curves.easeInOut,
                                  padding: EdgeInsets.only(
                                      left: searchSelected ? 10.0 : 0.0),
                                  width: ScreenUtil()
                                      .setWidth(searchSelected ? 305 : 360),
                                  height: ScreenUtil().setHeight(45),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                    color: Colors.white,
                                  ),
                                  child: Stack(
                                    alignment: Alignment.centerRight,
                                    children: <Widget>[
                                      Positioned(
                                        top: 0.0,
                                        left: 0.0,
                                        child: Container(
                                          width: ScreenUtil().setWidth(
                                              searchSelected ? 305 : 360),
                                          height: ScreenUtil().setHeight(45),
                                          padding: EdgeInsets.only(bottom: 7.5),
                                          child: TextField(
                                            controller: textEditingController,
                                            onTap: () async {
                                              setState(() {
                                                searchSelected = true;
                                              });
                                              Timer(Duration(milliseconds: 700),
                                                  () {
                                                setState(() {
                                                  searchSelectedDoneButton =
                                                      true;
                                                });
                                              });
                                            },
                                            onChanged: (value) async {
                                              setState(() {
                                                // isLoadingSearch = true;
                                                searchValue =
                                                    value.toUpperCase();
                                              });
                                              // setState(() {

                                              //   // info=styleNumber[].split(value);
                                              // asdasdadadadada(styleNumber[1].split(searchValue));
                                              // });
                                              await getSearch(
                                                  searchValue.toUpperCase());
                                              // setState(() {
                                              //   isLoadingSearch = false;
                                              // });
                                              // getSearchResult(value.toUpperCase());
                                            },
                                            decoration: InputDecoration(
                                                // contentPadding: EdgeInsets.all(15.0),
                                                // suffixIcon: searchSelected
                                                //     ? GestureDetector(
                                                //         onTap: () {
                                                //           textEditingController.clear();
                                                //           setState(() {
                                                //             searchValue = "";
                                                //           });
                                                //         },
                                                //         child: Icon(Icons.clear),
                                                //       )
                                                //     : SizedBox(
                                                //         height: 0.0,
                                                //         width: 0.0,
                                                //       ),
                                                hintText: 'SEARCH GEMSTORY',
                                                hintStyle: TextStyle(
                                                  fontFamily: 'Gilroy Medium',
                                                  color: Color(0xFF595959),
                                                  fontSize: ScreenUtil().setSp(
                                                      14,
                                                      allowFontScalingSelf:
                                                          true),
                                                ),
                                                border: InputBorder.none,
                                                alignLabelWithHint: true),
                                            textAlign: searchSelected
                                                ? TextAlign.start
                                                : TextAlign.center,
                                            style: TextStyle(
                                                fontFamily: 'Gilroy Regular',
                                                fontSize: ScreenUtil().setSp(16,
                                                    allowFontScalingSelf:
                                                        true)),
                                          ),
                                        ),
                                      ),
                                      // Positioned(
                                      //   top: 10.0,
                                      //   left: 10.0,
                                      //   child: GestureDetector(
                                      //     onTap: () {
                                      //       Navigator.of(context).pop();
                                      //     },
                                      //     child: AnimatedContainer(
                                      //       // margin: EdgeInsets.only(left: 10.0),
                                      //       duration:
                                      //           Duration(milliseconds: 600),
                                      //       // margin: EdgeInsets.only(right: 6.0),
                                      //       height: ScreenUtil().setHeight(
                                      //           searchSelected ? 0 : 18),
                                      //       width: ScreenUtil().setWidth(
                                      //           searchSelected ? 0 : 19),
                                      //       child: Image.asset(
                                      //         'assets/images/backButton.png',
                                      //         color: Colors.black,
                                      //       ),
                                      //     ),
                                      //   ),
                                      // ),
                                      AnimatedContainer(
                                        duration: Duration(milliseconds: 600),
                                        margin: EdgeInsets.only(right: 6.0),
                                        height: ScreenUtil()
                                            .setHeight(searchSelected ? 27 : 0),
                                        width: ScreenUtil()
                                            .setWidth(searchSelected ? 27 : 0),
                                        child: GestureDetector(
                                          onTap: () {
                                            textEditingController.clear();
                                            setState(() {
                                              searchValue = "";
                                            });
                                          },
                                          child: Icon(
                                            Icons.clear,
                                            color: Colors.black,
                                            size: searchSelected ? 25 : 0,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                searchSelectedDoneButton
                                    ? SizedBox(
                                        width: ScreenUtil().setWidth(10),
                                      )
                                    : SizedBox(
                                        width: 0,
                                      ),
                                searchSelectedDoneButton
                                    ? Container(
                                        height: ScreenUtil().setHeight(22),
                                        width: ScreenUtil().setWidth(45),
                                        child: GestureDetector(
                                          onTap: () {
                                            FocusScopeNode currentFocus =
                                                FocusScope.of(context);
                                            currentFocus.unfocus();
                                            textEditingController.clear();
                                            setState(() {
                                              searchValue = "";
                                              searchSelected = false;
                                              searchSelectedDoneButton = false;
                                            });
                                          },
                                          child: Text(
                                            'Done',
                                            style: TextStyle(
                                              fontFamily: 'Gilroy Bold',
                                              color: searchSelected
                                                  ? Colors.black
                                                  : Colors.black,
                                              fontSize: ScreenUtil().setSp(16,
                                                  allowFontScalingSelf: true),
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      )
                                    : SizedBox(
                                        width: 0,
                                      ),
                              ],
                            ),
                          ),
                          !searchSelected
                              ? SizedBox(
                                  height: 0.0,
                                  width: 0.0,
                                )
                              : Divider(
                                  color: Colors.grey[300],
                                  endIndent: 70.0,
                                  indent: 70.0,
                                ),
                          searchValue.isEmpty
                              ? SizedBox(
                                  height: 0.0,
                                  width: 0.0,
                                )
                              : isLoadingSearch
                                  ? Center(
                                      child: CircularProgressIndicator(),
                                    )
                                  : Container(
                                      height: ScreenUtil().setHeight(600.0),
                                      width: ScreenUtil().setHeight(360),
                                      margin:
                                          EdgeInsets.fromLTRB(25, 0, 26, 20),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                      ),
                                      child: suggestion.length > 0
                                          ? ListView.builder(
                                              physics:
                                                  NeverScrollableScrollPhysics(),
                                              shrinkWrap: true,
                                              scrollDirection: Axis.vertical,
                                              itemCount: Provider.of<Searchh>(
                                                      context,
                                                      listen: false)
                                                  .searchResult
                                                  .length,
                                              itemBuilder: (context, index) {
                                                info = suggestion[index]
                                                    .styleNumber
                                                    .split(searchValue);
                                                // asdasdadadadada(info);
                                                return GestureDetector(
                                                  onTap: () async {
                                                    try {
                                                      await Provider.of<
                                                                  Pagination>(
                                                              context,
                                                              listen: false)
                                                          .getProductDetail(
                                                              context: context,
                                                              styleNumber:
                                                                  suggestion[
                                                                          index]
                                                                      .styleNumber);
                                                      FocusScopeNode
                                                          currentFocus =
                                                          FocusScope.of(
                                                              context);
                                                      currentFocus.unfocus();
                                                      textEditingController
                                                          .clear();
                                                      setState(() {
                                                        searchValue = "";
                                                        searchSelected = false;
                                                        searchSelectedDoneButton =
                                                            false;
                                                      });
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              ProductDetail(
                                                            colorKey: 'yellow',
                                                            diamondKey: Provider.of<
                                                                            Pagination>(
                                                                        context,
                                                                        listen:
                                                                            false)
                                                                    .diamondQuality[
                                                                _defaultChoiceIndex4],
                                                            certPrice: Provider.of<
                                                                            Pagination>(
                                                                        context,
                                                                        listen:
                                                                            false)
                                                                    .isPriced
                                                                ? Provider.of<
                                                                            Pagination>(
                                                                        context,
                                                                        listen:
                                                                            false)
                                                                    .certPrices[Provider.of<
                                                                            Pagination>(
                                                                        context,
                                                                        listen:
                                                                            false)
                                                                    .cert[_defaultChoiceIndex3]]
                                                                : null,
                                                            defaultIndex1:
                                                                _defaultChoiceIndex1,
                                                            defaultIndex2:
                                                                _defaultChoiceIndex2,
                                                            defaultIndex3:
                                                                _defaultChoiceIndex3,
                                                            defaultIndex4:
                                                                _defaultChoiceIndex4,
                                                            product: Provider.of<
                                                                        Pagination>(
                                                                    context,
                                                                    listen:
                                                                        false)
                                                                .productDetailsForSearch[0],
                                                            select: 'all',
                                                            valueChangeBuild:
                                                                _onValueChange,
                                                            valueChangeColor:
                                                                _onValueChangeColor,
                                                            valueChangeCerti:
                                                                _onValueChangeCerti,
                                                            valueChangeDQ:
                                                                _onValueChangeDQ,
                                                          ),
                                                        ),
                                                      );
                                                    } catch (err) {
                                                      dataSelect(
                                                          context: context,
                                                          titleText: 'Alert!',
                                                          buttonText: 'Okay',
                                                          contentText:
                                                              err.toString(),
                                                          onPressed: () {
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          gif:
                                                              "assets/images/alert.gif");
                                                    }
                                                  },
                                                  child: Container(
                                                    color: Colors.transparent,
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 20.0,
                                                            right: 20.0),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: <Widget>[
                                                        Container(
                                                          height: ScreenUtil()
                                                              .setHeight(90),
                                                          width: ScreenUtil()
                                                              .setWidth(90),
                                                          // color: Colors.amber,
                                                          child: Image(
                                                            // suggestion[index]
                                                            //     .image,
                                                            image:
                                                                CachedNetworkImageProvider(
                                                              suggestion[index]
                                                                  .image,
                                                            ),
                                                            fit: BoxFit.fill,
                                                          ),
                                                        ),
                                                        RichText(
                                                          text: TextSpan(
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontFamily:
                                                                  'Gilroy Medium',
                                                              fontSize: ScreenUtil()
                                                                  .setSp(21,
                                                                      allowFontScalingSelf:
                                                                          true),
                                                            ),
                                                            children: [
                                                              TextSpan(
                                                                text: info[0],
                                                                style:
                                                                    TextStyle(
                                                                  color: Colors
                                                                      .grey,
                                                                  // fontWeight: FontWeight.bold,
                                                                  fontFamily:
                                                                      'Gilroy Medium',
                                                                  fontSize: ScreenUtil().setSp(
                                                                      21,
                                                                      allowFontScalingSelf:
                                                                          true),
                                                                ),
                                                              ),
                                                              TextSpan(
                                                                text:
                                                                    searchValue,
                                                                style:
                                                                    TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontFamily:
                                                                      'Gilroy Medium',
                                                                  fontSize: ScreenUtil().setSp(
                                                                      21,
                                                                      allowFontScalingSelf:
                                                                          true),
                                                                ),
                                                              ),
                                                              TextSpan(
                                                                text: info[1],
                                                                style:
                                                                    TextStyle(
                                                                  color: Colors
                                                                      .grey,
                                                                  // fontWeight: FontWeight.bold,
                                                                  fontFamily:
                                                                      'Gilroy Medium',
                                                                  fontSize: ScreenUtil().setSp(
                                                                      21,
                                                                      allowFontScalingSelf:
                                                                          true),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              },
                                            )
                                          : Center(
                                              child: Text(
                                                'No Products Found',
                                              ),
                                            ),
                                    )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
