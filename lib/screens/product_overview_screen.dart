import 'dart:async';
import 'package:Flutter/constant/const.dart';
import 'package:Flutter/providers/options.dart';
import 'package:Flutter/providers/pagination.dart';
import 'package:Flutter/providers/theme.dart';
import 'package:Flutter/providers/user.dart';
import 'package:Flutter/screens/splash_screen.dart';
import 'package:Flutter/widgets/filter_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart' as cp;
import 'package:flutter_svg/svg.dart';
import '../constant/const.dart';
import '../constant/const.dart';
import '../constant/const.dart';
import '../providers/auth.dart';
import '../widgets/cookie_page.dart';
import '../providers/products.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import '../constant/const.dart';
import './appui.dart';
import 'dart:ui' as ui;

class ProductOverViewScreen extends StatefulWidget {
  final ScrollController scrollController;
  final void Function(int) onButtonTapped;
  final bool val;

  const ProductOverViewScreen(
      {Key key, this.scrollController, this.onButtonTapped, this.val})
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

  @override
  void initState() {
    _tabController = TabController(length: 5, vsync: this, initialIndex: 1);
    // _loadedProduct = Provider.of<Products>(context, listen: true);

    new Future.delayed(Duration.zero, () async {
      // if (Provider.of<Options>(context, listen: false).build != null) {
      //   buildd = Provider.of<Options>(context, listen: false).build;
      // }
      // if (Provider.of<Options>(context, listen: false).certificate != null) {
      //   certt = Provider.of<Options>(context, listen: false).certificate;
      // }
    });

    super.initState();
  }

  Future<void> getProduct() async {
    await Provider.of<Pagination>(context, listen: false)
        .getProducts(page: 1, addition: false, select: 'all', context: context);
    await Provider.of<Pagination>(context, listen: false).getProducts(
        page: 1, addition: false, select: 'featured', context: context);
    await Provider.of<Pagination>(context, listen: false)
        .getProducts(page: 1, addition: false, select: 'new', context: context);
    await Provider.of<Pagination>(context, listen: false).getProducts(
        page: 1, addition: false, select: 'highestSelling', context: context);
    await Provider.of<Pagination>(context, listen: false).getProducts(
        addition: false, page: 1, context: context, select: 'fancyDiamond');
    await Provider.of<Pagination>(context, listen: false).getFav(context);
    //  await Provider.of<Pagination>(context, listen: false).getProducts(
    //       page: 1, addition: false, select: 'fancyDiamond', context: context);
    if (Provider.of<Auth>(context, listen: false).isLogin &&
        Provider.of<Auth>(context, listen: false).autoLogin == false)
      Provider.of<Auth>(context, listen: false).changeLog();

    if (Provider.of<Auth>(context, listen: false).isLogin == false &&
        Provider.of<Auth>(context, listen: false).autoLogin)
      Provider.of<Auth>(context, listen: false).changeAuto();
  }

  void didChangeDependencies() async {
    if (isInit) {
      setState(() {
        isLoading = true;
      });
      if (Provider.of<Auth>(context, listen: false).isLogin ||
          (Provider.of<Auth>(context, listen: false).autoLogin)) {
        await getProduct();
      }
      // Timer.periodic(
      //     Duration(seconds: 1),
      //     (Timer t) async => await Provider.of<Options>(context, listen: false)
      //         .getStringValuesSF());
      await Provider.of<Options>(context, listen: false).getStringValuesSF();

      if (Provider.of<Options>(context, listen: false).color != null) {
        colorr = Provider.of<Options>(context, listen: false).color;
        print(colorr);
        print('in products');
      }
      if (Provider.of<Options>(context, listen: false).diamondQuality != null) {
        diamond = Provider.of<Options>(context, listen: false).diamondQuality;
        print(colorr);
      }
      if (Provider.of<Options>(context, listen: false).build != null) {
        buildd = Provider.of<Options>(context, listen: false).build;
        print(colorr);
      }
      if (Provider.of<Options>(context, listen: false).certificate != null) {
        certt = Provider.of<Options>(context, listen: false).certificate;
        print(colorr);
      }

      setState(() {
        isLoading = false;
        colorr = Provider.of<Options>(context, listen: false).color;
        diamond = Provider.of<Options>(context, listen: false).diamondQuality;
        buildd = Provider.of<Options>(context, listen: false).build;
        certt = Provider.of<Options>(context, listen: false).certificate;
      });

      isInit = false;

      super.didChangeDependencies();
    }
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        width: 411.42857142857144,
        height: 774.8571428571429,
        allowFontScaling: true);
    var size = MediaQuery.of(context).size;
    print(size.height);
    print(size.width);
    return Scaffold(
      body: isLoading
          ? Center(
              child: Center(
              child: CircularProgressIndicator(),
            ))
          : Container(
              color: Color(0xFFF4F4F4),
              child: Stack(
                children: <Widget>[
                  Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          height: ScreenUtil().setHeight(22),
                        ),
                        Container(
                          // padding: EdgeInsets.all(10.0),
                          margin: EdgeInsets.fromLTRB(25, 11, 26, 20),
                          width: ScreenUtil().setWidth(360),
                          height: ScreenUtil().setHeight(40),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: Colors.white,
                          ),
                          child: Stack(
                            alignment: Alignment.centerRight,
                            children: <Widget>[
                              TextField(
                                decoration: InputDecoration(
                                  // contentPadding: EdgeInsets.all(15.0),
                                  hintText: 'SEARCH GEMSTORY',
                                  hintStyle: TextStyle(
                                    fontFamily: 'Gilroy Medium',
                                    color: Color(0xFF595959),
                                    fontSize: ScreenUtil()
                                        .setSp(14, allowFontScalingSelf: true),
                                  ),
                                  border: InputBorder.none,
                                ),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontFamily: 'Gilroy Regular',
                                    fontSize: ScreenUtil()
                                        .setSp(16, allowFontScalingSelf: true)),
                              ),
                              Container(
                                margin: EdgeInsets.only(right: 6.0),
                                child: SvgPicture.asset(
                                  'assets/icons/notificationIcon.svg',
                                  height: ScreenUtil().setHeight(27),
                                  width: ScreenUtil().setWidth(27),
                                  color: Colors.black,
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(25, 0, 26, 15),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              // ShaderMask(
                              // shaderCallback: (bounds) => LinearGradient(
                              //   colors: [
                              //     Color(0xFF34B0D9),
                              //     Color(0xFF3685CB),
                              //   ],
                              //   begin: Alignment.topLeft,
                              //   end: Alignment.bottomRight,
                              // ).createShader(
                              //   Rect.fromLTWH(0, 0, bounds.width, bounds.height),
                              // ),
                              //   child: Text(
                              //     'CART',
                              //     style: TextStyle(
                              //       color: Colors.white,
                              //       fontFamily: 'Gilroy Black',
                              //       fontSize: ScreenUtil()
                              //           .setSp(20, allowFontScalingSelf: true),
                              //     ),
                              //   ),
                              // ),
                              Container(
                                height: ScreenUtil().setHeight(20),
                                width: ScreenUtil().setWidth(275),
                                child: TabBar(
                                  controller: _tabController,
                                  indicatorColor: kPrimaryColor,
                                  labelColor: Colors.black,
                                  labelStyle: TextStyle(
                                    fontFamily: 'Gilroy Black',
                                    fontSize: ScreenUtil()
                                        .setSp(16, allowFontScalingSelf: true),
                                  ),
                                  unselectedLabelStyle: TextStyle(
                                    fontFamily: 'Gilroy',
                                    fontSize: ScreenUtil()
                                        .setSp(14, allowFontScalingSelf: true),
                                  ),
                                  labelPadding:
                                      EdgeInsets.only(left: 8.0, right: 8.0),
                                  isScrollable: true,
                                  indicator: BoxDecoration(),
                                  tabs: [
                                    Tab(
                                      child: ShaderMask(
                                        shaderCallback: (bounds) =>
                                            _tabController.index == 0
                                                ? LinearGradient(
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
                                                  )
                                                : LinearGradient(
                                                    colors: [
                                                      Color(0xFFA49797),
                                                      Color(0xFFA49797),
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
                                            // color: Colors.black,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Tab(
                                      child: ShaderMask(
                                        shaderCallback: (bounds) =>
                                            _tabController.index == 1
                                                ? LinearGradient(
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
                                                  )
                                                : LinearGradient(
                                                    colors: [
                                                      Color(0xFFA49797),
                                                      Color(0xFFA49797),
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
                                            _tabController.index == 2
                                                ? LinearGradient(
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
                                                  )
                                                : LinearGradient(
                                                    colors: [
                                                      Color(0xFFA49797),
                                                      Color(0xFFA49797),
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
                                            _tabController.index == 3
                                                ? LinearGradient(
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
                                                  )
                                                : LinearGradient(
                                                    colors: [
                                                      Color(0xFFA49797),
                                                      Color(0xFFA49797),
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
                                          'HIGHEST SELLING',
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Tab(
                                        child: ShaderMask(
                                      shaderCallback: (bounds) =>
                                          _tabController.index == 4
                                              ? LinearGradient(
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
                                                )
                                              : LinearGradient(
                                                  colors: [
                                                    Color(0xFFA49797),
                                                    Color(0xFFA49797),
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
                                        'FANCY DIAMOND',
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    )),
                                  ],
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.only(right: 4.0),
                                    child: SvgPicture.asset(
                                      'assets/icons/sortIcon.svg',
                                      width: ScreenUtil().setWidth(24),
                                      height: ScreenUtil().setHeight(24),
                                      color: Colors.black,
                                    ),
                                  ),
                                  SvgPicture.asset(
                                    'assets/icons/optionsIcon.svg',
                                    width: ScreenUtil().setWidth(24),
                                    height: ScreenUtil().setHeight(24),
                                    color: Colors.black,
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                        Expanded(
                          child: TabBarView(
                            controller: _tabController,
                            children: [
                              CookiePage(
                                products: Provider.of<Pagination>(context,
                                        listen: true)
                                    .allProducts,
                                scrollController: widget.scrollController,
                                select: 'all',
                                color:
                                    Provider.of<Options>(context, listen: true)
                                        .color,
                                diamond:
                                    Provider.of<Options>(context, listen: true)
                                        .diamondQuality,
                                build:
                                    Provider.of<Options>(context, listen: true)
                                        .build,
                                cert:
                                    Provider.of<Options>(context, listen: true)
                                        .certificate,
                              ),
                              CookiePage(
                                products: Provider.of<Pagination>(context,
                                        listen: true)
                                    .featuredProducts,
                                scrollController: widget.scrollController,
                                select: 'featured',
                                sort: sort,
                                count: count,
                                color:
                                    Provider.of<Options>(context, listen: true)
                                        .color,
                                diamond:
                                    Provider.of<Options>(context, listen: true)
                                        .diamondQuality,
                                build:
                                    Provider.of<Options>(context, listen: true)
                                        .build,
                                cert:
                                    Provider.of<Options>(context, listen: true)
                                        .certificate,
                              ),
                              CookiePage(
                                products: Provider.of<Pagination>(context,
                                        listen: true)
                                    .newProducts,
                                scrollController: widget.scrollController,
                                select: 'new',
                                sort: sort,
                                count: count,
                                color:
                                    Provider.of<Options>(context, listen: true)
                                        .color,
                                diamond:
                                    Provider.of<Options>(context, listen: true)
                                        .diamondQuality,
                                build:
                                    Provider.of<Options>(context, listen: true)
                                        .build,
                                cert:
                                    Provider.of<Options>(context, listen: true)
                                        .certificate,
                              ),
                              CookiePage(
                                products: Provider.of<Pagination>(context,
                                        listen: true)
                                    .highestSellingProducts,
                                scrollController: widget.scrollController,
                                select: 'highestSelling',
                                sort: sort,
                                count: count,
                                color:
                                    Provider.of<Options>(context, listen: true)
                                        .color,
                                diamond:
                                    Provider.of<Options>(context, listen: true)
                                        .diamondQuality,
                                build:
                                    Provider.of<Options>(context, listen: true)
                                        .build,
                                cert:
                                    Provider.of<Options>(context, listen: true)
                                        .certificate,
                              ),
                              CookiePage(
                                products: Provider.of<Pagination>(context,
                                        listen: true)
                                    .fancyDiamond,
                                scrollController: widget.scrollController,
                                select: 'fancyDiamond',
                                sort: sort,
                                count: count,
                                color:
                                    Provider.of<Options>(context, listen: true)
                                        .color,
                                diamond:
                                    Provider.of<Options>(context, listen: true)
                                        .diamondQuality,
                                build:
                                    Provider.of<Options>(context, listen: true)
                                        .build,
                                cert:
                                    Provider.of<Options>(context, listen: true)
                                        .certificate,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),

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
                ],
              ),
            ),
    );
  }
}
