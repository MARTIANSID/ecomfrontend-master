import 'dart:async';
import 'dart:ui';

import 'package:Flutter/providers/notifiaction.dart';
import 'package:Flutter/providers/options.dart';
import 'package:Flutter/providers/pagination.dart';
import 'package:Flutter/providers/search.dart';
import 'package:Flutter/screens/product_detail.dart';
import 'package:Flutter/widgets/cookie_page.dart';
import 'package:Flutter/widgets/optionsDialog.dart';
import 'package:Flutter/widgets/snackbar.dart';
import 'package:Flutter/widgets/sortPage.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_advanced_networkimage/provider.dart';
import 'package:flutter_animator/flutter_animator.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'product_overview_screen.dart';

class FavouriteScreen extends StatefulWidget {
  final ScrollController scrollController;
  final void Function(int) onButtonTapped;
  final void Function(int) pageController;
  final PageController pageControllerValue;
  final bool val;

  const FavouriteScreen(
      {Key key,
      this.scrollController,
      this.pageController,
      this.pageControllerValue,
      this.onButtonTapped,
      this.val})
      : super(key: key);
  @override
  _FavouriteScreenState createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen>
    with TickerProviderStateMixin {
  int _defaultChoiceIndex1;
  int _defaultChoiceIndex2;
  int _defaultChoiceIndex3;
  int _defaultChoiceIndex4;
  var _choices;
  var _choices1;
  var _choices2;
  var _choices3;

  bool searchSelected = false;

  String searchValue = "";

  TextEditingController textEditingController = TextEditingController();

  bool searchSelectedDoneButton = false;

  GlobalKey globalKey = GlobalKey();

  bool tapNotication = false;

  @override
  void initState() {
    super.initState();
  }

  void _onValueChange(int value) async {
    await Provider.of<Options>(context, listen: false).setBuild(build: value);
    setState(() {
      // await Provider.of<Options>(context, listen: false).setBuild(build: value);
      _defaultChoiceIndex1 = value;
      // print(value);
    });
  }

  void _onValueChangeColor(int value) async {
    await Provider.of<Options>(context, listen: false).setColor(color: value);
    setState(() {
      _defaultChoiceIndex2 = value;
    });
  }

  void _onValueChangeCerti(int value) async {
    await Provider.of<Options>(context, listen: false).setCert(cert: value);
    setState(() {
      _defaultChoiceIndex3 = value;
    });
  }

  void _onValueChangeDQ(int value) async {
    await Provider.of<Options>(context, listen: false)
        .setDiamond(diamond: value);
    setState(() {
      _defaultChoiceIndex4 = value;
    });
  }

  List<dynamic> suggestion;
  bool isLoadingSearch = false;
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
      setState(() {
        isLoadingSearch = false;
      });
    }

    // print(suggestion);
    // setState(() {

    // });
  }

  @override
  Widget build(BuildContext context) {
    final favProducts =
        Provider.of<Pagination>(context, listen: true).favProducts;
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
    _choices = Provider.of<Pagination>(context, listen: false).build;
    _choices1 = Provider.of<Pagination>(context, listen: false).color;
    _choices2 = Provider.of<Pagination>(context, listen: false).cert;
    _choices3 = Provider.of<Pagination>(context, listen: false).diamondQuality;
    ScreenUtil.init(context,
        width: 411.42857142857144,
        height: 774.8571428571429,
        allowFontScaling: true);
    List<String> info = [];
    // final suggestion = styleNumber
    //     .where(
    //         (element) => element.contains(searchValue.toString().toUpperCase()))
    //     .toList();
    // print('Search Selected' + searchSelected.toString());
    return Scaffold(
      resizeToAvoidBottomInset: false,
      resizeToAvoidBottomPadding: false,
      key: globalKey,
      body: Container(
        color: Color(0xFFF4F4F4),
        child: Stack(
          children: <Widget>[
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  widget.val
                      ? SizedBox(
                          height: ScreenUtil().setHeight(22 + 45 + 20 + 20),
                        )
                      : SizedBox(
                          height: ScreenUtil().setHeight(22),
                        ),
                  widget.val
                      ? Padding(
                          padding: EdgeInsets.fromLTRB(24, 0, 30, 0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
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
                                  'FAVOURITES',
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
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Tooltip(
                                    message: "Sort",
                                    waitDuration: Duration(seconds: 4),
                                    child: GestureDetector(
                                      onTap: () {
                                        showDialog(
                                          context: context,
                                          child: SortPage(),
                                        ).then((value) async {
                                          // await Future.wait([
                                          //   Provider.of<Pagination>(
                                          //           context,
                                          //           listen: false)
                                          //       .getProducts(
                                          //           addition: false,
                                          //           page: 1,
                                          //           context: context,
                                          //           select:
                                          //               'featured',
                                          //           sortby: Provider.of<
                                          //                       Pagination>(
                                          //                   context,
                                          //                   listen:
                                          //                       false)
                                          //               .count,
                                          //           sort: Provider.of<
                                          //                       Pagination>(
                                          //                   context,
                                          //                   listen:
                                          //                       false)
                                          //               .sort)
                                          // ]);
                                          await Future.wait([
                                            Provider.of<Pagination>(context,
                                                    listen: false)
                                                .getProducts(
                                                    addition: false,
                                                    page: 1,
                                                    context: context,
                                                    select: 'all',
                                                    sortby:
                                                        Provider.of<Pagination>(
                                                                context,
                                                                listen: false)
                                                            .count,
                                                    sort:
                                                        Provider.of<Pagination>(
                                                                context,
                                                                listen: false)
                                                            .sort)
                                          ]);
                                          await Future.wait([
                                            Provider.of<Pagination>(context,
                                                    listen: false)
                                                .getProducts(
                                                    addition: false,
                                                    page: 1,
                                                    context: context,
                                                    select: 'isnew',
                                                    sortby:
                                                        Provider.of<Pagination>(
                                                                context,
                                                                listen: false)
                                                            .count,
                                                    sort:
                                                        Provider.of<Pagination>(
                                                                context,
                                                                listen: false)
                                                            .sort)
                                          ]);
                                          await Future.wait([
                                            Provider.of<Pagination>(context,
                                                    listen: false)
                                                .getProducts(
                                                    addition: false,
                                                    page: 1,
                                                    context: context,
                                                    select: 'fancyDiamond',
                                                    sortby:
                                                        Provider.of<Pagination>(
                                                                context,
                                                                listen: false)
                                                            .count,
                                                    sort:
                                                        Provider.of<Pagination>(
                                                                context,
                                                                listen: false)
                                                            .sort),
                                          ]);

                                          await Future.wait([
                                            Provider.of<Pagination>(context,
                                                    listen: false)
                                                .getProducts(
                                                    addition: false,
                                                    page: 1,
                                                    context: context,
                                                    select: 'navratna',
                                                    sortby:
                                                        Provider.of<Pagination>(
                                                                context,
                                                                listen: false)
                                                            .count,
                                                    sort:
                                                        Provider.of<Pagination>(
                                                                context,
                                                                listen: false)
                                                            .sort)
                                          ]);
                                        });
                                      },
                                      child: Padding(
                                        padding: EdgeInsets.only(right: 8.0),
                                        child: SvgPicture.asset(
                                          'assets/icons/sortIcon.svg',
                                          width: ScreenUtil().setWidth(24),
                                          height: ScreenUtil().setHeight(24),
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Tooltip(
                                    message: "Options",
                                    waitDuration: Duration(seconds: 4),
                                    child: GestureDetector(
                                      onTap: () {
                                        showDialog(
                                          context: context,
                                          child: OptionsDialog(
                                            choicesBuild: _choices,
                                            choiceColor: _choices1,
                                            choiceCertification: _choices2,
                                            choiceDiamondQuality: _choices3,
                                            defValue: _defaultChoiceIndex1,
                                            defValue1: _defaultChoiceIndex2,
                                            defValue2: _defaultChoiceIndex3,
                                            defValue3: _defaultChoiceIndex4,
                                            valueChangeBuild: _onValueChange,
                                            valueChangeColor:
                                                _onValueChangeColor,
                                            valueChangeCerti:
                                                _onValueChangeCerti,
                                            valueChangeDQ: _onValueChangeDQ,
                                          ),
                                        );
                                      },
                                      child: SvgPicture.asset(
                                        'assets/icons/optionsIcon.svg',
                                        width: ScreenUtil().setWidth(24),
                                        height: ScreenUtil().setHeight(24),
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              // Row(
                              //   mainAxisAlignment: MainAxisAlignment.end,
                              //   crossAxisAlignment: CrossAxisAlignment.center,
                              //   children: <Widget>[
                              //     GestureDetector(
                              //       onTap: () {
                              //         showDialog(
                              //           context: context,
                              //           child: SortPage(),
                              //         );
                              //       },
                              //       child: Padding(
                              //         padding: EdgeInsets.only(right: 4.0),
                              //         child: SvgPicture.asset(
                              //           'assets/icons/sortIcon.svg',
                              //           width: ScreenUtil().setWidth(24),
                              //           height: ScreenUtil().setHeight(24),
                              //           color: Colors.black,
                              //         ),
                              //       ),
                              //     ),
                              //     GestureDetector(
                              //       onTap: () {
                              //         showDialog(
                              //           context: context,
                              //           child: OptionsDialog(
                              //             choicesBuild: _choices,
                              //             choiceColor: _choices1,
                              //             choiceCertification: _choices2,
                              //             choiceDiamondQuality: _choices3,
                              //             defValue: _defaultChoiceIndex1,
                              //             defValue1: _defaultChoiceIndex2,
                              //             defValue2: _defaultChoiceIndex3,
                              //             defValue3: _defaultChoiceIndex4,
                              //             valueChangeBuild: _onValueChange,
                              //             valueChangeColor: _onValueChangeColor,
                              //             valueChangeCerti: _onValueChangeCerti,
                              //             valueChangeDQ: _onValueChangeDQ,
                              //           ),
                              //         );
                              //       },
                              //       child: SvgPicture.asset(
                              //         'assets/icons/optionsIcon.svg',
                              //         width: ScreenUtil().setWidth(24),
                              //         height: ScreenUtil().setHeight(24),
                              //         color: Colors.black,
                              //       ),
                              //     )
                              //   ],
                              // )
                            ],
                          ),
                        )
                      : SizedBox(
                          height: 0.0,
                        ),
                  widget.val
                      ? SizedBox(
                          height: ScreenUtil().setHeight(15),
                        )
                      : SizedBox(
                          height: ScreenUtil().setHeight(20),
                        ),
                  Expanded(
                    child: favProducts.length > 0
                        ? CookiePage(
                            products:
                                Provider.of<Pagination>(context, listen: true)
                                    .favProducts,
                            scrollController: widget.scrollController,
                            select: 'fav',
                            color: _defaultChoiceIndex2,
                            build: _defaultChoiceIndex1,
                            cert: _defaultChoiceIndex3,
                            diamond: _defaultChoiceIndex4,
                            globalKey: globalKey,
                          )
                        : GestureDetector(
                            onTap: () {
                              // widget.pageController(2);
                              widget.pageControllerValue.animateToPage(2,
                                  duration: Duration(milliseconds: 500),
                                  curve: Curves.ease);
                            },
                            child: Container(
                              width: ScreenUtil().setHeight(350),
                              child: Center(
                                child: Text(
                                  // 'There aren\'t any Favourites product added yet!',
                                  "😕 No Favourites yet?",
                                  style: TextStyle(
                                    fontFamily: 'Gilory Regular',
                                    color: Color(0xFFA49797),
                                    // height: 3.0,
                                    // decoration: TextDecoration.underline,
                                    fontSize: ScreenUtil()
                                        .setSp(17, allowFontScalingSelf: true),
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                  )
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
            widget.val
                ? Container(
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
                                24, 20, 0, searchSelected ? 0 : 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.only(left: 10.0),
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
                                        // right: 0.0,
                                        child: Container(
                                          width: ScreenUtil().setWidth(
                                              searchSelected ? 305 : 360),
                                          height: ScreenUtil().setHeight(40),
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
                                                    gif:
                                                        "assets/images/alert.gif");
                                              }
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
                                              //           textEditingController
                                              //               .clear();
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
                                                    allowFontScalingSelf:
                                                        true)),
                                          ),
                                        ),
                                      ),
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
                                      GestureDetector(
                                          onTap: () async {
                                            await Provider.of<Notif>(context,
                                                    listen: false)
                                                .getNotification(
                                                    context: context);

                                            setState(() {
                                              tapNotication = !tapNotication;
                                            });
                                          },
                                          child: AnimatedContainer(
                                            duration:
                                                Duration(milliseconds: 600),
                                            margin: EdgeInsets.only(right: 6.0),
                                            alignment: Alignment.centerRight,
                                            height: ScreenUtil().setHeight(
                                                searchSelected ? 0 : 50),
                                            width: ScreenUtil().setWidth(
                                                searchSelected ? 0 : 50),
                                            color: Colors.transparent,
                                            child: Provider.of<Notif>(context,
                                                            listen: true)
                                                        .notifications
                                                        .length >
                                                    0
                                                ? Provider.of<Notif>(context,
                                                            listen: true)
                                                        .checkForDelete()
                                                    ? SvgPicture.asset(
                                                        'assets/icons/notificationIcon.svg',
                                                        color: Colors.black,
                                                        height: ScreenUtil()
                                                            .setHeight(
                                                                searchSelected
                                                                    ? 0
                                                                    : 25),
                                                        width: ScreenUtil()
                                                            .setWidth(
                                                                searchSelected
                                                                    ? 0
                                                                    : 25),
                                                      )
                                                    : Image.asset(
                                                        'assets/images/notificationPulse.png',
                                                        height: ScreenUtil()
                                                            .setHeight(
                                                                searchSelected
                                                                    ? 0
                                                                    : 25),
                                                        width: ScreenUtil()
                                                            .setWidth(
                                                                searchSelected
                                                                    ? 0
                                                                    : 25),
                                                      )
                                                : SvgPicture.asset(
                                                    'assets/icons/notificationIcon.svg',
                                                    height: ScreenUtil()
                                                        .setHeight(
                                                            searchSelected
                                                                ? 0
                                                                : 25),
                                                    width: ScreenUtil()
                                                        .setWidth(searchSelected
                                                            ? 0
                                                            : 25),
                                                    color: Colors.black,
                                                  ),
                                          )),
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
                                      margin:
                                          EdgeInsets.fromLTRB(25, 0, 26, 20),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(15.0),
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
                                                            select: 'all',
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
                                                            product: Provider.of<
                                                                        Pagination>(
                                                                    context,
                                                                    listen:
                                                                        false)
                                                                .productDetailsForSearch[0],
                                                            defaultIndex1:
                                                                _defaultChoiceIndex1,
                                                            defaultIndex2:
                                                                _defaultChoiceIndex2,
                                                            defaultIndex3:
                                                                _defaultChoiceIndex3,
                                                            defaultIndex4:
                                                                _defaultChoiceIndex4,
                                                            valueChangeBuild:
                                                                _onValueChange,
                                                            valueChangeColor:
                                                                _onValueChangeColor,
                                                            valueChangeCerti:
                                                                _onValueChangeCerti,
                                                            valueChangeDQ:
                                                                _onValueChangeDQ,
                                                            valueChangeBuild1:
                                                                _onValueChange,
                                                            valueChangeColor1:
                                                                _onValueChangeColor,
                                                            valueChangeCerti1:
                                                                _onValueChangeCerti,
                                                            valueChangeDQ1:
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
                                                        // Text(
                                                        //   styleNumber[index],
                                                        //   style: TextStyle(
                                                        //     fontFamily: 'Gilroy Medium',
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
                  )
                : SizedBox(
                    height: 0.0,
                  ),
            !tapNotication
                ? SizedBox(
                    height: 0.0,
                    width: 0.0,
                  )
                : Container(
                    color: Colors.transparent,
                    child: Container(
                      height: ScreenUtil().setHeight(775),
                      width: ScreenUtil().setWidth(411),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Color(0xFF34B0D9).withOpacity(0.2),
                            Color(0xFF3685CB).withOpacity(0.2),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      child: GestureDetector(
                        onTap: () {},
                        child: Container(
                          height: ScreenUtil().setHeight(775),
                          width: ScreenUtil().setWidth(411),
                        ),
                      ),
                    ),
                  ),
            !tapNotication
                ? SizedBox(
                    height: 0.0,
                    width: 0.0,
                  )
                : Container(
                    color: Colors.transparent,
                    child: Container(
                      height: ScreenUtil().setHeight(775),
                      width: ScreenUtil().setWidth(411),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Color(0xFF34B0D9).withOpacity(0.2),
                            Color(0xFF3685CB).withOpacity(0.2),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            tapNotication = false;
                          });
                        },
                        child: Container(
                          height: ScreenUtil().setHeight(775),
                          width: ScreenUtil().setWidth(411),
                        ),
                      ),
                    ),
                  ),
            tapNotication
                ? Container(
                    height: ScreenUtil().setHeight(775),
                    width: ScreenUtil().setWidth(370),
                    color: Colors.transparent,
                    // decoration: BoxDecoration(
                    //   gradient: LinearGradient(
                    //     colors: [
                    //       Color(0xFF34B0D9).withOpacity(0.2),
                    //       Color(0xFF3685CB).withOpacity(0.2),
                    //     ],
                    //     begin: Alignment.topLeft,
                    //     end: Alignment.bottomRight,
                    //   ),
                    // ),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                      child: Stack(
                        children: <Widget>[
                          Positioned(
                            top: ScreenUtil().setHeight(327),
                            left: ScreenUtil().setWidth(0.0),
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  tapNotication = false;
                                });
                              },
                              child: Container(
                                height: ScreenUtil().setHeight(775),
                                width: ScreenUtil().setWidth(411),
                                color: Colors.transparent,
                              ),
                            ),
                          ),
                          FadeIn(
                            child: CustomPaint(
                              painter: CurvePainter(),
                            ),
                          ),
                          Positioned(
                            top: ScreenUtil().setHeight(82.7 + 22 + 8),
                            left: ScreenUtil().setWidth(27),
                            child: FadeIn(
                              child: Container(
                                width: ScreenUtil().setWidth(341),
                                height: ScreenUtil().setHeight(300),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(26),
                                    bottomRight: Radius.circular(26),
                                    topLeft: Radius.circular(26),
                                  ),
                                  color: Colors.white,
                                ),
                                padding: EdgeInsets.all(25),
                                child: Provider.of<Notif>(context, listen: true)
                                            .notifications
                                            .length ==
                                        0
                                    ? Center(
                                        child: ShaderMask(
                                          shaderCallback: (bounds) =>
                                              LinearGradient(
                                            colors: [
                                              Color(0xFF34BDDD),
                                              Color(0xFF367DC8),
                                            ],
                                            begin: Alignment.topLeft,
                                            end: Alignment.bottomRight,
                                          ).createShader(Rect.fromLTWH(0, 0,
                                                  bounds.width, bounds.height)),
                                          child: Text(
                                            'No new notifications!',
                                            style: TextStyle(
                                              fontFamily: 'Gilroy Medium',
                                              fontSize: ScreenUtil().setSp(20,
                                                  allowFontScalingSelf: true),
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      )
                                    : ListView.builder(
                                        physics: BouncingScrollPhysics(),
                                        itemCount: Provider.of<Notif>(context,
                                                listen: true)
                                            .notifications
                                            .length,
                                        itemBuilder: (context, index) {
                                          return Container(
                                            width: ScreenUtil()
                                                .setWidth(260 + 15 + 15),
                                            child: Dismissible(
                                              // dismissThresholds: {
                                              //   DismissDirection
                                              //       .startToEnd: 0.4
                                              // },
                                              key: UniqueKey(),
                                              direction:
                                                  DismissDirection.startToEnd,
                                              background: Container(
                                                color: Colors.red,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(15),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Icon(Icons.delete,
                                                          color: Colors.white),
                                                      SizedBox(
                                                        width: ScreenUtil()
                                                            .setWidth(5),
                                                      ),
                                                      Text(
                                                        'Delete Notification',
                                                        style: TextStyle(
                                                          fontFamily:
                                                              'Gilroy Regular',
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),

                                              // confirmDismiss: (DismissDirection
                                              //     direction) async {

                                              // },
                                              onDismissed: (DismissDirection
                                                  direction) async {
                                                await Provider.of<Notif>(
                                                        context,
                                                        listen: false)
                                                    .deleteNotification(
                                                        context: context,
                                                        id: Provider.of<Notif>(
                                                                context,
                                                                listen: false)
                                                            .notifications[
                                                                index]
                                                            .id);
                                              },
                                              child: GestureDetector(
                                                onTap: () async {
                                                  await Provider.of<Notif>(
                                                          context,
                                                          listen: false)
                                                      .readNNotification(
                                                          context: context,
                                                          id: Provider.of<
                                                                      Notif>(
                                                                  context,
                                                                  listen: false)
                                                              .notifications[
                                                                  index]
                                                              .id);
                                                  // if (!Provider.of<
                                                  //             Notif>(
                                                  //         context,
                                                  //         listen:
                                                  //             false)
                                                  //     .notifications[
                                                  //         index]
                                                  //     .read) {
                                                  //   Provider.of<Auth>(
                                                  //           context,
                                                  //           listen:
                                                  //               false)
                                                  //       .restart(
                                                  //           context:
                                                  //               context);
                                                  // }
                                                  // print(Provider.of<
                                                  //             Notif>(
                                                  //         context,
                                                  //         listen:
                                                  //             false)
                                                  //     .notifications[
                                                  //         index]
                                                  //     .read);
                                                  // print(
                                                  // 'reading trueeeeeeeeeeeee');
                                                  setState(() {});
                                                },
                                                child: Container(
                                                  margin: EdgeInsets.only(
                                                      bottom: 20),
                                                  width: ScreenUtil()
                                                      .setWidth(260),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: <Widget>[
                                                      ShaderMask(
                                                        shaderCallback:
                                                            (bounds) =>
                                                                LinearGradient(
                                                          colors: [
                                                            Color(0xFF34BDDD),
                                                            Color(0xFF367DC8),
                                                          ],
                                                          begin:
                                                              Alignment.topLeft,
                                                          end: Alignment
                                                              .bottomRight,
                                                        ).createShader(
                                                          Rect.fromLTWH(
                                                              0,
                                                              0,
                                                              bounds.width,
                                                              bounds.height),
                                                        ),
                                                        child: SvgPicture.asset(
                                                          "assets/icons/ordersyet.svg",
                                                          height: ScreenUtil()
                                                              .setHeight(39),
                                                          width: ScreenUtil()
                                                              .setWidth(32),
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: ScreenUtil()
                                                            .setWidth(23),
                                                      ),
                                                      Container(
                                                        width: ScreenUtil()
                                                            .setWidth(204),
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: <Widget>[
                                                            Align(
                                                              alignment: Alignment
                                                                  .centerRight,
                                                              child: Text(
                                                                DateFormat('dd MMM, yyyy').add_jm().format(Provider.of<
                                                                            Notif>(
                                                                        context,
                                                                        listen:
                                                                            false)
                                                                    .notifications[
                                                                        index]
                                                                    .createdAt),
                                                                style:
                                                                    TextStyle(
                                                                  fontFamily:
                                                                      "Gilroy Light",
                                                                  fontSize: ScreenUtil().setSp(
                                                                      12,
                                                                      allowFontScalingSelf:
                                                                          true),
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              height:
                                                                  ScreenUtil()
                                                                      .setHeight(
                                                                          7.0),
                                                            ),
                                                            Text(
                                                              Provider.of<Notif>(
                                                                      context,
                                                                      listen:
                                                                          false)
                                                                  .notifications[
                                                                      index]
                                                                  .title,
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                      "Gilroy Light",
                                                                  fontSize: ScreenUtil().setSp(
                                                                      18,
                                                                      allowFontScalingSelf:
                                                                          true),
                                                                  fontWeight: Provider.of<Notif>(
                                                                              context,
                                                                              listen:
                                                                                  true)
                                                                          .notifications[
                                                                              index]
                                                                          .read
                                                                      ? FontWeight
                                                                          .normal
                                                                      : FontWeight
                                                                          .bold),
                                                            ),
                                                            SizedBox(
                                                              height:
                                                                  ScreenUtil()
                                                                      .setHeight(
                                                                          4),
                                                            ),
                                                            Text(
                                                              Provider.of<Notif>(
                                                                      context,
                                                                      listen:
                                                                          false)
                                                                  .notifications[
                                                                      index]
                                                                  .body,
                                                              // "Your order has been processed",
                                                              style: TextStyle(
                                                                fontFamily:
                                                                    "Gilroy Light",
                                                                fontSize: ScreenUtil()
                                                                    .setSp(12,
                                                                        allowFontScalingSelf:
                                                                            true),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                              ),
                            ),
                          ),
                          Positioned(
                            top: ScreenUtil().setHeight(20 + 22 + 0),
                            left: ScreenUtil().setWidth(335),
                            child: IconButton(
                              onPressed: () {
                                setState(() {
                                  tapNotication = false;
                                });
                              },
                              icon: Icon(
                                Icons.clear,
                                size: ScreenUtil()
                                    .setSp(30, allowFontScalingSelf: true),
                              ),
                            ),
                            // ),
                          ),
                          Positioned(
                            top: ScreenUtil().setHeight(425),
                            left: ScreenUtil().setWidth(260),
                            child: Provider.of<Notif>(context, listen: true)
                                        .notifications
                                        .length ==
                                    0
                                ? SizedBox(
                                    height: 0.0,
                                  )
                                : Container(
                                    width: ScreenUtil().setWidth(100),
                                    height: ScreenUtil().setHeight(45),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      boxShadow: <BoxShadow>[
                                        BoxShadow(
                                          blurRadius: 10,
                                          color: Colors.black.withOpacity(0.37),
                                          offset: Offset(1, 3),
                                        ),
                                      ],
                                      color: Colors.white,
                                    ),
                                    child: Material(
                                      type: MaterialType.transparency,
                                      elevation: 6.0,
                                      color: Colors.transparent,
                                      borderRadius: BorderRadius.circular(10),
                                      child: InkWell(
                                        splashColor:
                                            Colors.cyan[100].withOpacity(0.8),
                                        borderRadius: BorderRadius.circular(10),
                                        onTap: () async {
                                          Provider.of<Notif>(context,
                                                      listen: false)
                                                  .checkForDelete()
                                              ? await Provider.of<Notif>(
                                                      context,
                                                      listen: false)
                                                  .deleteAll(context: context)
                                              : await Provider.of<Notif>(
                                                      context,
                                                      listen: false)
                                                  .readAll(context: context);
                                        },
                                        child: Center(
                                          child: Text(
                                            Provider.of<Notif>(context,
                                                        listen: false)
                                                    .checkForDelete()
                                                ? 'Delete All'
                                                : 'Read All',
                                            style: TextStyle(
                                              fontFamily: "Gilroy Medium",
                                              fontSize: ScreenUtil().setSp(12,
                                                  allowFontScalingSelf: true),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                          )
                        ],
                      ),
                    ),
                  )
                : SizedBox(
                    height: 0.0,
                    width: 0.0,
                  )
            // Positioned(
            //   right: ScreenUtil().setHeight(32.88),
            //   top: ScreenUtil().setHeight(108.5),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //     children: <Widget>[
            //       RaisedButton(
            //         shape: RoundedRectangleBorder(
            //             borderRadius: BorderRadius.circular(18.0)),
            //         color: kPrimaryColor,
            //         child: Row(
            //           // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //           children: <Widget>[
            //             Icon(
            //               MyFlutterApp.cog,
            //               size: ScreenUtil().setSp(23,allowFontScalingSelf: true),
            //               color: Colors.white,
            //             ),
            //             SizedBox(
            //               width: ScreenUtil().setWidth(10),
            //             ),
            //             Text(
            //               "Options",
            //               style: TextStyle(
            //                 fontSize: ScreenUtil().setSp(17,allowFontScalingSelf: true),
            //                 color: Colors.white,
            //               ),
            //             ),
            //           ],
            //         ),
            //         onPressed: () {
            //           Navigator.push(
            //             context,
            //             MaterialPageRoute(
            //               builder: (context) =>
            //                   AppUI(onButtonTapped: widget.onButtonTapped),
            //             ),
            //           );
            //         },
            //       ),
            //       SizedBox(
            //         width: ScreenUtil().setWidth(15),
            //       ),
            //       RaisedButton(
            //         shape: RoundedRectangleBorder(
            //           borderRadius: BorderRadius.circular(18.0),
            //         ),
            //         color: kPrimaryColor,
            //         child: Row(
            //           // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //           children: <Widget>[
            //             Icon(
            //               MyFlutterApp.params,
            //               size: ScreenUtil().setSp(23,allowFontScalingSelf: true),
            //               color: Colors.white,
            //             ),
            //             SizedBox(
            //               width: ScreenUtil().setWidth(10),
            //             ),
            //             Text(
            //               "Sort",
            //               style: TextStyle(
            //                 fontSize: ScreenUtil().setSp(17,allowFontScalingSelf: true),
            //                 color: Colors.white,
            //               ),
            //             ),
            //           ],
            //         ),
            //         onPressed: () {
            //           showModalBottomSheet(
            //             context: context,
            //             backgroundColor: Colors.white.withOpacity(0.8),
            //             barrierColor: Colors.black45,
            //             // isScrollControlled: true,
            //             isDismissible: true,
            //             shape: RoundedRectangleBorder(
            //                 borderRadius: BorderRadius.only(
            //               topLeft: Radius.circular(50.0),
            //               topRight: Radius.circular(50.0),
            //             )),
            //             builder: (BuildContext context) {
            //               return Container(
            //                 padding: EdgeInsets.all(5.0),
            //                 height: ScreenUtil().setHeight(263.5),

            //               );
            //             },
            //           );
            //         },
            //       ),
            //     ],
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
