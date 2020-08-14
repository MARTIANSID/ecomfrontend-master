import 'package:Flutter/providers/options.dart';
import 'package:Flutter/providers/pagination.dart';
import 'package:Flutter/providers/user.dart';
import 'package:Flutter/screens/completeSignUp.dart';
import 'package:Flutter/screens/product_detail.dart';
import 'package:Flutter/widgets/add_to_cart.dart';
import 'package:Flutter/widgets/snackbar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
// import 'package:flutter_advanced_networkimage/provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:ui' show ImageFilter;
import 'package:http/http.dart' as https;

class CookiePage extends StatefulWidget {
  final select;
  final List<dynamic> products;
  final ScrollController scrollController;
  final String count;
  final int sort;
  final int c;
  final int color;
  final int diamond;
  final int build;
  final int cert;
  final GlobalKey globalKey;
  final valueChangeBuild;
  final valueChangeColor;
  final valueChangeCerti;
  final valueChangeDQ;
  final Animation<int> characterCount;
  final AnimationController controller;
  final int flag;

  const CookiePage(
      {Key key,
      this.select,
      this.characterCount,
      this.products,
      this.flag,
      this.scrollController,
      this.controller,
      this.count,
      this.sort,
      this.c,
      this.color,
      this.diamond,
      this.build,
      this.cert,
      this.globalKey,
      this.valueChangeBuild,
      this.valueChangeColor,
      this.valueChangeCerti,
      this.valueChangeDQ})
      : super(key: key);

  @override
  _CookiePageState createState() => _CookiePageState();
}

class _CookiePageState extends State<CookiePage>
    with SingleTickerProviderStateMixin {
  bool isScrollingDown = false;
  int selectedValue;
  int valueOfQuantity = 0;
  bool isLoading = false;
  bool isInit = true;
  int c;
  int value;
  String color;
  int colorr;
  bool isLoadingg = false;
  String colorKey;
  String prevColorKey;
  String priceKey;
  int buildPrice;
  int certPrice;
  // Animation<int> _characterCount;

  // int _stringIndex;

  int _defaultChoiceIndex2;

  int _defaultChoiceIndex1;

  int _defaultChoiceIndex3;

  int _defaultChoiceIndex4;

  bool show = false;
  double scroll = 100.0;
  AnimationController controller;

  Animation<int> characterCount;

  bool fff = true;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
  }

  Future<void> getMoreProducts() async {
    if (widget.select == 'all')
      await Provider.of<Pagination>(context, listen: false).getProducts(
          page: Provider.of<Pagination>(context, listen: false).pageAll,
          select: 'all',
          addition: true,
          context: context,
          sort: Provider.of<Pagination>(context, listen: false).sort,
          sortby: Provider.of<Pagination>(context, listen: false).count);
    if (widget.select == 'isnew')
      await Provider.of<Pagination>(context, listen: false).getProducts(
          page: Provider.of<Pagination>(context, listen: false).pageNew,
          select: 'isnew',
          addition: true,
          context: context,
          sort: Provider.of<Pagination>(context, listen: false).sort,
          sortby: Provider.of<Pagination>(context, listen: false).count);
    if (widget.select == 'featured')
      await Provider.of<Pagination>(context, listen: false).getProducts(
          page: Provider.of<Pagination>(context, listen: false).pageFeatured,
          select: 'featured',
          addition: true,
          context: context,
          sort: Provider.of<Pagination>(context, listen: false).sort,
          sortby: Provider.of<Pagination>(context, listen: false).count);
    if (widget.select == 'navratna')
      await Provider.of<Pagination>(context, listen: false).getProducts(
          page: Provider.of<Pagination>(context, listen: false).pageHighest,
          select: 'navratna',
          addition: true,
          context: context,
          sort: Provider.of<Pagination>(context, listen: false).sort,
          sortby: Provider.of<Pagination>(context, listen: false).count);
    if (widget.select == 'fancyDiamond')
      await Provider.of<Pagination>(context, listen: false).getProducts(
          page: Provider.of<Pagination>(context, listen: false).pageDiamond,
          select: 'fancyDiamond',
          addition: true,
          context: context,
          sort: Provider.of<Pagination>(context, listen: false).sort,
          sortby: Provider.of<Pagination>(context, listen: false).count);
  }

  ViewportOffset offset = ViewportOffset.fixed(50);

  createList() async {
    widget.scrollController.addListener(() async {
      // print(widget.scrollController.position.pixels);

      if (widget.scrollController.position.pixels > scroll ||
          widget.scrollController.position.pixels ==
              widget.scrollController.position.maxScrollExtent) {
        scroll = scroll + 1000;
        // if (mounted)
        //   setState(() {
        //     isLoading = true;
        //   });
        // if (Provider.of<Pagination>(context, listen: false).c) {
        //    Provider.of<Pagination>(context,listen:false).pageStart();

        // }
        if (context != null)
          Provider.of<Pagination>(context, listen: false)
              .pageAdd(widget.select);
        try {
          await getMoreProducts();
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
          // if (mounted)
          //   setState(() {
          //     isLoading = false;
          //   });
        }
      }
    });
  }

  void requestPrice() async {
    await Provider.of<Pagination>(context, listen: false)
        .requestPrice(context: context);
    Navigator.of(context).pop();
  }

  void didChangeDependencies() async {
    if (isInit) {
      if (widget.select != 'fav' &&
          Provider.of<Pagination>(context, listen: false).isVerified) {
        createList();
      }
      // _defaultChoiceIndex1 =
      //     Provider.of<Options>(context, listen: false).build == null
      //         ? 0
      //         : Provider.of<Options>(context, listen: false).build;
      // _defaultChoiceIndex2 =
      //     Provider.of<Options>(context, listen: false).color == null
      //         ? 0
      //         : Provider.of<Options>(context, listen: false).color;
      // _defaultChoiceIndex3 =
      //     Provider.of<Options>(context, listen: false).certificate == null
      //         ? 0
      //         : Provider.of<Options>(context, listen: false).certificate;
      // _defaultChoiceIndex4 =
      //     Provider.of<Options>(context, listen: false).diamondQuality == null
      //         ? 0
      //         : Provider.of<Options>(context, listen: false).diamondQuality;

      // print(colorKey);

      // if (Provider.of<Auth>(context, listen: false).autoLogin) {
      //   if (!mounted) return;
      //   setState(() {
      //     isLoading = true;
      //   });
      //   await Provider.of<Products>(context, listen: false).fetchAndSetProducts(
      //       token: Provider.of<Auth>(context, listen: false).token);
      //   if (!mounted) return;
      //   setState(() {
      //     _loadedProduct = Provider.of<Products>(context, listen: false);
      //   });
      //   Provider.of<Auth>(context, listen: false).autoLogin = false;
      // }
      // if (!Provider.of<Auth>(context, listen: false).autoLogin) {
      //   if (!mounted) return;
      //   setState(() {
      //     _loadedProduct = Provider.of<Products>(context, listen: false);
      //   });
      // }

      isInit = false;
      // if (!mounted) return;
      // setState(() {
      //   isLoading = false;
      // });
      super.didChangeDependencies();
    }
  }

  @override
  void dispose() {
    // scrollBottomBarController.removeListener(() {});
    super.dispose();
    controller.dispose();
  }

  void _onValueChange(int value, [int index]) {
    // await Provider.of<Options>(context, listen: false).setBuild(build: value);
    setState(() {
      _defaultChoiceIndex1 = value;
      print(value);
    });
  }

  void _onValueChangeColor(int value, [int index]) {
    // await Provider.of<Options>(context, listen: false).setColor(color: value);
    setState(() {
      _defaultChoiceIndex2 = value;
    });
  }

  void _onValueChangeCerti(int value, [int index]) {
    // await Provider.of<Options>(context, listen: false).setCert(cert: value);
    setState(() {
      _defaultChoiceIndex3 = value;
    });
  }

  void _onValueChangeDQ(int value, [int index]) {
    // await Provider.of<Options>(context, listen: false).setDiamond(diamond: value);
    setState(() {
      _defaultChoiceIndex4 = value;
    });
  }

  var pro;

  @override
  Widget build(BuildContext context) {
    Widget dateSelect(context, product) {
      // var alertDialog = ;
      // if (show) {
      //   showDialog(
      //     context: context,
      //     builder: (BuildContext context) {
      return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          backgroundColor: Colors.black.withOpacity(0.7),
          elevation: 100.0,
          content: Container(
            height: ScreenUtil().setHeight(375),
            width: ScreenUtil().setHeight(400),
            // width: 700.0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: Text(
                    product.styleNumber,
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Gilroy Medium',
                      fontSize:
                          ScreenUtil().setSp(25, allowFontScalingSelf: true),
                    ),
                  ),
                ),
                DataTable(
                  columns: [
                    DataColumn(
                        label: Text(
                      'Specifications',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    )),
                    DataColumn(
                        label: Text(
                      'Units',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    )),
                  ],
                  rows: [
                    DataRow(cells: [
                      DataCell(Text(
                        'Gold Weight',
                        style: TextStyle(color: Colors.white),
                      )),
                      DataCell(Text(
                        product.goldWeight.toString() == "" ||
                                product.goldWeight.toString() == null
                            ? "----"
                            : product.goldWeight.toString() + ' gms',
                        style: TextStyle(color: Colors.white),
                      )),
                    ]),
                    DataRow(cells: [
                      DataCell(Text(
                        'Diamond Weight',
                        style: TextStyle(color: Colors.white),
                      )),
                      DataCell(Text(
                        product.diamondWeight.toString() == "" ||
                                product.diamondWeight.toString() == null
                            ? "----"
                            : product.diamondWeight.toString() + ' ct',
                        style: TextStyle(color: Colors.white),
                      )),
                    ]),
                    DataRow(cells: [
                      DataCell(Text(
                        'Diamond Count',
                        style: TextStyle(color: Colors.white),
                      )),
                      DataCell(Text(
                        product.diamondCount.toString() == "" ||
                                product.diamondCount.toString() == null
                            ? "----"
                            : product.diamondCount.toString() + ' pieces',
                        style: TextStyle(color: Colors.white),
                      )),
                    ]),
                    DataRow(cells: [
                      DataCell(Text(
                        'Design Dimensions',
                        style: TextStyle(color: Colors.white),
                      )),
                      DataCell(Text(
                        product.designDimensions.toString() == "" ||
                                product.designDimensions.toString() == null
                            ? "----"
                            : product.designDimensions.toString(),
                        style: TextStyle(color: Colors.white),
                      )),
                    ]),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
      //     },
      //   );
      // } else {
      //   Navigator.of(context).pop();
      // }
    }

    // final scaff = Scaffold.of(context);
    // final Color themeColor = Theme.of(context).primaryColor;
    // print('PP No of Products: ${widget.products.length}');
    var size = MediaQuery.of(context).size;

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
    if (widget.color ==
        Provider.of<Pagination>(context, listen: false).color.length) {
      colorKey = 'angle';
    } else {
      colorKey =
          (Provider.of<Pagination>(context, listen: false).color[widget.color])
              .toLowerCase();
    }
    // prevColorKey =
    //     (Provider.of<Pagination>(context, listen: false).color[widget.color])
    //         .toLowerCase();
    // setState(() {
    // if (widget.select != 'fav') {
    if (Provider.of<Pagination>(context, listen: false).isPriced) {
      priceKey = (Provider.of<Pagination>(context, listen: false)
          .diamondQuality[widget.diamond]);

      buildPrice = Provider.of<Pagination>(context, listen: false).buildPrices[
          Provider.of<Pagination>(context, listen: false).build[widget.build]];
      certPrice = Provider.of<Pagination>(context, listen: false).certPrices[
          Provider.of<Pagination>(context, listen: false).cert[widget.cert]];
      // }}
    }

    ScreenUtil.init(context,
        width: 411.42857142857144,
        height: 774.8571428571429,
        allowFontScaling: true);
    return isLoadingg
        ? Center(child: CircularProgressIndicator())
        : Stack(
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: widget.products.length == 0
                        ? Center(
                            child: Text(
                              "New Products Coming Soon 💎",
                              style: TextStyle(
                                fontFamily: 'Gilory Regular',
                                color: Color(0xFFA49797),
                                fontSize: ScreenUtil()
                                    .setSp(17, allowFontScalingSelf: true),
                              ),
                              textAlign: TextAlign.center,
                            ),
                          )
                        : ListView(
                            controller: widget.scrollController,
                            children: <Widget>[
                              GridView.builder(
                                  scrollDirection: Axis.vertical,
                                  padding: EdgeInsets.only(left: 25, right: 21),
                                  shrinkWrap: true,
                                  physics: BouncingScrollPhysics(),
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    childAspectRatio: ScreenUtil()
                                            .setWidth(411) /
                                        (ScreenUtil().setHeight(775) / 2.07),
                                    crossAxisSpacing: 20.0,
                                    mainAxisSpacing: 20.0,
                                  ),
                                  itemCount: widget.products.length,
                                  itemBuilder: (context, i) {
                                    var configuration =
                                        createLocalImageConfiguration(context);
                                    // if (widget.products[i].imageUrl[colorKey]
                                    //     .toString()
                                    //     .contains("echo.gemstory.in")) {
                                    //   precacheImage(
                                    //       NetworkImage(widget
                                    //           .products[i].imageUrl[colorKey]),
                                    //       context);
                                    // }
                                    // bool valueOfImage = false;
                                    // widget.products[i].imageUrl.forEach((k, v) async {
                                    //   if (v.toString().contains("echo.gemstory.in")) {
                                    //     // final response = await https.get(v);
                                    //     // if (response.statusCode == 200) {
                                    //     // if (mounted)
                                    //     // setState(() {
                                    //     valueOfImage = true;
                                    //     // });
                                    //     // }
                                    //   }
                                    // });

                                    // print(
                                    //     "Value Of Image: " + valueOfImage.toString());

                                    // String text =
                                    //     "${int.parse(widget.products[i].prices[priceKey]) + certPrice} ₹";
                                    // if (widget.flag == 1) {
                                    //   characterCount =
                                    //       StepTween(begin: 0, end: text.length)
                                    //           .animate(CurvedAnimation(
                                    //               parent: controller,
                                    //               curve: Curves.easeIn));
                                    //   text =
                                    //       '${int.parse(widget.products[i].prices[priceKey]) + certPrice} ₹'
                                    //           .substring(0, characterCount.value);
                                    //   Future.delayed(Duration(seconds: 0), () async {
                                    //     await controller.forward();
                                    //   });
                                    // }
                                    return Stack(
                                      // alignment: Alignment.bottomRight,
                                      children: <Widget>[
                                        AnimatedContainer(
                                          duration: Duration(seconds: 1),
                                          width: ScreenUtil().setWidth(159),
                                          height: ScreenUtil().setHeight(150),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20.0),
                                            color: Colors.white,
                                            boxShadow: <BoxShadow>[
                                              BoxShadow(
                                                blurRadius: 10,
                                                color: Colors.black
                                                    .withOpacity(0.37),
                                                offset: Offset(2, 5),
                                              )
                                            ],
                                          ),
                                          child: GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      ProductDetail(
                                                    colorKey: colorKey,
                                                    diamondKey: priceKey,
                                                    certPrice: certPrice,
                                                    product: widget.products[i],
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
                                                        widget.valueChangeBuild,
                                                    valueChangeColor1:
                                                        widget.valueChangeColor,
                                                    valueChangeCerti1:
                                                        widget.valueChangeCerti,
                                                    valueChangeDQ1:
                                                        widget.valueChangeDQ,
                                                    select: widget.select,
                                                  ),
                                                ),
                                              );
                                            },
                                            onLongPress: () {
                                              print("Contact");
                                              setState(() {
                                                pro = widget.products[i];
                                                show = true;
                                              });
                                            },
                                            onLongPressUp: () {
                                              print("No Contact");
                                              setState(() {
                                                pro = [];
                                                show = false;
                                              });
                                            },
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: <Widget>[
                                                Container(
                                                  width: ScreenUtil().setWidth(
                                                      !Provider.of<Pagination>(
                                                                  context,
                                                                  listen: false)
                                                              .isVerified
                                                          ? 151
                                                          : 138),
                                                  height: ScreenUtil().setHeight(
                                                      !Provider.of<Pagination>(
                                                                  context,
                                                                  listen: false)
                                                              .isVerified
                                                          ? 135
                                                          : 119),
                                                  margin: EdgeInsets.only(
                                                      top: !Provider.of<
                                                                      Pagination>(
                                                                  context,
                                                                  listen: false)
                                                              .isVerified
                                                          ? 8
                                                          : 2,
                                                      left: !Provider.of<
                                                                      Pagination>(
                                                                  context,
                                                                  listen: false)
                                                              .isVerified
                                                          ? 8
                                                          : 19),
                                                  child: Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: <Widget>[
                                                      Container(
                                                          // color: Colors.amber,
                                                          height: ScreenUtil().setHeight(
                                                              !Provider.of<Pagination>(context, listen: false).isVerified
                                                                  ? 135
                                                                  : 119),
                                                          width: ScreenUtil().setWidth(
                                                              !Provider.of<Pagination>(
                                                                          context,
                                                                          listen:
                                                                              false)
                                                                      .isVerified
                                                                  ? 130
                                                                  : 117),
                                                          // child: widget.products[i].imageUrl.containsKey(colorKey)?widget.products[i].imageUrl[colorKey]:widget.products[i].imageUrl['yellow'],

                                                          // color: Colors.amber,
                                                          child: widget
                                                                  .products[i]
                                                                  .imageUrl[colorKey]
                                                                  .toString()
                                                                  .contains("echo.gemstory.in")
                                                              // .containsKey(colorKey)
                                                              ? Image(
                                                                  image:
                                                                      CachedNetworkImageProvider(
                                                                    widget
                                                                        .products[
                                                                            i]
                                                                        .imageUrl[colorKey],
                                                                  )..resolve(
                                                                          configuration),
                                                                  // color: Colors.amber,
                                                                  // image:
                                                                  //     AdvancedNetworkImage(
                                                                  //   widget.products[i]
                                                                  //           .imageUrl[
                                                                  //       colorKey],
                                                                  //   useDiskCache:
                                                                  //       true,
                                                                  //   cacheRule: CacheRule(
                                                                  //       maxAge:
                                                                  //           const Duration(
                                                                  //               days:
                                                                  //                   3)),
                                                                  // ),
                                                                  fit: BoxFit
                                                                      .fill,
                                                                )
                                                              : Image(
                                                                  image:
                                                                      CachedNetworkImageProvider(
                                                                    widget
                                                                        .products[
                                                                            i]
                                                                        .imageUrl['yellow'],
                                                                  ),
                                                                  // image:
                                                                  //     AdvancedNetworkImage(
                                                                  //   widget.products[i]
                                                                  //           .imageUrl[
                                                                  //       'yellow'],
                                                                  //   useDiskCache:
                                                                  //       true,
                                                                  //   cacheRule: CacheRule(
                                                                  //       maxAge:
                                                                  //           const Duration(
                                                                  //               days:
                                                                  //                   3)),
                                                                  // ),
                                                                  fit: BoxFit
                                                                      .fill,
                                                                )

                                                          // ),
                                                          ),
                                                      SizedBox(
                                                        width: ScreenUtil()
                                                            .setWidth(4),
                                                      ),
                                                      Container(
                                                        width: ScreenUtil()
                                                            .setWidth(14),
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: <Widget>[
                                                            SizedBox(
                                                              height:
                                                                  ScreenUtil()
                                                                      .setHeight(
                                                                          16),
                                                            ),
                                                            RotatedBox(
                                                              quarterTurns: -1,
                                                              child: Text(
                                                                widget
                                                                    .products[i]
                                                                    .styleNumber,
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: ScreenUtil().setSp(
                                                                      14,
                                                                      allowFontScalingSelf:
                                                                          true),
                                                                  fontFamily:
                                                                      'Gilroy Regular',
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                // Text(
                                                //   "5000 ₹",
                                                //   style: TextStyle(
                                                //     fontSize: ScreenUtil().setSp(18,
                                                //         allowFontScalingSelf: true),
                                                //     fontFamily: 'Gilroy Regular',
                                                //   ),
                                                // ),
                                                !Provider.of<Pagination>(
                                                            context,
                                                            listen: false)
                                                        .isVerified
                                                    ? SizedBox(
                                                        height: 0.0,
                                                      )
                                                    : !Provider.of<Pagination>(
                                                                context,
                                                                listen: false)
                                                            .isPriced
                                                        ? GestureDetector(
                                                            onTap: () async {
                                                              String date = await Provider.of<
                                                                          UserInfo>(
                                                                      context,
                                                                      listen:
                                                                          false)
                                                                  .getPriceDate();
                                                              if (date !=
                                                                  null) {
                                                                int d = DateTime
                                                                        .now()
                                                                    .difference(
                                                                        DateTime.parse(
                                                                            date))
                                                                    .inDays;
                                                                if (d >= 1) {
                                                                  dataSelect(
                                                                      context:
                                                                          context,
                                                                      titleText:
                                                                          'Important!',
                                                                      buttonText:
                                                                          'Request Prices',
                                                                      contentText:
                                                                          "To see prices you must first request a quotation from Team Gemstory",
                                                                      onPressed:
                                                                          requestPrice,
                                                                      gif:
                                                                          "assets/images/alert.gif");
                                                                } else {
                                                                  dataSelect(
                                                                      context:
                                                                          context,
                                                                      titleText:
                                                                          'Alert!',
                                                                      buttonText:
                                                                          'Okay',
                                                                      contentText:
                                                                          "Request has already been noted!",
                                                                      onPressed:
                                                                          () {
                                                                        Navigator.pop(
                                                                            context);
                                                                      },
                                                                      gif:
                                                                          "assets/images/identi.gif");
                                                                }
                                                              } else {
                                                                dataSelect(
                                                                    context:
                                                                        context,
                                                                    titleText:
                                                                        'Important!',
                                                                    buttonText:
                                                                        'Request Prices',
                                                                    contentText:
                                                                        "To see prices you must first request a quotation from Team Gemstory",
                                                                    onPressed:
                                                                        requestPrice,
                                                                    gif:
                                                                        "assets/images/alert.gif");
                                                              }
                                                            },
                                                            child: Container(
                                                              height:
                                                                  ScreenUtil()
                                                                      .setHeight(
                                                                          20),
                                                              width:
                                                                  ScreenUtil()
                                                                      .setWidth(
                                                                          110),
                                                              child: Center(
                                                                child: Text(
                                                                  'Request Prices',
                                                                  style:
                                                                      TextStyle(
                                                                    decoration:
                                                                        TextDecoration
                                                                            .underline,
                                                                    color: Colors
                                                                        .black,
                                                                    fontFamily:
                                                                        'Gilroy Medium',
                                                                    fontSize: ScreenUtil().setSp(
                                                                        14,
                                                                        allowFontScalingSelf:
                                                                            true),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          )
                                                        : widget.products[i]
                                                                .prices
                                                                .containsKey(
                                                                    priceKey)
                                                            // ? widget.flag == 1
                                                            //     ? AnimatedBuilder(
                                                            //         animation:
                                                            //             characterCount,
                                                            //         builder: (BuildContext
                                                            //                 context,
                                                            //             Widget
                                                            //                 child) {
                                                            //           String text = '${int.parse(widget.products[i].prices[priceKey]) + certPrice} ₹'
                                                            //               .substring(
                                                            //                   0,
                                                            //                   characterCount
                                                            //                       .value);
                                                            //           return Text(
                                                            //             text,
                                                            //             style:
                                                            //                 TextStyle(
                                                            //               fontSize: ScreenUtil().setSp(
                                                            //                   18,
                                                            //                   allowFontScalingSelf:
                                                            //                       true),
                                                            //               fontFamily:
                                                            //                   'Gilroy Regular',
                                                            //             ),
                                                            //           );
                                                            //         },
                                                            //       )
                                                            // :
                                                            ? Text(
                                                                '${int.parse(widget.products[i].prices[priceKey]) + certPrice + buildPrice} ₹',
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: ScreenUtil().setSp(
                                                                      18,
                                                                      allowFontScalingSelf:
                                                                          true),
                                                                  fontFamily:
                                                                      'Gilroy Regular',
                                                                ),
                                                              )
                                                            : Text(
                                                                'no price',
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: ScreenUtil().setSp(
                                                                      18,
                                                                      allowFontScalingSelf:
                                                                          true),
                                                                  fontFamily:
                                                                      'Gilroy Regular',
                                                                ),
                                                              ),
                                                // Row(
                                                //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                //   // crossAxisAlignment: CrossAxisAlignment.center,
                                                //   children: <Widget>[
                                                //     IconButton(
                                                //       icon: Icon(widget.products[i].isFavourite
                                                //           ? Icons.favorite
                                                //           : Icons.favorite_border),
                                                //       color: kPrimaryColor,
                                                //       onPressed: () async {
                                                //         await Provider.of<Products>(context, listen: false)
                                                //             .toogleFavourite(
                                                //                 styleNumber: widget.products[i].styleNumber,
                                                //                 context: context);
                                                //         setState(() {});
                                                //       },
                                                //     ),
                                                //     IconButton(
                                                //       icon: Icon(Icons.shopping_cart),
                                                //       color: kPrimaryColor,
                                                //       onPressed: () async {
                                                //         await Provider.of<Cart>(context, listen: false)
                                                //             .addCart(widget.products[i], context);

                                                //         showFloatingFlushbar(context,
                                                //             'Product has been added to your favourites"❤"');
                                                //       },
                                                //     ),
                                                //   ],
                                                // ),
                                                // SizedBox(
                                                //   height: 20.0,
                                                // ),
                                                // Text(
                                                //   '\$52.90',
                                                //   style: TextStyle(
                                                //     fontSize: 20.0,
                                                //     fontFamily: 'Gilroy',
                                                //   ),
                                                // ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          bottom: 0,
                                          right: 0,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            // crossAxisAlignment: CrossAxisAlignment.center,
                                            children: <Widget>[
                                              Container(
                                                height:
                                                    ScreenUtil().setHeight(29),
                                                width:
                                                    ScreenUtil().setWidth(29),
                                                decoration: BoxDecoration(
                                                  gradient: LinearGradient(
                                                    colors: [
                                                      Color(0xFF33D2E4),
                                                      Color(0xFF34B0D9),
                                                    ],
                                                    begin: Alignment.topLeft,
                                                    end: Alignment.bottomRight,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0),
                                                ),
                                                child: Material(
                                                  type:
                                                      MaterialType.transparency,
                                                  elevation: 6.0,
                                                  color: Colors.transparent,
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                  child: InkWell(
                                                    splashColor: Colors.cyan[50]
                                                        .withOpacity(0.5),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                    onTap: () async {
                                                      try {
                                                        if (mounted)
                                                          setState(() {});
                                                        if (widget.products[i]
                                                            .isFavourite) {
                                                          showFloatingFlushbar(
                                                              widget.globalKey
                                                                  .currentContext,
                                                              'Product removed from Favourites list',
                                                              widget.products[i]
                                                                  .styleNumber,
                                                              '❤');
                                                          await Provider.of<
                                                                      Pagination>(
                                                                  context,
                                                                  listen: false)
                                                              .toogleFavourite(
                                                                  styleNumber: widget
                                                                      .products[
                                                                          i]
                                                                      .styleNumber,
                                                                  context:
                                                                      context);
                                                        } else {
                                                          await Provider.of<
                                                                      Pagination>(
                                                                  context,
                                                                  listen: false)
                                                              .toogleFavourite(
                                                                  styleNumber: widget
                                                                      .products[
                                                                          i]
                                                                      .styleNumber,
                                                                  context:
                                                                      context,
                                                                  product: widget
                                                                      .products[i]);
                                                          showFloatingFlushbar(
                                                              widget.globalKey
                                                                  .currentContext,
                                                              'Product added to the Favourites list',
                                                              widget.products[i]
                                                                  .styleNumber,
                                                              '❤');
                                                        }
                                                        if (mounted)
                                                          setState(() {});
                                                      } catch (err) {
                                                        if (mounted)
                                                          setState(() {});
                                                      }
                                                    },
                                                    child: Icon(
                                                      widget.products[i]
                                                              .isFavourite
                                                          ? Icons.favorite
                                                          : Icons
                                                              .favorite_border,
                                                      color: Colors.white,
                                                      size: ScreenUtil().setSp(
                                                          16,
                                                          allowFontScalingSelf:
                                                              true),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height:
                                                    ScreenUtil().setHeight(6.0),
                                              ),
                                              Container(
                                                height:
                                                    ScreenUtil().setHeight(29),
                                                width:
                                                    ScreenUtil().setWidth(29),
                                                decoration: BoxDecoration(
                                                  gradient: LinearGradient(
                                                    colors: [
                                                      Color(0xFF34BEDD),
                                                      Color(0xFF359DD3),
                                                    ],
                                                    begin: Alignment.topLeft,
                                                    end: Alignment.bottomRight,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0),
                                                ),
                                                child: Material(
                                                  type:
                                                      MaterialType.transparency,
                                                  elevation: 6.0,
                                                  color: Colors.transparent,
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                  child: InkWell(
                                                    splashColor: Colors.cyan[50]
                                                        .withOpacity(0.5),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                    onTap: () async {
                                                      if (Provider.of<Pagination>(
                                                                  context,
                                                                  listen: false)
                                                              .isVerified ==
                                                          false) {
                                                        var date = await Provider
                                                                .of<UserInfo>(
                                                                    context,
                                                                    listen:
                                                                        false)
                                                            .getDate(context);
                                                        if (date != null) {
                                                          int d = DateTime.now()
                                                              .difference(
                                                                  DateTime
                                                                      .parse(
                                                                          date))
                                                              .inDays;
                                                          if (d < 1) {
                                                            fff = false;
                                                            dataSelect(
                                                                context:
                                                                    context,
                                                                titleText:
                                                                    'Alert!',
                                                                buttonText:
                                                                    'Okay',
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
                                                      if (fff) {
                                                        !Provider.of<Pagination>(
                                                                    context,
                                                                    listen:
                                                                        false)
                                                                .isVerified
                                                            ? dataSelect(
                                                                context:
                                                                    context,
                                                                titleText:
                                                                    'Important!',
                                                                buttonText:
                                                                    'Complete SignUp',
                                                                contentText:
                                                                    "To get complete access of the app, you need to first verify yourself!",
                                                                onPressed:
                                                                    () async {
                                                                  Navigator.of(
                                                                          context)
                                                                      .pop();
                                                                  String date = await Provider.of<
                                                                              UserInfo>(
                                                                          context,
                                                                          listen:
                                                                              false)
                                                                      .getDate(
                                                                          context);
                                                                  if (date !=
                                                                      null) {
                                                                    int d = DateTime
                                                                            .now()
                                                                        .difference(
                                                                            DateTime.parse(date))
                                                                        .inDays;
                                                                    if (d >=
                                                                        1) {
                                                                      Navigator
                                                                          .push(
                                                                        context,
                                                                        MaterialPageRoute(
                                                                          builder: (context) =>
                                                                              CompleteSignUp(),
                                                                        ),
                                                                      );
                                                                    } else {
                                                                      dataSelect(
                                                                          context:
                                                                              context,
                                                                          titleText:
                                                                              'Alert!',
                                                                          buttonText:
                                                                              'Okay',
                                                                          contentText:
                                                                              "Request has already been noted!",
                                                                          onPressed:
                                                                              () {
                                                                            Navigator.pop(context);
                                                                          },
                                                                          gif:
                                                                              "assets/images/identi.gif");
                                                                    }
                                                                  } else {
                                                                    Navigator
                                                                        .push(
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
                                                            // )
                                                            : showDialog(
                                                                context: widget
                                                                    .globalKey
                                                                    .currentContext,
                                                                child:
                                                                    AddToCart(
                                                                  globalKey: widget
                                                                      .globalKey,
                                                                  product: widget
                                                                      .products[i],
                                                                  updateCart:
                                                                      false,
                                                                  choicesBuild: Provider.of<
                                                                              Pagination>(
                                                                          context,
                                                                          listen:
                                                                              false)
                                                                      .build,
                                                                  choiceColor: Provider.of<
                                                                              Pagination>(
                                                                          context,
                                                                          listen:
                                                                              false)
                                                                      .color,
                                                                  choiceCertification: Provider.of<
                                                                              Pagination>(
                                                                          context,
                                                                          listen:
                                                                              false)
                                                                      .cert,
                                                                  choiceDiamondQuality: Provider.of<
                                                                              Pagination>(
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
                                                      }
                                                    },
                                                    child: Icon(
                                                      Icons.shopping_cart,
                                                      color: Colors.white,
                                                      size: ScreenUtil().setSp(
                                                          16,
                                                          allowFontScalingSelf:
                                                              true),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    );
                                  }),
                              SizedBox(
                                height: ScreenUtil().setHeight(93),
                              ),
                            ],
                          ),
                  ),
                  if (isLoading)
                    CircularProgressIndicator(
                      backgroundColor: Colors.cyan,
                    )
                ],
              ),
              show
                  ? Center(
                      // left: ScreenUtil().setWidth(0),
                      // top: ScreenUtil().setHeight(50),
                      child: dateSelect(context, pro))
                  : SizedBox(
                      height: 0.0,
                      width: 0.0,
                    ),
            ],
          );

    // (styleNumber) {
    //  ar
    //   isFavourite: True;
    // }

    //body: ListView(
    //   children: <Widget>[
    //     SizedBox(height: 5.0),
    //     Container(
    //         padding: EdgeInsets.only(right: 15.0),
    //         width: MediaQuery.of(context).size.width - 30.0,
    //         height: MediaQuery.of(context).size.height - 50.0,
    //         child: GridView.builder(
    //           gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
    //             crossAxisCount: 2,
    //             crossAxisSpacing: 1.0,
    //             mainAxisSpacing: 15.0,
    //             childAspectRatio: 0.8,
    //           ),
    //           itemCount: widget.products.length,
    //           itemBuilder: (ctx, i) => _buildCard(widget.products[i].styleNumber, 'Price',
    //               widget.products[i].main, false,widget. products[i].isFavourite, context,widget.products[i].weight,widget.products[i].gWeight,widget.products[i].count,widget.products[i],scaff),
    //         )),
    //     SizedBox(height: 15.0)
    //   ],
    // ),
  }

  // Widget _buildCard(
  //     String name,
  //     String price,
  //     String imgPath,
  //     bool added,
  //     bool isFavorite,
  //     context,
  //     bool weight,
  //     bool gWeight,
  //     bool count,
  //     product,
  //     scaff) {
  //   print(imgPath);
  //   final Color themeColor = Theme.of(context).primaryColor;
  //   return Padding(
  //       padding: EdgeInsets.only(top: 5.0, bottom: 5.0, left: 20, right: 5.0),
  //       child: Container(
  //           decoration: BoxDecoration(
  //               borderRadius: BorderRadius.circular(15.0),
  //               boxShadow: [
  //                 BoxShadow(
  //                     color: Colors.grey.withOpacity(0.2),
  //                     spreadRadius: 3.0,
  //                     blurRadius: 5.0)
  //               ],
  //               color: Colors.white),
  //           child: Column(children: [
  //             Padding(
  //                 padding: EdgeInsets.all(5.0),
  //                 child:
  //                     Row(mainAxisAlignment: MainAxisAlignment.end, children: [
  //                   isFavorite
  //                       ? GestureDetector(
  //                           child: Icon(Icons.favorite, color: themeColor),
  //                           onTap: () async {
  //                             await Provider.of<Products>(context,
  //                                     listen: false)
  //                                 .toogleFavourite(
  //                                     styleNumber: product.styleNumber,
  //                                     context: context);
  //                             setState(() {});
  //                           },
  //                         )
  //                       : GestureDetector(
  //                           onTap: () async {
  //                             await Provider.of<Products>(context,
  //                                     listen: false)
  //                                 .toogleFavourite(
  //                                     styleNumber: product.styleNumber,
  //                                     context: context);
  //                             setState(() {});
  //                           },
  //                           child:
  //                               Icon(Icons.favorite_border, color: themeColor))
  //                 ])),
  //             Container(
  //               height: 120.0,
  //               width: 75.0,
  //               decoration: BoxDecoration(
  //                 image: DecorationImage(
  //                   image: NetworkImage(imgPath),
  //                   fit: BoxFit.cover,
  //                 ),
  //               ),
  //             ),
  //             SizedBox(height: 7.0),
  //             Text(price,
  //                 style: TextStyle(
  //                     color: themeColor, fontFamily: 'Varela', fontSize: 14.0)),
  //         ,allowFontScalingSelf: true    Text(name,
  //                 style: TextStyle(
  //                     color: Color(0xFF575E67),
  //                     fontFamily: 'Varela',
  //                     fontSize: 14.0)),
  //         ,allowFontScalingSelf: true    Padding(
  //                 padding: EdgeInsets.all(8.0),
  //                 child: Container(color: Color(0xFFEBEBEB), height: 1.0)),
  //             Padding(
  //                 padding: EdgeInsets.only(left: 5.0, right: 5.0),
  //                 child: Row(
  //                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //                     children: [
  //                       if (!added) ...[
  //                         Icon(Icons.shopping_basket,
  //                             color: themeColor, size: 12.0),
  //                         GestureDetector(
  //                             onTap: () async {
  //                               await Provider.of<Cart>(context, listen: false)
  //                                   .addCart(product, context);
  //                               scaff.showSnackBar(new SnackBar(
  //                                   content: new Text('product added')));
  //                             },
  //                             child: Text('Add to cart',
  //                                 style: TextStyle(
  //                                     fontFamily: 'Varela',
  //                                     color: themeColor,
  //                                     fontSize: 12.0)))
  //         ,allowFontScalingSelf: true              ],
  //                       if (added) ...[
  //                         Icon(Icons.remove_circle_outline,
  //                             color: themeColor, size: 12.0),
  //                         Text('3',
  //                             style: TextStyle(
  //                                 fontFamily: 'Varela',
  //                                 color: themeColor,
  //                                 fontWeight: FontWeight.bold,
  //                                 fontSize: 12.0)),
  //         ,allowFontScalingSelf: true                Icon(Icons.add_circle_outline,
  //                             color: themeColor, size: 12.0),
  //                       ]
  //                     ])),
  //             if (count)
  //               Text('Diamond Count : ' +
  //                   product.diamondCount.toString() +
  //                   ' PCS'),
  //             if (weight)
  //               Text('Diamond Weight : ' +
  //                   product.diamondWeight.toString() +
  //                   ' CT'),
  //             if (gWeight)
  //               Text('Gold Weight : ' + product.goldWeight.toString() + ' GM'),
  //           ])));
  // }
}

// GET /product/paginated?select=all&sortby=styleNumber&sort=1&page=1&quant=20 200 383.490 ms - 13838
// GET /product/paginated?select=featured&sortby=styleNumber&sort=1&page=1&quant=20 200 231.117 ms - 13842
// GET /product/paginated?select=new&sortby=styleNumber&sort=1&page=1&quant=20 200 236.191 ms - 13840
// GET /product/paginated?select=highestSelling&sortby=styleNumber&sort=1&page=1&quant=20 200 200.590 ms - 13836
// GET /product/paginated?select=fancyDiamond&sortby=styleNumber&sort=1&page=1&quant=20 200 222.539 ms - 13835

// GET /product/paginated?select=featured&sortby=styleNumber&sort=1&page= 2 &quant=20 200 206.111 ms - 13848

// GET /product/paginated?select=all&sortby=diamondWeight&sort=-1&page=1&quant=20 200 199.119 ms - 13895
// GET /product/paginated?select=featured&sortby=diamondWeight&sort=-1&page=1&quant=20 200 203.049 ms - 13880
// GET /product/paginated?select=new&sortby=diamondWeight&sort=-1&page=1&quant=20 200 197.254 ms - 13874

// GET /product/paginated?select=featured&sortby=styleNumber&sort=1&page= 3 &quant=20 200 209.461 ms - 13847

// GET /product/paginated?select=highestSelling&sortby=diamondWeight&sort=-1&page=1&quant=20 200 196.481 ms - 13877
// GET /product/paginated?select=fancyDiamond&sortby=diamondWeight&sort=-1&page=1&quant=20 200 217.105 ms - 13876

// GET /product/paginated?select=featured&sortby=styleNumber&sort=1&page= 4 &quant=20 200 202.454 ms - 13841
