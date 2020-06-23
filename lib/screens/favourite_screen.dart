import 'dart:async';
import 'dart:ui';

import 'package:Flutter/providers/options.dart';
import 'package:Flutter/providers/pagination.dart';
import 'package:Flutter/providers/products.dart';
import 'package:Flutter/widgets/cookie_page.dart';
import 'package:Flutter/widgets/filter_widget.dart';
import 'package:Flutter/widgets/optionsDialog.dart';
import 'package:Flutter/widgets/sortPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/svg.dart';
import '../constant/const.dart';
import '../constant/const.dart';
import '../constant/const.dart';
import 'appui.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FavouriteScreen extends StatefulWidget {
  final ScrollController scrollController;
  final void Function(int) onButtonTapped;
  final bool val;

  const FavouriteScreen(
      {Key key, this.scrollController, this.onButtonTapped, this.val})
      : super(key: key);
  @override
  _FavouriteScreenState createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen>
    with TickerProviderStateMixin {
  TabController _tabController;
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void _onValueChange(int value) async {
    await Provider.of<Options>(context, listen: false).setBuild(build: value);
    setState(() {
      // await Provider.of<Options>(context, listen: false).setBuild(build: value);
      _defaultChoiceIndex1 = value;
      print(value);
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

  @override
  Widget build(BuildContext context) {
    final favProducts = Provider.of<Pagination>(context).favProducts;
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
    List<String> styleNumber = [
      'NP104',
      'NP105',
      'NP106',
      'NP107',
      'NP108',
      'NP109',
      'NP110',
      'NP111',
      'NP112',
      'NP113',
    ];
    List<String> info = [];
    final suggestion = styleNumber
        .where(
            (element) => element.contains(searchValue.toString().toUpperCase()))
        .toList();
    print('Search Selected' + searchSelected.toString());
    return Scaffold(
      body: Container(
        color: Color(0xFFF4F4F4),
        child: Stack(
          children: <Widget>[
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: ScreenUtil().setHeight(22 + 11 + 20 + 40),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(25, 0, 26, 20),
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
                            Rect.fromLTWH(0, 0, bounds.width, bounds.height),
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
                            GestureDetector(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  child: SortPage(),
                                );
                              },
                              child: Padding(
                                padding: EdgeInsets.only(right: 4.0),
                                child: SvgPicture.asset(
                                  'assets/icons/sortIcon.svg',
                                  width: ScreenUtil().setWidth(24),
                                  height: ScreenUtil().setHeight(24),
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            GestureDetector(
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
                                    valueChangeColor: _onValueChangeColor,
                                    valueChangeCerti: _onValueChangeCerti,
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
                            )
                          ],
                        )
                      ],
                    ),
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
                          )
                        : Center(
                            child: Text(
                              'There aren\t any Favourites product added yet!',
                              style: TextStyle(
                                  fontFamily: 'Gilory Black',
                                  color: Colors.grey[400],
                                  fontSize: ScreenUtil()
                                      .setSp(35, allowFontScalingSelf: true),
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
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
                      width: ScreenUtil().setHeight(360),
                      height: ScreenUtil().setHeight(45),
                      margin: EdgeInsets.fromLTRB(
                          25, 11, 26, searchSelected ? 0 : 20),
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
                                  onTap: () {
                                    setState(() {
                                      searchSelected = true;
                                    });
                                    Timer(Duration(milliseconds: 700), () {
                                      setState(() {
                                        searchSelectedDoneButton = true;
                                      });
                                    });
                                  },
                                  onChanged: (value) {
                                    setState(() {
                                      searchValue = value;
                                      // info=styleNumber[].split(value);
                                      // print(styleNumber[1].split(searchValue));
                                    });
                                    // getSearchResult(value.toUpperCase());
                                  },
                                  decoration: InputDecoration(
                                    // contentPadding: EdgeInsets.all(15.0),
                                    suffixIcon: searchSelected
                                        ? GestureDetector(
                                            onTap: () =>
                                                textEditingController.clear(),
                                            child: Icon(Icons.clear),
                                          )
                                        : SizedBox(
                                            height: 0.0,
                                            width: 0.0,
                                          ),
                                    hintText: !searchSelected
                                        ? ''
                                        : 'SEARCH GEMSTORY',
                                    hintStyle: TextStyle(
                                      fontFamily: 'Gilroy Medium',
                                      color: Color(0xFF595959),
                                      fontSize: ScreenUtil().setSp(14,
                                          allowFontScalingSelf: true),
                                    ),
                                    border: InputBorder.none,
                                  ),
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      fontFamily: 'Gilroy Regular',
                                      fontSize: ScreenUtil().setSp(16,
                                          allowFontScalingSelf: true)),
                                ),
                                searchSelected
                                    ? SizedBox(
                                        height: 0.0,
                                        width: 0.0,
                                      )
                                    : Center(child: Text('SEARCH GEMSTORY')),
                                AnimatedContainer(
                                  duration: Duration(milliseconds: 600),
                                  margin: EdgeInsets.only(right: 6.0),
                                  child: SvgPicture.asset(
                                    'assets/icons/notificationIcon.svg',
                                    height: ScreenUtil()
                                        .setHeight(searchSelected ? 0 : 27),
                                    width: ScreenUtil()
                                        .setWidth(searchSelected ? 0 : 27),
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
                              ? GestureDetector(
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
                                      fontSize: ScreenUtil().setSp(18,
                                          allowFontScalingSelf: true),
                                      fontWeight: FontWeight.w500,
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
                        : Container(
                            height: ScreenUtil().setHeight(600.0),
                            width: ScreenUtil().setHeight(360),
                            margin: EdgeInsets.fromLTRB(25, 0, 26, 20),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            child: ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              // physics: BouncingScrollPhysics(),
                              itemCount: suggestion.length,
                              itemBuilder: (context, index) {
                                info = suggestion[index].split(searchValue);
                                print(info);
                                return suggestion.length > 0
                                    ? Padding(
                                        padding: const EdgeInsets.only(
                                            left: 20.0, right: 20.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: <Widget>[
                                            Container(
                                              height: 90.0,
                                              width: 90.0,
                                              // color: Colors.amber,
                                              child: Image.asset(
                                                'assets/images/nosepin12.png',
                                                fit: BoxFit.contain,
                                              ),
                                            ),
                                            // Text(
                                            //   styleNumber[index],
                                            //   style: TextStyle(
                                            //     fontFamily: 'Varela',
                                            //     fontSize: 21.0,
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
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: 'Varela',
                                                  fontSize: 21.0,
                                                ),
                                                children: [
                                                  TextSpan(
                                                    text: info[0],
                                                    style: TextStyle(
                                                      color: Colors.grey,
                                                      // fontWeight: FontWeight.bold,
                                                      fontFamily: 'Varela',
                                                      fontSize: 21.0,
                                                    ),
                                                  ),
                                                  TextSpan(
                                                    text: searchValue,
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontFamily: 'Varela',
                                                      fontSize: 21.0,
                                                    ),
                                                  ),
                                                  TextSpan(
                                                    text: info[1],
                                                    style: TextStyle(
                                                      color: Colors.grey,
                                                      // fontWeight: FontWeight.bold,
                                                      fontFamily: 'Varela',
                                                      fontSize: 21.0,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      )
                                    : Center(
                                        child: Text(
                                          'No Products Found',
                                        ),
                                      );
                              },
                            ),
                          )
                  ],
                ),
              ),
            ),
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
