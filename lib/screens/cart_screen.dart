import 'dart:async';
import 'dart:ui';
import 'package:Flutter/providers/notifiaction.dart';
import 'package:Flutter/providers/order.dart';
import 'package:Flutter/providers/cart.dart';
import 'package:Flutter/providers/options.dart';
import 'package:Flutter/providers/pagination.dart';
import 'package:Flutter/providers/search.dart';
import 'package:Flutter/screens/product_detail.dart';
import 'package:Flutter/widgets/add_to_cart.dart';
import 'package:Flutter/widgets/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_networkimage/provider.dart';
import 'package:flutter_animator/flutter_animator.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:flutter/gestures.dart';
import 'product_overview_screen.dart';
import 'package:url_launcher/url_launcher.dart';

class CartScreen extends StatefulWidget {
  final int pageIndex;
  final PageController pageController;

  const CartScreen({Key key, this.pageIndex, this.pageController})
      : super(key: key);
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  int valueOf = 0;

  int _defaultChoiceIndex4;

  int _defaultChoiceIndex3;

  int _defaultChoiceIndex2;

  int _defaultChoiceIndex1;
  bool flag;

  bool searchSelected = false;

  String searchValue = "";
  bool isCheckoutLoading = false;
  TextEditingController textEditingController = TextEditingController();

  bool searchSelectedDoneButton = false;

  bool isCartLoading = false;

  bool value2 = false;

  bool isListLoading = false;

  bool tapNotication = false;

  @override
  void initState() {
    super.initState();
    setState(() {
      isCartLoading = true;
    });
    Future.delayed(Duration.zero, () async {
      try {
        if (Provider.of<Cart>(context, listen: false).cart.isEmpty)
          await Provider.of<Cart>(context, listen: false)
              .getCart(context: context);
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
        isCartLoading = false;
      }
      setState(() {
        isCartLoading = false;
      });
    });
    flag = true;
  }

  void _onValueChange(int value, int index) {
    // await Provider.of<Options>(context, listen: false).setBuild(build: value);
    setState(() {
      Provider.of<Cart>(context, listen: false).buildChange(value, index);
      // print(value);
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

  final scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
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
    // final suggestion = styleNumber
    //     .where(
    //         (element) => element.contains(searchValue.toString().toUpperCase()))
    //     .toList();
    // print('Search Selected' + searchSelected.toString());
    return Scaffold(
      key: scaffoldKey,
      resizeToAvoidBottomInset: false,
      resizeToAvoidBottomPadding: false,

      // body: isCartLoading
      //     ? Center(
      //         child: CircularProgressIndicator(),
      //       )
      //     : Container(
      //         color: Color(0xFFF4F4F4),
      //         child: Stack(
      //           children: <Widget>[
      //             Container(
      //               height: ScreenUtil().setHeight(775),
      //               child: Column(
      //                 crossAxisAlignment: CrossAxisAlignment.center,
      //                 mainAxisAlignment: MainAxisAlignment.start,
      //                 children: <Widget>[
      //                   SizedBox(
      //                     height: ScreenUtil().setHeight(22 + 20 + 20 + 40),
      //                   ),
      //                   Padding(
      //                     padding: EdgeInsets.fromLTRB(24, 0, 25, 0),
      //                     child: Row(
      //                       crossAxisAlignment: CrossAxisAlignment.center,
      //                       mainAxisAlignment: MainAxisAlignment.start,
      //                       children: <Widget>[
      //                         ShaderMask(
      //                           shaderCallback: (bounds) => LinearGradient(
      //                             colors: [
      //                               Color(0xFF34B0D9),
      //                               Color(0xFF3685CB),
      //                             ],
      //                             begin: Alignment.topLeft,
      //                             end: Alignment.bottomRight,
      //                           ).createShader(
      //                             Rect.fromLTWH(
      //                                 0, 0, bounds.width, bounds.height),
      //                           ),
      //                           child: Text(
      //                             'CART',
      //                             style: TextStyle(
      //                               color: Colors.white,
      //                               fontFamily: 'Gilroy Bold',
      //                               fontSize: ScreenUtil()
      //                                   .setSp(20, allowFontScalingSelf: true),
      //                             ),
      //                           ),
      //                         ),
      //                       ],
      //                     ),
      //                   ),
      //                   SizedBox(
      //                     height: ScreenUtil().setHeight(20),
      //                   ),
      //                   Expanded(
      //                     child: Provider.of<Cart>(context, listen: true)
      //                                 .cart
      //                                 .length >
      //                             0
      //                         ? isListLoading
      //                             ? Center(child: CircularProgressIndicator())
      //                             : ListView.builder(
      //                                 scrollDirection: Axis.vertical,
      //                                 shrinkWrap: true,
      //                                 physics: BouncingScrollPhysics(),
      //                                 itemCount: Provider.of<Cart>(context,
      //                                         listen: true)
      //                                     .cart
      //                                     .length,
      //                                 itemBuilder: (context, index) {
      //                                   final product = Provider.of<Cart>(
      //                                           context,
      //                                           listen: true)
      //                                       .cart[index]
      //                                       .product;

      //                                   // _defaultChoiceIndex1 =
      //                                   //     Provider.of<Cart>(context, listen: true)
      //                                   //         .cart[index]
      //                                   //         .buildValue;
      //                                   // _defaultChoiceIndex2 =
      //                                   //     Provider.of<Cart>(context, listen: true)
      //                                   //         .cart[index]
      //                                   //         .colorValue;
      //                                   // _defaultChoiceIndex3 =
      //                                   //     Provider.of<Cart>(context, listen: true)
      //                                   //         .cart[index]
      //                                   //         .certValue;
      //                                   // _defaultChoiceIndex4 =
      //                                   //     Provider.of<Cart>(context, listen: true)
      //                                   //         .cart[index]
      //                                   //         .diamondValue;

      //                                   return Column(
      //                                     children: <Widget>[
      //                                       Dismissible(
      //                                         direction:
      //                                             DismissDirection.startToEnd,
      //                                         confirmDismiss: (DismissDirection
      //                                             direction) async {
      //                                           return await dataSelectConfirmMessage(
      //                                             context: context,
      //                                             titleText: 'Alert!',
      //                                             contentText:
      //                                                 "Are you sure, You want to remove ${product.styleNumber} from Cart?",
      //                                             gif:
      //                                                 'assets/images/reversecartGIF.gif',
      //                                           ).then((value) async {
      //                                             return value2 = value;
      //                                           });
      //                                         },
      //                                         onDismissed: (DismissDirection
      //                                             direction) async {
      //                                           // setState(() {
      //                                           //   isListLoading=true;
      //                                           // });
      //                                           try {
      //                                             await Provider.of<Cart>(
      //                                                     context,
      //                                                     listen: false)
      //                                                 .deleteCart(
      //                                                     id: Provider.of<Cart>(
      //                                                             context,
      //                                                             listen: false)
      //                                                         .cart[index]
      //                                                         .id,
      //                                                     context: context);
      //                                             if (mounted) setState(() {});
      //                                           } catch (err) {
      //                                             dataSelect(
      //                                                 context: context,
      //                                                 titleText: 'Alert!',
      //                                                 buttonText: 'Okay',
      //                                                 contentText:
      //                                                     err.toString(),
      //                                                 onPressed: () {
      //                                                   Navigator.pop(context);
      //                                                 },
      //                                                 gif:
      //                                                     "assets/images/alert.gif");
      //                                           }
      //                                         },
      //                                         background: Container(
      //                                           color: Colors.red,
      //                                           child: Padding(
      //                                             padding:
      //                                                 const EdgeInsets.all(15),
      //                                             child: Row(
      //                                               mainAxisAlignment:
      //                                                   MainAxisAlignment.start,
      //                                               children: [
      //                                                 Icon(Icons.delete,
      //                                                     color: Colors.white),
      //                                                 SizedBox(
      //                                                   width: ScreenUtil()
      //                                                       .setWidth(5),
      //                                                 ),
      //                                                 Text(
      //                                                   'Remove from Cart',
      //                                                   style: TextStyle(
      //                                                     fontFamily:
      //                                                         'Gilroy Regular',
      //                                                     color: Colors.white,
      //                                                   ),
      //                                                 ),
      //                                               ],
      //                                             ),
      //                                           ),
      //                                         ),
      //                                         key: UniqueKey(),
      //                                         child: Container(
      //                                           height:
      //                                               ScreenUtil().setHeight(94),
      //                                           width:
      //                                               ScreenUtil().setWidth(390),
      //                                           margin: EdgeInsets.fromLTRB(
      //                                               11.0, 0.0, 10.0, 5.0),
      //                                           decoration: BoxDecoration(
      //                                             borderRadius:
      //                                                 BorderRadius.circular(10),
      //                                             color: Colors.white,
      //                                           ),
      //                                           child: Row(
      //                                             mainAxisAlignment:
      //                                                 MainAxisAlignment.start,
      //                                             crossAxisAlignment:
      //                                                 CrossAxisAlignment.center,
      //                                             children: <Widget>[
      //                                               SizedBox(
      //                                                 width: ScreenUtil()
      //                                                     .setWidth(4),
      //                                               ),
      //                                               Image(
      //                                                 height: ScreenUtil()
      //                                                     .setHeight(79),
      //                                                 width: ScreenUtil()
      //                                                     .setWidth(76),
      //                                                 image: AdvancedNetworkImage(
      //                                                     product
      //                                                         .imageUrl[Provider
      //                                                             .of<Cart>(
      //                                                                 context,
      //                                                                 listen:
      //                                                                     true)
      //                                                         .cart[index]
      //                                                         .color
      //                                                         .toLowerCase()],
      //                                                     useDiskCache: true,
      //                                                     cacheRule: CacheRule(
      //                                                         maxAge:
      //                                                             const Duration(
      //                                                                 days:
      //                                                                     3))),
      //                                                 fit: BoxFit.fill,
      //                                               ),
      //                                               SizedBox(
      //                                                 width: ScreenUtil()
      //                                                     .setWidth(2),
      //                                               ),
      //                                               GestureDetector(
      //                                                 onTap: () {
      //                                                   showDialog(
      //                                                     context: context,
      //                                                     child: AddToCart(
      //                                                       product: product,
      //                                                       productIndexInCart:
      //                                                           index,
      //                                                       updateCart: true,
      //                                                       choicesBuild:
      //                                                           Provider.of<Pagination>(
      //                                                                   context,
      //                                                                   listen:
      //                                                                       false)
      //                                                               .build,
      //                                                       choiceColor: Provider.of<
      //                                                                   Pagination>(
      //                                                               context,
      //                                                               listen:
      //                                                                   false)
      //                                                           .color,
      //                                                       choiceCertification:
      //                                                           Provider.of<Pagination>(
      //                                                                   context,
      //                                                                   listen:
      //                                                                       false)
      //                                                               .cert,
      //                                                       choiceDiamondQuality:
      //                                                           Provider.of<Pagination>(
      //                                                                   context,
      //                                                                   listen:
      //                                                                       false)
      //                                                               .diamondQuality,
      //                                                       defValue: Provider.of<
      //                                                                   Cart>(
      //                                                               context,
      //                                                               listen:
      //                                                                   false)
      //                                                           .cart[index]
      //                                                           .buildValue,
      //                                                       defValue1: Provider
      //                                                               .of<Cart>(
      //                                                                   context,
      //                                                                   listen:
      //                                                                       false)
      //                                                           .cart[index]
      //                                                           .colorValue,
      //                                                       defValue2: Provider
      //                                                               .of<Cart>(
      //                                                                   context,
      //                                                                   listen:
      //                                                                       false)
      //                                                           .cart[index]
      //                                                           .certValue,
      //                                                       defValue3: Provider
      //                                                               .of<Cart>(
      //                                                                   context,
      //                                                                   listen:
      //                                                                       false)
      //                                                           .cart[index]
      //                                                           .diamondValue,
      //                                                       valueChangeBuild:
      //                                                           _onValueChange,
      //                                                       valueChangeColor:
      //                                                           _onValueChangeColor,
      //                                                       valueChangeCerti:
      //                                                           _onValueChangeCerti,
      //                                                       valueChangeDQ:
      //                                                           _onValueChangeDQ,
      //                                                       globalKey:
      //                                                           scaffoldKey,
      //                                                     ),
      //                                                   );
      //                                                 },
      //                                                 child: Container(
      //                                                   width: ScreenUtil()
      //                                                       .setWidth(192),
      //                                                   height: ScreenUtil()
      //                                                       .setHeight(79),
      //                                                   // color: Colors.amber,
      //                                                   child: Column(
      //                                                     crossAxisAlignment:
      //                                                         CrossAxisAlignment
      //                                                             .start,
      //                                                     mainAxisAlignment:
      //                                                         MainAxisAlignment
      //                                                             .center,
      //                                                     children: <Widget>[
      //                                                       Text(
      //                                                         '${product.styleNumber}',
      //                                                         style: TextStyle(
      //                                                           color: Colors
      //                                                               .black,
      //                                                           fontFamily:
      //                                                               'Gilroy Bold',
      //                                                           fontSize: ScreenUtil()
      //                                                               .setSp(18,
      //                                                                   allowFontScalingSelf:
      //                                                                       true),
      //                                                           fontWeight:
      //                                                               FontWeight
      //                                                                   .w500,
      //                                                         ),
      //                                                       ),
      //                                                       SizedBox(
      //                                                         height:
      //                                                             ScreenUtil()
      //                                                                 .setHeight(
      //                                                                     6),
      //                                                       ),
      //                                                       Text(
      //                                                         '${(Provider.of<Cart>(context, listen: true).cart[index].color).toUpperCase()} ${Provider.of<Cart>(context, listen: true).cart[index].diamond} ${Provider.of<Cart>(context, listen: true).cart[index].cert} ${Provider.of<Cart>(context, listen: true).cart[index].build}',
      //                                                         style: TextStyle(
      //                                                           color: Colors
      //                                                               .black,
      //                                                           fontFamily:
      //                                                               'Gilroy Light',
      //                                                           fontSize: ScreenUtil()
      //                                                               .setSp(12,
      //                                                                   allowFontScalingSelf:
      //                                                                       true),
      //                                                         ),
      //                                                       ),
      //                                                       SizedBox(
      //                                                         height:
      //                                                             ScreenUtil()
      //                                                                 .setHeight(
      //                                                                     4),
      //                                                       ),
      //                                                       ShaderMask(
      //                                                         shaderCallback:
      //                                                             (bounds) =>
      //                                                                 LinearGradient(
      //                                                           colors: [
      //                                                             Color(
      //                                                                 0xFF34B0D9),
      //                                                             Color(
      //                                                                 0xFF3685CB),
      //                                                           ],
      //                                                           begin: Alignment
      //                                                               .topLeft,
      //                                                           end: Alignment
      //                                                               .bottomRight,
      //                                                         ).createShader(
      //                                                           Rect.fromLTWH(
      //                                                               0,
      //                                                               0,
      //                                                               bounds
      //                                                                   .width,
      //                                                               bounds
      //                                                                   .height),
      //                                                         ),
      //                                                         // child: Text(
      //                                                         //   '5000 ₹',
      //                                                         //   style: TextStyle(
      //                                                         //     fontFamily: 'Gilroy Bold',
      //                                                         //     color: Colors.white,
      //                                                         //     fontSize: ScreenUtil().setSp(18,
      //                                                         //         allowFontScalingSelf: true),
      //                                                         //     fontWeight: FontWeight.w500,
      //                                                         //   ),
      //                                                         // ),
      //                                                         child: product.prices.containsKey(Provider.of<Cart>(
      //                                                                         context,
      //                                                                         listen:
      //                                                                             true)
      //                                                                     .cart[
      //                                                                         index]
      //                                                                     .diamond) &&
      //                                                                 Provider.of<Pagination>(
      //                                                                         context,
      //                                                                         listen: false)
      //                                                                     .isPriced
      //                                                             ? RichText(
      //                                                                 text:
      //                                                                     TextSpan(
      //                                                                   children: [
      //                                                                     TextSpan(
      //                                                                       text:
      //                                                                           '${(int.parse(product.prices[Provider.of<Cart>(context, listen: true).cart[index].diamond]) + Provider.of<Pagination>(context, listen: true).certPrices[Provider.of<Cart>(context, listen: true).cart[index].cert] + Provider.of<Pagination>(context, listen: true).buildPrices[Provider.of<Cart>(context, listen: true).cart[index].build]) * Provider.of<Cart>(context, listen: true).cart[index].quantity}',
      //                                                                       // '${(int.parse(product.prices[Provider.of<Cart>(context, listen: true).cart[index].diamond]) + Provider.of<Pagination>(context, listen: true).certPrices[Provider.of<Cart>(context, listen: true).cart[index].cert]) * Provider.of<Cart>(context, listen: true).cart[index].quantity}',
      //                                                                       style:
      //                                                                           TextStyle(
      //                                                                         color: Colors.white,
      //                                                                         fontSize: ScreenUtil().setSp(18, allowFontScalingSelf: true),
      //                                                                         fontFamily: 'Gilroy Bold',
      //                                                                       ),
      //                                                                     ),
      //                                                                     TextSpan(
      //                                                                       text:
      //                                                                           ' ₹',
      //                                                                       style:
      //                                                                           TextStyle(
      //                                                                         color: Colors.white,
      //                                                                         fontSize: ScreenUtil().setSp(18, allowFontScalingSelf: true),
      //                                                                         fontFamily: 'Roboto Medium',
      //                                                                       ),
      //                                                                     ),
      //                                                                   ],
      //                                                                 ),
      //                                                                 // '${int.parse(product.prices[Provider.of<Cart>(context, listen: true).cart[index].diamond]) + Provider.of<Pagination>(context, listen: true).certPrices[Provider.of<Cart>(context, listen: true).cart[index].cert]}',
      //                                                                 // style: TextStyle(
      //                                                                 //   color: Colors.white,
      //                                                                 //   fontSize: ScreenUtil()
      //                                                                 //       .setSp(18,
      //                                                                 //           allowFontScalingSelf:
      //                                                                 //               true),
      //                                                                 //   fontFamily:
      //                                                                 //       'Gilroy Bold',
      //                                                                 // ),
      //                                                               )
      //                                                             : Text(
      //                                                                 'Prices not set',
      //                                                                 style:
      //                                                                     TextStyle(
      //                                                                   color: Colors
      //                                                                       .white,
      //                                                                   fontSize: ScreenUtil().setSp(
      //                                                                       18,
      //                                                                       allowFontScalingSelf:
      //                                                                           true),
      //                                                                   fontFamily:
      //                                                                       'Gilroy Bold',
      //                                                                 ),
      //                                                               ),
      //                                                       ),
      //                                                     ],
      //                                                   ),
      //                                                 ),
      //                                               ),
      //                                               SizedBox(
      //                                                 width: ScreenUtil()
      //                                                     .setWidth(7),
      //                                               ),
      //                                             Container(
      //                                                   width: ScreenUtil()
      //                                                       .setWidth(93),
      //                                                   height: ScreenUtil()
      //                                                       .setHeight(80),
      //                                                   child: Row(
      //                                                     mainAxisAlignment:
      //                                                         MainAxisAlignment
      //                                                             .center,
      //                                                     crossAxisAlignment:
      //                                                         CrossAxisAlignment
      //                                                             .center,
      //                                                     children: <Widget>[
      //                                                       Container(
      //                                                         width:
      //                                                             ScreenUtil()
      //                                                                 .setWidth(
      //                                                                     15),
      //                                                         color: Colors
      //                                                             .transparent,
      //                                                         child: ShaderMask(
      //                                                           shaderCallback:
      //                                                               (bounds) =>
      //                                                                   LinearGradient(
      //                                                             colors: [
      //                                                               Colors
      //                                                                   .black,
      //                                                               Colors
      //                                                                   .black,
      //                                                             ],
      //                                                             begin: Alignment
      //                                                                 .topLeft,
      //                                                             end: Alignment
      //                                                                 .bottomRight,
      //                                                           ).createShader(
      //                                                             Rect.fromLTWH(
      //                                                                 0,
      //                                                                 0,
      //                                                                 bounds
      //                                                                     .width,
      //                                                                 bounds
      //                                                                     .height),
      //                                                           ),
      //                                                           child: Text(
      //                                                             '-',
      //                                                             style:
      //                                                                 TextStyle(
      //                                                               fontFamily:
      //                                                                   'Gilroy Bold',
      //                                                               color: Colors
      //                                                                   .black,
      //                                                               fontSize: ScreenUtil().setSp(
      //                                                                   25,
      //                                                                   allowFontScalingSelf:
      //                                                                       true),
      //                                                               fontWeight:
      //                                                                   FontWeight
      //                                                                       .w500,
      //                                                             ),
      //                                                           ),
      //                                                         ),
      //                                                       ),
      //                                                       SizedBox(
      //                                                         width:
      //                                                             ScreenUtil()
      //                                                                 .setWidth(
      //                                                                     5),
      //                                                       ),
      //                                                       GestureDetector(
      //                                                         onTap: () {},
      //                                                         child: Container(
      //                                                           width:
      //                                                               ScreenUtil()
      //                                                                   .setWidth(
      //                                                                       35),
      //                                                           child: Center(
      //                                                             child:
      //                                                                 ShaderMask(
      //                                                               shaderCallback:
      //                                                                   (bounds) =>
      //                                                                       LinearGradient(
      //                                                                 colors: [
      //                                                                   Colors
      //                                                                       .black,
      //                                                                   Colors
      //                                                                       .black,
      //                                                                 ],
      //                                                                 begin: Alignment
      //                                                                     .topLeft,
      //                                                                 end: Alignment
      //                                                                     .bottomRight,
      //                                                               ).createShader(
      //                                                                 Rect.fromLTWH(
      //                                                                     0,
      //                                                                     0,
      //                                                                     bounds
      //                                                                         .width,
      //                                                                     bounds
      //                                                                         .height),
      //                                                               ),
      //                                                               child: Text(
      //                                                                 // '888',
      //                                                                 '${Provider.of<Cart>(context, listen: true).cart[index].quantity}',
      //                                                                 style:
      //                                                                     TextStyle(
      //                                                                   fontFamily:
      //                                                                       'Gilroy Black',
      //                                                                   color: Colors
      //                                                                       .black,
      //                                                                   fontSize: ScreenUtil().setSp(
      //                                                                       20,
      //                                                                       allowFontScalingSelf:
      //                                                                           true),
      //                                                                   fontWeight:
      //                                                                       FontWeight.w500,
      //                                                                 ),
      //                                                               ),
      //                                                             ),
      //                                                           ),
      //                                                         ),
      //                                                       ),
      //                                                       SizedBox(
      //                                                         width:
      //                                                             ScreenUtil()
      //                                                                 .setWidth(
      //                                                                     5),
      //                                                       ),
      //                                                       GestureDetector(
      //                                                         onTap: () async {
      //                                                           try {
      //                                                             setState(() {
      //                                                               isCheckoutLoading =
      //                                                                   true;
      //                                                             });
      //                                                             await Provider.of<Cart>(context, listen: false).incQuantity(
      //                                                                 context:
      //                                                                     context,
      //                                                                 product:
      //                                                                     product,
      //                                                                 update:
      //                                                                     true,
      //                                                                 build: Provider.of<Pagination>(context, listen: false).build[Provider.of<Cart>(context, listen: false)
      //                                                                     .cart[
      //                                                                         index]
      //                                                                     .buildValue],
      //                                                                 color: Provider.of<Pagination>(context,
      //                                                                         listen:
      //                                                                             false)
      //                                                                     .color[Provider.of<Cart>(
      //                                                                         context,
      //                                                                         listen: false)
      //                                                                     .cart[index]
      //                                                                     .colorValue],
      //                                                                 cert: Provider.of<Pagination>(context, listen: false).cert[Provider.of<Cart>(context, listen: false).cart[index].certValue],
      //                                                                 diamond: Provider.of<Pagination>(context, listen: false).diamondQuality[Provider.of<Cart>(context, listen: false).cart[index].diamondValue],
      //                                                                 buildValue: Provider.of<Cart>(context, listen: false).cart[index].buildValue,
      //                                                                 colorValue: Provider.of<Cart>(context, listen: false).cart[index].colorValue,
      //                                                                 certvalue: Provider.of<Cart>(context, listen: false).cart[index].certValue,
      //                                                                 diamondValue: Provider.of<Cart>(context, listen: false).cart[index].diamondValue,
      //                                                                 index: index);
      //                                                             // setState(() {
      //                                                             //   isCheckoutLoading=false;
      //                                                             // });
      //                                                           } catch (err) {
      //                                                             dataSelect(
      //                                                                 context:
      //                                                                     context,
      //                                                                 titleText:
      //                                                                     'Alert!',
      //                                                                 buttonText:
      //                                                                     'Okay',
      //                                                                 contentText: err
      //                                                                     .toString(),
      //                                                                 onPressed:
      //                                                                     () {
      //                                                                   Navigator.pop(
      //                                                                       context);
      //                                                                 },
      //                                                                 gif:
      //                                                                     "assets/images/alert.gif");
      //                                                           } finally {
      //                                                             setState(() {
      //                                                               isCheckoutLoading =
      //                                                                   false;
      //                                                             });
      //                                                           }
      //                                                         },
      //                                                         child: Container(
      //                                                           width:
      //                                                               ScreenUtil()
      //                                                                   .setWidth(
      //                                                                       15),
      //                                                           color: Colors
      //                                                               .transparent,
      //                                                           child:
      //                                                               ShaderMask(
      //                                                             shaderCallback:
      //                                                                 (bounds) =>
      //                                                                     LinearGradient(
      //                                                               colors: [
      //                                                                 Color(
      //                                                                     0xFF34B0D9),
      //                                                                 Color(
      //                                                                     0xFF3685CB),
      //                                                               ],
      //                                                               begin: Alignment
      //                                                                   .topLeft,
      //                                                               end: Alignment
      //                                                                   .bottomRight,
      //                                                             ).createShader(
      //                                                               Rect.fromLTWH(
      //                                                                   0,
      //                                                                   0,
      //                                                                   bounds
      //                                                                       .width,
      //                                                                   bounds
      //                                                                       .height),
      //                                                             ),
      //                                                             child: Text(
      //                                                               '+',
      //                                                               style:
      //                                                                   TextStyle(
      //                                                                 fontFamily:
      //                                                                     'Gilroy Bold',
      //                                                                 color: Colors
      //                                                                     .white,
      //                                                                 fontSize: ScreenUtil().setSp(
      //                                                                     25,
      //                                                                     allowFontScalingSelf:
      //                                                                         true),
      //                                                                 fontWeight:
      //                                                                     FontWeight
      //                                                                         .w500,
      //                                                               ),
      //                                                             ),
      //                                                           ),
      //                                                         ),
      //                                                       )
      //                                                     ],
      //                                                   ),
      //                                                   decoration:
      //                                                       BoxDecoration(
      //                                                     image:
      //                                                         DecorationImage(
      //                                                       image: AssetImage(
      //                                                           'assets/images/cartButtonShape.png'),
      //                                                       fit: BoxFit.contain,
      //                                                     ),
      //                                                   ),
      //                                                 ),
      //                                               )
      //                                             ],
      //                                           ),
      //                                         ),
      //                                       ),
      //                                       index ==
      //                                               Provider.of<Cart>(context,
      //                                                           listen: false)
      //                                                       .cart
      //                                                       .length -
      //                                                   1
      //                                           ? SizedBox(
      //                                               height: ScreenUtil()
      //                                                   .setHeight(30),
      //                                             )
      //                                           : SizedBox(
      //                                               height: 0,
      //                                             ),
      //                                       index ==
      //                                                   Provider.of<Cart>(
      //                                                               context,
      //                                                               listen:
      //                                                                   false)
      //                                                           .cart
      //                                                           .length -
      //                                                       1 &&
      //                                               Provider.of<Pagination>(
      //                                                       context,
      //                                                       listen: false)
      //                                                   .isPriced
      //                                           ? Container(
      //                                               width: ScreenUtil()
      //                                                   .setWidth(250),
      //                                               height: ScreenUtil()
      //                                                   .setWidth(43),
      //                                               // padding: EdgeInsets.all(20.0),
      //                                               child: Material(
      //                                                 type: MaterialType
      //                                                     .transparency,
      //                                                 elevation: 6.0,
      //                                                 color: Colors.transparent,
      //                                                 borderRadius:
      //                                                     BorderRadius.circular(
      //                                                         30),
      //                                                 child: InkWell(
      //                                                   splashColor: Colors
      //                                                       .cyan[100]
      //                                                       .withOpacity(0.5),
      //                                                   borderRadius:
      //                                                       BorderRadius
      //                                                           .circular(30),
      //                                                   onTap: () async {
      //                                                     bool value2 = false;
      //                                                     await dataSelectConfirmMessage(
      //                                                       context: context,
      //                                                       titleText: 'Alert!',
      //                                                       contentText:
      //                                                           "Do you want to place order?",
      //                                                       gif:
      //                                                           'assets/images/cartGIF1.gif',
      //                                                     ).then((value) async {
      //                                                       if (value) {
      //                                                         value2 = value;
      //                                                       }
      //                                                     });
      //                                                     if (value2) {
      //                                                       try {
      //                                                         await Provider.of<
      //                                                                     Orders>(
      //                                                                 context,
      //                                                                 listen:
      //                                                                     false)
      //                                                             .placeOrder(
      //                                                                 context:
      //                                                                     context);
      //                                                         dataSelect(
      //                                                             context:
      //                                                                 context,
      //                                                             titleText:
      //                                                                 'Order Placed Succesfully!',
      //                                                             buttonText:
      //                                                                 'Okay',
      //                                                             contentText:
      //                                                                 "Your order has been placed successfully.",
      //                                                             onPressed:
      //                                                                 () {
      //                                                               Navigator.of(
      //                                                                       context)
      //                                                                   .pop();
      //                                                             },
      //                                                             gif:
      //                                                                 "assets/images/success.gif");
      //                                                       } catch (err) {
      //                                                         dataSelect(
      //                                                             context:
      //                                                                 context,
      //                                                             titleText:
      //                                                                 'Alert!',
      //                                                             buttonText:
      //                                                                 'Okay',
      //                                                             contentText: err
      //                                                                 .toString(),
      //                                                             onPressed:
      //                                                                 () {
      //                                                               Navigator.pop(
      //                                                                   context);
      //                                                             },
      //                                                             gif:
      //                                                                 "assets/images/alert.gif");
      //                                                       }
      //                                                     }
      //                                                   },
      //                                                   child: Center(
      //                                                     child: isCheckoutLoading
      //                                                         ? CircularProgressIndicator()
      //                                                         : Text(
      //                                                             'Checkout ${Provider.of<Cart>(context, listen: false).checkoutPrice(context: context)} ₹',
      //                                                             style:
      //                                                                 TextStyle(
      //                                                               fontFamily:
      //                                                                   'Gilroy Bold',
      //                                                               color: Colors
      //                                                                   .white,
      //                                                               fontSize: ScreenUtil().setSp(
      //                                                                   18,
      //                                                                   allowFontScalingSelf:
      //                                                                       true),
      //                                                               fontWeight:
      //                                                                   FontWeight
      //                                                                       .w500,
      //                                                             ),
      //                                                           ),
      //                                                   ),
      //                                                 ),
      //                                               ),
      //                                               decoration: BoxDecoration(
      //                                                   image: DecorationImage(
      //                                                 image: AssetImage(
      //                                                     'assets/images/vector17.png'),
      //                                                 fit: BoxFit.contain,
      //                                               )),
      //                                             )
      //                                           : SizedBox(
      //                                               height: 0,
      //                                             ),
      //                                       index ==
      //                                                   Provider.of<Cart>(
      //                                                               context,
      //                                                               listen:
      //                                                                   false)
      //                                                           .cart
      //                                                           .length -
      //                                                       1 &&
      //                                               Provider.of<Pagination>(
      //                                                       context,
      //                                                       listen: false)
      //                                                   .isPriced
      //                                           ? SizedBox(
      //                                               height: ScreenUtil()
      //                                                   .setHeight(93),
      //                                             )
      //                                           : SizedBox(
      //                                               height: 0,
      //                                             ),
      //                                       index ==
      //                                                   Provider.of<Cart>(
      //                                                               context,
      //                                                               listen:
      //                                                                   false)
      //                                                           .cart
      //                                                           .length -
      //                                                       1 &&
      //                                               Provider.of<Pagination>(
      //                                                           context,
      //                                                           listen: false)
      //                                                       .isPriced ==
      //                                                   false
      //                                           ? GestureDetector(
      //                                               onTap: () {},
      //                                               child: Container(
      //                                                 width: ScreenUtil()
      //                                                     .setWidth(250),
      //                                                 height: ScreenUtil()
      //                                                     .setWidth(43),
      //                                                 // padding: EdgeInsets.all(20.0),
      //                                                 child: Center(
      //                                                   child: Text(
      //                                                     'Prices Not Set',
      //                                                     style: TextStyle(
      //                                                       fontFamily:
      //                                                           'Gilroy Bold',
      //                                                       color: Colors.white,
      //                                                       fontSize: ScreenUtil()
      //                                                           .setSp(18,
      //                                                               allowFontScalingSelf:
      //                                                                   true),
      //                                                       fontWeight:
      //                                                           FontWeight.w500,
      //                                                     ),
      //                                                   ),
      //                                                 ),
      //                                                 decoration: BoxDecoration(
      //                                                     image:
      //                                                         DecorationImage(
      //                                                   image: AssetImage(
      //                                                       'assets/images/vector17.png'),
      //                                                   fit: BoxFit.contain,
      //                                                 )),
      //                                               ),
      //                                             )
      //                                           : SizedBox(
      //                                               height: 0,
      //                                             ),
      //                                       index ==
      //                                               Provider.of<Cart>(context,
      //                                                           listen: false)
      //                                                       .cart
      //                                                       .length -
      //                                                   1
      //                                           ? SizedBox(
      //                                               height: ScreenUtil()
      //                                                   .setHeight(93),
      //                                             )
      //                                           : SizedBox(
      //                                               height: 0,
      //                                             ),
      //                                     ],
      //                                   );
      //                                 },
      //                               )
      //                         : Container(
      //                             width: ScreenUtil().setHeight(350),
      //                             child: Center(
      //                               child: Text(
      //                                 "🛒 ➡ 🤷‍♂️ 'This means cart is empty!'",
      //                                 style: TextStyle(
      //                                   fontFamily: 'Gilory Regular',
      //                                   // decoration: TextDecoration.underline,
      //                                   color: Color(0xFFA49797),
      //                                   fontSize: ScreenUtil().setSp(17,
      //                                       allowFontScalingSelf: true),
      //                                   // fontWeight: FontWeight.bold,
      //                                 ),
      //                                 textAlign: TextAlign.center,
      //                               ),
      //                             ),
      //                           ),
      //                   ),
      //                 ],
      //               ),
      //             ),
      //             !searchSelected
      //                 ? SizedBox(
      //                     height: 0.0,
      //                     width: 0.0,
      //                   )
      //                 : Container(
      //                     height: ScreenUtil().setHeight(775),
      //                     width: ScreenUtil().setWidth(411),
      //                     color: Colors.transparent,
      //                     child: GestureDetector(
      //                       onTap: () {},
      //                       child: Container(
      //                         height: ScreenUtil().setHeight(775),
      //                         width: ScreenUtil().setWidth(411),
      //                       ),
      //                     ),
      //                   ),
      //             Container(
      //               child: BackdropFilter(
      //                 filter: ImageFilter.blur(
      //                     sigmaX: searchSelected ? 5 : 0,
      //                     sigmaY: searchSelected ? 5 : 0),
      //                 child: Column(
      //                   children: <Widget>[
      //                     SizedBox(
      //                       height: ScreenUtil().setHeight(22),
      //                     ),
      //                     Container(
      //                       width: ScreenUtil().setWidth(360),
      //                       height: ScreenUtil().setHeight(45),
      //                       margin: EdgeInsets.fromLTRB(
      //                           24, 20, 0, searchSelected ? 0 : 20),
      //                       child: Row(
      //                         mainAxisAlignment: MainAxisAlignment.start,
      //                         crossAxisAlignment: CrossAxisAlignment.center,
      //                         children: <Widget>[
      //                           AnimatedContainer(
      //                             duration: Duration(milliseconds: 600),
      //                             curve: Curves.easeInOut,
      //                             padding: EdgeInsets.only(left: 10.0),
      //                             width: ScreenUtil()
      //                                 .setWidth(searchSelected ? 305 : 360),
      //                             height: ScreenUtil().setHeight(45),
      //                             decoration: BoxDecoration(
      //                               borderRadius: BorderRadius.circular(10.0),
      //                               color: Colors.white,
      //                             ),
      //                             child: Stack(
      //                               alignment: Alignment.centerRight,
      //                               children: <Widget>[
      //                                 Positioned(
      //                                   top: 0.0,
      //                                   left: 0.0,
      //                                   // right: 0.0,
      //                                   child: Container(
      //                                     width: ScreenUtil().setWidth(
      //                                         searchSelected ? 305 : 360),
      //                                     height: ScreenUtil().setHeight(40),
      //                                     child: TextField(
      //                                       controller: textEditingController,
      //                                       onTap: () async {
      //                                         setState(() {
      //                                           searchSelected = true;
      //                                         });
      //                                         Timer(Duration(milliseconds: 700),
      //                                             () {
      //                                           setState(() {
      //                                             searchSelectedDoneButton =
      //                                                 true;
      //                                           });
      //                                         });
      //                                       },
      //                                       onChanged: (value) async {
      //                                         setState(() {
      //                                           // isLoadingSearch = true;
      //                                           searchValue =
      //                                               value.toUpperCase();
      //                                         });
      //                                         // setState(() {

      //                                         //   // info=styleNumber[].split(value);
      //                                         // print(styleNumber[1].split(searchValue));
      //                                         // });
      //                                         try {
      //                                           await getSearch(
      //                                               searchValue.toUpperCase());
      //                                         } catch (err) {
      //                                           dataSelect(
      //                                               context: context,
      //                                               titleText: 'Alert!',
      //                                               buttonText: 'Okay',
      //                                               contentText: err.toString(),
      //                                               onPressed: () {
      //                                                 Navigator.pop(context);
      //                                               },
      //                                               gif:
      //                                                   "assets/images/alert.gif");
      //                                         }
      //                                         // setState(() {
      //                                         //   isLoadingSearch = false;
      //                                         // });
      //                                         // getSearchResult(value.toUpperCase());
      //                                       },
      //                                       decoration: InputDecoration(
      //                                         // contentPadding: EdgeInsets.all(15.0),
      //                                         // suffixIcon: searchSelected
      //                                         //     ? GestureDetector(
      //                                         //         onTap: () {
      //                                         //           textEditingController
      //                                         //               .clear();
      //                                         //           setState(() {
      //                                         //             searchValue = "";
      //                                         //           });
      //                                         //         },
      //                                         //         child: Icon(Icons.clear),
      //                                         //       )
      //                                         //     : SizedBox(
      //                                         //         height: 0.0,
      //                                         //         width: 0.0,
      //                                         //       ),
      //                                         hintText: 'SEARCH GEMSTORY',
      //                                         hintStyle: TextStyle(
      //                                           fontFamily: 'Gilroy Medium',
      //                                           color: Color(0xFF595959),
      //                                           fontSize: ScreenUtil().setSp(14,
      //                                               allowFontScalingSelf: true),
      //                                         ),
      //                                         border: InputBorder.none,
      //                                       ),
      //                                       textAlign: searchSelected
      //                                           ? TextAlign.start
      //                                           : TextAlign.center,
      //                                       style: TextStyle(
      //                                           fontFamily: 'Gilroy Regular',
      //                                           fontSize: ScreenUtil().setSp(16,
      //                                               allowFontScalingSelf:
      //                                                   true)),
      //                                     ),
      //                                   ),
      //                                 ),
      //                                 AnimatedContainer(
      //                                   duration: Duration(milliseconds: 600),
      //                                   margin: EdgeInsets.only(right: 6.0),
      //                                   height: ScreenUtil()
      //                                       .setHeight(searchSelected ? 27 : 0),
      //                                   width: ScreenUtil()
      //                                       .setWidth(searchSelected ? 27 : 0),
      //                                   child: GestureDetector(
      //                                     onTap: () {
      //                                       textEditingController.clear();
      //                                       setState(() {
      //                                         searchValue = "";
      //                                       });
      //                                     },
      //                                     child: Icon(
      //                                       Icons.clear,
      //                                       color: Colors.black,
      //                                       size: searchSelected
      //                                           ? ScreenUtil().setSp(25,
      //                                               allowFontScalingSelf: true)
      //                                           : 0,
      //                                     ),
      //                                   ),
      //                                 ),
      //                                 GestureDetector(
      //                                   onTap: () {
      //                                     // setState(() {
      //                                     //   tapNotication =
      //                                     //       !tapNotication;
      //                                     // });
      //                                   },
      //                                   child: AnimatedContainer(
      //                                     duration: Duration(milliseconds: 600),
      //                                     margin: EdgeInsets.only(right: 6.0),
      //                                     height: ScreenUtil().setHeight(
      //                                         searchSelected ? 0 : 25),
      //                                     width: ScreenUtil().setWidth(
      //                                         searchSelected ? 0 : 25),
      //                                     child: SvgPicture.asset(
      //                                       Provider.of<Notif>(context,
      //                                                       listen: true)
      //                                                   .notifications
      //                                                   .length >
      //                                               0
      //                                           ? 'assets/icons/notificationPulseIcon.svg'
      //                                           : 'assets/icons/notificationIcon.svg',
      //                                       color: Colors.black,
      //                                     ),
      //                                   ),
      //                                 ),
      //                               ],
      //                             ),
      //                           ),
      //                           searchSelectedDoneButton
      //                               ? SizedBox(
      //                                   width: ScreenUtil().setWidth(10),
      //                                 )
      //                               : SizedBox(
      //                                   width: 0,
      //                                 ),
      //                           searchSelectedDoneButton
      //                               ? Container(
      //                                   height: ScreenUtil().setHeight(22),
      //                                   width: ScreenUtil().setWidth(45),
      //                                   child: GestureDetector(
      //                                     onTap: () {
      //                                       FocusScopeNode currentFocus =
      //                                           FocusScope.of(context);
      //                                       currentFocus.unfocus();
      //                                       textEditingController.clear();
      //                                       setState(() {
      //                                         searchValue = "";
      //                                         searchSelected = false;
      //                                         searchSelectedDoneButton = false;
      //                                       });
      //                                     },
      //                                     child: Text(
      //                                       'Done',
      //                                       style: TextStyle(
      //                                         fontFamily: 'Gilroy Bold',
      //                                         color: Colors.black,
      //                                         fontSize: ScreenUtil().setSp(16,
      //                                             allowFontScalingSelf: true),
      //                                         fontWeight: FontWeight.w500,
      //                                       ),
      //                                     ),
      //                                   ),
      //                                 )
      //                               : SizedBox(
      //                                   width: 0,
      //                                 ),
      //                         ],
      //                       ),
      //                     ),
      //                     !searchSelected
      //                         ? SizedBox(
      //                             height: 0.0,
      //                             width: 0.0,
      //                           )
      //                         : Divider(
      //                             color: Colors.grey[300],
      //                             endIndent: 70.0,
      //                             indent: 70.0,
      //                           ),
      //                     searchValue.isEmpty
      //                         ? SizedBox(
      //                             height: 0.0,
      //                             width: 0.0,
      //                           )
      //                         : isLoadingSearch
      //                             ? Center(
      //                                 child: CircularProgressIndicator(),
      //                               )
      //                             : Container(
      //                                 height: ScreenUtil().setHeight(600.0),
      //                                 width: ScreenUtil().setHeight(360),
      //                                 margin:
      //                                     EdgeInsets.fromLTRB(25, 0, 26, 20),
      //                                 decoration: BoxDecoration(
      //                                   color: Colors.white,
      //                                   borderRadius:
      //                                       BorderRadius.circular(15.0),
      //                                 ),
      //                                 child: suggestion.length > 0
      //                                     ? ListView.builder(
      //                                         shrinkWrap: true,
      //                                         scrollDirection: Axis.vertical,
      //                                         physics: BouncingScrollPhysics(),
      //                                         itemCount: Provider.of<Searchh>(
      //                                                 context,
      //                                                 listen: false)
      //                                             .searchResult
      //                                             .length,
      //                                         itemBuilder: (context, index) {
      //                                           info = suggestion[index]
      //                                               .styleNumber
      //                                               .split(searchValue);
      //                                           // print(info);
      //                                           return GestureDetector(
      //                                             onTap: () async {
      //                                               try {
      //                                                 await Provider.of<
      //                                                             Pagination>(
      //                                                         context,
      //                                                         listen: false)
      //                                                     .getProductDetail(
      //                                                         context: context,
      //                                                         styleNumber:
      //                                                             suggestion[
      //                                                                     index]
      //                                                                 .styleNumber);
      //                                                 FocusScopeNode
      //                                                     currentFocus =
      //                                                     FocusScope.of(
      //                                                         context);
      //                                                 currentFocus.unfocus();
      //                                                 textEditingController
      //                                                     .clear();
      //                                                 setState(() {
      //                                                   searchValue = "";
      //                                                   searchSelected = false;
      //                                                   searchSelectedDoneButton =
      //                                                       false;
      //                                                 });
      //                                                 Navigator.push(
      //                                                   context,
      //                                                   MaterialPageRoute(
      //                                                     builder: (context) =>
      //                                                         ProductDetail(
      //                                                       colorKey: 'yellow',
      //                                                       select: 'all',
      //                                                       diamondKey: Provider.of<
      //                                                                       Pagination>(
      //                                                                   context,
      //                                                                   listen:
      //                                                                       false)
      //                                                               .diamondQuality[
      //                                                           _defaultChoiceIndex4],
      //                                                       certPrice: Provider.of<
      //                                                                       Pagination>(
      //                                                                   context,
      //                                                                   listen:
      //                                                                       false)
      //                                                               .isPriced
      //                                                           ? Provider.of<
      //                                                                       Pagination>(
      //                                                                   context,
      //                                                                   listen:
      //                                                                       false)
      //                                                               .certPrices[Provider.of<
      //                                                                       Pagination>(
      //                                                                   context,
      //                                                                   listen:
      //                                                                       false)
      //                                                               .cert[_defaultChoiceIndex3]]
      //                                                           : null,
      //                                                       product: Provider.of<
      //                                                                   Pagination>(
      //                                                               context,
      //                                                               listen:
      //                                                                   false)
      //                                                           .productDetailsForSearch[0],
      //                                                       defaultIndex1:
      //                                                           _defaultChoiceIndex1,
      //                                                       defaultIndex2:
      //                                                           _defaultChoiceIndex2,
      //                                                       defaultIndex3:
      //                                                           _defaultChoiceIndex3,
      //                                                       defaultIndex4:
      //                                                           _defaultChoiceIndex4,
      //                                                       valueChangeBuild:
      //                                                           _onValueChange,
      //                                                       valueChangeColor:
      //                                                           _onValueChangeColor,
      //                                                       valueChangeCerti:
      //                                                           _onValueChangeCerti,
      //                                                       valueChangeDQ:
      //                                                           _onValueChangeDQ,
      //                                                       valueChangeBuild1:
      //                                                           _onValueChange,
      //                                                       valueChangeColor1:
      //                                                           _onValueChangeColor,
      //                                                       valueChangeCerti1:
      //                                                           _onValueChangeCerti,
      //                                                       valueChangeDQ1:
      //                                                           _onValueChangeDQ,
      //                                                     ),
      //                                                   ),
      //                                                 );
      //                                               } catch (err) {
      //                                                 dataSelect(
      //                                                     context: context,
      //                                                     titleText: 'Alert!',
      //                                                     buttonText: 'Okay',
      //                                                     contentText:
      //                                                         err.toString(),
      //                                                     onPressed: () {
      //                                                       Navigator.pop(
      //                                                           context);
      //                                                     },
      //                                                     gif:
      //                                                         "assets/images/alert.gif");
      //                                               }
      //                                             },
      //                                             child: Container(
      //                                               color: Colors.transparent,
      //                                               padding:
      //                                                   const EdgeInsets.only(
      //                                                       left: 20.0,
      //                                                       right: 20.0),
      //                                               child: Row(
      //                                                 mainAxisAlignment:
      //                                                     MainAxisAlignment
      //                                                         .start,
      //                                                 crossAxisAlignment:
      //                                                     CrossAxisAlignment
      //                                                         .center,
      //                                                 children: <Widget>[
      //                                                   Container(
      //                                                     height: ScreenUtil()
      //                                                         .setHeight(90),
      //                                                     width: ScreenUtil()
      //                                                         .setWidth(90),
      //                                                     // color: Colors.amber,
      //                                                     child: Image(
      //                                                       image:
      //                                                           AdvancedNetworkImage(
      //                                                         suggestion[index]
      //                                                             .image,
      //                                                         useDiskCache:
      //                                                             true,
      //                                                         cacheRule: CacheRule(
      //                                                             maxAge:
      //                                                                 const Duration(
      //                                                                     days:
      //                                                                         3)),
      //                                                       ),
      //                                                       fit: BoxFit.fill,
      //                                                     ),
      //                                                   ),
      //                                                   // Text(
      //                                                   //   styleNumber[index],
      //                                                   //   style: TextStyle(
      //                                                   //     fontFamily: 'Gilroy Medium',
      //                                                   //     fontSize: ScreenUtil().setSp(21,allowFontScalingSelf: true),
      //                                                   //   ),
      //                                                   // )
      //                                                   RichText(
      //                                                     text: TextSpan(
      //                                                       // text: suggestion[index].substring(
      //                                                       //   suggestion[index].indexOf(
      //                                                       //       searchValue),
      //                                                       //   searchValue.length,
      //                                                       // ),
      //                                                       style: TextStyle(
      //                                                         color:
      //                                                             Colors.black,
      //                                                         fontWeight:
      //                                                             FontWeight
      //                                                                 .bold,
      //                                                         fontFamily:
      //                                                             'Gilroy Medium',
      //                                                         fontSize: ScreenUtil()
      //                                                             .setSp(21,
      //                                                                 allowFontScalingSelf:
      //                                                                     true),
      //                                                       ),
      //                                                       children: [
      //                                                         TextSpan(
      //                                                           text: info[0],
      //                                                           style:
      //                                                               TextStyle(
      //                                                             color: Colors
      //                                                                 .grey,
      //                                                             // fontWeight: FontWeight.bold,
      //                                                             fontFamily:
      //                                                                 'Gilroy Medium',
      //                                                             fontSize: ScreenUtil().setSp(
      //                                                                 21,
      //                                                                 allowFontScalingSelf:
      //                                                                     true),
      //                                                           ),
      //                                                         ),
      //                                                         TextSpan(
      //                                                           text:
      //                                                               searchValue,
      //                                                           style:
      //                                                               TextStyle(
      //                                                             color: Colors
      //                                                                 .black,
      //                                                             fontWeight:
      //                                                                 FontWeight
      //                                                                     .bold,
      //                                                             fontFamily:
      //                                                                 'Gilroy Medium',
      //                                                             fontSize: ScreenUtil().setSp(
      //                                                                 21,
      //                                                                 allowFontScalingSelf:
      //                                                                     true),
      //                                                           ),
      //                                                         ),
      //                                                         TextSpan(
      //                                                           text: info[1],
      //                                                           style:
      //                                                               TextStyle(
      //                                                             color: Colors
      //                                                                 .grey,
      //                                                             // fontWeight: FontWeight.bold,
      //                                                             fontFamily:
      //                                                                 'Gilroy Medium',
      //                                                             fontSize: ScreenUtil().setSp(
      //                                                                 21,
      //                                                                 allowFontScalingSelf:
      //                                                                     true),
      //                                                           ),
      //                                                         ),
      //                                                       ],
      //                                                     ),
      //                                                   )
      //                                                 ],
      //                                               ),
      //                                             ),
      //                                           );
      //                                         },
      //                                       )
      //                                     : Center(
      //                                         child: Text(
      //                                           'No Products Found',
      //                                         ),
      //                                       ),
      //                               )
      //                   ],
      //                 ),
      //               ),
      //             ),
      //           ],
      //         ),
      //       ),

      body: isCartLoading
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
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                          height: ScreenUtil().setHeight(22 + 20 + 20 + 40),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(24, 0, 25, 0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
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
                                  'CART',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Gilroy Bold',
                                    fontSize: ScreenUtil()
                                        .setSp(20, allowFontScalingSelf: true),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: ScreenUtil().setHeight(20),
                        ),
                        Expanded(
                          child:
                              Provider.of<Cart>(context, listen: true)
                                          .cart
                                          .length >
                                      0
                                  ? isListLoading
                                      ? Center(
                                          child: CircularProgressIndicator())
                                      : ListView.builder(
                                          scrollDirection: Axis.vertical,
                                          shrinkWrap: true,
                                          physics: BouncingScrollPhysics(),
                                          itemCount: Provider.of<Cart>(context,
                                                  listen: true)
                                              .cart
                                              .length,
                                          itemBuilder: (context, index) {
                                            final product = Provider.of<Cart>(
                                                    context,
                                                    listen: true)
                                                .cart[index]
                                                .product;

                                            // _defaultChoiceIndex1 =
                                            //     Provider.of<Cart>(context, listen: true)
                                            //         .cart[index]
                                            //         .buildValue;
                                            // _defaultChoiceIndex2 =
                                            //     Provider.of<Cart>(context, listen: true)
                                            //         .cart[index]
                                            //         .colorValue;
                                            // _defaultChoiceIndex3 =
                                            //     Provider.of<Cart>(context, listen: true)
                                            //         .cart[index]
                                            //         .certValue;
                                            // _defaultChoiceIndex4 =
                                            //     Provider.of<Cart>(context, listen: true)
                                            //         .cart[index]
                                            //         .diamondValue;

                                            return Column(
                                              children: <Widget>[
                                                Dismissible(
                                                  direction: DismissDirection
                                                      .startToEnd,
                                                  confirmDismiss:
                                                      (DismissDirection
                                                          direction) async {
                                                    return await dataSelectConfirmMessage(
                                                      context: context,
                                                      titleText: 'Alert!',
                                                      contentText:
                                                          "Are you sure, You want to remove ${product.styleNumber} from Cart?",
                                                      gif:
                                                          'assets/images/reversecartGIF.gif',
                                                    ).then((value) async {
                                                      return value2 = value;
                                                    });
                                                  },
                                                  onDismissed: (DismissDirection
                                                      direction) async {
                                                    // setState(() {
                                                    //   isListLoading=true;
                                                    // });
                                                    try {
                                                      await Provider.of<Cart>(
                                                              context,
                                                              listen: false)
                                                          .deleteCart(
                                                              id: Provider.of<
                                                                          Cart>(
                                                                      context,
                                                                      listen:
                                                                          false)
                                                                  .cart[index]
                                                                  .id,
                                                              context: context);
                                                      if (mounted)
                                                        setState(() {});
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
                                                  background: Container(
                                                    color: Colors.red,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              15),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: [
                                                          Icon(Icons.delete,
                                                              color:
                                                                  Colors.white),
                                                          SizedBox(
                                                            width: ScreenUtil()
                                                                .setWidth(5),
                                                          ),
                                                          Text(
                                                            'Remove from Cart',
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  'Gilroy Regular',
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  key: UniqueKey(),
                                                  child: Container(
                                                    height: ScreenUtil()
                                                        .setHeight(94),
                                                    width: ScreenUtil()
                                                        .setWidth(390),
                                                    margin: EdgeInsets.fromLTRB(
                                                        11.0, 0.0, 10.0, 5.0),
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      color: Colors.white,
                                                    ),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: <Widget>[
                                                        SizedBox(
                                                          width: ScreenUtil()
                                                              .setWidth(4),
                                                        ),
                                                        Image(
                                                          height: ScreenUtil()
                                                              .setHeight(79),
                                                          width: ScreenUtil()
                                                              .setWidth(76),
                                                          image: AdvancedNetworkImage(
                                                              product
                                                                  .imageUrl[Provider.of<
                                                                          Cart>(
                                                                      context,
                                                                      listen:
                                                                          true)
                                                                  .cart[index]
                                                                  .color
                                                                  .toLowerCase()],
                                                              useDiskCache:
                                                                  true,
                                                              cacheRule: CacheRule(
                                                                  maxAge:
                                                                      const Duration(
                                                                          days:
                                                                              3))),
                                                          fit: BoxFit.fill,
                                                        ),
                                                        SizedBox(
                                                          width: ScreenUtil()
                                                              .setWidth(2),
                                                        ),
                                                        GestureDetector(
                                                          onTap: () {
                                                            showDialog(
                                                              context: context,
                                                              child: AddToCart(
                                                                product:
                                                                    product,
                                                                productIndexInCart:
                                                                    index,
                                                                updateCart:
                                                                    true,
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
                                                                defValue: Provider.of<
                                                                            Cart>(
                                                                        context,
                                                                        listen:
                                                                            false)
                                                                    .cart[index]
                                                                    .buildValue,
                                                                defValue1: Provider.of<
                                                                            Cart>(
                                                                        context,
                                                                        listen:
                                                                            false)
                                                                    .cart[index]
                                                                    .colorValue,
                                                                defValue2: Provider.of<
                                                                            Cart>(
                                                                        context,
                                                                        listen:
                                                                            false)
                                                                    .cart[index]
                                                                    .certValue,
                                                                defValue3: Provider.of<
                                                                            Cart>(
                                                                        context,
                                                                        listen:
                                                                            false)
                                                                    .cart[index]
                                                                    .diamondValue,
                                                                valueChangeBuild:
                                                                    _onValueChange,
                                                                valueChangeColor:
                                                                    _onValueChangeColor,
                                                                valueChangeCerti:
                                                                    _onValueChangeCerti,
                                                                valueChangeDQ:
                                                                    _onValueChangeDQ,
                                                                globalKey:
                                                                    scaffoldKey,
                                                              ),
                                                            );
                                                          },
                                                          child: Container(
                                                            width: ScreenUtil()
                                                                .setWidth(192),
                                                            height: ScreenUtil()
                                                                .setHeight(79),
                                                            // color: Colors.amber,
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: <
                                                                  Widget>[
                                                                Text(
                                                                  '${product.styleNumber}',
                                                                  style:
                                                                      TextStyle(
                                                                    color: Colors
                                                                        .black,
                                                                    fontFamily:
                                                                        'Gilroy Bold',
                                                                    fontSize: ScreenUtil().setSp(
                                                                        18,
                                                                        allowFontScalingSelf:
                                                                            true),
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  height: ScreenUtil()
                                                                      .setHeight(
                                                                          6),
                                                                ),
                                                                Text(
                                                                  '${(Provider.of<Cart>(context, listen: true).cart[index].color).toUpperCase()} ${Provider.of<Cart>(context, listen: true).cart[index].diamond} ${Provider.of<Cart>(context, listen: true).cart[index].cert} ${Provider.of<Cart>(context, listen: true).cart[index].build}',
                                                                  style:
                                                                      TextStyle(
                                                                    color: Colors
                                                                        .black,
                                                                    fontFamily:
                                                                        'Gilroy Light',
                                                                    fontSize: ScreenUtil().setSp(
                                                                        12,
                                                                        allowFontScalingSelf:
                                                                            true),
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  height: ScreenUtil()
                                                                      .setHeight(
                                                                          4),
                                                                ),
                                                                ShaderMask(
                                                                  shaderCallback:
                                                                      (bounds) =>
                                                                          LinearGradient(
                                                                    colors: [
                                                                      Color(
                                                                          0xFF34B0D9),
                                                                      Color(
                                                                          0xFF3685CB),
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
                                                                  // child: Text(
                                                                  //   '5000 ₹',
                                                                  //   style: TextStyle(
                                                                  //     fontFamily: 'Gilroy Bold',
                                                                  //     color: Colors.white,
                                                                  //     fontSize: ScreenUtil().setSp(18,
                                                                  //         allowFontScalingSelf: true),
                                                                  //     fontWeight: FontWeight.w500,
                                                                  //   ),
                                                                  // ),
                                                                  child: product
                                                                              .prices
                                                                              .containsKey(Provider.of<Cart>(context, listen: true).cart[index].diamond) &&
                                                                          Provider.of<Pagination>(context, listen: false).isPriced
                                                                      ? RichText(
                                                                          text:
                                                                              TextSpan(
                                                                            children: [
                                                                              TextSpan(
                                                                                text: '${(int.parse(product.prices[Provider.of<Cart>(context, listen: true).cart[index].diamond]) + Provider.of<Pagination>(context, listen: true).certPrices[Provider.of<Cart>(context, listen: true).cart[index].cert] + Provider.of<Pagination>(context, listen: true).buildPrices[Provider.of<Cart>(context, listen: true).cart[index].build]) * Provider.of<Cart>(context, listen: true).cart[index].quantity}',
                                                                                // '${(int.parse(product.prices[Provider.of<Cart>(context, listen: true).cart[index].diamond]) + Provider.of<Pagination>(context, listen: true).certPrices[Provider.of<Cart>(context, listen: true).cart[index].cert]) * Provider.of<Cart>(context, listen: true).cart[index].quantity}',
                                                                                style: TextStyle(
                                                                                  color: Colors.white,
                                                                                  fontSize: ScreenUtil().setSp(18, allowFontScalingSelf: true),
                                                                                  fontFamily: 'Gilroy Bold',
                                                                                ),
                                                                              ),
                                                                              TextSpan(
                                                                                text: ' ₹',
                                                                                style: TextStyle(
                                                                                  color: Colors.white,
                                                                                  fontSize: ScreenUtil().setSp(18, allowFontScalingSelf: true),
                                                                                  fontFamily: 'Roboto Medium',
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                          // '${int.parse(product.prices[Provider.of<Cart>(context, listen: true).cart[index].diamond]) + Provider.of<Pagination>(context, listen: true).certPrices[Provider.of<Cart>(context, listen: true).cart[index].cert]}',
                                                                          // style: TextStyle(
                                                                          //   color: Colors.white,
                                                                          //   fontSize: ScreenUtil()
                                                                          //       .setSp(18,
                                                                          //           allowFontScalingSelf:
                                                                          //               true),
                                                                          //   fontFamily:
                                                                          //       'Gilroy Bold',
                                                                          // ),
                                                                        )
                                                                      : Text(
                                                                          'Prices not set',
                                                                          style:
                                                                              TextStyle(
                                                                            color:
                                                                                Colors.white,
                                                                            fontSize:
                                                                                ScreenUtil().setSp(18, allowFontScalingSelf: true),
                                                                            fontFamily:
                                                                                'Gilroy Bold',
                                                                          ),
                                                                        ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: ScreenUtil()
                                                              .setWidth(7),
                                                        ),
                                                        Container(
                                                          width: ScreenUtil()
                                                              .setWidth(93),
                                                          height: ScreenUtil()
                                                              .setHeight(80),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .center,
                                                            children: <Widget>[
                                                              GestureDetector(
                                                                onTap:
                                                                    () async {
                                                                  setState(() {
                                                                    isCheckoutLoading =
                                                                        true;
                                                                  });
                                                                  if (Provider.of<Cart>(
                                                                              context,
                                                                              listen:
                                                                                  false)
                                                                          .cart[
                                                                              index]
                                                                          .quantity >=
                                                                      1) {
                                                                    try {
                                                                      if (Provider.of<Cart>(context, listen: false)
                                                                              .cart[index]
                                                                              .quantity ==
                                                                          1) {
                                                                        final v =
                                                                            await dataSelectConfirmMessage(
                                                                          context:
                                                                              context,
                                                                          titleText:
                                                                              'Alert!',
                                                                          contentText:
                                                                              "Are you sure, You want to remove ${product.styleNumber} from Cart?",
                                                                          gif:
                                                                              'assets/images/reversecartGIF.gif',
                                                                        );
                                                                        if (v) {
                                                                          try {
                                                                            await Provider.of<Cart>(context, listen: false).deleteCart(
                                                                                id: Provider.of<Cart>(context, listen: false).cart[index].id,
                                                                                context: context);
                                                                            if (mounted) {
                                                                              setState(() {});
                                                                            }
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
                                                                        }
                                                                      } else {
                                                                        await Provider.of<Cart>(context, listen: false).decQuantity(
                                                                            context:
                                                                                context,
                                                                            product:
                                                                                product,
                                                                            update:
                                                                                true,
                                                                            build:
                                                                                Provider.of<Pagination>(context, listen: false).build[Provider.of<Cart>(context, listen: false).cart[index].buildValue],
                                                                            color: Provider.of<Pagination>(context, listen: false).color[Provider.of<Cart>(context, listen: false).cart[index].colorValue],
                                                                            cert: Provider.of<Pagination>(context, listen: false).cert[Provider.of<Cart>(context, listen: false).cart[index].certValue],
                                                                            diamond: Provider.of<Pagination>(context, listen: false).diamondQuality[Provider.of<Cart>(context, listen: false).cart[index].diamondValue],
                                                                            buildValue: Provider.of<Cart>(context, listen: false).cart[index].buildValue,
                                                                            colorValue: Provider.of<Cart>(context, listen: false).cart[index].colorValue,
                                                                            certvalue: Provider.of<Cart>(context, listen: false).cart[index].certValue,
                                                                            diamondValue: Provider.of<Cart>(context, listen: false).cart[index].diamondValue,
                                                                            index: index);
                                                                      }
                                                                    } catch (err) {
                                                                      dataSelect(
                                                                          context:
                                                                              context,
                                                                          titleText:
                                                                              'Alert!',
                                                                          buttonText:
                                                                              'Okay',
                                                                          contentText: err
                                                                              .toString(),
                                                                          onPressed:
                                                                              () {
                                                                            Navigator.pop(context);
                                                                          },
                                                                          gif:
                                                                              "assets/images/alert.gif");
                                                                    } finally {
                                                                      setState(
                                                                          () {
                                                                        isCheckoutLoading =
                                                                            false;
                                                                      });
                                                                    }
                                                                  }
                                                                },
                                                                child:
                                                                    Container(
                                                                  width: ScreenUtil()
                                                                      .setWidth(
                                                                          15),
                                                                  color: Colors
                                                                      .transparent,
                                                                  child:
                                                                      ShaderMask(
                                                                    shaderCallback:
                                                                        (bounds) =>
                                                                            LinearGradient(
                                                                      colors: [
                                                                        Colors
                                                                            .black,
                                                                        Colors
                                                                            .black,
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
                                                                    child: Text(
                                                                      '-',
                                                                      style:
                                                                          TextStyle(
                                                                        fontFamily:
                                                                            'Gilroy Bold',
                                                                        color: Colors
                                                                            .black,
                                                                        fontSize: ScreenUtil().setSp(
                                                                            25,
                                                                            allowFontScalingSelf:
                                                                                true),
                                                                        fontWeight:
                                                                            FontWeight.w500,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                width:
                                                                    ScreenUtil()
                                                                        .setWidth(
                                                                            5),
                                                              ),
                                                              GestureDetector(
                                                                onTap: () {},
                                                                child:
                                                                    Container(
                                                                  width: ScreenUtil()
                                                                      .setWidth(
                                                                          35),
                                                                  child: Center(
                                                                    child:
                                                                        ShaderMask(
                                                                      shaderCallback:
                                                                          (bounds) =>
                                                                              LinearGradient(
                                                                        colors: [
                                                                          Colors
                                                                              .black,
                                                                          Colors
                                                                              .black,
                                                                        ],
                                                                        begin: Alignment
                                                                            .topLeft,
                                                                        end: Alignment
                                                                            .bottomRight,
                                                                      ).createShader(
                                                                        Rect.fromLTWH(
                                                                            0,
                                                                            0,
                                                                            bounds.width,
                                                                            bounds.height),
                                                                      ),
                                                                      child:
                                                                          Text(
                                                                        // '888',
                                                                        '${Provider.of<Cart>(context, listen: true).cart[index].quantity}',
                                                                        style:
                                                                            TextStyle(
                                                                          fontFamily:
                                                                              'Gilroy Black',
                                                                          color:
                                                                              Colors.black,
                                                                          fontSize: ScreenUtil().setSp(
                                                                              20,
                                                                              allowFontScalingSelf: true),
                                                                          fontWeight:
                                                                              FontWeight.w500,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                width:
                                                                    ScreenUtil()
                                                                        .setWidth(
                                                                            5),
                                                              ),
                                                              GestureDetector(
                                                                onTap:
                                                                    () async {
                                                                  try {
                                                                    setState(
                                                                        () {
                                                                      isCheckoutLoading =
                                                                          true;
                                                                    });
                                                                    await Provider.of<Cart>(context, listen: false).incQuantity(
                                                                        context:
                                                                            context,
                                                                        product:
                                                                            product,
                                                                        update:
                                                                            true,
                                                                        build: Provider.of<Pagination>(context, listen: false).build[Provider.of<Cart>(context, listen: false)
                                                                            .cart[
                                                                                index]
                                                                            .buildValue],
                                                                        color: Provider.of<Pagination>(context, listen: false)
                                                                            .color[Provider.of<Cart>(context,
                                                                                listen: false)
                                                                            .cart[index]
                                                                            .colorValue],
                                                                        cert: Provider.of<Pagination>(context, listen: false).cert[Provider.of<Cart>(context, listen: false).cart[index].certValue],
                                                                        diamond: Provider.of<Pagination>(context, listen: false).diamondQuality[Provider.of<Cart>(context, listen: false).cart[index].diamondValue],
                                                                        buildValue: Provider.of<Cart>(context, listen: false).cart[index].buildValue,
                                                                        colorValue: Provider.of<Cart>(context, listen: false).cart[index].colorValue,
                                                                        certvalue: Provider.of<Cart>(context, listen: false).cart[index].certValue,
                                                                        diamondValue: Provider.of<Cart>(context, listen: false).cart[index].diamondValue,
                                                                        index: index);
                                                                    // setState(() {
                                                                    //   isCheckoutLoading=false;
                                                                    // });
                                                                  } catch (err) {
                                                                    dataSelect(
                                                                        context:
                                                                            context,
                                                                        titleText:
                                                                            'Alert!',
                                                                        buttonText:
                                                                            'Okay',
                                                                        contentText: err
                                                                            .toString(),
                                                                        onPressed:
                                                                            () {
                                                                          Navigator.pop(
                                                                              context);
                                                                        },
                                                                        gif:
                                                                            "assets/images/alert.gif");
                                                                  } finally {
                                                                    setState(
                                                                        () {
                                                                      isCheckoutLoading =
                                                                          false;
                                                                    });
                                                                  }
                                                                },
                                                                child:
                                                                    Container(
                                                                  width: ScreenUtil()
                                                                      .setWidth(
                                                                          15),
                                                                  color: Colors
                                                                      .transparent,
                                                                  child:
                                                                      ShaderMask(
                                                                    shaderCallback:
                                                                        (bounds) =>
                                                                            LinearGradient(
                                                                      colors: [
                                                                        Color(
                                                                            0xFF34B0D9),
                                                                        Color(
                                                                            0xFF3685CB),
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
                                                                    child: Text(
                                                                      '+',
                                                                      style:
                                                                          TextStyle(
                                                                        fontFamily:
                                                                            'Gilroy Bold',
                                                                        color: Colors
                                                                            .white,
                                                                        fontSize: ScreenUtil().setSp(
                                                                            25,
                                                                            allowFontScalingSelf:
                                                                                true),
                                                                        fontWeight:
                                                                            FontWeight.w500,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          decoration:
                                                              BoxDecoration(
                                                            image:
                                                                DecorationImage(
                                                              image: AssetImage(
                                                                  'assets/images/cartButtonShape.png'),
                                                              fit: BoxFit
                                                                  .contain,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                index ==
                                                        Provider.of<Cart>(
                                                                    context,
                                                                    listen:
                                                                        false)
                                                                .cart
                                                                .length -
                                                            1
                                                    ? SizedBox(
                                                        height: ScreenUtil()
                                                            .setHeight(30),
                                                      )
                                                    : SizedBox(
                                                        height: 0,
                                                      ),
                                                index ==
                                                            Provider.of<Cart>(
                                                                        context,
                                                                        listen:
                                                                            false)
                                                                    .cart
                                                                    .length -
                                                                1 &&
                                                        Provider.of<Pagination>(
                                                                context,
                                                                listen: false)
                                                            .isPriced
                                                    ? Column(
                                                        children: <Widget>[
                                                          Container(
                                                            width: ScreenUtil()
                                                                .setWidth(250),
                                                            height: ScreenUtil()
                                                                .setWidth(43),
                                                            // padding: EdgeInsets.all(20.0),
                                                            child: Material(
                                                              type: MaterialType
                                                                  .transparency,
                                                              elevation: 6.0,
                                                              color: Colors
                                                                  .transparent,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          30),
                                                              child: InkWell(
                                                                splashColor: Colors
                                                                    .cyan[100]
                                                                    .withOpacity(
                                                                        0.5),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            30),
                                                                onTap:
                                                                    () async {
                                                                  bool value2 =
                                                                      false;
                                                                  await dataSelectConfirmMessage(
                                                                    context:
                                                                        context,
                                                                    titleText:
                                                                        'Confirm!',
                                                                    contentText:
                                                                        "By placing the order, I agree to the terms and condition given by Gemstory.",
                                                                    gif:
                                                                        'assets/images/cartGIF1.gif',
                                                                  ).then(
                                                                      (value) async {
                                                                    if (value) {
                                                                      value2 =
                                                                          value;
                                                                    }
                                                                  });
                                                                  if (value2) {
                                                                    try {
                                                                      await Provider.of<Orders>(
                                                                              context,
                                                                              listen:
                                                                                  false)
                                                                          .placeOrder(
                                                                              context: context);
                                                                      dataSelect(
                                                                          context: scaffoldKey
                                                                              .currentContext,
                                                                          titleText:
                                                                              'Order Placed Succesfully!',
                                                                          buttonText:
                                                                              'Okay',
                                                                          contentText:
                                                                              "Your order has been placed successfully.",
                                                                          onPressed:
                                                                              () {
                                                                            Navigator.of(scaffoldKey.currentContext).pop();
                                                                          },
                                                                          gif:
                                                                              "assets/images/success.gif");
                                                                    } catch (err) {
                                                                      dataSelect(
                                                                          context:
                                                                              context,
                                                                          titleText:
                                                                              'Alert!',
                                                                          buttonText:
                                                                              'Okay',
                                                                          contentText: err
                                                                              .toString(),
                                                                          onPressed:
                                                                              () {
                                                                            Navigator.pop(context);
                                                                          },
                                                                          gif:
                                                                              "assets/images/alert.gif");
                                                                    }
                                                                  }
                                                                },
                                                                child: Center(
                                                                  child: isCheckoutLoading
                                                                      ? CircularProgressIndicator()
                                                                      : Text(
                                                                          'Checkout ${Provider.of<Cart>(context, listen: false).checkoutPrice(context: context)} ₹',
                                                                          style:
                                                                              TextStyle(
                                                                            fontFamily:
                                                                                'Gilroy Bold',
                                                                            color:
                                                                                Colors.white,
                                                                            fontSize:
                                                                                ScreenUtil().setSp(18, allowFontScalingSelf: true),
                                                                            fontWeight:
                                                                                FontWeight.w500,
                                                                          ),
                                                                        ),
                                                                ),
                                                              ),
                                                            ),
                                                            decoration:
                                                                BoxDecoration(
                                                                    image:
                                                                        DecorationImage(
                                                              image: AssetImage(
                                                                  'assets/images/vector17.png'),
                                                              fit: BoxFit
                                                                  .contain,
                                                            )),
                                                          ),
                                                          SizedBox(
                                                            height: ScreenUtil()
                                                                .setHeight(5),
                                                          ),
                                                          Container(
                                                            width: ScreenUtil()
                                                                .setWidth(239),
                                                            height: ScreenUtil()
                                                                .setHeight(30),
                                                            child: RichText(
                                                              text: TextSpan(
                                                                style:
                                                                    TextStyle(
                                                                  fontFamily:
                                                                      'Gilroy Medium',
                                                                  fontSize: ScreenUtil().setSp(
                                                                      12,
                                                                      allowFontScalingSelf:
                                                                          true),
                                                                  color: Color(
                                                                      0xFF8C8888),
                                                                ),
                                                                children: [
                                                                  TextSpan(
                                                                    text:
                                                                        'By placing the order, I agree to the ',
                                                                  ),
                                                                  TextSpan(
                                                                    text:
                                                                        'terms & condition',
                                                                    recognizer:
                                                                        TapGestureRecognizer()
                                                                          ..onTap =
                                                                              () async {
                                                                            await dataSelectConfirmMessageTNC(
                                                                              context: scaffoldKey.currentContext,
                                                                              titleText: 'TERMS AND CONDITIONS!',
                                                                              contentText: "1) Order once placed cannot be edited or changed.\n\n2) Gold prices are just to give you an approximte value of the product at the time of ordering. Final pricing for gold would be decided as per the current market prices, prevailing at the time of delivery.\n\n3) Payment schedule is 7 days from the date of delivery.\n\n4) Delivery of the order would be approx 20 days after placing the order and receiving confirmation from Team Gemstory.\n\n5) Orders can be tracked through their respective order numbers.\n\n6) Diamond rates applicable are inbuilt in system. You can check them at My-Prices page. Kindly go through before placing the final order.\n\n7) Rates calculation are as per delivery in Mumbai only. Interstate or intrastate delivery charges would be added to your bill.",
                                                                              // gif:
                                                                              //     'assets/images/notification1.gif',
                                                                            );
                                                                          },
                                                                    style:
                                                                        TextStyle(
                                                                      decoration:
                                                                          TextDecoration
                                                                              .underline,
                                                                    ),
                                                                  ),
                                                                  TextSpan(
                                                                    text:
                                                                        ' given by Gemstory.',
                                                                  ),
                                                                ],
                                                              ),
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                            ),
                                                          )
                                                        ],
                                                      )
                                                    : SizedBox(
                                                        height: 0,
                                                      ),
                                                index ==
                                                            Provider.of<Cart>(
                                                                        context,
                                                                        listen:
                                                                            false)
                                                                    .cart
                                                                    .length -
                                                                1 &&
                                                        Provider.of<Pagination>(
                                                                context,
                                                                listen: false)
                                                            .isPriced
                                                    ? SizedBox(
                                                        height: ScreenUtil()
                                                            .setHeight(93),
                                                      )
                                                    : SizedBox(
                                                        height: 0,
                                                      ),
                                                index ==
                                                            Provider.of<Cart>(
                                                                        context,
                                                                        listen:
                                                                            false)
                                                                    .cart
                                                                    .length -
                                                                1 &&
                                                        Provider.of<Pagination>(
                                                                    context,
                                                                    listen:
                                                                        false)
                                                                .isPriced ==
                                                            false
                                                    ? GestureDetector(
                                                        onTap: () {},
                                                        child: Container(
                                                          width: ScreenUtil()
                                                              .setWidth(250),
                                                          height: ScreenUtil()
                                                              .setWidth(43),
                                                          // padding: EdgeInsets.all(20.0),
                                                          child: Center(
                                                            child: Text(
                                                              'Prices Not Set',
                                                              style: TextStyle(
                                                                fontFamily:
                                                                    'Gilroy Bold',
                                                                color: Colors
                                                                    .white,
                                                                fontSize: ScreenUtil()
                                                                    .setSp(18,
                                                                        allowFontScalingSelf:
                                                                            true),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                              ),
                                                            ),
                                                          ),
                                                          decoration:
                                                              BoxDecoration(
                                                                  image:
                                                                      DecorationImage(
                                                            image: AssetImage(
                                                                'assets/images/vector17.png'),
                                                            fit: BoxFit.contain,
                                                          )),
                                                        ),
                                                      )
                                                    : SizedBox(
                                                        height: 0,
                                                      ),
                                                index ==
                                                            Provider.of<Cart>(
                                                                        context,
                                                                        listen:
                                                                            false)
                                                                    .cart
                                                                    .length -
                                                                1 &&
                                                        Provider.of<Pagination>(
                                                                    context,
                                                                    listen:
                                                                        false)
                                                                .isPriced ==
                                                            false
                                                    ? SizedBox(
                                                        height: ScreenUtil()
                                                            .setHeight(93),
                                                      )
                                                    : SizedBox(
                                                        height: 0,
                                                      ),
                                              ],
                                            );
                                          },
                                        )
                                  : Container(
                                      width: ScreenUtil().setHeight(350),
                                      child: Center(
                                        child: Text(
                                          "🛒 ➡ 🤷‍♂️ 'This means cart is empty!'",
                                          style: TextStyle(
                                            fontFamily: 'Gilory Regular',
                                            // decoration: TextDecoration.underline,
                                            color: Color(0xFFA49797),
                                            fontSize: ScreenUtil().setSp(17,
                                                allowFontScalingSelf: true),
                                            // fontWeight: FontWeight.bold,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
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
                                          duration: Duration(milliseconds: 600),
                                          margin: EdgeInsets.only(right: 6.0),
                                          height: ScreenUtil().setHeight(
                                              searchSelected ? 0 : 25),
                                          width: ScreenUtil().setWidth(
                                              searchSelected ? 0 : 25),
                                          child: Provider.of<Notif>(context,
                                                          listen: true)
                                                      .notifications
                                                      .length >
                                                  0
                                              ? Image.asset(
                                                  'assets/images/notificationPulse.png',
                                                )
                                              : SvgPicture.asset(
                                                  'assets/icons/notificationIcon.svg',
                                                  color: Colors.black,
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
                                                            image:
                                                                AdvancedNetworkImage(
                                                              suggestion[index]
                                                                  .image,
                                                              useDiskCache:
                                                                  true,
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
                  tapNotication
                      ? Container(
                          height: ScreenUtil().setHeight(775),
                          width: ScreenUtil().setWidth(370),
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
                                      child: Provider.of<Notif>(context,
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
                                                  begin: Alignment.topLeft,
                                                  end: Alignment.bottomRight,
                                                ).createShader(Rect.fromLTWH(
                                                        0,
                                                        0,
                                                        bounds.width,
                                                        bounds.height)),
                                                child: Text(
                                                  'No new notifications!',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily: 'Gilroy Medium',
                                                    fontSize: ScreenUtil().setSp(
                                                        20,
                                                        allowFontScalingSelf:
                                                            true),
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                            )
                                          : ListView.builder(
                                              physics: BouncingScrollPhysics(),
                                              itemCount: Provider.of<Notif>(
                                                      context,
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
                                                    direction: DismissDirection
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
                                                            Icon(Icons.delete,
                                                                color: Colors
                                                                    .white),
                                                            SizedBox(
                                                              width:
                                                                  ScreenUtil()
                                                                      .setWidth(
                                                                          5),
                                                            ),
                                                            Text(
                                                              'Delete Notification',
                                                              style: TextStyle(
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
                                                      await Provider.of<Notif>(
                                                              context,
                                                              listen: false)
                                                          .deleteNotification(
                                                              context: context,
                                                              id: Provider.of<
                                                                          Notif>(
                                                                      context,
                                                                      listen:
                                                                          false)
                                                                  .notifications[
                                                                      index]
                                                                  .id);
                                                    },
                                                    child: GestureDetector(
                                                      onTap: () async {
                                                        await Provider.of<
                                                                    Notif>(
                                                                context,
                                                                listen: false)
                                                            .readNNotification(
                                                                context:
                                                                    context,
                                                                id: Provider.of<
                                                                            Notif>(
                                                                        context,
                                                                        listen:
                                                                            false)
                                                                    .notifications[
                                                                        index]
                                                                    .id);
                                                        print(
                                                            Provider.of<Notif>(
                                                                    context,
                                                                    listen:
                                                                        false)
                                                                .notifications[
                                                                    index]
                                                                .read);
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
                                                              MainAxisAlignment
                                                                  .start,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: <Widget>[
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
                                                                height:
                                                                    ScreenUtil()
                                                                        .setHeight(
                                                                            39),
                                                                width:
                                                                    ScreenUtil()
                                                                        .setWidth(
                                                                            32),
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width:
                                                                  ScreenUtil()
                                                                      .setWidth(
                                                                          23),
                                                            ),
                                                            Container(
                                                              width:
                                                                  ScreenUtil()
                                                                      .setWidth(
                                                                          204),
                                                              child: Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: <
                                                                    Widget>[
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
                                                                        fontWeight: Provider.of<Notif>(context, listen: true).notifications[index].read
                                                                            ? FontWeight.normal
                                                                            : FontWeight.bold),
                                                                  ),
                                                                  SizedBox(
                                                                    height: ScreenUtil()
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
                                                                    style:
                                                                        TextStyle(
                                                                      fontFamily:
                                                                          "Gilroy Light",
                                                                      fontSize: ScreenUtil().setSp(
                                                                          12,
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
                                  top: ScreenUtil().setHeight(20 + 22 + 10),
                                  left: ScreenUtil().setWidth(348),
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        tapNotication = false;
                                      });
                                    },
                                    child: Icon(Icons.clear,
                                        size: ScreenUtil().setSp(30,
                                            allowFontScalingSelf: true)),
                                    // child: SvgPicture.asset(
                                    //   'assets/icons/notificationIcon.svg',
                                    //   height: ScreenUtil().setHeight(25),
                                    //   width: ScreenUtil().setWidth(25),
                                    //   color: Colors.black,
                                    // ),
                                  ),
                                ),
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
    );
  }
}
