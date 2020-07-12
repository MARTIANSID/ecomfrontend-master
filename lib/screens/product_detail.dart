import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:Flutter/providers/options.dart';
import 'package:Flutter/providers/pagination.dart';
import 'package:Flutter/providers/search.dart';
import 'package:Flutter/providers/user.dart';
import 'package:Flutter/screens/photo_detail_screen.dart';
import 'package:Flutter/widgets/add_to_cart.dart';
import 'package:Flutter/widgets/optionsDialog.dart';
import 'package:Flutter/widgets/snackbar.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_networkimage/provider.dart';
import 'package:flutter_animator/flutter_animator.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import 'completeSignUp.dart';

class ProductDetail extends StatefulWidget {
  final colorKey;
  final diamondKey;
  final product;
  final certPrice;
  final defaultIndex1;
  final defaultIndex2;
  final defaultIndex3;
  final defaultIndex4;

  final valueChangeBuild;
  final valueChangeColor;
  final valueChangeCerti;
  final valueChangeDQ;
  final valueChangeBuild1;
  final valueChangeColor1;
  final valueChangeCerti1;
  final valueChangeDQ1;
  final select;

  const ProductDetail(
      {Key key,
      this.colorKey,
      this.diamondKey,
      this.product,
      this.certPrice,
      this.defaultIndex1,
      this.defaultIndex2,
      this.defaultIndex3,
      this.defaultIndex4,
      this.valueChangeBuild,
      this.valueChangeColor,
      this.valueChangeCerti,
      this.valueChangeDQ,
      this.valueChangeBuild1,
      this.valueChangeColor1,
      this.valueChangeCerti1,
      this.valueChangeDQ1,
      this.select})
      : super(key: key);

  @override
  _ProductDetailState createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  bool isColourSetRadial = false;
  bool isColourSetLinear = false;
  bool searchSelected = false;
  bool hideButton = false;
  String searchValue = "";

  TextEditingController textEditingController = TextEditingController();

  bool searchSelectedDoneButton = false;

  List<dynamic> suggestion;
  bool isLoadingSearch = false;
  GlobalKey globalKey = GlobalKey();

  int _defaultChoiceIndex1;
  int _defaultChoiceIndex2;
  int _defaultChoiceIndex3;
  int _defaultChoiceIndex4;

  int page = 0;

  Future<void> getSearch(query) async {
    try {
      setState(() {
        isLoadingSearch = true;
      });
      await Provider.of<Searchh>(context, listen: false)
          .getSearch(query: query.toUpperCase(), context: context)
          .then((value) {
        setState(() {
          suggestion = Provider.of<Searchh>(context, listen: false)
              .searchResult
              .where((element) =>
                  element.styleNumber.contains(searchValue.toUpperCase()))
              .toList();

          // print('DC SEARCH');
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
      isLoadingSearch = false;
    }

    // print(suggestion);
    // setState(() {

    // });
  }

  void _onValueChange(int value, [int index]) async {
    await Provider.of<Options>(context, listen: false).setBuild(build: value);
    setState(() {
      // await Provider.of<Options>(context, listen: false).setBuild(build: value);
      _defaultChoiceIndex1 = value;
      // print(value);
    });
  }

  void _onValueChangeColor(int value, [int index]) async {
    await Provider.of<Options>(context, listen: false).setColor(color: value);
    setState(() {
      _defaultChoiceIndex2 = value;
      // _stringIndex = _stringIndex == null ? 0 : _stringIndex + 1;
      // _characterCount = StepTween(begin: 0, end: 3)
      //     .animate(CurvedAnimation(parent: controller, curve: Curves.easeIn));
    });

    // setState(() {
    //   flag = 1;
    //   _defaultChoiceIndex2 = value;
    // });
  }

  void _onValueChangeCerti(int value, [int index]) async {
    await Provider.of<Options>(context, listen: false).setCert(cert: value);
    setState(() {
      _defaultChoiceIndex3 = value;
    });
  }

  void _onValueChangeDQ(int value, [int index]) async {
    await Provider.of<Options>(context, listen: false)
        .setDiamond(diamond: value);
    setState(() {
      _defaultChoiceIndex4 = value;
    });
  }

  Widget _buildDot(int index) {
    double selectedness = Curves.easeOut.transform(
      max(
        0.0,
        1.0 - ((page ?? 0) - index).abs(),
      ),
    );
    double zoom = 1.0 + (2.0 - 1.0) * selectedness;
    return new Container(
      width: ScreenUtil().setWidth(20),
      child: new Center(
        child: new Material(
          color: isColourSetLinear || (!isColourSetLinear && !isColourSetRadial)
              ? Colors.black
              : Colors.white,
          type: MaterialType.circle,
          child: new Container(
            width: 5.0 * zoom,
            height: 5.0 * zoom,
          ),
        ),
      ),
    );
  }

  void requestPrice() async {
    try {
      await Provider.of<Pagination>(context).requestPrice(context: context);
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
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
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

    ScreenUtil.init(
      context,
      allowFontScaling: true,
      width: 411.42857142857144,
      height: 774.8571428571429,
    );
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
    List<String> info = [];
    return Scaffold(
      key: globalKey,
      resizeToAvoidBottomInset: false,
      resizeToAvoidBottomPadding: false,
      body: GestureDetector(
        onPanStart: (details) {
          // print("object1");
          setState(() {
            hideButton = true;
          });
        },
        onPanEnd: (details) {
          // print("object2");
          Timer(
            Duration(seconds: 3),
            () => setState(
              () {
                hideButton = false;
              },
            ),
          );
        },
        child: Container(
          color: Colors.white,
          child: Stack(
            children: <Widget>[
              // Positioned(
              //   left: 0,
              //   bottom: 0,
              //   // top: 0,
              //   child: Stack(
              //     children: <Widget>[
              //       Opacity(
              //         opacity: 0.20,
              //         child: Container(
              //           decoration: BoxDecoration(
              //               gradient: LinearGradient(
              //             colors: [
              //               Color(0xFF0F1533),
              //               Color(0xFF5DB4D8),
              //             ],
              //             begin: Alignment.topCenter,
              //             end: Alignment.bottomCenter,
              //           )),
              //           height: ScreenUtil().setHeight(483),
              //           width: ScreenUtil().setWidth(65),
              //         ),
              //       ),
              //       Container(
              //         height: ScreenUtil().setHeight(483),
              //         width: ScreenUtil().setWidth(65),
              //         child: Column(
              //           mainAxisAlignment: MainAxisAlignment.end,
              //           crossAxisAlignment: CrossAxisAlignment.center,
              //           children: <Widget>[
              //             RotatedBox(
              //               quarterTurns: 1,
              //               child: Text(
              //                 'ADDITIONAL DETAILS',
              //                 style: TextStyle(
              //                   color: Colors.black,
              //                   fontFamily: 'Gilroy Light',
              //                   fontSize: ScreenUtil()
              //                       .setSp(18, allowFontScalingSelf: true),
              //                   letterSpacing: 0.035,
              //                 ),
              //               ),
              //             ),
              //             SizedBox(
              //               height: ScreenUtil().setHeight(135),
              //             ),
              //           ],
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Container(
                  width: ScreenUtil().setWidth(412),
                  height: ScreenUtil().setHeight(775),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        height: ScreenUtil().setHeight(440),
                        width: ScreenUtil().setWidth(412),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.elliptical(650, 300),
                            bottomRight: Radius.elliptical(650, 300),
                          ),
                          gradient: isColourSetLinear
                              ? LinearGradient(
                                  colors: [
                                    Color(0xFF34BDDD).withOpacity(0.1),
                                    Color(0xFF367DC8).withOpacity(0.1),
                                  ],
                                )
                              : isColourSetRadial
                                  ? RadialGradient(
                                      colors: [
                                        Color(0xFF2B3E50),
                                        Color(0xFF010101),
                                      ],
                                    )
                                  : LinearGradient(
                                      colors: [
                                        Colors.white,
                                        Colors.white,
                                      ],
                                    ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            SizedBox(
                              height: ScreenUtil().setHeight(22 + 17 + 28 + 40),
                            ),
                            widget.product.imageUrl.containsKey(widget.colorKey)
                                ? Container(
                                    height: ScreenUtil().setHeight(290),
                                    width: ScreenUtil().setWidth(286),
                                    child: PageView.builder(
                                      // allowImplicitScrolling: true,
                                      onPageChanged: (value) {
                                        setState(() {
                                          page = value;
                                        });
                                      },
                                      itemCount: Provider.of<Pagination>(
                                              context,
                                              listen: false)
                                          .color
                                          .length,
                                      itemBuilder: (context, index) {
                                        return Hero(
                                          tag: 'tag1',
                                          child: GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      PhotoDetailScreen(
                                                          Provider.of<Pagination>(
                                                                  context,
                                                                  listen: false)
                                                              .color[index]
                                                              .toLowerCase(),
                                                          widget.product),
                                                ),
                                              );
                                            },
                                            child: Image(
                                              height:
                                                  ScreenUtil().setHeight(290),
                                              width: ScreenUtil().setWidth(290),
                                              image: AdvancedNetworkImage(
                                                widget.product.imageUrl[
                                                    Provider.of<Pagination>(
                                                            context,
                                                            listen: false)
                                                        .color[index]
                                                        .toLowerCase()],
                                                useDiskCache: true,
                                                cacheRule: CacheRule(
                                                    maxAge: const Duration(
                                                        days: 3)),
                                              ),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  )
                                : Hero(
                                    tag: 'tag1',
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                PhotoDetailScreen(
                                                    widget.colorKey,
                                                    widget.product),
                                          ),
                                        );
                                      },
                                      child: Image(
                                        height: ScreenUtil().setHeight(290),
                                        width: ScreenUtil().setWidth(290),
                                        image: AdvancedNetworkImage(
                                          widget.product.imageUrl['yellow'],
                                          useDiskCache: true,
                                          cacheRule: CacheRule(
                                              maxAge: const Duration(days: 3)),
                                        ),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                            SizedBox(
                              height: ScreenUtil().setHeight(10),
                            ),
                            Container(
                              height: ScreenUtil().setHeight(20),
                              width: ScreenUtil().setWidth(100),
                              // padding: EdgeInsets.all(20),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: List<Widget>.generate(3, _buildDot),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: ScreenUtil().setHeight(17),
                      ),
                      Container(
                        width: ScreenUtil().setWidth(411),
                        // height: ScreenUtil().setHeight(300),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(
                              width: ScreenUtil().setWidth(54),
                            ),
                            Container(
                              width: ScreenUtil().setWidth(330),
                              // height: ScreenUtil().setHeight(300),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    width: ScreenUtil().setWidth(330),
                                    height: ScreenUtil().setHeight(44),
                                    // margin: EdgeInsets.only(bottom: 35.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Text(
                                          '${widget.product.styleNumber}',
                                          style: TextStyle(
                                            fontFamily: 'Gilroy Medium',
                                            fontSize: ScreenUtil().setSp(36,
                                                allowFontScalingSelf: true),
                                            color: Colors.black,
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: <Widget>[
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 6.0),
                                              child: GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    isColourSetLinear =
                                                        !isColourSetLinear;
                                                    isColourSetRadial = false;
                                                  });
                                                },
                                                child: Container(
                                                  height: ScreenUtil()
                                                      .setHeight(20),
                                                  width:
                                                      ScreenUtil().setWidth(20),
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    gradient: isColourSetLinear
                                                        ? LinearGradient(
                                                            colors: [
                                                              Color(0xFF34BDDD),
                                                              Color(0xFF367DC8),
                                                            ],
                                                          )
                                                        : LinearGradient(
                                                            colors: [
                                                              Color(0xFF858585),
                                                              Color(0xFF858585),
                                                            ],
                                                          ),
                                                  ),
                                                  child: Padding(
                                                    padding: EdgeInsets.all(
                                                        isColourSetLinear
                                                            ? 3.0
                                                            : 0.0),
                                                    child: Container(
                                                      // height: ScreenUtil()
                                                      //     .setHeight(16),
                                                      // width:
                                                      //     ScreenUtil().setWidth(16),
                                                      decoration: BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                          color:
                                                              Color(0xFFEAF2FA)
                                                          // gradient: LinearGradient(
                                                          //   colors: [
                                                          //     Color(0xFF34BDDD)
                                                          //         .withOpacity(0.1),
                                                          //     Color(0xFF367DC8)
                                                          //         .withOpacity(0.1),
                                                          //   ],
                                                          // ),
                                                          ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  isColourSetRadial =
                                                      !isColourSetRadial;
                                                  isColourSetLinear = false;
                                                });
                                              },
                                              child: Container(
                                                height:
                                                    ScreenUtil().setHeight(20),
                                                width:
                                                    ScreenUtil().setWidth(20),
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  gradient: isColourSetRadial
                                                      ? LinearGradient(
                                                          colors: [
                                                            Color(0xFF34BDDD),
                                                            Color(0xFF367DC8),
                                                          ],
                                                        )
                                                      : LinearGradient(
                                                          colors: [
                                                            Color(0xFF858585),
                                                            Color(0xFF858585),
                                                          ],
                                                        ),
                                                ),
                                                child: Padding(
                                                  padding: EdgeInsets.all(
                                                      isColourSetRadial
                                                          ? 3.0
                                                          : 0.0),
                                                  child: Container(
                                                    // height:
                                                    //     ScreenUtil().setHeight(16),
                                                    // width:
                                                    //     ScreenUtil().setWidth(16),
                                                    decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      // border: Border.all(
                                                      //   color: Color(0xFF858585),
                                                      //   width: 1.0,
                                                      // ),
                                                      gradient: RadialGradient(
                                                        colors: [
                                                          Color(0xFF2B3E50),
                                                          Color(0xFF010101),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: ScreenUtil().setHeight(15),
                                  ),
                                  Container(
                                    // width: ScreenUtil().setWidth(93),
                                    height: ScreenUtil().setHeight(35),
                                    margin: EdgeInsets.only(left: 9.0),
                                    child: ShaderMask(
                                      shaderCallback: (bounds) =>
                                          LinearGradient(
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
                                      // child: widget.product.prices.containsKey(
                                      //             widget.diamondKey) &&
                                      child: Provider.of<Pagination>(context,
                                                      listen: false)
                                                  .isPriced ==
                                              true
                                          ? Text(
                                              // '50000',
                                              '${int.parse(widget.product.prices[Provider.of<Pagination>(context, listen: false).diamondQuality[_defaultChoiceIndex4]]) + Provider.of<Pagination>(context, listen: false).certPrices[Provider.of<Pagination>(context, listen: false).cert[_defaultChoiceIndex3]] + Provider.of<Pagination>(context, listen: false).buildPrices[Provider.of<Pagination>(context, listen: false).build[_defaultChoiceIndex1]]} ₹',
                                              style: TextStyle(
                                                fontFamily: 'Gilroy Medium',
                                                color: Colors.white,
                                                fontSize: ScreenUtil().setSp(29,
                                                    allowFontScalingSelf: true),
                                                fontWeight: FontWeight.w500,
                                              ),
                                            )
                                          : Text(
                                              'No Prices Set',
                                              style: TextStyle(
                                                fontFamily: 'Gilroy Medium',
                                                color: Colors.white,
                                                fontSize: ScreenUtil().setSp(29,
                                                    allowFontScalingSelf: true),
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: ScreenUtil().setHeight(10),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(left: 9.0),
                                    width: ScreenUtil().setWidth(285),
                                    height: ScreenUtil().setHeight(97),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Container(
                                              margin:
                                                  EdgeInsets.only(bottom: 3.0),
                                              child: Text(
                                                'Gold Weight'.toUpperCase(),
                                                style: TextStyle(
                                                  fontFamily: 'Gilroy Light',
                                                  color: Colors.black,
                                                  fontSize: ScreenUtil().setSp(
                                                      14,
                                                      allowFontScalingSelf:
                                                          true),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              margin:
                                                  EdgeInsets.only(bottom: 3.0),
                                              child: Text(
                                                'Diamond Weight'.toUpperCase(),
                                                style: TextStyle(
                                                  fontFamily: 'Gilroy Light',
                                                  color: Colors.black,
                                                  fontSize: ScreenUtil().setSp(
                                                      14,
                                                      allowFontScalingSelf:
                                                          true),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              margin:
                                                  EdgeInsets.only(bottom: 3.0),
                                              child: Text(
                                                'Diamond Count'.toUpperCase(),
                                                style: TextStyle(
                                                  fontFamily: 'Gilroy Light',
                                                  color: Colors.black,
                                                  fontSize: ScreenUtil().setSp(
                                                      14,
                                                      allowFontScalingSelf:
                                                          true),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              child: Text(
                                                'DESIGN DIMENSIONS',
                                                style: TextStyle(
                                                  fontFamily: 'Gilroy Light',
                                                  color: Colors.black,
                                                  fontSize: ScreenUtil().setSp(
                                                      14,
                                                      allowFontScalingSelf:
                                                          true),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Container(
                                              margin:
                                                  EdgeInsets.only(bottom: 3.0),
                                              child: Text(
                                                '${widget.product.goldWeight}' +
                                                    ' gms',
                                                style: TextStyle(
                                                  fontFamily: 'Gilroy Light',
                                                  color: Colors.black,
                                                  fontSize: ScreenUtil().setSp(
                                                      14,
                                                      allowFontScalingSelf:
                                                          true),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              margin:
                                                  EdgeInsets.only(bottom: 3.0),
                                              child: Text(
                                                '${widget.product.diamondWeight}' +
                                                    ' ct',
                                                style: TextStyle(
                                                  fontFamily: 'Gilroy Light',
                                                  color: Colors.black,
                                                  fontSize: ScreenUtil().setSp(
                                                      14,
                                                      allowFontScalingSelf:
                                                          true),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              margin:
                                                  EdgeInsets.only(bottom: 3.0),
                                              child: Text(
                                                '${widget.product.diamondCount}' +
                                                    ' pieces',
                                                style: TextStyle(
                                                  fontFamily: 'Gilroy Light',
                                                  color: Colors.black,
                                                  fontSize: ScreenUtil().setSp(
                                                      14,
                                                      allowFontScalingSelf:
                                                          true),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              child: Text(
                                                '${widget.product.designDimensions}',
                                                style: TextStyle(
                                                  fontFamily: 'Gilroy Light',
                                                  color: Colors.black,
                                                  fontSize: ScreenUtil().setSp(
                                                      14,
                                                      allowFontScalingSelf:
                                                          true),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: ScreenUtil().setHeight(17),
                                  ),
                                  Container(
                                    height: ScreenUtil().setHeight(94),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        SizedBox(
                                          width: ScreenUtil().setWidth(15),
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: <Widget>[
                                            GestureDetector(
                                              onTap: () {
                                                !Provider.of<Pagination>(
                                                            context,
                                                            listen: false)
                                                        .isVerified
                                                    ? dataSelect(
                                                        context: context,
                                                        titleText: 'Important!',
                                                        contentText:
                                                            "To get complete access of the app, you need to first verify yourself!",
                                                        buttonText:
                                                            'Complete SignUp',
                                                        onPressed: () async {
                                                          Navigator.pop(
                                                              context);
                                                          String date =
                                                              await Provider.of<
                                                                          UserInfo>(
                                                                      context,
                                                                      listen:
                                                                          false)
                                                                  .getDate();
                                                          if (date != null) {
                                                            int d = DateTime
                                                                    .now()
                                                                .difference(
                                                                    DateTime
                                                                        .parse(
                                                                            date))
                                                                .inDays;
                                                            if (d >= 1) {
                                                              Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          CompleteSignUp(),
                                                                ),
                                                              );
                                                            } else {
                                                              dataSelect(
                                                                  context:
                                                                      context,
                                                                  titleText:
                                                                      'Alert!',
                                                                  contentText:
                                                                      'Request has already been noted!',
                                                                  buttonText:
                                                                      'Okay',
                                                                  gif:
                                                                      "assets/images/alert.gif",
                                                                  onPressed:
                                                                      () {
                                                                    Navigator.pop(
                                                                        context);
                                                                  });
                                                            }
                                                          } else {
                                                            Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        CompleteSignUp(),
                                                              ),
                                                            );
                                                          }
                                                        },
                                                        gif:
                                                            "assets/images/alert.gif")
                                                    : showDialog(
                                                        context: context,
                                                        child: AddToCart(
                                                          globalKey: globalKey,
                                                          product:
                                                              widget.product,
                                                          updateCart: false,
                                                          choicesBuild:
                                                              Provider.of<Pagination>(
                                                                      context,
                                                                      listen:
                                                                          false)
                                                                  .build,
                                                          choiceColor: Provider
                                                                  .of<Pagination>(
                                                                      context,
                                                                      listen:
                                                                          false)
                                                              .color,
                                                          choiceCertification:
                                                              Provider.of<Pagination>(
                                                                      context,
                                                                      listen:
                                                                          false)
                                                                  .cert,
                                                          choiceDiamondQuality:
                                                              Provider.of<Pagination>(
                                                                      context,
                                                                      listen:
                                                                          false)
                                                                  .diamondQuality,
                                                          defValue:
                                                              _defaultChoiceIndex1,
                                                          defValue1:
                                                              _defaultChoiceIndex2,
                                                          defValue2:
                                                              _defaultChoiceIndex3,
                                                          defValue3:
                                                              _defaultChoiceIndex4,
                                                          valueChangeBuild: widget
                                                              .valueChangeBuild,
                                                          valueChangeColor: widget
                                                              .valueChangeColor,
                                                          valueChangeCerti: widget
                                                              .valueChangeCerti,
                                                          valueChangeDQ: widget
                                                              .valueChangeDQ,
                                                        ),
                                                      );
                                              },
                                              child: Container(
                                                width:
                                                    ScreenUtil().setWidth(270),
                                                height:
                                                    ScreenUtil().setWidth(40),
                                                // padding: EdgeInsets.all(20.0),
                                                child: Center(
                                                  child: Text(
                                                    'ADD TO CART',
                                                    style: TextStyle(
                                                      fontFamily: 'Gilroy Bold',
                                                      color: Colors.white,
                                                      fontSize: ScreenUtil().setSp(
                                                          18,
                                                          allowFontScalingSelf:
                                                              true),
                                                      fontWeight:
                                                          FontWeight.w500,
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
                                            SizedBox(
                                              height:
                                                  ScreenUtil().setHeight(15),
                                            ),
                                            Container(
                                              width: ScreenUtil().setWidth(239),
                                              height:
                                                  ScreenUtil().setHeight(30),
                                              child: RichText(
                                                text: TextSpan(
                                                  style: TextStyle(
                                                    fontFamily: 'Gilroy Medium',
                                                    fontSize: ScreenUtil().setSp(
                                                        12,
                                                        allowFontScalingSelf:
                                                            true),
                                                    color: Color(0xFF8C8888),
                                                  ),
                                                  children: [
                                                    TextSpan(
                                                      text:
                                                          'To know more about this design or contact Team Gemstory, ',
                                                    ),
                                                    TextSpan(
                                                        text: 'Click here',
                                                        recognizer:
                                                            TapGestureRecognizer()
                                                              ..onTap =
                                                                  () async {
                                                                bool value2 =
                                                                    false;
                                                                await dataSelectConfirmMessage(
                                                                  context: globalKey
                                                                      .currentContext,
                                                                  titleText:
                                                                      'Alert!',
                                                                  contentText:
                                                                      "Are you sure, You want to open Whatsapp?",
                                                                  gif:
                                                                      'assets/images/whatsappGIF.gif',
                                                                ).then(
                                                                    (value) async {
                                                                  if (value) {
                                                                    value2 =
                                                                        value;
                                                                  }
                                                                });
                                                                if (value2) {
                                                                  if (await canLaunch(
                                                                      "https://wa.me/919322244007")) {
                                                                    await launch(
                                                                        "https://wa.me/919322244007");
                                                                  } else {
                                                                    throw 'Could not launch https://wa.me/919322244007';
                                                                  }
                                                                }
                                                              },
                                                        style: TextStyle(
                                                          decoration:
                                                              TextDecoration
                                                                  .underline,
                                                        )),
                                                  ],
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Positioned(
                top: ScreenUtil().setHeight(92 + 22),
                left: ScreenUtil().setWidth(30),
                child: hideButton
                    ? GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            child: OptionsDialog(
                              choicesBuild: Provider.of<Pagination>(context,
                                      listen: false)
                                  .build,
                              choiceColor: Provider.of<Pagination>(context,
                                      listen: false)
                                  .color,
                              choiceCertification: Provider.of<Pagination>(
                                      context,
                                      listen: false)
                                  .cert,
                              choiceDiamondQuality: Provider.of<Pagination>(
                                      context,
                                      listen: false)
                                  .diamondQuality,
                              defValue: _defaultChoiceIndex1,
                              defValue1: _defaultChoiceIndex2,
                              defValue2: _defaultChoiceIndex3,
                              defValue3: _defaultChoiceIndex4,
                              valueChangeBuild: _onValueChange,
                              valueChangeColor: _onValueChangeColor,
                              valueChangeCerti: _onValueChangeCerti,
                              valueChangeDQ: _onValueChangeDQ,
                            ),
                          );
                        },
                        child: SvgPicture.asset(
                          'assets/icons/optionsIcon.svg',
                          width: ScreenUtil().setWidth(29),
                          height: ScreenUtil().setHeight(29),
                          color: isColourSetLinear ||
                                  (!isColourSetLinear && !isColourSetRadial)
                              ? Color(0xFFB8B8B8)
                              : Colors.white,
                        ),
                      )
                    : FadeOut(
                        child: SvgPicture.asset(
                          'assets/icons/optionsIcon.svg',
                          width: ScreenUtil().setWidth(29),
                          height: ScreenUtil().setHeight(29),
                          color: isColourSetLinear ||
                                  (!isColourSetLinear && !isColourSetRadial)
                              ? Color(0xFFB8B8B8)
                              : Colors.white,
                        ),
                      ),
              ),
              Positioned(
                top: ScreenUtil().setHeight(92 + 22),
                right: ScreenUtil().setWidth(26),
                child: hideButton
                    ? GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PhotoDetailScreen(
                                  widget.colorKey, widget.product),
                            ),
                          );
                        },
                        child: SvgPicture.asset(
                          'assets/icons/zoomIcon.svg',
                          width: ScreenUtil().setWidth(29),
                          height: ScreenUtil().setHeight(29),
                          color: isColourSetLinear ||
                                  (!isColourSetLinear && !isColourSetRadial)
                              ? Color(0xFFB8B8B8)
                              : Colors.white,
                        ),
                      )
                    : FadeOut(
                        child: SvgPicture.asset(
                          'assets/icons/zoomIcon.svg',
                          width: ScreenUtil().setWidth(29),
                          height: ScreenUtil().setHeight(29),
                          color: isColourSetLinear ||
                                  (!isColourSetLinear && !isColourSetRadial)
                              ? Color(0xFFB8B8B8)
                              : Colors.white,
                        ),
                      ),
              ),
              Positioned(
                top: ScreenUtil().setHeight(383),
                right: ScreenUtil().setWidth(26),
                child: Container(
                  height: ScreenUtil().setHeight(43),
                  width: ScreenUtil().setWidth(43),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color(0xFF34B0D9),
                        Color(0xFF3685CB),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: GestureDetector(
                      child: Icon(
                        widget.product.isFavourite
                            ? Icons.favorite
                            : Icons.favorite_border,
                        size:
                            ScreenUtil().setSp(30, allowFontScalingSelf: true),
                        color: Colors.white,
                      ),
                      onTap: () async {
                        try {
                          if (mounted) setState(() {});
                          if (widget.product.isFavourite) {
                            await Provider.of<Pagination>(context,
                                    listen: false)
                                .toogleFavourite(
                                    styleNumber: widget.product.styleNumber,
                                    context: context);
                          } else {
                            await Provider.of<Pagination>(context,
                                    listen: false)
                                .toogleFavourite(
                                    styleNumber: widget.product.styleNumber,
                                    context: context,
                                    product: widget.product);
                          }
                          if (mounted) setState(() {});
                        } catch (err) {
                          if (mounted) setState(() {});
                        }
                        // child: Icon(
                        //   widget.product.isFavourite
                        //       ? Icons.favorite
                        //       : Icons.favorite_border,
                        //   size: 30.0,
                        //   color: Colors.white,
                        // ),
                      }),
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
                            26, 11, 0, searchSelected ? 0 : 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            AnimatedContainer(
                              duration: Duration(milliseconds: 600),
                              curve: Curves.easeInOut,
                              padding: EdgeInsets.only(left: 10.0),
                              width: ScreenUtil()
                                  .setWidth(searchSelected ? 305 : 360),
                              height: ScreenUtil().setHeight(45),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                color: isColourSetLinear || isColourSetRadial
                                    ? Colors.white
                                    : Color(0xFFF4F4F4),
                              ),
                              child: Stack(
                                alignment: Alignment.centerRight,
                                children: <Widget>[
                                  AnimatedContainer(
                                    duration: Duration(milliseconds: 600),
                                    width: ScreenUtil()
                                        .setWidth(searchSelected ? 305 : 360),
                                    height: ScreenUtil().setHeight(40),
                                    padding: EdgeInsets.only(bottom: 2),
                                    child: TextField(
                                      controller: textEditingController,
                                      onTap: () async {
                                        setState(() {
                                          searchSelected = true;
                                        });
                                        Timer(Duration(milliseconds: 700), () {
                                          setState(() {
                                            searchSelectedDoneButton = true;
                                          });
                                        });
                                      },
                                      onChanged: (value) async {
                                        setState(() {
                                          // isLoadingSearch = true;
                                          searchValue = value.toUpperCase();
                                        });
                                        // setState(() {

                                        //   // info=styleNumber[].split(value);
                                        // print(styleNumber[1].split(searchValue));
                                        // });
                                        try {
                                          await getSearch(
                                              searchValue.toUpperCase());
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
                                        }
                                        // await getSearch(
                                        //     searchValue.toUpperCase());
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
                                          fontSize: ScreenUtil().setSp(14,
                                              allowFontScalingSelf: true),
                                        ),
                                        border: InputBorder.none,
                                      ),
                                      textAlign: searchSelected
                                          ? TextAlign.start
                                          : TextAlign.center,
                                      style: TextStyle(
                                          fontFamily: 'Gilroy Regular',
                                          fontSize: ScreenUtil().setSp(16,
                                              allowFontScalingSelf: true)),
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
                                  //       duration: Duration(milliseconds: 600),
                                  //       // margin: EdgeInsets.only(right: 6.0),
                                  //       height: ScreenUtil()
                                  //           .setHeight(searchSelected ? 0 : 18),
                                  //       width: ScreenUtil()
                                  //           .setWidth(searchSelected ? 0 : 19),
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
                                        size: searchSelected
                                            ? ScreenUtil().setSp(25,
                                                allowFontScalingSelf: true)
                                            : 0,
                                      ),
                                    ),
                                  ),
                                  AnimatedContainer(
                                    duration: Duration(milliseconds: 600),
                                    margin: EdgeInsets.only(right: 6.0),
                                    height: ScreenUtil()
                                        .setHeight(searchSelected ? 0 : 25),
                                    width: ScreenUtil()
                                        .setWidth(searchSelected ? 0 : 25),
                                    child: SvgPicture.asset(
                                      'assets/icons/notificationIcon.svg',
                                      color: Colors.black,
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
                                              ? isColourSetLinear ||
                                                      (!isColourSetLinear &&
                                                          !isColourSetRadial)
                                                  ? Colors.black
                                                  : Colors.white
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
                                  margin: EdgeInsets.fromLTRB(25, 0, 26, 20),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  child: suggestion.length > 0
                                      ? ListView.builder(
                                          shrinkWrap: true,
                                          scrollDirection: Axis.vertical,
                                          physics: BouncingScrollPhysics(),
                                          itemCount: Provider.of<Searchh>(
                                                  context,
                                                  listen: false)
                                              .searchResult
                                              .length,
                                          itemBuilder: (context, index) {
                                            info = suggestion[index]
                                                .styleNumber
                                                .split(searchValue);
                                            // print(info);
                                            return GestureDetector(
                                              onTap: () async {
                                                try {
                                                  await Provider.of<Pagination>(
                                                          context,
                                                          listen: false)
                                                      .getProductDetail(
                                                          context: context,
                                                          styleNumber:
                                                              suggestion[index]
                                                                  .styleNumber);
                                                  FocusScopeNode currentFocus =
                                                      FocusScope.of(context);
                                                  currentFocus.unfocus();
                                                  textEditingController.clear();
                                                  setState(() {
                                                    searchValue = "";
                                                    searchSelected = false;
                                                    searchSelectedDoneButton =
                                                        false;
                                                  });
                                                  // print(Provider.of<Pagination>(
                                                  //         context,
                                                  //         listen: false)
                                                  //     .diamondQuality[widget
                                                  //         .defaultIndex4]
                                                  //     .toString() +
                                                  // "DC");
                                                  // print(Provider.of<Pagination>(
                                                  //         context,
                                                  //         listen: false)
                                                  //     .certPrices[Provider
                                                  //             .of<Pagination>(
                                                  //                 context,
                                                  //                 listen:
                                                  //                     false)
                                                  //         .cert[widget.defaultIndex3]]
                                                  //     .toString() +
                                                  // "DC");
                                                  // print(widget.defaultIndex1
                                                  //     .toString() +
                                                  // "DC");
                                                  // print(widget.defaultIndex2
                                                  //     .toString() +
                                                  // "DC");
                                                  // print(widget.defaultIndex3
                                                  //     .toString() +
                                                  // "DC");
                                                  // print(widget.defaultIndex4
                                                  //     .toString() +
                                                  // "DC");
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          ProductDetail(
                                                        select: 'all',
                                                        colorKey: 'yellow',
                                                        diamondKey: Provider.of<
                                                                        Pagination>(
                                                                    context,
                                                                    listen: false)
                                                                .diamondQuality[
                                                            widget
                                                                .defaultIndex4],
                                                        certPrice: Provider.of<
                                                                    Pagination>(
                                                                context,
                                                                listen: false)
                                                            .certPrices[Provider
                                                                    .of<Pagination>(
                                                                        context,
                                                                        listen:
                                                                            false)
                                                                .cert[
                                                            widget
                                                                .defaultIndex3]],
                                                        product: Provider.of<
                                                                    Pagination>(
                                                                context,
                                                                listen: false)
                                                            .productDetailsForSearch[0],
                                                        defaultIndex1: widget
                                                            .defaultIndex1,
                                                        defaultIndex2: widget
                                                            .defaultIndex2,
                                                        defaultIndex3: widget
                                                            .defaultIndex3,
                                                        defaultIndex4: widget
                                                            .defaultIndex4,
                                                        valueChangeBuild: widget
                                                            .valueChangeBuild,
                                                        valueChangeColor: widget
                                                            .valueChangeColor,
                                                        valueChangeCerti: widget
                                                            .valueChangeCerti,
                                                        valueChangeDQ: widget
                                                            .valueChangeDQ,
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
                                                        Navigator.pop(context);
                                                      },
                                                      gif:
                                                          "assets/images/alert.gif");
                                                }
                                              },
                                              child: Container(
                                                color: Colors.transparent,
                                                padding: const EdgeInsets.only(
                                                    left: 20.0, right: 20.0),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: <Widget>[
                                                    Container(
                                                      height: ScreenUtil()
                                                          .setHeight(90),
                                                      width: ScreenUtil()
                                                          .setWidth(90),
                                                      // color: Colors.amber,
                                                      child: Image(
                                                        image:
                                                            AdvancedNetworkImage(
                                                          suggestion[index]
                                                              .image,
                                                          useDiskCache: true,
                                                          cacheRule: CacheRule(
                                                              maxAge:
                                                                  const Duration(
                                                                      days: 3)),
                                                        ),
                                                        fit: BoxFit.fill,
                                                      ),
                                                    ),
                                                    RichText(
                                                      text: TextSpan(
                                                        style: TextStyle(
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.bold,
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
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.grey,
                                                              // fontWeight: FontWeight.bold,
                                                              fontFamily:
                                                                  'Gilroy Medium',
                                                              fontSize: ScreenUtil()
                                                                  .setSp(21,
                                                                      allowFontScalingSelf:
                                                                          true),
                                                            ),
                                                          ),
                                                          TextSpan(
                                                            text: searchValue,
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
                                                          ),
                                                          TextSpan(
                                                            text: info[1],
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.grey,
                                                              // fontWeight: FontWeight.bold,
                                                              fontFamily:
                                                                  'Gilroy Medium',
                                                              fontSize: ScreenUtil()
                                                                  .setSp(21,
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
      ),
    );
  }
}
