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

import 'package:Flutter/providers/cart.dart';
import 'package:Flutter/providers/pagination.dart';
import 'package:Flutter/providers/search.dart';
import 'package:Flutter/widgets/add_to_cart.dart';
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

  // int _defaultChoiceIndex4;

  // int _defaultChoiceIndex3;

  // int _defaultChoiceIndex2;

  // int _defaultChoiceIndex1;
  bool flag;

  bool searchSelected = false;

  String searchValue = "";

  TextEditingController textEditingController = TextEditingController();

  bool searchSelectedDoneButton = false;

  @override
  void initState() {
    super.initState();
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
    // final suggestion = styleNumber
    //     .where(
    //         (element) => element.contains(searchValue.toString().toUpperCase()))
    //     .toList();
    print('Search Selected' + searchSelected.toString());
    return Scaffold(
      body: Container(
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
                            'CART',
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
                  SizedBox(
                    height: ScreenUtil().setHeight(20),
                  ),
                  Expanded(
                    child: Provider.of<Cart>(context, listen: true)
                                .cart
                                .length >
                            0
                        ? ListView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            physics: BouncingScrollPhysics(),
                            itemCount: Provider.of<Cart>(context, listen: true)
                                .cart
                                .length,
                            itemBuilder: (context, index) {
                              final product =
                                  Provider.of<Cart>(context, listen: true)
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
                                  GestureDetector(
                                    onTap: () {
                                      showDialog(
                                        context: context,
                                        child: AddToCart(
                                          product: product,
                                          productIndexInCart: index,
                                          updateCart: true,
                                          choicesBuild: Provider.of<Pagination>(
                                                  context,
                                                  listen: false)
                                              .build,
                                          choiceColor: Provider.of<Pagination>(
                                                  context,
                                                  listen: false)
                                              .color,
                                          choiceCertification:
                                              Provider.of<Pagination>(context,
                                                      listen: false)
                                                  .cert,
                                          choiceDiamondQuality:
                                              Provider.of<Pagination>(context,
                                                      listen: false)
                                                  .diamondQuality,
                                          defValue: Provider.of<Cart>(context,
                                                  listen: false)
                                              .cart[index]
                                              .buildValue,
                                          defValue1: Provider.of<Cart>(context,
                                                  listen: false)
                                              .cart[index]
                                              .colorValue,
                                          defValue2: Provider.of<Cart>(context,
                                                  listen: false)
                                              .cart[index]
                                              .certValue,
                                          defValue3: Provider.of<Cart>(context,
                                                  listen: false)
                                              .cart[index]
                                              .diamondValue,
                                          valueChangeBuild: _onValueChange,
                                          valueChangeColor: _onValueChangeColor,
                                          valueChangeCerti: _onValueChangeCerti,
                                          valueChangeDQ: _onValueChangeDQ,
                                        ),
                                      );
                                    },
                                    child: Container(
                                      height: ScreenUtil().setHeight(94),
                                      width: ScreenUtil().setWidth(411),
                                      margin: EdgeInsets.fromLTRB(
                                          24.0, 0.0, 25.0, 5.0),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.white,
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: <Widget>[
                                          SizedBox(
                                            width: ScreenUtil().setWidth(10),
                                          ),
                                          // Image.asset(
                                          //   'assets/images/nosepin12.png',
                                          //   height: ScreenUtil().setHeight(76),
                                          //   width: ScreenUtil().setWidth(79),
                                          //   fit: BoxFit.fill,
                                          // ),
                                          product.imageUrl.containsKey(
                                                  Provider.of<Cart>(context,
                                                          listen: true)
                                                      .cart[index]
                                                      .color)
                                              ? Image(
                                                  height: ScreenUtil()
                                                      .setHeight(79),
                                                  width:
                                                      ScreenUtil().setWidth(76),
                                                  image: AdvancedNetworkImage(
                                                    product.imageUrl[
                                                        Provider.of<Cart>(
                                                                context,
                                                                listen: true)
                                                            .cart[index]
                                                            .color],
                                                    useDiskCache: true,
                                                    cacheRule: CacheRule(
                                                        maxAge: const Duration(
                                                            days: 3)),
                                                  ),
                                                  fit: BoxFit.fill,
                                                )
                                              : Image(
                                                  height: ScreenUtil()
                                                      .setHeight(79),
                                                  width:
                                                      ScreenUtil().setWidth(76),
                                                  image: AdvancedNetworkImage(
                                                    product.imageUrl['yellow'],
                                                    useDiskCache: true,
                                                    cacheRule: CacheRule(
                                                        maxAge: const Duration(
                                                            days: 3)),
                                                  ),
                                                  fit: BoxFit.fill,
                                                ),
                                          SizedBox(
                                            width: ScreenUtil().setWidth(2),
                                          ),
                                          Container(
                                            width: ScreenUtil().setWidth(185),
                                            height: ScreenUtil().setHeight(76),
                                            // color: Colors.amber,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: <Widget>[
                                                Text(
                                                  '${product.styleNumber}',
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontFamily: 'Gilroy Bold',
                                                    fontSize: ScreenUtil().setSp(
                                                        18,
                                                        allowFontScalingSelf:
                                                            true),
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height:
                                                      ScreenUtil().setHeight(6),
                                                ),
                                                Text(
                                                  '${(Provider.of<Cart>(context, listen: true).cart[index].color).toUpperCase()} ${Provider.of<Cart>(context, listen: true).cart[index].diamond} ${Provider.of<Cart>(context, listen: true).cart[index].cert} ${Provider.of<Cart>(context, listen: true).cart[index].build}',
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontFamily: 'Gilroy Light',
                                                    fontSize: ScreenUtil().setSp(
                                                        12,
                                                        allowFontScalingSelf:
                                                            true),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height:
                                                      ScreenUtil().setHeight(4),
                                                ),
                                                ShaderMask(
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
                                                  child: product.prices
                                                          .containsKey(
                                                              Provider.of<Cart>(
                                                                      context,
                                                                      listen:
                                                                          true)
                                                                  .cart[index]
                                                                  .diamond)
                                                      ? RichText(
                                                          text: TextSpan(
                                                            children: [
                                                              TextSpan(
                                                                text:
                                                                    '${int.parse(product.prices[Provider.of<Cart>(context, listen: true).cart[index].diamond]) + Provider.of<Pagination>(context, listen: true).certPrices[Provider.of<Cart>(context, listen: true).cart[index].cert]}',
                                                                style:
                                                                    TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: ScreenUtil().setSp(
                                                                      18,
                                                                      allowFontScalingSelf:
                                                                          true),
                                                                  fontFamily:
                                                                      'Gilroy Bold',
                                                                ),
                                                              ),
                                                              TextSpan(
                                                                text: ' ₹',
                                                                style:
                                                                    TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: ScreenUtil().setSp(
                                                                      18,
                                                                      allowFontScalingSelf:
                                                                          true),
                                                                  fontFamily:
                                                                      'Roboto Medium',
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
                                                          'no price',
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: ScreenUtil()
                                                                .setSp(18,
                                                                    allowFontScalingSelf:
                                                                        true),
                                                            fontFamily:
                                                                'Gilroy Bold',
                                                          ),
                                                        ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            width: ScreenUtil().setWidth(2),
                                          ),
                                          Container(
                                            width: ScreenUtil().setWidth(77),
                                            height: ScreenUtil().setHeight(38),
                                            padding: EdgeInsets.all(3.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: <Widget>[
                                                GestureDetector(
                                                  onTap: () {
                                                    if (Provider.of<Cart>(
                                                                context,
                                                                listen: false)
                                                            .cart[index]
                                                            .quantity >
                                                        1) {
                                                      setState(() {
                                                        Provider.of<Cart>(
                                                                context,
                                                                listen: false)
                                                            .decQuantity(index);
                                                      });
                                                    }
                                                  },
                                                  child: Container(
                                                    height: ScreenUtil()
                                                        .setHeight(12),
                                                    width: ScreenUtil()
                                                        .setWidth(12),
                                                    child: Center(
                                                      child: Text(
                                                        '-',
                                                        style: TextStyle(
                                                          fontFamily: 'Gilroy',
                                                          color: Colors.black,
                                                          fontSize: ScreenUtil()
                                                              .setSp(22,
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
                                                      ScreenUtil().setWidth(4),
                                                ),
                                                Container(
                                                  height: ScreenUtil()
                                                      .setHeight(19),
                                                  width:
                                                      ScreenUtil().setWidth(24),
                                                  child: Center(
                                                    child: Text(
                                                      '${Provider.of<Cart>(context, listen: true).cart[index].quantity}',
                                                      style: TextStyle(
                                                        fontFamily:
                                                            'Gilroy Black',
                                                        color: Colors.black,
                                                        fontSize: ScreenUtil()
                                                            .setSp(18,
                                                                allowFontScalingSelf:
                                                                    true),
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width:
                                                      ScreenUtil().setWidth(4),
                                                ),
                                                GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      Provider.of<Cart>(context,
                                                              listen: false)
                                                          .incQuantity(index);
                                                    });
                                                  },
                                                  child: Container(
                                                    height: ScreenUtil()
                                                        .setHeight(12),
                                                    width: ScreenUtil()
                                                        .setWidth(12),
                                                    child: Center(
                                                      child: ShaderMask(
                                                        shaderCallback:
                                                            (bounds) =>
                                                                LinearGradient(
                                                          colors: [
                                                            Color(0xFF34B0D9),
                                                            Color(0xFF3685CB),
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
                                                        child: Text(
                                                          '+',
                                                          style: TextStyle(
                                                            fontFamily:
                                                                'Gilroy',
                                                            color: Colors.white,
                                                            fontSize: ScreenUtil()
                                                                .setSp(22,
                                                                    allowFontScalingSelf:
                                                                        true),
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                image: AssetImage(
                                                    'assets/images/cartButtonShape.png'),
                                                fit: BoxFit.contain,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  index == 19
                                      ? SizedBox(
                                          height: ScreenUtil().setHeight(30),
                                        )
                                      : SizedBox(
                                          height: 0,
                                        ),
                                  index == 19
                                      ? GestureDetector(
                                          onTap: () {},
                                          child: Container(
                                            width: ScreenUtil().setWidth(250),
                                            height: ScreenUtil().setWidth(43),
                                            // padding: EdgeInsets.all(20.0),
                                            child: Center(
                                              child: Text(
                                                'Checkout  50000 ₹',
                                                style: TextStyle(
                                                  fontFamily: 'Gilroy Bold',
                                                  color: Colors.white,
                                                  fontSize: ScreenUtil().setSp(
                                                      18,
                                                      allowFontScalingSelf:
                                                          true),
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
                                        )
                                      : SizedBox(
                                          height: 0,
                                        ),
                                  index == 19
                                      ? SizedBox(
                                          height: ScreenUtil().setHeight(93),
                                        )
                                      : SizedBox(
                                          height: 0,
                                        ),
                                ],
                              );
                            },
                          )
                        : Center(
                            child: Text(
                              "Unfortunately, I'm empty you can fill me up!",
                              style: TextStyle(
                                  fontFamily: 'Gilory',
                                  color: Colors.black,
                                  fontSize: ScreenUtil()
                                      .setSp(12, allowFontScalingSelf: true),
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
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
                          24, 11, 25, searchSelected ? 0 : 20),
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
                                                  height: ScreenUtil()
                                                      .setHeight(90),
                                                  width:
                                                      ScreenUtil().setWidth(90),
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
                                                      fontSize: ScreenUtil().setSp(
                                                          21,
                                                          allowFontScalingSelf:
                                                              true),
                                                    ),
                                                    children: [
                                                      TextSpan(
                                                        text: info[0],
                                                        style: TextStyle(
                                                          color: Colors.grey,
                                                          // fontWeight: FontWeight.bold,
                                                          fontFamily: 'Varela',
                                                          fontSize: ScreenUtil()
                                                              .setSp(21,
                                                                  allowFontScalingSelf:
                                                                      true),
                                                        ),
                                                      ),
                                                      TextSpan(
                                                        text: searchValue,
                                                        style: TextStyle(
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontFamily: 'Varela',
                                                          fontSize: ScreenUtil()
                                                              .setSp(21,
                                                                  allowFontScalingSelf:
                                                                      true),
                                                        ),
                                                      ),
                                                      TextSpan(
                                                        text: info[1],
                                                        style: TextStyle(
                                                          color: Colors.grey,
                                                          // fontWeight: FontWeight.bold,
                                                          fontFamily: 'Varela',
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
                                          );
                                        },
                                      )
                                    : Center(
                                        child: Text(
                                          'No Products Found',
                                        ),
                                      ),
                              ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  TextSpan searchMatch(String match) {
    var refinedMatch = match.toLowerCase();
    var refinedSearch = searchValue.toLowerCase();
    if (refinedMatch.contains(refinedSearch)) {
      if (refinedMatch.substring(0, refinedSearch.length) == refinedSearch) {
        return TextSpan(
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontFamily: 'Varela',
            fontSize: 21.0,
          ),
          text: match.substring(0, refinedSearch.length),
          children: [
            searchMatch(
              match.substring(
                refinedSearch.length,
              ),
            ),
          ],
        );
      } else if (refinedMatch.length == refinedSearch.length) {
        return TextSpan(
          text: match,
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontFamily: 'Varela',
            fontSize: 21.0,
          ),
        );
      } else {
        return TextSpan(
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontFamily: 'Varela',
            fontSize: 21.0,
          ),
          text: match.substring(
            0,
            refinedMatch.indexOf(refinedSearch),
          ),
          children: [
            searchMatch(
              match.substring(
                refinedMatch.indexOf(refinedSearch),
              ),
            ),
          ],
        );
      }
    }
    // return TextSpan(
    //   text: match.substring(0, refinedMatch.indexOf(refinedSearch)),
    //   style: negRes,
    //   children: [
    //     searchMatch(match.substring(refinedMatch.indexOf(refinedSearch)))
    //   ],
    // );
  }
}
