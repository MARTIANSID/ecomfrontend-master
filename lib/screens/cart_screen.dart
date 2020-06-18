// import 'package:Flutter/providers/cart.dart';
// import 'package:Flutter/widgets/add_to_cart.dart';
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

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

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

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        width: 411.42857142857144,
        height: 774.8571428571429,
        allowFontScaling: true);
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
                              fontFamily: 'Gilroy',
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
                  Expanded(
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      physics: BouncingScrollPhysics(),
                      itemCount: 20,
                      itemBuilder: (context, index) {
                        return Column(
                          children: <Widget>[
                            Container(
                              height: ScreenUtil().setHeight(94),
                              width: ScreenUtil().setWidth(411),
                              margin: EdgeInsets.fromLTRB(25.0, 0.0, 26.0, 5.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Image.asset(
                                    'assets/images/nosepin12.png',
                                    height: ScreenUtil().setHeight(76),
                                    width: ScreenUtil().setWidth(79),
                                    fit: BoxFit.fill,
                                  ),
                                  Container(
                                    height: ScreenUtil().setHeight(76),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          'GS2102' + '${index + 1}',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: 'Gilroy Bold',
                                            fontSize: ScreenUtil().setSp(18,allowFontScalingSelf: true),
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 6.0, bottom: 4.0),
                                          child: Text(
                                            'YELLOW VVS_VS_IH IGI SCREW',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontFamily: 'Gilroy Light',
                                              fontSize: ScreenUtil().setSp(12,allowFontScalingSelf: true),
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
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
                                            Rect.fromLTWH(0, 0, bounds.width,
                                                bounds.height),
                                          ),
                                          child: Text(
                                            '5000 ₹',
                                            style: TextStyle(
                                              fontFamily: 'Gilroy Bold',
                                              color: Colors.white,
                                              fontSize: ScreenUtil().setSp(18,allowFontScalingSelf: true),
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: ScreenUtil().setWidth(20),
                                  ),
                                  Container(
                                    width: ScreenUtil().setWidth(77),
                                    height: ScreenUtil().setHeight(38),
                                    padding: EdgeInsets.all(3.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        GestureDetector(
                                          onTap: () {
                                            if (valueOf > 0) {
                                              setState(() {
                                                valueOf = valueOf - 1;
                                              });
                                            }
                                          },
                                          child: Text(
                                            '-',
                                            style: TextStyle(
                                              fontFamily: 'Gilroy',
                                              color: Colors.black,
                                              fontSize: ScreenUtil().setSp(22,allowFontScalingSelf: true),
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          height: ScreenUtil().setHeight(19),
                                          width: ScreenUtil().setWidth(11),
                                          child: Text(
                                            '$valueOf',
                                            style: TextStyle(
                                              fontFamily: 'Gilroy Black',
                                              color: Colors.black,
                                              fontSize: ScreenUtil().setSp(18,allowFontScalingSelf: true),
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              valueOf = valueOf + 1;
                                            });
                                          },
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
                                              Rect.fromLTWH(0, 0, bounds.width,
                                                  bounds.height),
                                            ),
                                            child: Text(
                                              '+',
                                              style: TextStyle(
                                                fontFamily: 'Gilroy',
                                                color: Colors.white,
                                                fontSize: ScreenUtil().setSp(22,allowFontScalingSelf: true),
                                                fontWeight: FontWeight.w500,
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
                                            fontSize: ScreenUtil().setSp(18,allowFontScalingSelf: true),
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
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
