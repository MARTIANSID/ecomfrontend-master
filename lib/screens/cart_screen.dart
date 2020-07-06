// import 'package:Flutter/providers/cart.dart';
// import 'package:Flutter/widgets/add_to_cart.dart';
// import 'package:flutter_advanced_networkimage/provider.dart';
// import 'package:provider/provider.dart';
// import 'package:flutter/material.dart';
// import '../constant/const.dart';
// import '../providers/cart.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// class CartScreen extends StatefulWidget {
//   @override
//   _CartScreenState createState() => _CartScreenState();
// }

// class _CartScreenState extends State<CartScreen> {
//   int valueOfQuantity = 0;

//   showPicker(String itemName, String price, String imgPath, int i,
//       BuildContext context) {
//     showModalBottomSheet(
//       context: context,
//       backgroundColor: Colors.white,
//       barrierColor: Colors.black26,
//       isScrollControlled: true,
//       isDismissible: true,
//       shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.only(
//         topLeft: Radius.circular(50.0),
//         topRight: Radius.circular(50.0),
//       )),
//       builder: (BuildContext context) {
//         return Container(
//           padding: EdgeInsets.all(5.0),
//           child: AddToCart(
//             itemName: itemName,
//             imgPath: imgPath,
//             i: i,
//             price: price,
//             updateCart: true,
//             // products: widget.products,
//           ),
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     // return ListView.builder(itemCount:Provider.of<Cart>(context,listen:true).cart.length,itemBuilder: (context,i){
//     //  final product= Provider.of<Cart>(context,listen:true).cart[i];
//     //   return itemCard(product.styleNumber,'30',product.main,true,i,context);

//     // });
//     ScreenUtil.init(
//       context,
//       width: 411.42857142857144,
//       height: 774.8571428571429,
//       allowFontScaling: true,
//     );
//     var size = MediaQuery.of(context).size;
//     return Scaffold(
//       body: Container(
//         child: Stack(
//           children: <Widget>[
//             Container(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: <Widget>[
//                   Center(
//                     child: SizedBox(
//                       height: ScreenUtil().setHeight(38.75),
//                     ),
//                   ),
//                   Container(
//                     height: ScreenUtil().setHeight(77.5),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       children: <Widget>[
//                         Padding(
//                           padding: const EdgeInsets.only(left: 10.0),
//                           child: Text(
//                             'Cart',
//                             style: TextStyle(
//                               fontFamily: 'Gilroy Black',
//                               fontSize: ScreenUtil()
//                                   .setSp(35, allowFontScalingSelf: true),
//                             ),
//                           ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.only(left: 10.0),
//                           child: Text(
//                             '${Provider.of<Cart>(context, listen: true).cart.length} products',
//                             style: TextStyle(
//                               fontFamily: 'Gilroy Black',
//                               fontSize: ScreenUtil()
//                                   .setSp(16, allowFontScalingSelf: true),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   SizedBox(
//                     height: ScreenUtil().setHeight(15.5),
//                   ),
//                   Stack(
//                     children: <Widget>[
//                       Container(
//                         width: size.width,
//                         height: ScreenUtil().setHeight(584),
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.only(
//                             topRight: Radius.circular(100.0),
//                           ),
//                           color: kPrimaryLightColor,
//                         ),
//                       ),
//                       Container(
//                         width: size.width,
//                         height: ScreenUtil().setHeight(484),
//                         padding: EdgeInsets.fromLTRB(10.0, 25.0, 30.0, 10.0),
//                         decoration: BoxDecoration(
//                           color: Color(0xFFE9FFFF),
//                           gradient: LinearGradient(
//                             colors: <Color>[
//                               // Color(0xFF0F2985),
//                               // Colors.blue[400]
//                               kPrimaryLightColor,
//                               Colors.white
//                             ],
//                             stops: [0.1, 0.9],
//                             begin: Alignment.topCenter,
//                             end: Alignment.bottomCenter,
//                           ),
//                           borderRadius: BorderRadius.only(
//                             topRight: Radius.circular(100.0),
//                           ),
//                         ),
//                         child: Provider.of<Cart>(context, listen: true)
//                                     .cart
//                                     .length >
//                                 0
//                             ? ListView.separated(
//                                 physics: BouncingScrollPhysics(),
//                                 shrinkWrap: true,
//                                 scrollDirection: Axis.vertical,
//                                 separatorBuilder: (context, i) {
//                                   return Padding(
//                                     padding: const EdgeInsets.only(
//                                         left: 8.0, right: 8.0),
//                                     child: Divider(
//                                       color: Colors.grey[400],
//                                     ),
//                                   );
//                                 },
//                                 itemCount:
//                                     Provider.of<Cart>(context, listen: true)
//                                         .cart
//                                         .length,
//                                 itemBuilder: (context, i) {
//                                   final product =
//                                       Provider.of<Cart>(context, listen: true)
//                                           .cart[i].product;
//                                   return itemCard(product.styleNumber, '30',
//                                       product.yellow, true, i, context);
//                                 },
//                               )
//                             : Center(
//                                 child: Text(
//                                   "Unfortunately, I'm empty you can fill me up!",
//                                   style: TextStyle(
//                                       fontFamily: 'Gilory',
//                                       color: Colors.black,
//                                       fontSize: ScreenUtil().setSp(12,
//                                           allowFontScalingSelf: true),
//                                       fontWeight: FontWeight.bold),
//                                   textAlign: TextAlign.center,
//                                 ),
//                               ),
//                       ),
//                     ],
//                   )
//                 ],
//               ),
//             ),
//             Positioned(
//               left: ScreenUtil().setWidth(-35),
//               top: ScreenUtil().setHeight(-20),
//               child: Container(
//                 width: ScreenUtil().setWidth(217),
//                 height: ScreenUtil().setHeight(217),
//                 child: Image.network(
//                   'https://api.nakoda.daxy.in/images/products/nosepin6.webp',
//                   fit: BoxFit.contain,
//                 ),
//               ),
//             ),
//             Positioned(
//               left: 0.0,
//               bottom: 0.0,
//               child: Container(
//                 color: Colors.white,
//                 width: size.width,
//                 margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
//                 padding: EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 0.0),
//                 height: ScreenUtil().setHeight(165),
//                 // color: Colors.amberAccent,
//                 child: Column(
//                   children: <Widget>[
//                     Align(
//                       alignment: Alignment.centerRight,
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.end,
//                         children: <Widget>[
//                           Text(
//                             'Subtotal (${Provider.of<Cart>(context, listen: true).cart.length} items)',
//                             style: TextStyle(
//                                 fontFamily: 'Gilroy',
//                                 fontSize: ScreenUtil().setSp(15,allowFontScalingSelf: true),
//                                 color: Colors.black,
//                                 fontWeight: FontWeight.bold),
//                           ),
//                           SizedBox(width: ScreenUtil().setWidth(40),),
//                           Text(
//                             '₹500',
//                             style: TextStyle(
//                                 fontFamily: 'Gilroy',
//                                 fontSize: ScreenUtil().setSp(30,allowFontScalingSelf: true),
//                                 color: Colors.black,
//                                 fontWeight: FontWeight.bold),
//                           )
//                         ],
//                       ),
//                     ),
//                     SizedBox(
//                       height: ScreenUtil().setHeight(20),
//                     ),
//                     Container(
//                       decoration: BoxDecoration(
//                           color: kPrimaryColor,
//                           borderRadius: BorderRadius.circular(10.0)),
//                       child: Center(
//                         child: ListTile(
//                           // leading: ,
//                           title: Text(
//                             'Place order',
//                             style: TextStyle(
//                                 fontFamily: 'GIlroy',
//                                 fontSize: ScreenUtil().setSp(18,allowFontScalingSelf: true),
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.white),
//                           ),
//                           trailing: Container(
//                             padding: EdgeInsets.all(6.0),
//                             decoration: BoxDecoration(
//                               shape: BoxShape.circle,
//                               color: Colors.white,
//                             ),
//                             child: GestureDetector(
//                               onTap: () {},
//                               child: Icon(
//                                 Icons.arrow_forward_ios,
//                                 color: kPrimaryColor,
//                                 size: ScreenUtil().setSp(26,allowFontScalingSelf: true),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget itemCard(itemName, price, imgPath, available, i, context) {
//     var size = MediaQuery.of(context).size;
//     return Container(
//       // width: size.width*0.5,
//       height: ScreenUtil().setHeight(210),
//       // color: Colors.amber,
//       // padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
//       // margin: EdgeInsets.only(top: 15.0),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: <Widget>[
//           Container(
//             height: ScreenUtil().setHeight(141),
//             width: ScreenUtil().setWidth(123.3),
//             // color: Colors.amber,
//             // decoration: BoxDecoration(
//             //     borderRadius: BorderRadius.circular(20.0),
//             //     color: Colors.white),
//             child: Image.network(
//               imgPath,
//               fit: BoxFit.fill,
//             ),
//           ),
//           Container(
//             height: ScreenUtil().setHeight(210),
//             // color: Colors.amber,
//             width: ScreenUtil().setWidth(240),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.start,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: <Widget>[
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: <Widget>[
//                     Text(
//                       itemName,
//                       style: TextStyle(
//                         fontFamily: 'Gilroy Black',
//                         fontWeight: FontWeight.bold,
//                         fontSize:
//                             ScreenUtil().setSp(20, allowFontScalingSelf: true),
//                       ),
//                     ),
//                     // SizedBox(
//                     //   width: 20.0,
//                     // ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: <Widget>[
//                         Container(
//                           height: ScreenUtil().setHeight(37),
//                           width: ScreenUtil().setWidth(37),
//                           decoration: BoxDecoration(
//                             border: Border.all(
//                               color: kPrimaryColor,
//                               width: 2.0,
//                             ),
//                             shape: BoxShape.circle,
//                             // color: Colors.white,
//                           ),
//                           child: GestureDetector(
//                             child: Center(
//                               child: Text(
//                                 '-',
//                                 style: TextStyle(
//                                   fontSize: ScreenUtil()
//                                       .setSp(25, allowFontScalingSelf: true),
//                                   color: kPrimaryColor,
//                                   fontFamily: 'Gilroy',
//                                 ),
//                               ),
//                             ),
//                             onTap: () {
//                               if (valueOfQuantity > 0) {
//                                 setState(() {
//                                   valueOfQuantity = valueOfQuantity - 1;
//                                 });
//                               }
//                             },
//                           ),
//                         ),
//                         Container(
//                           height: ScreenUtil().setHeight(31),
//                           width: ScreenUtil().setWidth(31),
//                           // decoration: BoxDecoration(
//                           //     // shape: BoxShape.circle,
//                           //     borderRadius:BorderRadius.circular(6.0),
//                           //     color: Colors.white),
//                           child: Center(
//                             child: Text(
//                               '$valueOfQuantity',
//                               style: TextStyle(
//                                 fontSize: ScreenUtil()
//                                     .setSp(28, allowFontScalingSelf: true),
//                                 color: Colors.black,
//                                 fontFamily: 'Gilroy',
//                               ),
//                             ),
//                           ),
//                         ),
//                         Container(
//                           height: ScreenUtil().setHeight(37),
//                           width: ScreenUtil().setWidth(37),
//                           decoration: BoxDecoration(
//                             border: Border.all(
//                               color: kPrimaryColor,
//                               width: 2.0,
//                             ),
//                             shape: BoxShape.circle,
//                             // color: Colors.white,
//                           ),
//                           child: Center(
//                             child: GestureDetector(
//                               child: Text(
//                                 '+',
//                                 style: TextStyle(
//                                   fontSize: ScreenUtil()
//                                       .setSp(25, allowFontScalingSelf: true),
//                                   color: kPrimaryColor,
//                                   fontFamily: 'Gilroy',
//                                 ),
//                               ),
//                               onTap: () {
//                                 setState(() {
//                                   valueOfQuantity = valueOfQuantity + 1;
//                                 });
//                               },
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//                 SizedBox(
//                   height: ScreenUtil().setHeight(10),
//                 ),
//                 Column(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: <Widget>[
//                     GestureDetector(
//                       onTap: () {
//                         showPicker(itemName, price, imgPath, i, context);
//                       },
//                       child: Wrap(
//                         direction: Axis.horizontal,
//                         // mainAxisAlignment: MainAxisAlignment.start,
//                         spacing: 4.0,
//                         runSpacing: 10.0,
//                         children: <Widget>[
//                           Container(
//                             // margin: EdgeInsets.only(right: 5.0),
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(18.0),
//                               color: Colors.white,
//                             ),
//                             padding: EdgeInsets.all(10.0),
//                             child: Text(
//                               'Diamond Quality: 6',
//                               style: TextStyle(
//                                 fontFamily: 'Gilroy',
//                                 fontSize: ScreenUtil().setSp(12,allowFontScalingSelf: true),
//                               ),
//                             ),
//                           ),
//                           Container(
//                             // margin: EdgeInsets.only(right: 10.0),
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(18.0),
//                               color: Colors.white,
//                             ),
//                             padding: EdgeInsets.all(10.0),
//                             child: Text(
//                               'Colour: 9',
//                               style: TextStyle(
//                                 fontFamily: 'Gilroy',
//                                 fontSize: ScreenUtil().setSp(12,allowFontScalingSelf: true),
//                               ),
//                             ),
//                           ),
//                           Container(
//                             // margin: EdgeInsets.only(right: 10.0),
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(18.0),
//                               color: Colors.white,
//                             ),
//                             padding: EdgeInsets.all(10.0),
//                             child: Text(
//                               'Certification: 16',
//                               style: TextStyle(
//                                 fontFamily: 'Gilroy',
//                                 fontSize: ScreenUtil().setSp(12,allowFontScalingSelf: true),
//                               ),
//                             ),
//                           ),
//                           Container(
//                             // margin: EdgeInsets.only(right: 10.0),
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(18.0),
//                               color: Colors.white,
//                             ),
//                             padding: EdgeInsets.all(10.0),
//                             child: Text(
//                               'Build: Taar',
//                               style: TextStyle(
//                                 fontFamily: 'Gilroy',
//                                 fontSize: ScreenUtil().setSp(12,allowFontScalingSelf: true),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     SizedBox(
//                       height: ScreenUtil().setHeight(20),
//                     ),
//                     Text(
//                       '5000000 ₹',
//                       style: TextStyle(
//                         fontFamily: 'Gilroy Black',
//                         color: Colors.black,
//                         fontSize:
//                             ScreenUtil().setSp(25, allowFontScalingSelf: true),
//                       ),
//                     )
//                   ],
//                 )
//               ],
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }

import 'dart:async';
import 'dart:ui';
import 'package:Flutter/providers/order.dart';
import 'package:Flutter/providers/cart.dart';
import 'package:Flutter/providers/options.dart';
import 'package:Flutter/providers/order.dart';
import 'package:Flutter/providers/pagination.dart';
import 'package:Flutter/providers/search.dart';
import 'package:Flutter/screens/product_detail.dart';
import 'package:Flutter/widgets/add_to_cart.dart';
import 'package:Flutter/widgets/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_networkimage/provider.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

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

  TextEditingController textEditingController = TextEditingController();

  bool searchSelectedDoneButton = false;

  bool isCartLoading = false;

  bool value2 = false;

  bool isListLoading = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      setState(() {
        isCartLoading = true;
      });
      try {
        if (Provider.of<Cart>(context, listen: false).cart.isEmpty)
          await Provider.of<Cart>(context, listen: false)
              .getCart(context: context);
      } catch (err) {
        dataSelect(context, '$err', '', 'OK', () {
          Navigator.pop(context);
        });
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
      print(value);
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
          print('DC SEARCH');
        });
      });
    } catch (err) {
      dataSelect(context, '$err', '', 'OK', () {
        Navigator.pop(context);
      });
    } finally {
      setState(() {
        isLoadingSearch = false;
      });
    }

    print(suggestion);
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
    print('Search Selected' + searchSelected.toString());
    return Scaffold(
      key: scaffoldKey,
      resizeToAvoidBottomInset: false,
      resizeToAvoidBottomPadding: false,
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
                          height: ScreenUtil().setHeight(22 + 11 + 20 + 40),
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
                                                      context,
                                                      'Alert!',
                                                      "Are you sure, You want to remove the item form the cart?",
                                                      'Request Prices',
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
                                                      dataSelect(context,
                                                          '$err', '', 'OK', () {
                                                        Navigator.pop(context);
                                                      });
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
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      showDialog(
                                                        context: context,
                                                        child: AddToCart(
                                                          product: product,
                                                          productIndexInCart:
                                                              index,
                                                          updateCart: true,
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
                                                              Provider.of<Cart>(
                                                                      context,
                                                                      listen:
                                                                          false)
                                                                  .cart[index]
                                                                  .buildValue,
                                                          defValue1:
                                                              Provider.of<Cart>(
                                                                      context,
                                                                      listen:
                                                                          false)
                                                                  .cart[index]
                                                                  .colorValue,
                                                          defValue2:
                                                              Provider.of<Cart>(
                                                                      context,
                                                                      listen:
                                                                          false)
                                                                  .cart[index]
                                                                  .certValue,
                                                          defValue3:
                                                              Provider.of<Cart>(
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
                                                      height: ScreenUtil()
                                                          .setHeight(94),
                                                      width: ScreenUtil()
                                                          .setWidth(390),
                                                      margin:
                                                          EdgeInsets.fromLTRB(
                                                              11.0,
                                                              0.0,
                                                              10.0,
                                                              5.0),
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
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
                                                            image:
                                                                AdvancedNetworkImage(
                                                              product.imageUrl[
                                                                  'yellow'],
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
                                                          SizedBox(
                                                            width: ScreenUtil()
                                                                .setWidth(2),
                                                          ),
                                                          Container(
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
                                                              children: <
                                                                  Widget>[
                                                                GestureDetector(
                                                                  onTap:
                                                                      () async {
                                                                    if (Provider.of<Cart>(context,
                                                                                listen: false)
                                                                            .cart[index]
                                                                            .quantity >=
                                                                        1) {
                                                                      try {
                                                                        if (Provider.of<Cart>(context, listen: false).cart[index].quantity >
                                                                            0) {
                                                                          await Provider.of<Cart>(context, listen: false).decQuantity(
                                                                              context: context,
                                                                              product: product,
                                                                              update: true,
                                                                              build: Provider.of<Pagination>(context, listen: false).build[Provider.of<Cart>(context, listen: false).cart[index].buildValue],
                                                                              color: Provider.of<Pagination>(context, listen: false).color[Provider.of<Cart>(context, listen: false).cart[index].colorValue],
                                                                              cert: Provider.of<Pagination>(context, listen: false).cert[Provider.of<Cart>(context, listen: false).cart[index].certValue],
                                                                              diamond: Provider.of<Pagination>(context, listen: false).diamondQuality[Provider.of<Cart>(context, listen: false).cart[index].diamondValue],
                                                                              buildValue: Provider.of<Cart>(context, listen: false).cart[index].buildValue,
                                                                              colorValue: Provider.of<Cart>(context, listen: false).cart[index].colorValue,
                                                                              certvalue: Provider.of<Cart>(context, listen: false).cart[index].certValue,
                                                                              diamondValue: Provider.of<Cart>(context, listen: false).cart[index].diamondValue,
                                                                              index: index);
                                                                        } else {
                                                                          try {
                                                                            await Provider.of<Cart>(context, listen: false).deleteCart(
                                                                                id: Provider.of<Cart>(context, listen: false).cart[index].id,
                                                                                context: context);

                                                                            setState(() {});
                                                                          } catch (err) {
                                                                            dataSelect(
                                                                                context,
                                                                                'Alert!',
                                                                                '$err',
                                                                                'OK',
                                                                                () {
                                                                              Navigator.pop(context);
                                                                            });
                                                                          }
                                                                        }
                                                                      } catch (err) {
                                                                        dataSelect(
                                                                            context,
                                                                            'Alert!',
                                                                            '$err',
                                                                            'OK',
                                                                            () {
                                                                          Navigator.pop(
                                                                              context);
                                                                        });
                                                                      }
                                                                    }
                                                                  },
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
                                                                SizedBox(
                                                                  width: ScreenUtil()
                                                                      .setWidth(
                                                                          5),
                                                                ),
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
                                                                SizedBox(
                                                                  width: ScreenUtil()
                                                                      .setWidth(
                                                                          5),
                                                                ),
                                                                GestureDetector(
                                                                  onTap:
                                                                      () async {
                                                                    try {
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
                                                                          color: Provider.of<Pagination>(context, listen: false).color[Provider.of<Cart>(context, listen: false)
                                                                              .cart[
                                                                                  index]
                                                                              .colorValue],
                                                                          cert: Provider.of<Pagination>(context, listen: false).cert[Provider.of<Cart>(context, listen: false)
                                                                              .cart[index]
                                                                              .certValue],
                                                                          diamond: Provider.of<Pagination>(context, listen: false).diamondQuality[Provider.of<Cart>(context, listen: false).cart[index].diamondValue],
                                                                          buildValue: Provider.of<Cart>(context, listen: false).cart[index].buildValue,
                                                                          colorValue: Provider.of<Cart>(context, listen: false).cart[index].colorValue,
                                                                          certvalue: Provider.of<Cart>(context, listen: false).cart[index].certValue,
                                                                          diamondValue: Provider.of<Cart>(context, listen: false).cart[index].diamondValue,
                                                                          index: index);
                                                                    } catch (err) {
                                                                      dataSelect(
                                                                          context,
                                                                          'Alert!',
                                                                          '$err',
                                                                          'OK',
                                                                          () {
                                                                        Navigator.pop(
                                                                            context);
                                                                      });
                                                                    }
                                                                  },
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
                                                    ? GestureDetector(
                                                        onTap: () {
                                                          Provider.of<Orders>(
                                                                  context,
                                                                  listen: false)
                                                              .placeOrder(
                                                                  context:
                                                                      context);
                                                        },
                                                        child: Container(
                                                          width: ScreenUtil()
                                                              .setWidth(250),
                                                          height: ScreenUtil()
                                                              .setWidth(43),
                                                          // padding: EdgeInsets.all(20.0),
                                                          child: Center(
                                                            child: Text(
                                                              'Checkout ${Provider.of<Cart>(context, listen: false).totalPrice} ₹',
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
                                24, 11, 0, searchSelected ? 0 : 20),
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
                                      AnimatedContainer(
                                        duration: Duration(milliseconds: 600),
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
                                            try {
                                              await getSearch(
                                                  searchValue.toUpperCase());
                                            } catch (err) {
                                              dataSelect(
                                                  context, '$err', '', 'OK',
                                                  () {
                                                Navigator.pop(context);
                                              });
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
                                                  allowFontScalingSelf: true)),
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
                                                print(info);
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
                                                            certPrice: Provider
                                                                    .of<Pagination>(
                                                                        context,
                                                                        listen:
                                                                            false)
                                                                .certPrices[Provider.of<
                                                                        Pagination>(
                                                                    context,
                                                                    listen:
                                                                        false)
                                                                .cert[_defaultChoiceIndex3]],
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
                                                      dataSelect(context,
                                                          '$err', '', 'OK', () {
                                                        Navigator.pop(context);
                                                      });
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
                                                            image: NetworkImage(
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
                  ),
                ],
              ),
            ),
    );
  }
}
