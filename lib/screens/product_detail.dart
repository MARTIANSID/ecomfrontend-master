import 'dart:async';
import 'dart:ui';

import 'package:Flutter/providers/pagination.dart';
import 'package:Flutter/providers/search.dart';
import 'package:Flutter/screens/photo_detail_screen.dart';
import 'package:Flutter/widgets/add_to_cart.dart';
import 'package:Flutter/widgets/snackbar.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_networkimage/provider.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

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
      this.select})
      : super(key: key);

  @override
  _ProductDetailState createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  bool isColourSet = false;
  bool searchSelected = false;

  String searchValue = "";

  TextEditingController textEditingController = TextEditingController();

  bool searchSelectedDoneButton = false;

  List<dynamic> suggestion;
  bool isLoadingSearch = false;
  Future<void> getSearch(query) async {
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
        isLoadingSearch = false;
        print('DC SEARCH');
      });
    });

    print(suggestion);
    // setState(() {

    // });
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
      context,
      allowFontScaling: true,
      width: 411.42857142857144,
      height: 774.8571428571429,
    );
    List<String> info = [];
    return Scaffold(
      body: Container(
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
                width: ScreenUtil().setWidth(411),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      height: ScreenUtil().setHeight(440),
                      width: ScreenUtil().setWidth(411),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.elliptical(650, 300),
                          bottomRight: Radius.elliptical(650, 300),
                        ),
                        gradient: isColourSet
                            ? LinearGradient(colors: [
                                Color(0xFF34BDDD).withOpacity(0.1),
                                Color(0xFF367DC8).withOpacity(0.1),
                              ])
                            : RadialGradient(
                                colors: [
                                  Color(0xFF2B3E50),
                                  Color(0xFF010101),
                                ],
                              ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(
                            height: ScreenUtil().setHeight(22+17+28+40),
                          ),
                          widget.product.imageUrl.containsKey(widget.colorKey)
                              ? Hero(
                                  tag: 'tag1',
                                  child: Image(
                                    height: ScreenUtil().setHeight(290),
                                    width: ScreenUtil().setWidth(290),
                                    image: AdvancedNetworkImage(
                                      widget.product.imageUrl[widget.colorKey],
                                      useDiskCache: true,
                                      cacheRule: CacheRule(
                                          maxAge: const Duration(days: 3)),
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                )
                              : Hero(
                                  tag: 'tag1',
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
                        ],
                      ),
                    ),
                    SizedBox(
                      height: ScreenUtil().setHeight(17),
                    ),
                    Container(
                      width: ScreenUtil().setWidth(411),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(
                            width: ScreenUtil().setWidth(54),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                width: ScreenUtil().setWidth(330),
                                // margin: EdgeInsets.only(bottom: 35.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
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
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: <Widget>[
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 6.0),
                                          child: GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                isColourSet = true;
                                              });
                                            },
                                            child: Container(
                                              height:
                                                  ScreenUtil().setHeight(16),
                                              width: ScreenUtil().setWidth(16),
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                border: Border.all(
                                                  color: Color(0xFF858585),
                                                  width: 1.0,
                                                ),
                                                gradient: LinearGradient(
                                                  colors: [
                                                    Colors.white,
                                                    Color(0xFF2E3F99),
                                                  ],
                                                  begin: Alignment.topLeft,
                                                  end: Alignment.bottomRight,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              isColourSet = false;
                                            });
                                          },
                                          child: Container(
                                            height: ScreenUtil().setHeight(16),
                                            width: ScreenUtil().setWidth(16),
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              border: Border.all(
                                                color: Color(0xFF858585),
                                                width: 1.0,
                                              ),
                                              gradient: LinearGradient(
                                                colors: [
                                                  Colors.black,
                                                  Color(0xFF2E3F99),
                                                ],
                                                begin: Alignment.topLeft,
                                                end: Alignment.bottomRight,
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
                                margin: EdgeInsets.only(left: 9.0),
                                child: ShaderMask(
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
                                  child: widget.product.prices
                                          .containsKey(widget.diamondKey)
                                      ? Text(
                                          '${int.parse(widget.product.prices[widget.diamondKey]) + widget.certPrice} ₹',
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
                                          margin: EdgeInsets.only(bottom: 7.0),
                                          child: Text(
                                            'Gold Weight'.toUpperCase(),
                                            style: TextStyle(
                                              fontFamily: 'Gilroy Light',
                                              color: Colors.black,
                                              fontSize: ScreenUtil().setSp(14,
                                                  allowFontScalingSelf: true),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(bottom: 7.0),
                                          child: Text(
                                            'Diamond Weight'.toUpperCase(),
                                            style: TextStyle(
                                              fontFamily: 'Gilroy Light',
                                              color: Colors.black,
                                              fontSize: ScreenUtil().setSp(14,
                                                  allowFontScalingSelf: true),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(bottom: 7.0),
                                          child: Text(
                                            'Diamond Count'.toUpperCase(),
                                            style: TextStyle(
                                              fontFamily: 'Gilroy Light',
                                              color: Colors.black,
                                              fontSize: ScreenUtil().setSp(14,
                                                  allowFontScalingSelf: true),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          child: Text(
                                            'DESIGN DIMENSIONS',
                                            style: TextStyle(
                                              fontFamily: 'Gilroy Light',
                                              color: Colors.black,
                                              fontSize: ScreenUtil().setSp(14,
                                                  allowFontScalingSelf: true),
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
                                          margin: EdgeInsets.only(bottom: 7.0),
                                          child: Text(
                                            '${widget.product.goldWeight}' +
                                                ' gms',
                                            style: TextStyle(
                                              fontFamily: 'Gilroy Light',
                                              color: Colors.black,
                                              fontSize: ScreenUtil().setSp(14,
                                                  allowFontScalingSelf: true),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(bottom: 7.0),
                                          child: Text(
                                            '${widget.product.diamondWeight}' +
                                                ' ct',
                                            style: TextStyle(
                                              fontFamily: 'Gilroy Light',
                                              color: Colors.black,
                                              fontSize: ScreenUtil().setSp(14,
                                                  allowFontScalingSelf: true),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(bottom: 7.0),
                                          child: Text(
                                            '${widget.product.diamondCount}' +
                                                ' pieces',
                                            style: TextStyle(
                                              fontFamily: 'Gilroy Light',
                                              color: Colors.black,
                                              fontSize: ScreenUtil().setSp(14,
                                                  allowFontScalingSelf: true),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          child: Text(
                                            '${widget.product.designDimensions}',
                                            style: TextStyle(
                                              fontFamily: 'Gilroy Light',
                                              color: Colors.black,
                                              fontSize: ScreenUtil().setSp(14,
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
                                height: ScreenUtil().setHeight(19),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  SizedBox(
                                    width: ScreenUtil().setWidth(17),
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      GestureDetector(
                                        onTap: () {
                                          Provider.of<Pagination>(context,
                                                      listen: false)
                                                  .isPriced
                                              ? dataSelect(
                                                  context,
                                                  'Important!',
                                                  "To see prices you must first request a quotation from Team Gemstory",
                                                  'Request Prices',
                                                )
                                              : showDialog(
                                                  context: context,
                                                  child: AddToCart(
                                                    product: widget.product,
                                                    updateCart: false,
                                                    choicesBuild:
                                                        Provider.of<Pagination>(
                                                                context,
                                                                listen: false)
                                                            .build,
                                                    choiceColor:
                                                        Provider.of<Pagination>(
                                                                context,
                                                                listen: false)
                                                            .color,
                                                    choiceCertification:
                                                        Provider.of<Pagination>(
                                                                context,
                                                                listen: false)
                                                            .cert,
                                                    choiceDiamondQuality:
                                                        Provider.of<Pagination>(
                                                                context,
                                                                listen: false)
                                                            .diamondQuality,
                                                    defValue:
                                                        widget.defaultIndex1,
                                                    defValue1:
                                                        widget.defaultIndex2,
                                                    defValue2:
                                                        widget.defaultIndex3,
                                                    defValue3:
                                                        widget.defaultIndex4,
                                                    valueChangeBuild:
                                                        widget.valueChangeBuild,
                                                    valueChangeColor:
                                                        widget.valueChangeColor,
                                                    valueChangeCerti:
                                                        widget.valueChangeCerti,
                                                    valueChangeDQ:
                                                        widget.valueChangeDQ,
                                                  ),
                                                );
                                        },
                                        child: Container(
                                          width: ScreenUtil().setWidth(270),
                                          height: ScreenUtil().setWidth(43),
                                          // padding: EdgeInsets.all(20.0),
                                          child: Center(
                                            child: Text(
                                              'ADD TO CART',
                                              style: TextStyle(
                                                fontFamily: 'Gilroy Bold',
                                                color: Colors.white,
                                                fontSize: ScreenUtil().setSp(18,
                                                    allowFontScalingSelf: true),
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
                                      SizedBox(
                                        height: ScreenUtil().setHeight(15),
                                      ),
                                      Container(
                                        width: ScreenUtil().setWidth(239),
                                        child: RichText(
                                          text: TextSpan(
                                            style: TextStyle(
                                              fontFamily: 'Gilroy Medium',
                                              fontSize: ScreenUtil().setSp(12,
                                                  allowFontScalingSelf: true),
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
                                                        ..onTap = () async {
                                                          if (await canLaunch(
                                                              "https://wa.me/919322244007")) {
                                                            await launch(
                                                                "https://wa.me/919322244007");
                                                          } else {
                                                            throw 'Could not launch https://wa.me/919322244007';
                                                          }
                                                        },
                                                  style: TextStyle(
                                                    decoration: TextDecoration
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
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
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
              child: BackdropFilter(
                filter: ImageFilter.blur(
                    sigmaX: searchSelected ? 5 : 0,
                    sigmaY: searchSelected ? 5 : 0),
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: ScreenUtil().setHeight(22),
                    ),
                    Container(
                      width: ScreenUtil().setWidth(360),
                      height: ScreenUtil().setHeight(45),
                      margin: EdgeInsets.fromLTRB(
                          25, 17, 26, searchSelected ? 0 : 28),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          AnimatedContainer(
                            duration: Duration(milliseconds: 600),
                            curve: Curves.slowMiddle,
                            padding: EdgeInsets.only(left: 10.0),
                            width: ScreenUtil()
                                .setWidth(searchSelected ? 305 : 360),
                            height: ScreenUtil().setHeight(40),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: Colors.white,
                            ),
                            child: Stack(
                              alignment: Alignment.centerRight,
                              children: <Widget>[
                                TextField(
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
                                    //   // print(styleNumber[1].split(searchValue));
                                    // });
                                    await getSearch(searchValue.toUpperCase());
                                    // setState(() {
                                    //   isLoadingSearch = false;
                                    // });
                                    // getSearchResult(value.toUpperCase());
                                  },
                                  decoration: InputDecoration(
                                    // contentPadding: EdgeInsets.all(15.0),
                                    suffixIcon: searchSelected
                                        ? GestureDetector(
                                            onTap: () {
                                              textEditingController.clear();
                                              setState(() {
                                                searchValue = "";
                                              });
                                            },
                                            child: Icon(Icons.clear),
                                          )
                                        : SizedBox(
                                            height: 0.0,
                                            width: 0.0,
                                          ),
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
                                AnimatedContainer(
                                  duration: Duration(milliseconds: 600),
                                  margin: EdgeInsets.only(right: 6.0),
                                  height: ScreenUtil()
                                      .setHeight(searchSelected ? 0 : 27),
                                  width: ScreenUtil()
                                      .setWidth(searchSelected ? 0 : 27),
                                  child: SvgPicture.asset(
                                    'assets/icons/notificationIcon.svg',
                                    color: Colors.black,
                                  ),
                                )
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
                                        color: Colors.black,
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
                                        itemCount: Provider.of<Searchh>(context,
                                                listen: false)
                                            .searchResult
                                            .length,
                                        itemBuilder: (context, index) {
                                          info = suggestion[index]
                                              .styleNumber
                                              .split(searchValue);
                                          print(info);
                                          return Padding(
                                            padding: const EdgeInsets.only(
                                                left: 20.0, right: 20.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: <Widget>[
                                                Container(
                                                  height: ScreenUtil().setHeight(90),
                                                  width: ScreenUtil().setWidth(90),
                                                  // color: Colors.amber,
                                                  child: Image(
                                                    image: AdvancedNetworkImage(
                                                      suggestion[index].image,
                                                      useDiskCache: true,
                                                      cacheRule: CacheRule(
                                                          maxAge:
                                                              const Duration(
                                                                  days: 3)),
                                                    ),
                                                    fit: BoxFit.fill,
                                                  ),
                                                ),
                                                // Text(
                                                //   styleNumber[index],
                                                //   style: TextStyle(
                                                //     fontFamily: 'Varela',
                                                //     fontSize: ScreenUtil().setSp(21,allowFontScalingSelf: true),
                                                //   ),
                                                // )
                                                RichText(
                                                  text: TextSpan(
                                                    // text: suggestion[index].substring(
                                                    //   suggestion[index].indexOf(
                                                    //       searchValue),
                                                    //   searchValue.length,
                                                    // ),
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontFamily: 'Varela',
                                                      fontSize: ScreenUtil().setSp(21,allowFontScalingSelf: true),
                                                    ),
                                                    children: [
                                                      TextSpan(
                                                        text: info[0],
                                                        style: TextStyle(
                                                          color: Colors.grey,
                                                          // fontWeight: FontWeight.bold,
                                                          fontFamily: 'Varela',
                                                          fontSize: ScreenUtil().setSp(21,allowFontScalingSelf: true),
                                                        ),
                                                      ),
                                                      TextSpan(
                                                        text: searchValue,
                                                        style: TextStyle(
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontFamily: 'Varela',
                                                          fontSize: ScreenUtil().setSp(21,allowFontScalingSelf: true),
                                                        ),
                                                      ),
                                                      TextSpan(
                                                        text: info[1],
                                                        style: TextStyle(
                                                          color: Colors.grey,
                                                          // fontWeight: FontWeight.bold,
                                                          fontFamily: 'Varela',
                                                          fontSize: ScreenUtil().setSp(21,allowFontScalingSelf: true),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              ],
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
            Positioned(
              top: ScreenUtil().setHeight(92 + 22),
              right: ScreenUtil().setWidth(26),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          PhotoDetailScreen(widget.colorKey, widget.product),
                    ),
                  );
                },
                child: SvgPicture.asset(
                  'assets/icons/zoomIcon.svg',
                  width: ScreenUtil().setWidth(29),
                  height: ScreenUtil().setHeight(29),
                  color: isColourSet ? Color(0xFFB8B8B8) : Colors.white,
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
                  onTap: () async {
                    await Provider.of<Pagination>(context, listen: false)
                        .toogleFavourite(
                            styleNumber: widget.product.styleNumber,
                            context: context,
                            select: widget.select);
                    setState(() {});
                  },
                  child: Icon(
                    widget.product.isFavourite
                        ? Icons.favorite
                        : Icons.favorite_border,
                    size: 30.0,
                    color: Colors.white,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
