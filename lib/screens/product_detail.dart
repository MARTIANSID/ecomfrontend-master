// import 'package:Flutter/constant/const.dart';
// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// class ProductDetail extends StatefulWidget {
//   @override
//   _ProductDetailState createState() => _ProductDetailState();
// }

// class _ProductDetailState extends State<ProductDetail> {
//   int _current = 0;
//   List imgList = [
//     'https://images.unsplash.com/photo-1502117859338-fd9daa518a9a?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=800&q=60',
//     'https://images.unsplash.com/photo-1554321586-92083ba0a115?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=800&q=60',
//     'https://images.unsplash.com/photo-1536679545597-c2e5e1946495?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=800&q=60',
//     'https://images.unsplash.com/photo-1543922596-b3bbaba80649?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=800&q=60',
//     'https://images.unsplash.com/photo-1502943693086-33b5b1cfdf2f?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=668&q=80'
//   ];
//   List<T> map<T>(List list, Function handler) {
//     List<T> result = [];
//     for (var i = 0; i < list.length; i++) {
//       result.add(handler(i, list[i]));
//     }
//     return result;
//   }

//   @override
//   Widget build(BuildContext context) {
//     var size = MediaQuery.of(context).size;
//     ScreenUtil.init(context,
//         width: 411.42857142857144,
//         height: 774.8571428571429,
//         allowFontScaling: true);
//     return Scaffold(
//       body: Container(
//         color: Colors.grey[100],
//         child: Stack(
//           children: <Widget>[
//             Column(
//               children: <Widget>[
//                 Padding(
//                   padding: const EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 10.0),
//                   child: Container(
//                     margin: EdgeInsets.only(
//                         top: MediaQuery.of(context).padding.top),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: <Widget>[
//                         Row(
//                           children: <Widget>[
//                             IconButton(
//                               icon: Icon(Icons.arrow_back_ios),
//                               onPressed: () {
//                                 print(MediaQuery.of(context).padding.top);
//                                 print(size.width);
//                                 print(size.height);
//                                 Navigator.of(context).pop();
//                               },
//                               color: Colors.grey,
//                             ),
//                           ],
//                         ),
//                         IconButton(
//                           icon: Icon(Icons.search),
//                           iconSize: ScreenUtil().setSp(30,allowFontScalingSelf: true),
//                           onPressed: () {},
//                         )
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             Positioned(
//               top: ScreenUtil().setHeight(77.5),
//               left: 0.0,
//               right: 0.0,
//               child: Container(
//                 height: ScreenUtil().setHeight(700),
//                 width: size.width,
//                 // decoration: BoxDecoration(
//                 //   gradient: LinearGradient(
//                 //     colors: <Color>[
//                 //       // Color(0xFF0F2985),
//                 //       // Colors.blue[400]
//                 //       kPrimaryLightColor,
//                 //       Colors.white
//                 //     ],
//                 //     stops: [0.4, 1],
//                 //     begin: Alignment.topRight,
//                 //     end: Alignment.bottomCenter,
//                 //   ),
//                 // ),
//                 // color: Colors.amber,
//                 margin: EdgeInsets.only(top: 25.0),
//                 // padding: EdgeInsets.all(10.0),
//                 child: Column(
//                   children: <Widget>[
//                     Container(
//                       height: ScreenUtil().setHeight(155),
//                       child: CarouselSlider(
//                         height: ScreenUtil().setHeight(155),
//                         initialPage: 0,
//                         enlargeCenterPage: true,
//                         autoPlay: true,
//                         reverse: false,
//                         enableInfiniteScroll: true,
//                         autoPlayInterval: Duration(seconds: 2),
//                         autoPlayAnimationDuration: Duration(milliseconds: 2000),
//                         pauseAutoPlayOnTouch: Duration(seconds: 10),
//                         scrollDirection: Axis.horizontal,
//                         onPageChanged: (index) {
//                           setState(() {
//                             _current = index;
//                           });
//                         },
//                         items: imgList.map((imgUrl) {
//                           return Builder(
//                             builder: (BuildContext context) {
//                               return Container(
//                                 width: ScreenUtil().setWidth(411),
//                                 height: ScreenUtil().setHeight(69.75),
//                                 margin: EdgeInsets.symmetric(horizontal: 5.0),
//                                 decoration: BoxDecoration(
//                                   color: Colors.white,
//                                 ),
//                                 child: Image.network(
//                                   imgUrl,
//                                   fit: BoxFit.fill,
//                                 ),
//                                 // child: PinchZoomImage(
//                                 //   image: Image.network(
//                                 //     imgUrl,
//                                 //     fit: BoxFit.contain,
//                                 //   ),
//                                 //   zoomedBackgroundColor:
//                                 //       Color.fromRGBO(240, 240, 240, 1.0),
//                                 //   hideStatusBarWhileZooming: true,
//                                 //   onZoomStart: () {
//                                 //     print('Zoom started');
//                                 //   },
//                                 //   onZoomEnd: () {
//                                 //     print('Zoom finished');
//                                 //   },
//                                 // ),
//                               );
//                             },
//                           );
//                         }).toList(),
//                       ),
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: map<Widget>(
//                         imgList,
//                         (index, url) {
//                           return Container(
//                             width: ScreenUtil().setWidth(10),
//                             height: ScreenUtil().setHeight(10),
//                             margin: EdgeInsets.symmetric(
//                                 vertical: 5.0, horizontal: 2.0),
//                             decoration: BoxDecoration(
//                               shape: BoxShape.circle,
//                               color: _current == index
//                                   ? Colors.black
//                                   : Colors.grey,
//                             ),
//                           );
//                         },
//                       ),
//                     ),
//                     SizedBox(
//                       height: ScreenUtil().setHeight(10),
//                     ),
//                     Container(
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.only(
//                           topRight: Radius.circular(80.0),
//                           bottomRight: Radius.circular(80.0),
//                           bottomLeft: Radius.circular(80.0),
//                         ),
//                         // border: Border.all(
//                         //   color: kPrimaryColor,
//                         //   width: 2.0,
//                         // ),
//                         color: Colors.white,
//                         // boxShadow: <BoxShadow>[
//                         //   BoxShadow(
//                         //     color: Colors.black12,
//                         //     blurRadius: 10.0,
//                         //     offset: Offset(0.0, 10.0),
//                         //   ),
//                         // ],
//                         // gradient: LinearGradient(
//                         //   colors: <Color>[
//                         //     // Color(0xFF0F2985),
//                         //     // Colors.blue[400]
//                         //     kPrimaryColor,
//                         //     Colors.white
//                         //   ],
//                         //   stops: [0.05, 1],
//                         //   begin: Alignment.topRight,
//                         //   end: Alignment.bottomCenter,
//                         // ),
//                       ),
//                       padding: EdgeInsets.fromLTRB(20.0, 15.0, 70.0, 0.0),
//                       width: ScreenUtil().setWidth(411),
//                       height: ScreenUtil().setHeight(392.5),
//                       child: SingleChildScrollView(
//                         scrollDirection: Axis.vertical,
//                         physics: BouncingScrollPhysics(),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: <Widget>[
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: <Widget>[
//                                 Text(
//                                   'NP104',
//                                   style: TextStyle(
//                                     color: Colors.black,
//                                     fontSize: ScreenUtil().setSp(29,allowFontScalingSelf: true),
//                                     fontFamily: 'Gilroy Black',
//                                   ),
//                                 ),
//                                 Text(
//                                   '20,000 ₹',
//                                   style: TextStyle(
//                                     color: Colors.black,
//                                     fontSize: ScreenUtil().setSp(29,allowFontScalingSelf: true),
//                                     fontFamily: 'Gilroy Black',
//                                   ),
//                                 )
//                               ],
//                             ),
//                             Padding(
//                               padding:
//                                   EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
//                               // height: size.height * 0.01,
//                               child: Divider(
//                                 color: Colors.black,
//                               ),
//                             ),
//                             Text(
//                               'Description: ',
//                               style: TextStyle(
//                                 fontFamily: 'Gilroy Black',
//                                 fontSize: ScreenUtil().setSp(16,allowFontScalingSelf: true),
//                               ),
//                             ),
//                             Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               // child: Text(
//                               //   'Gold Weight'+'2.966'+'grams',
//                               //   style: TextStyle(
//                               //     fontSize: 14.0,
//                               //   ),
//                               //   textAlign: TextAlign.justify,
//                               // ),
//                               child: DataTable(
//                                 // sortAscending: true,
//                                 columns: [
//                                   DataColumn(label: Text('Specifications',style: TextStyle(fontFamily: 'Gilroy',fontSize: ScreenUtil().setSp(13,allowFontScalingSelf: true),fontWeight: FontWeight.bold),)),
//                                   DataColumn(label: Text('Units',style: TextStyle(fontFamily: 'Gilroy',fontSize: ScreenUtil().setSp(13,allowFontScalingSelf: true),fontWeight: FontWeight.bold),)),
//                                 ],
//                                 rows: [
//                                   DataRow(cells: [
//                                     DataCell(Text('Gold Weight',style: TextStyle(fontFamily: 'Gilroy',fontSize: ScreenUtil().setSp(13,allowFontScalingSelf: true),),)),
//                                     DataCell(Text('2.99 grams',style: TextStyle(fontFamily: 'Gilroy',fontSize: ScreenUtil().setSp(13,allowFontScalingSelf: true),),)),
//                                   ]),
//                                   DataRow(cells: [
//                                     DataCell(Text('Diamond Weight',style: TextStyle(fontFamily: 'Gilroy',fontSize: ScreenUtil().setSp(13,allowFontScalingSelf: true),),)),
//                                     DataCell(Text('1.23 carat',style: TextStyle(fontFamily: 'Gilroy',fontSize: ScreenUtil().setSp(13,allowFontScalingSelf: true),),)),
//                                   ]),
//                                   DataRow(cells: [
//                                     DataCell(Text('Diamond Count',style: TextStyle(fontFamily: 'Gilroy',fontSize: ScreenUtil().setSp(13,allowFontScalingSelf: true),),)),
//                                     DataCell(Text('95 pieces',style: TextStyle(fontFamily: 'Gilroy',fontSize: ScreenUtil().setSp(13,allowFontScalingSelf: true),),)),
//                                   ]),
//                                 ],
//                               ),
//                             ),
//                             SizedBox(
//                               height: ScreenUtil().setHeight(28.675),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                     Padding(
//                       padding:
//                           const EdgeInsets.fromLTRB(10.0, 15.0, 10.0, 10.0),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                         children: <Widget>[
//                           RaisedButton(
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(30.0),
//                             ),
//                             color: kPrimaryColor,
//                             onPressed: () {},
//                             child: Row(
//                               children: <Widget>[
//                                 Icon(
//                                   Icons.favorite,
//                                   size: ScreenUtil().setSp(25,allowFontScalingSelf: true),
//                                   color: Colors.white,
//                                 ),
//                                 SizedBox(
//                                   width: ScreenUtil().setWidth(10),
//                                 ),
//                                 Text(
//                                   "Favourites",
//                                   style: TextStyle(
//                                     fontFamily: 'Gilroy',
//                                     fontSize: ScreenUtil().setSp(18,allowFontScalingSelf: true),
//                                     color: Colors.white,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                           RaisedButton(
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(30.0),
//                             ),
//                             color: kPrimaryColor,
//                             onPressed: () {},
//                             child: Row(
//                               children: <Widget>[
//                                 Icon(
//                                   Icons.shopping_cart,
//                                   size: ScreenUtil().setSp(25,allowFontScalingSelf: true),
//                                   color: Colors.white,
//                                 ),
//                                 SizedBox(
//                                   width: ScreenUtil().setWidth(10),
//                                 ),
//                                 Text(
//                                   "Add to Cart",
//                                   style: TextStyle(
//                                     fontFamily: 'Gilroy',
//                                     fontSize: ScreenUtil().setSp(18,allowFontScalingSelf: true),
//                                     color: Colors.white,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             Positioned(
//               right: 0.0,
//               top: ScreenUtil().setHeight(400),
//               child: Container(
//                 width: ScreenUtil().setWidth(49.731),
//                 height: ScreenUtil().setHeight(310),
//                 margin: EdgeInsets.only(left: 20.0),
//                 child: Wrap(
//                   direction: Axis.vertical,
//                   children: <Widget>[
//                     RotatedBox(
//                       quarterTurns: 1,
//                       child: Text(
//                         'Product in Detail',
//                         style: TextStyle(
//                           fontFamily: 'Gilroy',
//                           fontSize: ScreenUtil().setSp(25,allowFontScalingSelf: true),
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
// }

import 'package:Flutter/providers/pagination.dart';
import 'package:Flutter/screens/photo_detail_screen.dart';
import 'package:Flutter/widgets/add_to_cart.dart';
import 'package:Flutter/widgets/snackbar.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_networkimage/provider.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class ProductDetail extends StatefulWidget {
  final colorKey;
  final diamondKey;
  final product;
  final certPrice;
  final defaultIndex1;
  final defaultIndex2;
  final defaultIndex3;
  final defaultIndex4;

  final valueChangeBuild;
  final valueChangeColor;
  final valueChangeCerti;
  final valueChangeDQ;
  final select;

  const ProductDetail(
      {Key key,
      this.colorKey,
      this.diamondKey,
      this.product,
      this.certPrice,
      this.defaultIndex1,
      this.defaultIndex2,
      this.defaultIndex3,
      this.defaultIndex4,
      this.valueChangeBuild,
      this.valueChangeColor,
      this.valueChangeCerti,
      this.valueChangeDQ,
      this.select})
      : super(key: key);

  @override
  _ProductDetailState createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  bool isColourSet = false;

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
      context,
      allowFontScaling: true,
      width: 411.42857142857144,
      height: 774.8571428571429,
    );
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Stack(
          children: <Widget>[
            // Positioned(
            //   left: 0,
            //   bottom: 0,
            //   // top: 0,
            //   child: Stack(
            //     children: <Widget>[
            //       Opacity(
            //         opacity: 0.20,
            //         child: Container(
            //           decoration: BoxDecoration(
            //               gradient: LinearGradient(
            //             colors: [
            //               Color(0xFF0F1533),
            //               Color(0xFF5DB4D8),
            //             ],
            //             begin: Alignment.topCenter,
            //             end: Alignment.bottomCenter,
            //           )),
            //           height: ScreenUtil().setHeight(483),
            //           width: ScreenUtil().setWidth(65),
            //         ),
            //       ),
            //       Container(
            //         height: ScreenUtil().setHeight(483),
            //         width: ScreenUtil().setWidth(65),
            //         child: Column(
            //           mainAxisAlignment: MainAxisAlignment.end,
            //           crossAxisAlignment: CrossAxisAlignment.center,
            //           children: <Widget>[
            //             RotatedBox(
            //               quarterTurns: 1,
            //               child: Text(
            //                 'ADDITIONAL DETAILS',
            //                 style: TextStyle(
            //                   color: Colors.black,
            //                   fontFamily: 'Gilroy Light',
            //                   fontSize: ScreenUtil()
            //                       .setSp(18, allowFontScalingSelf: true),
            //                   letterSpacing: 0.035,
            //                 ),
            //               ),
            //             ),
            //             SizedBox(
            //               height: ScreenUtil().setHeight(135),
            //             ),
            //           ],
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                width: ScreenUtil().setWidth(411),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      height: ScreenUtil().setHeight(440),
                      width: ScreenUtil().setWidth(411),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.elliptical(650, 300),
                          bottomRight: Radius.elliptical(650, 300),
                        ),
                        gradient: isColourSet
                            ? LinearGradient(colors: [
                                Color(0xFF34BDDD).withOpacity(0.1),
                                Color(0xFF367DC8).withOpacity(0.1),
                              ])
                            : RadialGradient(
                                colors: [
                                  Color(0xFF2B3E50),
                                  Color(0xFF010101),
                                ],
                              ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(
                            height: ScreenUtil().setHeight(22),
                          ),
                          Container(
                            // padding: EdgeInsets.all(10.0),
                            margin: EdgeInsets.fromLTRB(25, 17, 26, 28),
                            width: ScreenUtil().setWidth(360),
                            height: ScreenUtil().setHeight(40),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: Colors.white,
                            ),
                            child: TextField(
                              decoration: InputDecoration(
                                suffixIcon: Container(
                                  margin: EdgeInsets.all(6.0),
                                  child: SvgPicture.asset(
                                    'assets/icons/notificationIcon.svg',
                                    height: ScreenUtil().setHeight(27),
                                    width: ScreenUtil().setWidth(27),
                                    color: Colors.black,
                                  ),
                                ),
                                prefixIcon: IconButton(
                                  icon: Icon(Icons.arrow_back),
                                  iconSize: 28,
                                  color: Colors.black,
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
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
                              // textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontFamily: 'Gilroy',
                                  fontSize: ScreenUtil()
                                      .setSp(14, allowFontScalingSelf: true)),
                            ),
                          ),
                          widget.product.imageUrl.containsKey(widget.colorKey)
                              ? Hero(
                                  tag: 'tag1',
                                  child: Image(
                                    height: ScreenUtil().setHeight(290),
                                    width: ScreenUtil().setWidth(290),
                                    image: AdvancedNetworkImage(
                                      widget.product.imageUrl[widget.colorKey],
                                      useDiskCache: true,
                                      cacheRule: CacheRule(
                                          maxAge: const Duration(days: 3)),
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                )
                              : Hero(
                                  tag: 'tag1',
                                  child: Image(
                                    height: ScreenUtil().setHeight(290),
                                    width: ScreenUtil().setWidth(290),
                                    image: AdvancedNetworkImage(
                                      widget.product.imageUrl['yellow'],
                                      useDiskCache: true,
                                      cacheRule: CacheRule(
                                          maxAge: const Duration(days: 3)),
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: ScreenUtil().setHeight(17),
                    ),
                    Container(
                      width: ScreenUtil().setWidth(411),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(
                            width: ScreenUtil().setWidth(54),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                width: ScreenUtil().setWidth(330),
                                // margin: EdgeInsets.only(bottom: 35.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      '${widget.product.styleNumber}',
                                      style: TextStyle(
                                        fontFamily: 'Gilroy Medium',
                                        fontSize: ScreenUtil().setSp(36,
                                            allowFontScalingSelf: true),
                                        color: Colors.black,
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: <Widget>[
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 6.0),
                                          child: GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                isColourSet = true;
                                              });
                                            },
                                            child: Container(
                                              height:
                                                  ScreenUtil().setHeight(16),
                                              width: ScreenUtil().setWidth(16),
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                border: Border.all(
                                                  color: Color(0xFF858585),
                                                  width: 1.0,
                                                ),
                                                gradient: LinearGradient(
                                                  colors: [
                                                    Colors.white,
                                                    Color(0xFF2E3F99),
                                                  ],
                                                  begin: Alignment.topLeft,
                                                  end: Alignment.bottomRight,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              isColourSet = false;
                                            });
                                          },
                                          child: Container(
                                            height: ScreenUtil().setHeight(16),
                                            width: ScreenUtil().setWidth(16),
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              border: Border.all(
                                                color: Color(0xFF858585),
                                                width: 1.0,
                                              ),
                                              gradient: LinearGradient(
                                                colors: [
                                                  Colors.black,
                                                  Color(0xFF2E3F99),
                                                ],
                                                begin: Alignment.topLeft,
                                                end: Alignment.bottomRight,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: ScreenUtil().setHeight(15),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 9.0),
                                child: ShaderMask(
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
                                  child: widget.product.prices
                                          .containsKey(widget.diamondKey)
                                      ? Text(
                                          '${int.parse(widget.product.prices[widget.diamondKey]) + widget.certPrice} ₹',
                                          style: TextStyle(
                                            fontFamily: 'Gilroy Medium',
                                            color: Colors.white,
                                            fontSize: ScreenUtil().setSp(29,
                                                allowFontScalingSelf: true),
                                            fontWeight: FontWeight.w500,
                                          ),
                                        )
                                      : Text(
                                          'No Prices Set',
                                          style: TextStyle(
                                            fontFamily: 'Gilroy Medium',
                                            color: Colors.white,
                                            fontSize: ScreenUtil().setSp(29,
                                                allowFontScalingSelf: true),
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                ),
                              ),
                              SizedBox(
                                height: ScreenUtil().setHeight(10),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 9.0),
                                width: ScreenUtil().setWidth(285),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Container(
                                          margin: EdgeInsets.only(bottom: 7.0),
                                          child: Text(
                                            'Gold Weight'.toUpperCase(),
                                            style: TextStyle(
                                              fontFamily: 'Gilroy Light',
                                              color: Colors.black,
                                              fontSize: ScreenUtil().setSp(14,
                                                  allowFontScalingSelf: true),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(bottom: 7.0),
                                          child: Text(
                                            'Diamond Weight'.toUpperCase(),
                                            style: TextStyle(
                                              fontFamily: 'Gilroy Light',
                                              color: Colors.black,
                                              fontSize: ScreenUtil().setSp(14,
                                                  allowFontScalingSelf: true),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(bottom: 7.0),
                                          child: Text(
                                            'Diamond Count'.toUpperCase(),
                                            style: TextStyle(
                                              fontFamily: 'Gilroy Light',
                                              color: Colors.black,
                                              fontSize: ScreenUtil().setSp(14,
                                                  allowFontScalingSelf: true),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          child: Text(
                                            'DESIGN DIMENSIONS',
                                            style: TextStyle(
                                              fontFamily: 'Gilroy Light',
                                              color: Colors.black,
                                              fontSize: ScreenUtil().setSp(14,
                                                  allowFontScalingSelf: true),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Container(
                                          margin: EdgeInsets.only(bottom: 7.0),
                                          child: Text(
                                            '${widget.product.goldWeight}' +
                                                ' gms',
                                            style: TextStyle(
                                              fontFamily: 'Gilroy Light',
                                              color: Colors.black,
                                              fontSize: ScreenUtil().setSp(14,
                                                  allowFontScalingSelf: true),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(bottom: 7.0),
                                          child: Text(
                                            '${widget.product.diamondWeight}' +
                                                ' ct',
                                            style: TextStyle(
                                              fontFamily: 'Gilroy Light',
                                              color: Colors.black,
                                              fontSize: ScreenUtil().setSp(14,
                                                  allowFontScalingSelf: true),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(bottom: 7.0),
                                          child: Text(
                                            '${widget.product.diamondCount}' +
                                                ' pieces',
                                            style: TextStyle(
                                              fontFamily: 'Gilroy Light',
                                              color: Colors.black,
                                              fontSize: ScreenUtil().setSp(14,
                                                  allowFontScalingSelf: true),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          child: Text(
                                            '${widget.product.designDimensions}',
                                            style: TextStyle(
                                              fontFamily: 'Gilroy Light',
                                              color: Colors.black,
                                              fontSize: ScreenUtil().setSp(14,
                                                  allowFontScalingSelf: true),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: ScreenUtil().setHeight(19),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  SizedBox(
                                    width: ScreenUtil().setWidth(17),
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      GestureDetector(
                                        onTap: () {
                                          Provider.of<Pagination>(context,
                                                listen: false)
                                            .isPriced
                                        ? dataSelect(
                                            context,
                                            'Important!',
                                            "To see prices you must first request a quotation from Team Gemstory",
                                            'Request Prices',
                                          )
                                        : showDialog(
                                            context: context,
                                            child: AddToCart(
                                              product: widget.product,
                                              updateCart: false,
                                              choicesBuild:
                                                  Provider.of<Pagination>(
                                                          context,
                                                          listen: false)
                                                      .build,
                                              choiceColor:
                                                  Provider.of<Pagination>(
                                                          context,
                                                          listen: false)
                                                      .color,
                                              choiceCertification:
                                                  Provider.of<Pagination>(
                                                          context,
                                                          listen: false)
                                                      .cert,
                                              choiceDiamondQuality:
                                                  Provider.of<Pagination>(
                                                          context,
                                                          listen: false)
                                                      .diamondQuality,
                                              defValue: widget.defaultIndex1,
                                              defValue1: widget.defaultIndex2,
                                              defValue2: widget.defaultIndex3,
                                              defValue3: widget.defaultIndex4,
                                              valueChangeBuild:
                                                  widget.valueChangeBuild,
                                              valueChangeColor:
                                                  widget.valueChangeColor,
                                              valueChangeCerti:
                                                  widget.valueChangeCerti,
                                              valueChangeDQ:
                                                  widget.valueChangeDQ,
                                            ),
                                          );
                                        },
                                        child: Container(
                                          width: ScreenUtil().setWidth(270),
                                          height: ScreenUtil().setWidth(43),
                                          // padding: EdgeInsets.all(20.0),
                                          child: Center(
                                            child: Text(
                                              'ADD TO CART',
                                              style: TextStyle(
                                                fontFamily: 'Gilroy Bold',
                                                color: Colors.white,
                                                fontSize: ScreenUtil().setSp(18,
                                                    allowFontScalingSelf: true),
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
                                      ),
                                      SizedBox(
                                        height: ScreenUtil().setHeight(15),
                                      ),
                                      Container(
                                        width: ScreenUtil().setWidth(239),
                                        child: RichText(
                                          text: TextSpan(
                                            style: TextStyle(
                                              fontFamily: 'Gilroy Medium',
                                              fontSize: ScreenUtil().setSp(12,
                                                  allowFontScalingSelf: true),
                                              color: Color(0xFF8C8888),
                                            ),
                                            children: [
                                              TextSpan(
                                                text:
                                                    'To know more about this design or contact Team Gemstory, ',
                                              ),
                                              TextSpan(
                                                  text: 'Click here',
                                                  recognizer:
                                                      TapGestureRecognizer()
                                                        ..onTap = () async {
                                                          if (await canLaunch(
                                                              "https://wa.me/919322244007")) {
                                                            await launch(
                                                                "https://wa.me/919322244007");
                                                          } else {
                                                            throw 'Could not launch https://wa.me/919322244007';
                                                          }
                                                        },
                                                  style: TextStyle(
                                                    decoration: TextDecoration
                                                        .underline,
                                                  )),
                                            ],
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            Positioned(
              top: ScreenUtil().setHeight(92 + 22),
              right: ScreenUtil().setWidth(26),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          PhotoDetailScreen(widget.colorKey, widget.product),
                    ),
                  );
                },
                child: SvgPicture.asset(
                  'assets/icons/zoomIcon.svg',
                  width: ScreenUtil().setWidth(29),
                  height: ScreenUtil().setHeight(29),
                  color: isColourSet ? Color(0xFFB8B8B8) : Colors.white,
                ),
              ),
            ),
            Positioned(
              top: ScreenUtil().setHeight(383),
              right: ScreenUtil().setWidth(26),
              child: Container(
                height: ScreenUtil().setHeight(43),
                width: ScreenUtil().setWidth(43),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFF34B0D9),
                      Color(0xFF3685CB),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: GestureDetector(
                  onTap: () async {
                    await Provider.of<Pagination>(context, listen: false)
                        .toogleFavourite(
                            styleNumber: widget.product.styleNumber,
                            context: context,
                            select: widget.select);
                    setState(() {});
                  },
                  child: Icon(
                    widget.product.isFavourite
                        ? Icons.favorite
                        : Icons.favorite_border,
                    size: 30.0,
                    color: Colors.white,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
