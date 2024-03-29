import 'dart:async';
import 'dart:ui';
import 'package:Flutter/providers/cart.dart';
import 'package:Flutter/providers/options.dart';
import 'package:Flutter/providers/pagination.dart';
import 'package:Flutter/providers/search.dart';
import 'package:Flutter/providers/user.dart';
import 'package:Flutter/screens/product_detail.dart';
import 'package:Flutter/screens/splash_screen.dart';
import 'package:Flutter/widgets/optionsDialog.dart';
import 'package:Flutter/widgets/snackbar.dart';
import 'package:Flutter/widgets/sortPage.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_advanced_networkimage/provider.dart';
import 'package:flutter_animator/widgets/fading_entrances/fade_in.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/svg.dart';
import '../providers/auth.dart';
import '../widgets/cookie_page.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../providers/notifiaction.dart';
import 'completeSignUp.dart';

bool sortChange = false;
bool screenChange = true;

class ProductOverViewScreen extends StatefulWidget {
  final ScrollController scrollController;
  final void Function(int) onButtonTapped;
  final bool val;
  final void Function(bool) loader;
  final Animation<double> opacityAnimation;

  const ProductOverViewScreen(
      {Key key,
      this.scrollController,
      this.opacityAnimation,
      this.onButtonTapped,
      this.val,
      this.loader})
      : super(key: key);
  @override
  _ProductOverViewScreenState createState() => _ProductOverViewScreenState();
}

class _ProductOverViewScreenState extends State<ProductOverViewScreen>
    with TickerProviderStateMixin {
  TabController _tabController;
  bool isInit = true;
  bool isLoading = false;
  String count;
  int sort;
  int colorr;
  int diamond;
  int _defaultChoiceIndex1;
  int _defaultChoiceIndex2;
  int _defaultChoiceIndex3;
  int _defaultChoiceIndex4;
  final TextEditingController textEditingController = TextEditingController();
  String searchValue = "";
  bool searchSelected = false;
  bool searchSelectedDoneButton = false;

  var _choices;
  var _choices1;
  var _choices2;
  var _choices3;

  GlobalKey scaffoldKey = GlobalKey();

  bool tapNotication = false;
  Animation<int> _characterCount;

  AnimationController controller;
  AnimationController controllerScroll;
  Animation<double> heightAnimation;

  int flag = 0;

  bool ff = true;

  bool isLoadingSort = false;

  @override
  void initState() {
    super.initState();
    controllerScroll = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 600),
      reverseDuration: Duration(milliseconds: 600),
    );
    heightAnimation = Tween(begin: 45.0, end: 0.0).animate(
        CurvedAnimation(curve: Curves.easeInOut, parent: controllerScroll));
    _tabController = TabController(
      length: 5,
      vsync: this,
      initialIndex: 1,
    );
    controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
  }

  Future<void> getProduct() async {
    try {
      await Provider.of<Pagination>(context, listen: false).getSortData();
      var futures = <Future>[
        // Provider.of<UserInfo>(context, listen: false).getuser(context),
        Provider.of<Pagination>(context, listen: false).getProducts(
            page: 1,
            addition: false,
            select: 'featured',
            context: context,
            sortby: Provider.of<Pagination>(context, listen: false).count,
            sort: Provider.of<Pagination>(context, listen: false).sort),
        Provider.of<Pagination>(context, listen: false).getFav(context),
        Provider.of<Options>(context, listen: false).getStringValuesSF(),
        Provider.of<Notif>(context, listen: false)
            .getNotification(context: context),
      ];
      await Future.wait(futures);
      await Future.delayed(Duration(milliseconds: 100), () async {
        await Provider.of<Pagination>(context, listen: false).getProducts(
            addition: false,
            page: 1,
            context: context,
            select: 'all',
            sortby: Provider.of<Pagination>(context, listen: false).count,
            sort: Provider.of<Pagination>(context, listen: false).sort);
      });
      await Future.delayed(Duration(milliseconds: 100), () async {
        await Provider.of<Pagination>(context, listen: false).getProducts(
            addition: false,
            page: 1,
            context: context,
            select: 'isnew',
            sortby: Provider.of<Pagination>(context, listen: false).count,
            sort: Provider.of<Pagination>(context, listen: false).sort);
      });
      await Future.delayed(Duration(milliseconds: 100), () async {
        await Provider.of<Pagination>(context, listen: false).getProducts(
            addition: false,
            page: 1,
            context: context,
            select: 'navratna',
            sortby: Provider.of<Pagination>(context, listen: false).count,
            sort: Provider.of<Pagination>(context, listen: false).sort);
      });
      await Future.delayed(Duration(milliseconds: 100), () async {
        await Provider.of<Pagination>(context, listen: false).getProducts(
            addition: false,
            page: 1,
            context: context,
            select: 'fancyDiamond',
            sortby: Provider.of<Pagination>(context, listen: false).count,
            sort: Provider.of<Pagination>(context, listen: false).sort);
      });
      // await Provider.of<Pagination>(context, listen: false).getProducts(
      //     page: 1,
      //     addition: false,
      //     select: 'all',
      //     context: context,
      //     sortby: Provider.of<Pagination>(context, listen: false).count,
      //     sort: Provider.of<Pagination>(context, listen: false).sort);
      // await Provider.of<Pagination>(context, listen: false).getProducts(
      //     page: 1,
      //     addition: false,
      //     select: 'isnew',
      //     context: context,
      //     sortby: Provider.of<Pagination>(context, listen: false).count,
      //     sort: Provider.of<Pagination>(context, listen: false).sort);
      // await Provider.of<Pagination>(context, listen: false).getProducts(
      //     page: 1,
      //     addition: false,
      //     select: 'navratna',
      //     context: context,
      //     sortby: Provider.of<Pagination>(context, listen: false).count,
      //     sort: Provider.of<Pagination>(context, listen: false).sort);
      // await Provider.of<Pagination>(context, listen: false).getProducts(
      //     addition: false,
      //     page: 1,
      //     context: context,
      //     select: 'fancyDiamond',
      //     sortby: Provider.of<Pagination>(context, listen: false).count,
      //     sort: Provider.of<Pagination>(context, listen: false).sort);
      await Provider.of<UserInfo>(context, listen: false).getuser(context);

      await Provider.of<Cart>(context, listen: false).getCart(context: context);
      if (Provider.of<Auth>(context, listen: false).isLogin &&
          Provider.of<Auth>(context, listen: false).autoLogin == false)
        Provider.of<Auth>(context, listen: false).changeLog();

      if (Provider.of<Auth>(context, listen: false).isLogin == false &&
          Provider.of<Auth>(context, listen: false).autoLogin)
        Provider.of<Auth>(context, listen: false).changeAuto();
    } catch (err) {
      dataSelect(
          context: context,
          titleText: 'Alert!',
          buttonText: "Okay",
          contentText: err.toString(),
          onPressed: () {
            Navigator.pop(context);
          },
          gif: "assets/images/alert.gif");
    }
  }

  @override
  void didChangeDependencies() async {
    if (isInit) {
      try {
        if (mounted)
          setState(() {
            isLoading = true;
          });
        if (Provider.of<Auth>(context, listen: false).isLogin ||
            (Provider.of<Auth>(context, listen: false).autoLogin)) {
          await getProduct();

          widget.loader(false);
        }
      } catch (err) {
        dataSelect(
            context: context,
            titleText: 'Alert!',
            buttonText: "Okay",
            contentText: err.toString(),
            onPressed: () {
              Navigator.pop(context);
            },
            gif: "assets/images/alert.gif");
      } finally {
        if (mounted)
          setState(() {
            isLoading = false;
            isInit = false;
            super.didChangeDependencies();
          });
      }
      // if (screenChange) {
      //   if (context != null) {
      //     // await Provider.of<UserInfo>(context, listen: false).getuser(context);

      //   }
      // }
      setState(() {
        screenChange = false;
      });
    }
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
      flag = 1;
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

  void completeSignUp() async {
    Navigator.of(context).pop();
    String date =
        await Provider.of<UserInfo>(context, listen: false).getDate(context);
    if (date != null) {
      int d = DateTime.now().difference(DateTime.parse(date)).inDays;
      if (d >= 1) {
        await Provider.of<UserInfo>(context, listen: false).getuser(context);

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CompleteSignUp(),
          ),
        );
      } else {
        dataSelect(
            context: context,
            titleText: 'Alert!',
            buttonText: "Okay",
            contentText: 'Request has already been noted!',
            onPressed: () {
              Navigator.pop(context);
            },
            gif: "assets/images/identi.gif");
      }
    } else {
      await Provider.of<UserInfo>(context, listen: false).getuser(context);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CompleteSignUp(),
        ),
      );
    }
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

  void changeFlag() {
    setState(() {
      flag = 0;
    });
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  List<dynamic> suggestion;
  bool isLoadingSearch = false;
  Future<void> getSearch(query) async {
    try {
      // Navigator.of(context).pop(Navigator.of(context).pop());
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
          buttonText: "Okay",
          contentText: 'Request has already been noted!',
          onPressed: () {
            Navigator.pop(context);
          },
          gif: "assets/images/identi.gif");
    } finally {
      isLoadingSearch = false;
    }

    // print(suggestion);
    // setState(() {

    // });
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
    _choices = Provider.of<Pagination>(context, listen: false).build;
    _choices1 = Provider.of<Pagination>(context, listen: false).color;
    _choices2 = Provider.of<Pagination>(context, listen: false).cert;
    _choices3 = Provider.of<Pagination>(context, listen: false).diamondQuality;
    ScreenUtil.init(context,
        width: 411.42857142857144,
        height: 774.8571428571429,
        allowFontScaling: true);
    // ScreenUtil.init(context,
    //     width: MediaQuery.of(context).size.width,
    //     height: MediaQuery.of(context).size.height,
    //     allowFontScaling: true);
    // List<String> styleNumber = [
    //   'NP104',
    //   'NP105',
    //   'NP106',
    //   'NP107',
    //   'NP108',
    //   'NP109',
    //   'NP110',
    //   'NP111',
    //   'NP112',
    //   'NP113',
    // ];

    List<String> info = [];
    // suggestion = styleNumber
    //     .where(
    //         (element) => element.contains(searchValue.toString().toUpperCase()))
    //     .toList();
    // print('Search Selected' + searchSelected.toString());
    return Scaffold(
      resizeToAvoidBottomInset: false,
      resizeToAvoidBottomPadding: false,
      key: scaffoldKey,
      body: AnimatedSwitcher(
        duration: Duration(seconds: 1),
        child: isLoading
            ? SplashScreen()
            : Container(
                color: Color(0xFFF4F4F4),
                child: Stack(
                  children: <Widget>[
                    Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          widget.val
                              ? FadeTransition(
                                  opacity: widget.opacityAnimation,
                                  child: SizedBox(
                                    height: ScreenUtil()
                                        .setHeight(22 + 45 + 20 + 20),
                                  ),
                                )
                              : FadeTransition(
                                  opacity: widget.opacityAnimation,
                                  child: SizedBox(
                                    height: ScreenUtil().setHeight(22),
                                  ),
                                ),
                          widget.val
                              ? FadeTransition(
                                  opacity: widget.opacityAnimation,
                                  child: Container(
                                    width: ScreenUtil().setWidth(357),
                                    margin: EdgeInsets.fromLTRB(24, 0, 0, 15),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Container(
                                          height: ScreenUtil().setHeight(20),
                                          width: ScreenUtil().setWidth(265),
                                          child: TabBar(
                                            onTap: (value) async {
                                              if (Provider.of<Pagination>(
                                                          context,
                                                          listen: false)
                                                      .isVerified ==
                                                  false) {
                                                // setState(() {
                                                //   _tabController.index = 1;
                                                // });
                                                var date =
                                                    await Provider.of<UserInfo>(
                                                            context,
                                                            listen: false)
                                                        .getDate(context);
                                                if (date != null) {
                                                  int d = DateTime.now()
                                                      .difference(
                                                          DateTime.parse(date))
                                                      .inDays;
                                                  if (d < 1) {
                                                    ff = false;
                                                    setState(() {
                                                      _tabController.index = 1;
                                                    });
                                                    dataSelect(
                                                        context: context,
                                                        titleText: 'Alert!',
                                                        buttonText: 'Okay',
                                                        contentText:
                                                            'Request has already been noted!',
                                                        onPressed: () {
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        gif:
                                                            "assets/images/identi.gif");
                                                  }
                                                }
                                              }
                                              if (!Provider.of<Pagination>(
                                                          context,
                                                          listen: false)
                                                      .isVerified &&
                                                  ff) {
                                                setState(() {
                                                  _tabController.index = 1;
                                                });
                                                dataSelect(
                                                    context: context,
                                                    titleText: 'Important!',
                                                    buttonText:
                                                        'Complete SignUp',
                                                    contentText:
                                                        "To get complete access of the app, you need to first verify yourself!",
                                                    onPressed: completeSignUp,
                                                    gif:
                                                        "assets/images/alert.gif");
                                              }
                                              if (Provider.of<UserInfo>(context,
                                                          listen: false)
                                                      .street ==
                                                  "-") {
                                                setState(() {
                                                  _tabController.index = 1;
                                                });
                                              }
                                            },
                                            controller: _tabController,
                                            labelStyle: TextStyle(
                                              fontFamily: 'Gilroy Bold',
                                              color: Colors.white,
                                              fontSize: ScreenUtil().setSp(16,
                                                  allowFontScalingSelf: true),
                                            ),
                                            unselectedLabelStyle: TextStyle(
                                              fontFamily: 'Gilroy Regular',
                                              color: Colors.white,
                                              fontSize: ScreenUtil().setSp(14,
                                                  allowFontScalingSelf: true),
                                            ),
                                            labelPadding: EdgeInsets.only(
                                                left: 5.0, right: 5.0),
                                            isScrollable: true,
                                            indicator: BoxDecoration(),
                                            tabs: [
                                              Tab(
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
                                                        0,
                                                        0,
                                                        bounds.width,
                                                        bounds.height),
                                                  ),
                                                  child: Text(
                                                    'ALL',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Tab(
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
                                                        0,
                                                        0,
                                                        bounds.width,
                                                        bounds.height),
                                                  ),
                                                  child: Text(
                                                    'FEATURED',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Tab(
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
                                                        0,
                                                        0,
                                                        bounds.width,
                                                        bounds.height),
                                                  ),
                                                  // : LinearGradient(
                                                  //     colors: [
                                                  //       Color(0xFFA49797),
                                                  //       Color(0xFFA49797),
                                                  //     ],
                                                  //     begin: Alignment.topLeft,
                                                  //     end:
                                                  //         Alignment.bottomRight,
                                                  //   ).createShader(
                                                  //     Rect.fromLTWH(
                                                  //         0,
                                                  //         0,
                                                  //         bounds.width,
                                                  //         bounds.height),
                                                  //   ),
                                                  child: Text(
                                                    'NEW',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Tab(
                                                child: ShaderMask(
                                                  shaderCallback: (bounds) =>
                                                      // _tabController.index == 3
                                                      // ?
                                                      LinearGradient(
                                                    colors: [
                                                      Color(0xFF34B0D9),
                                                      Color(0xFF3685CB),
                                                    ],
                                                    begin: Alignment.topLeft,
                                                    end: Alignment.bottomRight,
                                                  ).createShader(
                                                    Rect.fromLTWH(
                                                        0,
                                                        0,
                                                        bounds.width,
                                                        bounds.height),
                                                  ),
                                                  // : LinearGradient(
                                                  //     colors: [
                                                  //       Color(0xFFA49797),
                                                  //       Color(0xFFA49797),
                                                  //     ],
                                                  //     begin: Alignment.topLeft,
                                                  //     end:
                                                  //         Alignment.bottomRight,
                                                  //   ).createShader(
                                                  //     Rect.fromLTWH(
                                                  //         0,
                                                  //         0,
                                                  //         bounds.width,
                                                  //         bounds.height),
                                                  //   ),
                                                  child: Text(
                                                    'NAVRATNA',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Tab(
                                                  child: ShaderMask(
                                                shaderCallback: (bounds) =>
                                                    // _tabController.index == 4
                                                    //     ?
                                                    LinearGradient(
                                                  colors: [
                                                    Color(0xFF34B0D9),
                                                    Color(0xFF3685CB),
                                                  ],
                                                  begin: Alignment.topLeft,
                                                  end: Alignment.bottomRight,
                                                ).createShader(
                                                  Rect.fromLTWH(
                                                      0,
                                                      0,
                                                      bounds.width,
                                                      bounds.height),
                                                ),
                                                // : LinearGradient(
                                                //     colors: [
                                                //       Color(0xFFA49797),
                                                //       Color(0xFFA49797),
                                                //     ],
                                                //     begin: Alignment.topLeft,
                                                //     end: Alignment.bottomRight,
                                                //   ).createShader(
                                                //     Rect.fromLTWH(
                                                //         0,
                                                //         0,
                                                //         bounds.width,
                                                //         bounds.height),
                                                //   ),
                                                child: Text(
                                                  'FANCY DIAMOND',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              )),
                                            ],
                                          ),
                                        ),
                                        // SizedBox(
                                        //   width: ScreenUtil().setWidth(30),
                                        // ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: <Widget>[
                                            Tooltip(
                                              message: "Sort",
                                              waitDuration:
                                                  Duration(seconds: 4),
                                              child: GestureDetector(
                                                onTap: () {
                                                  showDialog(
                                                    context: context,
                                                    child: SortPage(
                                                      scrollController: widget
                                                          .scrollController,
                                                    ),
                                                  ).then((value) async {
                                                    // bool checkValue = false;
                                                    setState(() {
                                                      // checkValue = Provider.of<
                                                      //             Pagination>(
                                                      //         context,
                                                      //         listen: false)
                                                      //     .sortChange;
                                                      isLoadingSort = true;
                                                    });
                                                    // print("CheckValue: " +
                                                    //     checkValue.toString());
                                                    try {
                                                      print("Inside Try");
                                                      if (sortChange) {
                                                        print("Inside Logic");
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
                                                        // Provider.of<Pagination>(
                                                        //         context,
                                                        //         listen: false)
                                                        //     .changeSort();
                                                      }
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
                                                    } finally {
                                                      setState(() {
                                                        sortChange = false;
                                                        isLoadingSort = false;
                                                      });
                                                    }
                                                  });
                                                },
                                                child: Padding(
                                                  padding: EdgeInsets.only(
                                                      right: 8.0),
                                                  child: SvgPicture.asset(
                                                    'assets/icons/sortIcon.svg',
                                                    width: ScreenUtil()
                                                        .setWidth(24),
                                                    height: ScreenUtil()
                                                        .setHeight(24),
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Tooltip(
                                              message: "Options",
                                              waitDuration:
                                                  Duration(seconds: 4),
                                              child: GestureDetector(
                                                onTap: () {
                                                  showDialog(
                                                    context: context,
                                                    barrierDismissible: true,
                                                    child: OptionsDialog(
                                                      choicesBuild: _choices,
                                                      choiceColor: _choices1,
                                                      choiceCertification:
                                                          _choices2,
                                                      choiceDiamondQuality:
                                                          _choices3,
                                                      defValue:
                                                          _defaultChoiceIndex1,
                                                      defValue1:
                                                          _defaultChoiceIndex2,
                                                      defValue2:
                                                          _defaultChoiceIndex3,
                                                      defValue3:
                                                          _defaultChoiceIndex4,
                                                      valueChangeBuild:
                                                          _onValueChange,
                                                      valueChangeColor:
                                                          _onValueChangeColor,
                                                      valueChangeCerti:
                                                          _onValueChangeCerti,
                                                      valueChangeDQ:
                                                          _onValueChangeDQ,
                                                    ),
                                                  );
                                                },
                                                child: SvgPicture.asset(
                                                  'assets/icons/optionsIcon.svg',
                                                  width:
                                                      ScreenUtil().setWidth(24),
                                                  height: ScreenUtil()
                                                      .setHeight(24),
                                                  color: Colors.black,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              : FadeTransition(
                                  opacity: widget.opacityAnimation,
                                  child: SizedBox(
                                    height: ScreenUtil().setHeight(15),
                                  ),
                                ),
                          AnimatedContainer(
                            duration: Duration(milliseconds: 600),
                            height:
                                ScreenUtil().setHeight(!widget.val ? 15 : 0),
                          ),
                          Expanded(
                            child: isLoadingSort
                                ? Center(
                                    child: CircularProgressIndicator(),
                                  )
                                : TabBarView(
                                    physics: Provider.of<Pagination>(context,
                                                    listen: false)
                                                .isVerified &&
                                            Provider.of<UserInfo>(context,
                                                        listen: false)
                                                    .street !=
                                                "-"
                                        ? ClampingScrollPhysics()
                                        : NeverScrollableScrollPhysics(),
                                    controller: _tabController,
                                    children: [
                                      CookiePage(
                                        globalKey: scaffoldKey,
                                        products: Provider.of<Pagination>(
                                                context,
                                                listen: true)
                                            .allProducts,
                                        scrollController:
                                            widget.scrollController,
                                        select: 'all',
                                        build: _defaultChoiceIndex1,
                                        color: _defaultChoiceIndex2,
                                        cert: _defaultChoiceIndex3,
                                        diamond: _defaultChoiceIndex4,
                                        characterCount: _characterCount,
                                        controller: controller,
                                        flag: flag,
                                        valueChangeBuild: _onValueChange,
                                        valueChangeColor: _onValueChangeColor,
                                        valueChangeCerti: _onValueChangeCerti,
                                        valueChangeDQ: _onValueChangeDQ,
                                      ),
                                      CookiePage(
                                        globalKey: scaffoldKey,
                                        products: Provider.of<Pagination>(
                                                context,
                                                listen: true)
                                            .featuredProducts,
                                        scrollController:
                                            widget.scrollController,
                                        select: 'featured',
                                        sort: sort,
                                        count: count,
                                        build: _defaultChoiceIndex1,
                                        color: _defaultChoiceIndex2,
                                        cert: _defaultChoiceIndex3,
                                        diamond: _defaultChoiceIndex4,
                                        characterCount: _characterCount,
                                        controller: controller,
                                        flag: flag,
                                        valueChangeBuild: _onValueChange,
                                        valueChangeColor: _onValueChangeColor,
                                        valueChangeCerti: _onValueChangeCerti,
                                        valueChangeDQ: _onValueChangeDQ,
                                      ),
                                      CookiePage(
                                        globalKey: scaffoldKey,
                                        products: Provider.of<Pagination>(
                                                context,
                                                listen: true)
                                            .newProducts,
                                        scrollController:
                                            widget.scrollController,
                                        select: 'isnew',
                                        sort: sort,
                                        count: count,
                                        build: _defaultChoiceIndex1,
                                        color: _defaultChoiceIndex2,
                                        cert: _defaultChoiceIndex3,
                                        diamond: _defaultChoiceIndex4,
                                        characterCount: _characterCount,
                                        controller: controller,
                                        flag: flag,
                                        valueChangeBuild: _onValueChange,
                                        valueChangeColor: _onValueChangeColor,
                                        valueChangeCerti: _onValueChangeCerti,
                                        valueChangeDQ: _onValueChangeDQ,
                                      ),
                                      CookiePage(
                                        globalKey: scaffoldKey,
                                        products: Provider.of<Pagination>(
                                                context,
                                                listen: true)
                                            .highestSellingProducts,
                                        scrollController:
                                            widget.scrollController,
                                        select: 'navratna',
                                        sort: sort,
                                        count: count,
                                        build: _defaultChoiceIndex1,
                                        color: _defaultChoiceIndex2,
                                        cert: _defaultChoiceIndex3,
                                        diamond: _defaultChoiceIndex4,
                                        characterCount: _characterCount,
                                        controller: controller,
                                        flag: flag,
                                        valueChangeBuild: _onValueChange,
                                        valueChangeColor: _onValueChangeColor,
                                        valueChangeCerti: _onValueChangeCerti,
                                        valueChangeDQ: _onValueChangeDQ,
                                      ),
                                      CookiePage(
                                        globalKey: scaffoldKey,
                                        products: Provider.of<Pagination>(
                                                context,
                                                listen: true)
                                            .fancyDiamond,
                                        scrollController:
                                            widget.scrollController,
                                        select: 'fancyDiamond',
                                        sort: sort,
                                        count: count,
                                        build: _defaultChoiceIndex1,
                                        color: _defaultChoiceIndex2,
                                        cert: _defaultChoiceIndex3,
                                        diamond: _defaultChoiceIndex4,
                                        characterCount: _characterCount,
                                        controller: controller,
                                        flag: flag,
                                        valueChangeBuild: _onValueChange,
                                        valueChangeColor: _onValueChangeColor,
                                        valueChangeCerti: _onValueChangeCerti,
                                        valueChangeDQ: _onValueChangeDQ,
                                      ),
                                    ],
                                  ),
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

                    FadeTransition(
                      opacity: widget.opacityAnimation,
                      child: Container(
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
                                    AnimatedContainer(
                                      duration: Duration(milliseconds: 600),
                                      curve: Curves.easeInOut,
                                      padding: EdgeInsets.only(left: 10.0),
                                      width: ScreenUtil()
                                          .setWidth(searchSelected ? 305 : 360),
                                      height: ScreenUtil().setHeight(45),
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
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
                                              height:
                                                  ScreenUtil().setHeight(40),
                                              child: TextField(
                                                enabled:
                                                    !widget.val ? false : true,
                                                controller:
                                                    textEditingController,
                                                onTap: () async {
                                                  setState(() {
                                                    searchSelected = true;
                                                  });
                                                  Timer(
                                                      Duration(
                                                          milliseconds: 700),
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
                                                    await getSearch(searchValue
                                                        .toUpperCase());
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
                                                    fontSize: ScreenUtil().setSp(
                                                        14,
                                                        allowFontScalingSelf:
                                                            true),
                                                  ),
                                                  border: InputBorder.none,
                                                ),
                                                textAlign: searchSelected
                                                    ? TextAlign.start
                                                    : TextAlign.center,
                                                style: TextStyle(
                                                    fontFamily:
                                                        'Gilroy Regular',
                                                    fontSize: ScreenUtil().setSp(
                                                        16,
                                                        allowFontScalingSelf:
                                                            true)),
                                              ),
                                            ),
                                          ),
                                          AnimatedContainer(
                                            duration:
                                                Duration(milliseconds: 600),
                                            margin: EdgeInsets.only(right: 6.0),
                                            height: ScreenUtil().setHeight(
                                                searchSelected ? 27 : 0),
                                            width: ScreenUtil().setWidth(
                                                searchSelected ? 27 : 0),
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
                                                        allowFontScalingSelf:
                                                            true)
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
                                            child: Container(
                                              width: 50.0,
                                              child: Center(
                                                child: AnimatedContainer(
                                                  duration: Duration(
                                                      milliseconds: 600),
                                                  margin: EdgeInsets.only(
                                                      right: 6.0),
                                                  alignment:
                                                      Alignment.centerRight,
                                                  height: ScreenUtil()
                                                      .setHeight(searchSelected
                                                          ? 0
                                                          : 50),
                                                  width: ScreenUtil().setWidth(
                                                      searchSelected ? 0 : 50),
                                                  color: Colors.transparent,
                                                  child: Provider.of<Notif>(
                                                                  context,
                                                                  listen: true)
                                                              .notifications
                                                              .length >
                                                          0
                                                      ? Provider.of<Notif>(
                                                                  context,
                                                                  listen: true)
                                                              .checkForDelete()
                                                          ? SvgPicture.asset(
                                                              'assets/icons/notificationIcon.svg',
                                                              color:
                                                                  Colors.black,
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
                                                              .setWidth(
                                                                  searchSelected
                                                                      ? 0
                                                                      : 25),
                                                          color: Colors.black,
                                                        ),
                                                ),
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
                                              onTap: !widget.val
                                                  ? null
                                                  : () {
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
                                                    },
                                              child: Text(
                                                'Done',
                                                style: TextStyle(
                                                  fontFamily: 'Gilroy Bold',
                                                  color: Colors.black,
                                                  fontSize: ScreenUtil().setSp(
                                                      16,
                                                      allowFontScalingSelf:
                                                          true),
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
                                          margin: EdgeInsets.fromLTRB(
                                              25, 0, 26, 20),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(15.0),
                                          ),
                                          child: suggestion.length > 0
                                              ? ListView.builder(
                                                  shrinkWrap: true,
                                                  scrollDirection:
                                                      Axis.vertical,
                                                  physics:
                                                      BouncingScrollPhysics(),
                                                  itemCount:
                                                      Provider.of<Searchh>(
                                                              context,
                                                              listen: false)
                                                          .searchResult
                                                          .length,
                                                  itemBuilder:
                                                      (context, index) {
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
                                                                  context:
                                                                      context,
                                                                  styleNumber:
                                                                      suggestion[
                                                                              index]
                                                                          .styleNumber);
                                                          FocusScopeNode
                                                              currentFocus =
                                                              FocusScope.of(
                                                                  context);
                                                          currentFocus
                                                              .unfocus();
                                                          textEditingController
                                                              .clear();
                                                          setState(() {
                                                            searchValue = "";
                                                            searchSelected =
                                                                false;
                                                            searchSelectedDoneButton =
                                                                false;
                                                          });
                                                          Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                              builder: (context) =>
                                                                  ProductDetail(
                                                                colorKey:
                                                                    'yellow',
                                                                select: 'all',
                                                                diamondKey: Provider.of<
                                                                            Pagination>(
                                                                        context,
                                                                        listen:
                                                                            false)
                                                                    .diamondQuality[_defaultChoiceIndex4],
                                                                certPrice: Provider.of<Pagination>(
                                                                            context,
                                                                            listen:
                                                                                false)
                                                                        .isPriced
                                                                    ? Provider.of<Pagination>(
                                                                            context,
                                                                            listen:
                                                                                false)
                                                                        .certPrices[Provider.of<Pagination>(
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
                                                              titleText:
                                                                  'Alert!',
                                                              buttonText:
                                                                  'Okay',
                                                              contentText: err
                                                                  .toString(),
                                                              onPressed: () {
                                                                Navigator.pop(
                                                                    context);
                                                              },
                                                              gif:
                                                                  "assets/images/alert.gif");
                                                        }
                                                      },
                                                      child: Container(
                                                        color:
                                                            Colors.transparent,
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
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
                                                              height:
                                                                  ScreenUtil()
                                                                      .setHeight(
                                                                          90),
                                                              width:
                                                                  ScreenUtil()
                                                                      .setWidth(
                                                                          90),
                                                              // color: Colors.amber,
                                                              child: Image(
                                                                // suggestion[
                                                                //         index]
                                                                //     .image,
                                                                image:
                                                                    CachedNetworkImageProvider(
                                                                  suggestion[
                                                                          index]
                                                                      .image,
                                                                ),
                                                                fit:
                                                                    BoxFit.fill,
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
                                                                children: [
                                                                  TextSpan(
                                                                    text:
                                                                        info[0],
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
                                                                    text:
                                                                        info[1],
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
                    ),
                    // : FadeTransition(
                    //     opacity: widget.opacityAnimation,
                    //     child: SizedBox(
                    //       height: 0.0,
                    //     ),
                    //   ),
                    // Positioned(
                    //   left: ScreenUtil().setWidth(37),
                    //   top: ScreenUtil().setHeight(110),
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    //     children: <Widget>[
                    //       RaisedButton(
                    //         shape: RoundedRectangleBorder(
                    //           borderRadius: BorderRadius.circular(18.0),
                    //         ),
                    //         color: kPrimaryColor,
                    //         child: Row(
                    //           // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    //           children: <Widget>[
                    //             Icon(
                    //               MyFlutterApp.cog,
                    //               color: Colors.white,
                    //               size: ScreenUtil()
                    //                   .setSp(23, allowFontScalingSelf: true),
                    //             ),
                    //             SizedBox(
                    //               width: ScreenUtil().setWidth(10),
                    //             ),
                    //             Text(
                    //               "Options",
                    //               style: TextStyle(
                    //                 fontSize: ScreenUtil()
                    //                     .setSp(17, allowFontScalingSelf: true),
                    //                 color: Colors.white,
                    //               ),
                    //             ),
                    //           ],
                    //         ),
                    //         onPressed: () {
                    //           Navigator.push(
                    //             context,
                    //             MaterialPageRoute(
                    //               builder: (context) => AppUI(
                    //                   onButtonTapped: widget.onButtonTapped),
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
                    //               color: Colors.white,
                    //               size: ScreenUtil()
                    //                   .setSp(23, allowFontScalingSelf: true),
                    //             ),
                    //             SizedBox(
                    //               width: ScreenUtil().setWidth(10),
                    //             ),
                    //             Text(
                    //               "Sort",
                    //               style: TextStyle(
                    //                 fontSize: ScreenUtil()
                    //                     .setSp(17, allowFontScalingSelf: true),
                    //                 color: Colors.white,
                    //               ),
                    //             ),
                    //           ],
                    //         ),
                    //         // onPressed: showPicker,
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
                    //                 height: size.height * 0.34,
                    //                 child: FilterForProduct(),
                    //               );
                    //             },
                    //           );
                    //         },
                    //       ),
                    //       // popUpButton(),
                    //     ],
                    //   ),
                    // ),
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
                                        child:
                                            Provider.of<Notif>(context,
                                                            listen: true)
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
                                                        begin:
                                                            Alignment.topLeft,
                                                        end: Alignment
                                                            .bottomRight,
                                                      ).createShader(
                                                              Rect.fromLTWH(
                                                                  0,
                                                                  0,
                                                                  bounds.width,
                                                                  bounds
                                                                      .height)),
                                                      child: Text(
                                                        'No new notifications!',
                                                        style: TextStyle(
                                                          fontFamily:
                                                              'Gilroy Medium',
                                                          fontSize: ScreenUtil()
                                                              .setSp(20,
                                                                  allowFontScalingSelf:
                                                                      true),
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                : ListView.builder(
                                                    physics:
                                                        BouncingScrollPhysics(),
                                                    itemCount:
                                                        Provider.of<Notif>(
                                                                context,
                                                                listen: true)
                                                            .notifications
                                                            .length,
                                                    itemBuilder:
                                                        (context, index) {
                                                      return Container(
                                                        width: ScreenUtil()
                                                            .setWidth(
                                                                260 + 15 + 15),
                                                        child: Dismissible(
                                                          // dismissThresholds: {
                                                          //   DismissDirection
                                                          //       .startToEnd: 0.4
                                                          // },
                                                          key: UniqueKey(),
                                                          direction:
                                                              DismissDirection
                                                                  .startToEnd,
                                                          background: Container(
                                                            color: Colors.red,
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(15),
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Icon(
                                                                      Icons
                                                                          .delete,
                                                                      color: Colors
                                                                          .white),
                                                                  SizedBox(
                                                                    width: ScreenUtil()
                                                                        .setWidth(
                                                                            5),
                                                                  ),
                                                                  Text(
                                                                    'Delete Notification',
                                                                    style:
                                                                        TextStyle(
                                                                      fontFamily:
                                                                          'Gilroy Regular',
                                                                      color: Colors
                                                                          .white,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),

                                                          // confirmDismiss: (DismissDirection
                                                          //     direction) async {

                                                          // },
                                                          onDismissed:
                                                              (DismissDirection
                                                                  direction) async {
                                                            await Provider.of<
                                                                        Notif>(
                                                                    context,
                                                                    listen:
                                                                        false)
                                                                .deleteNotification(
                                                                    context:
                                                                        context,
                                                                    id: Provider.of<Notif>(
                                                                            context,
                                                                            listen:
                                                                                false)
                                                                        .notifications[
                                                                            index]
                                                                        .id);
                                                          },
                                                          child:
                                                              GestureDetector(
                                                            onTap: () async {
                                                              await Provider.of<
                                                                          Notif>(
                                                                      context,
                                                                      listen:
                                                                          false)
                                                                  .readNNotification(
                                                                      context:
                                                                          context,
                                                                      id: Provider.of<Notif>(
                                                                              context,
                                                                              listen:
                                                                                  false)
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
                                                              margin: EdgeInsets
                                                                  .only(
                                                                      bottom:
                                                                          20),
                                                              width:
                                                                  ScreenUtil()
                                                                      .setWidth(
                                                                          260),
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .center,
                                                                children: <
                                                                    Widget>[
                                                                  ShaderMask(
                                                                    shaderCallback:
                                                                        (bounds) =>
                                                                            LinearGradient(
                                                                      colors: [
                                                                        Color(
                                                                            0xFF34BDDD),
                                                                        Color(
                                                                            0xFF367DC8),
                                                                      ],
                                                                      begin: Alignment
                                                                          .topLeft,
                                                                      end: Alignment
                                                                          .bottomRight,
                                                                    ).createShader(
                                                                      Rect.fromLTWH(
                                                                          0,
                                                                          0,
                                                                          bounds
                                                                              .width,
                                                                          bounds
                                                                              .height),
                                                                    ),
                                                                    child: SvgPicture
                                                                        .asset(
                                                                      "assets/icons/ordersyet.svg",
                                                                      height: ScreenUtil()
                                                                          .setHeight(
                                                                              39),
                                                                      width: ScreenUtil()
                                                                          .setWidth(
                                                                              32),
                                                                      color: Colors
                                                                          .white,
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                    width: ScreenUtil()
                                                                        .setWidth(
                                                                            23),
                                                                  ),
                                                                  Container(
                                                                    width: ScreenUtil()
                                                                        .setWidth(
                                                                            204),
                                                                    child:
                                                                        Column(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: <
                                                                          Widget>[
                                                                        Align(
                                                                          alignment:
                                                                              Alignment.centerRight,
                                                                          child:
                                                                              Text(
                                                                            DateFormat('dd MMM, yyyy').add_jm().format(Provider.of<Notif>(context, listen: false).notifications[index].createdAt),
                                                                            style:
                                                                                TextStyle(
                                                                              fontFamily: "Gilroy Light",
                                                                              fontSize: ScreenUtil().setSp(12, allowFontScalingSelf: true),
                                                                              fontWeight: FontWeight.w600,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        SizedBox(
                                                                          height:
                                                                              ScreenUtil().setHeight(7.0),
                                                                        ),
                                                                        Text(
                                                                          Provider.of<Notif>(context, listen: false)
                                                                              .notifications[index]
                                                                              .title,
                                                                          style: TextStyle(
                                                                              fontFamily: "Gilroy Light",
                                                                              fontSize: ScreenUtil().setSp(18, allowFontScalingSelf: true),
                                                                              fontWeight: Provider.of<Notif>(context, listen: true).notifications[index].read ? FontWeight.normal : FontWeight.bold),
                                                                        ),
                                                                        SizedBox(
                                                                          height:
                                                                              ScreenUtil().setHeight(4),
                                                                        ),
                                                                        Text(
                                                                          Provider.of<Notif>(context, listen: false)
                                                                              .notifications[index]
                                                                              .body,
                                                                          // "Your order has been processed",
                                                                          style:
                                                                              TextStyle(
                                                                            fontFamily:
                                                                                "Gilroy Light",
                                                                            fontSize:
                                                                                ScreenUtil().setSp(12, allowFontScalingSelf: true),
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
                                        size: ScreenUtil().setSp(30,
                                            allowFontScalingSelf: true),
                                      ),
                                    ),
                                    // ),
                                  ),
                                  Positioned(
                                    top: ScreenUtil().setHeight(425),
                                    left: ScreenUtil().setWidth(260),
                                    child: Provider.of<Notif>(context,
                                                    listen: true)
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
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                              boxShadow: <BoxShadow>[
                                                BoxShadow(
                                                  blurRadius: 10,
                                                  color: Colors.black
                                                      .withOpacity(0.37),
                                                  offset: Offset(1, 3),
                                                ),
                                              ],
                                              color: Colors.white,
                                            ),
                                            child: Material(
                                              type: MaterialType.transparency,
                                              elevation: 6.0,
                                              color: Colors.transparent,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              child: InkWell(
                                                splashColor: Colors.cyan[100]
                                                    .withOpacity(0.8),
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                onTap: () async {
                                                  Provider.of<Notif>(context,
                                                              listen: false)
                                                          .checkForDelete()
                                                      ? await Provider.of<
                                                                  Notif>(
                                                              context,
                                                              listen: false)
                                                          .deleteAll(
                                                              context: context)
                                                      : await Provider.of<
                                                                  Notif>(
                                                              context,
                                                              listen: false)
                                                          .readAll(
                                                              context: context);
                                                },
                                                child: Center(
                                                  child: Text(
                                                    Provider.of<Notif>(context,
                                                                listen: false)
                                                            .checkForDelete()
                                                        ? 'Delete All'
                                                        : 'Read All',
                                                    style: TextStyle(
                                                      fontFamily:
                                                          "Gilroy Medium",
                                                      fontSize: ScreenUtil().setSp(
                                                          12,
                                                          allowFontScalingSelf:
                                                              true),
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
                  ],
                ),
              ),
      ),
    );
  }
}

class CurvePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = Colors.white;
    paint.style = PaintingStyle.fill;

    // var path = Path();
    // // var paint = Paint();

    // path.moveTo(0, size.height * 0.84);
    // path.quadraticBezierTo(size.width * 0.25, size.height * 0.77,
    //     size.width * 0.52, size.height * 0.84);
    // path.quadraticBezierTo(
    //     size.width * 0.74, size.height * 0.92, size.width, size.height * 0.84);
    // path.lineTo(size.width, size.height);
    // path.lineTo(0, size.height);
    // path.close();
    // // paint.color = AppColors.primaryColor.withOpacity(0.70);
    // canvas.drawPath(path, paint);

    var path = Path();
    path.moveTo(
        ScreenUtil().setWidth(321.76), ScreenUtil().setHeight(82.73 + 22 + 8));
    path.quadraticBezierTo(
        ScreenUtil().setWidth(349.33),
        ScreenUtil().setHeight(81.45 + 22 + 8),
        ScreenUtil().setWidth(368),
        ScreenUtil().setHeight(54 + 22 + 8));
    // path.lineTo(ScreenUtil().setWidth(368, 54);
    path.lineTo(
        ScreenUtil().setWidth(368), ScreenUtil().setHeight(82.73 + 22 + 8));
    path.lineTo(
        ScreenUtil().setWidth(321.76), ScreenUtil().setHeight(82.73 + 22 + 8));
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
