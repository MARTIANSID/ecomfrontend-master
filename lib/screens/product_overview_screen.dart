import 'dart:async';
import 'dart:ui';
import 'package:Flutter/constant/const.dart';
import 'package:Flutter/providers/options.dart';
import 'package:Flutter/providers/pagination.dart';
import 'package:Flutter/providers/search.dart';
import 'package:Flutter/providers/theme.dart';
import 'package:Flutter/providers/user.dart';
import 'package:Flutter/screens/splash_screen.dart';
import 'package:Flutter/widgets/filter_widget.dart';
import 'package:Flutter/widgets/optionsDialog.dart';
import 'package:Flutter/widgets/snackbar.dart';
import 'package:Flutter/widgets/sortPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_networkimage/provider.dart';
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

  @override
  void initState() {
    _tabController = TabController(length: 5, vsync: this, initialIndex: 1);
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        dataSelect(
          context,
          'Important!',
          "To get complete access of the app, you need to first verify yourself!",
          'Complete SignUp',
        );
      }
      // if (_tabController.indexIsChanging) {
      //   dataSelect(
      //     context,
      //     'Important!',
      //     "To get complete access of the app, you need to first verify yourself!",
      //     'Complete SignUp',
      //   );
      // }
    });
    // _loadedProduct = Provider.of<Products>(context, listen: true);

    // new Future.delayed(Duration.zero, () async {

    //   // if (Provider.of<Options>(context, listen: false).build != null) {
    //   //   buildd = Provider.of<Options>(context, listen: false).build;
    //   // }
    //   // if (Provider.of<Options>(context, listen: false).certificate != null) {
    //   //   certt = Provider.of<Options>(context, listen: false).certificate;
    //   // }
//  Binding.instance.addPostFrameCallback((_) {
//       if (Provider.of<Auth>(context, listen: false).isLogin ||
//           (Provider.of<Auth>(context, listen: false).autoLogin)) {

//     });   // });

    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   if (Provider.of<Auth>(context, listen: false).isLogin ||
    //       (Provider.of<Auth>(context, listen: false).autoLogin)) {

    // });

    super.initState();
  }

  Future<void> getProduct() async {
    var futures = <Future>[
      Provider.of<Pagination>(context, listen: false).getProducts(
          page: 1, addition: false, select: 'all', context: context),
      Provider.of<Pagination>(context, listen: false).getProducts(
          page: 1, addition: false, select: 'featured', context: context),
      Provider.of<Pagination>(context, listen: false).getProducts(
          page: 1, addition: false, select: 'new', context: context),
      Provider.of<Pagination>(context, listen: false).getProducts(
          page: 1, addition: false, select: 'highestSelling', context: context),
      Provider.of<Pagination>(context, listen: false).getProducts(
          addition: false, page: 1, context: context, select: 'fancyDiamond'),
      Provider.of<Pagination>(context, listen: false).getFav(context),
      Provider.of<Options>(context, listen: false).getStringValuesSF()
    ];

    await Future.wait(futures);

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
      // await Provider.of<Options>(context, listen: false).getStringValuesSF();

      // if (Provider.of<Options>(context, listen: false).color != null) {
      //   colorr = Provider.of<Options>(context, listen: false).color;
      //   print(colorr);
      //   print('in products');
      // }
      // if (Provider.of<Options>(context, listen: false).diamondQuality != null) {
      //   diamond = Provider.of<Options>(context, listen: false).diamondQuality;
      //   print(colorr);
      // }
      // if (Provider.of<Options>(context, listen: false).build != null) {
      //   buildd = Provider.of<Options>(context, listen: false).build;
      //   print(colorr);
      // }
      // if (Provider.of<Options>(context, listen: false).certificate != null) {
      //   certt = Provider.of<Options>(context, listen: false).certificate;
      //   print(colorr);
      // }

      setState(() {
        isLoading = false;
        // colorr = Provider.of<Options>(context, listen: false).color;
        // diamond = Provider.of<Options>(context, listen: false).diamondQuality;
        // buildd = Provider.of<Options>(context, listen: false).build;
        // certt = Provider.of<Options>(context, listen: false).certificate;
      });

      isInit = false;

      super.didChangeDependencies();
    }
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
    print('Search Selected' + searchSelected.toString());
    return Scaffold(
      resizeToAvoidBottomInset: false,
      resizeToAvoidBottomPadding: false,
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
                          height: ScreenUtil().setHeight(22 + 45 + 11 + 20),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(30, 0, 24, 15),
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
                                    fontFamily: 'Gilroy Bold',
                                    fontSize: ScreenUtil()
                                        .setSp(16, allowFontScalingSelf: true),
                                  ),
                                  unselectedLabelStyle: TextStyle(
                                    fontFamily: 'Gilroy Regular',
                                    fontSize: ScreenUtil()
                                        .setSp(14, allowFontScalingSelf: true),
                                  ),
                                  // indicatorPadding: EdgeInsets.only(left: 8.0, right: 8.0),
                                  labelPadding:
                                      EdgeInsets.only(left: 5.0, right: 5.0),
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
                                  GestureDetector(
                                    onTap: () {
                                      showDialog(
                                        context: context,
                                        child: SortPage(
                                          scrollController:
                                              widget.scrollController,
                                        ),
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
                          child: TabBarView(
                            controller: _tabController,
                            children: [
                              CookiePage(
                                products: Provider.of<Pagination>(context,
                                        listen: true)
                                    .allProducts,
                                scrollController: widget.scrollController,
                                select: 'all',
                                build: _defaultChoiceIndex1,
                                color: _defaultChoiceIndex2,
                                cert: _defaultChoiceIndex3,
                                diamond: _defaultChoiceIndex4,
                              ),
                              CookiePage(
                                products: Provider.of<Pagination>(context,
                                        listen: true)
                                    .featuredProducts,
                                scrollController: widget.scrollController,
                                select: 'featured',
                                sort: sort,
                                count: count,
                                build: _defaultChoiceIndex1,
                                color: _defaultChoiceIndex2,
                                cert: _defaultChoiceIndex3,
                                diamond: _defaultChoiceIndex4,
                              ),
                              CookiePage(
                                products: Provider.of<Pagination>(context,
                                        listen: true)
                                    .newProducts,
                                scrollController: widget.scrollController,
                                select: 'new',
                                sort: sort,
                                count: count,
                                build: _defaultChoiceIndex1,
                                color: _defaultChoiceIndex2,
                                cert: _defaultChoiceIndex3,
                                diamond: _defaultChoiceIndex4,
                              ),
                              CookiePage(
                                products: Provider.of<Pagination>(context,
                                        listen: true)
                                    .highestSellingProducts,
                                scrollController: widget.scrollController,
                                select: 'highestSelling',
                                sort: sort,
                                count: count,
                                build: _defaultChoiceIndex1,
                                color: _defaultChoiceIndex2,
                                cert: _defaultChoiceIndex3,
                                diamond: _defaultChoiceIndex4,
                              ),
                              CookiePage(
                                products: Provider.of<Pagination>(context,
                                        listen: true)
                                    .fancyDiamond,
                                scrollController: widget.scrollController,
                                select: 'fancyDiamond',
                                sort: sort,
                                count: count,
                                build: _defaultChoiceIndex1,
                                color: _defaultChoiceIndex2,
                                cert: _defaultChoiceIndex3,
                                diamond: _defaultChoiceIndex4,
                              ),
                            ],
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
                                        onTap: () async {
                                          setState(() {
                                            searchSelected = true;
                                          });
                                          Timer(Duration(milliseconds: 700),
                                              () {
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
                                          await getSearch(
                                              searchValue.toUpperCase());
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
                                                    textEditingController
                                                        .clear();
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
                                        child: SvgPicture.asset(
                                          'assets/icons/notificationIcon.svg',
                                          height: ScreenUtil().setHeight(
                                              searchSelected ? 0 : 27),
                                          width: ScreenUtil().setWidth(
                                              searchSelected ? 0 : 27),
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
                                                print(info);
                                                return Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 20.0,
                                                          right: 20.0),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: <Widget>[
                                                      Container(
                                                        height: 90.0,
                                                        width: 90.0,
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
                                                                        days:
                                                                            3)),
                                                          ),
                                                          fit: BoxFit.fill,
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
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontFamily:
                                                                'Varela',
                                                            fontSize: 21.0,
                                                          ),
                                                          children: [
                                                            TextSpan(
                                                              text: info[0],
                                                              style: TextStyle(
                                                                color:
                                                                    Colors.grey,
                                                                // fontWeight: FontWeight.bold,
                                                                fontFamily:
                                                                    'Varela',
                                                                fontSize: 21.0,
                                                              ),
                                                            ),
                                                            TextSpan(
                                                              text: searchValue,
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontFamily:
                                                                    'Varela',
                                                                fontSize: 21.0,
                                                              ),
                                                            ),
                                                            TextSpan(
                                                              text: info[1],
                                                              style: TextStyle(
                                                                color:
                                                                    Colors.grey,
                                                                // fontWeight: FontWeight.bold,
                                                                fontFamily:
                                                                    'Varela',
                                                                fontSize: 21.0,
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
