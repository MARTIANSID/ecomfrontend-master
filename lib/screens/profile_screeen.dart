// import 'package:Flutter/providers/pagination.dart';
// import 'package:Flutter/providers/user.dart';
// import 'package:Flutter/screens/accountinfo.dart';
// import 'package:Flutter/screens/completeSignUp.dart';
// import 'package:Flutter/screens/testimony_page.dart';
// import 'package:Flutter/widgets/snackbar.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:provider/provider.dart';
// import '../constant/const.dart';
// import '../providers/auth.dart';
// import 'accountinfo.dart';
// import 'my_price.dart';
// import 'my_order.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// class UserPage extends StatefulWidget {
// final int pageIndex;
// final PageController pageController;
// final void Function(int) onButtonTapped;
// final cont;

//   const UserPage(
//       {Key key,
//       this.pageIndex,
//       this.pageController,
//       this.onButtonTapped,
//       this.cont})
//       : super(key: key);

//   @override
//   _UserPageState createState() => _UserPageState();
// }

// class _UserPageState extends State<UserPage>
//     with SingleTickerProviderStateMixin {
//   bool value2;
//   bool isLoading = false;

//   bool storeCheckValue = false;
//   int timerVal = 0;

//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     ScreenUtil.init(
//       context,
//       width: 411.42857142857144,
//       height: 774.8571428571429,
//       allowFontScaling: true,
//     );
//     return Scaffold(
//       body: isLoading
//           ? Center(
//               child: CircularProgressIndicator(),
//             )
//           : ListView(
//               shrinkWrap: true,
//               scrollDirection: Axis.vertical,
//               physics: BouncingScrollPhysics(),
//               children: <Widget>[
//                   Column(children: <Widget>[
//                     Stack(children: <Widget>[
//                       Container(
//                         height: ScreenUtil().setHeight(232.5),
//                         width: double.infinity,
//                         color: Colors.blue[400],
//                       ),
//                       Positioned(
//                         bottom: ScreenUtil().setHeight(460),
//                         right: ScreenUtil().setWidth(98.64),
//                         child: Container(
//                           height: ScreenUtil().setHeight(372),
//                           width: ScreenUtil().setWidth(398.67),
//                           decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(200.0),
//                               color: Colors.cyan.withOpacity(0.4)),
//                         ),
//                       ),
//                       Positioned(
//                         bottom: ScreenUtil().setHeight(542),
//                         right: ScreenUtil().setWidth(-50),
//                         child: Container(
//                             height: ScreenUtil().setHeight(279),
//                             width: ScreenUtil().setWidth(300),
//                             decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(150.0),
//                                 color: Colors.cyan.withOpacity(0.5))),
//                       ),
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: <Widget>[
//                           SizedBox(
//                             height: ScreenUtil().setHeight(25),
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                             children: <Widget>[
//                               Row(
//                                 children: <Widget>[
//                                   Container(
//                                     // alignment: Alignment.topLeft,
//                                     margin: EdgeInsets.only(
//                                         left: 20.0, right: 15.0),
//                                     height: ScreenUtil().setHeight(70),
//                                     width: ScreenUtil().setWidth(70),
//                                     decoration: BoxDecoration(
//                                       shape: BoxShape.circle,
//                                       // borderRadius: BorderRadius.circular(37.5),
//                                       border: Border.all(
//                                           color: Colors.white,
//                                           style: BorderStyle.solid,
//                                           width: 3.0),
//                                       // image: DecorationImage(
//                                       //   image: AssetImage('assets/images/chris.jpg'),
//                                       // ),
//                                     ),
//                                   ),
//                                   Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: <Widget>[
//                                       Text(
//                                         // 'Yash Karade',
//                                         Provider.of<UserInfo>(context,
//                                                 listen: false)
//                                             .fullname,
//                                         style: TextStyle(
//                                           fontFamily: 'Gilroy',
//                                           fontSize: ScreenUtil().setSp(25,
//                                               allowFontScalingSelf: true),
//                                           fontWeight: FontWeight.bold,
//                                         ),
//                                       ),
//                                       Provider.of<Pagination>(context,
//                                                   listen: false)
//                                               .isVerified
//                                           ? Text(
//                                               // 'daxy.in',
//                                               Provider.of<UserInfo>(context,
//                                                       listen: false)
//                                                   .firm,
//                                               style: TextStyle(
//                                                 fontFamily: 'Gilroy',
//                                                 fontSize: ScreenUtil().setSp(15,
//                                                     allowFontScalingSelf: true),
//                                                 color: Colors.black
//                                                     .withOpacity(0.7),
//                                               ),
//                                             )
//                                           : SizedBox(height: 0.0),
//                                     ],
//                                   ),
//                                 ],
//                               ),
//                               Container(
//                                 alignment: Alignment.topRight,
//                                 child: IconButton(
//                                   icon: Icon(Icons.settings),
//                                   onPressed: () {},
//                                   color: Colors.white,
//                                   iconSize: ScreenUtil()
//                                       .setSp(30, allowFontScalingSelf: true),
//                                 ),
//                               ),
//                             ],
//                           ),
//                           SizedBox(
//                             height: ScreenUtil().setHeight(10),
//                           ),
//                           Provider.of<Pagination>(context, listen: false)
//                                   .isVerified
//                               ? Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceEvenly,
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: <Widget>[
//                                     Container(
//                                       child: Column(
//                                         children: <Widget>[
//                                           IconButton(
//                                             icon: Icon(Icons.card_travel),
//                                             color: Colors.white,
//                                             iconSize: ScreenUtil().setSp(40,
//                                                 allowFontScalingSelf: true),
//                                             onPressed: () async {
//                                               if (!Provider.of<Pagination>(
//                                                       context,
//                                                       listen: false)
//                                                   .isVerified) {
//                                                 if (storeCheckValue) {
//                                                 } else {
//                                                   Navigator.push(
//                                                     context,
//                                                     MaterialPageRoute(
//                                                       builder: (context) =>
//                                                           CompleteSignUp(),
//                                                     ),
//                                                   );
//                                                 }
//                                               } else if (!Provider.of<
//                                                           Pagination>(context,
//                                                       listen: false)
//                                                   .isPriced) {
//                                                 try {
//                                                   await Provider.of<Pagination>(
//                                                           context,
//                                                           listen: false)
//                                                       .requestPrice(
//                                                           context: context);
//                                                 } catch (err) {
//                                                   dataSelect(
//                                                       context, '$err', '', 'OK',
//                                                       () {
//                                                     Navigator.pop(context);
//                                                   });
//                                                 }
//                                               } else {
//                                                 Navigator.push(
//                                                   context,
//                                                   MaterialPageRoute(
//                                                     builder: (context) =>
//                                                         MyOrder(),
//                                                   ),
//                                                 );
//                                               }
//                                             },
//                                           ),
//                                           Text(
//                                             'My Orders',
//                                             style: TextStyle(
//                                               fontFamily: 'Gilroy',
//                                               fontSize: ScreenUtil().setSp(15,
//                                                   allowFontScalingSelf: true),
//                                               color: Colors.white,
//                                               fontWeight: FontWeight.bold,
//                                             ),
//                                           )
//                                         ],
//                                       ),
//                                     ),
//                                     Container(
//                                       child: Column(
//                                         children: <Widget>[
//                                           IconButton(
//                                             icon: Icon(
//                                                 Icons.account_balance_wallet),
//                                             color: Colors.white,
//                                             iconSize: ScreenUtil().setSp(40,
//                                                 allowFontScalingSelf: true),
//                                             onPressed: () async {
//                                               if (!Provider.of<Pagination>(
//                                                       context,
//                                                       listen: false)
//                                                   .isVerified) {
//                                                 String date =
//                                                     await Provider.of<UserInfo>(
//                                                             context,
//                                                             listen: false)
//                                                         .getDate();
//                                                 if (date != null) {
//                                                   int d = DateTime.now()
//                                                       .difference(
//                                                           DateTime.parse(date))
//                                                       .inDays;
//                                                   if (d >= 1) {
//                                                     Navigator.push(
//                                                       context,
//                                                       MaterialPageRoute(
//                                                         builder: (context) =>
//                                                             CompleteSignUp(),
//                                                       ),
//                                                     );
//                                                   } else {
//                                                     dataSelect(
//                                                         context,
//                                                         'Request has already been noted!',
//                                                         '',
//                                                         'ok', () {
//                                                       Navigator.pop(context);
//                                                     });
//                                                   }
//                                                 } else {
//                                                   Navigator.push(
//                                                     context,
//                                                     MaterialPageRoute(
//                                                       builder: (context) =>
//                                                           CompleteSignUp(),
//                                                     ),
//                                                   );
//                                                 }
//                                               } else if (!Provider.of<
//                                                           Pagination>(context,
//                                                       listen: false)
//                                                   .isPriced) {
//                                                 try {
//                                                   await Provider.of<Pagination>(
//                                                           context,
//                                                           listen: false)
//                                                       .requestPrice(
//                                                           context: context);
//                                                 } catch (err) {
//                                                   dataSelect(
//                                                       context, '$err', '', 'OK',
//                                                       () {
//                                                     Navigator.pop(context);
//                                                   });
//                                                 }
//                                               } else {
//                                                 Navigator.push(
//                                                   context,
//                                                   MaterialPageRoute(
//                                                     builder: (context) =>
//                                                         MyPrice(
//                                                       onButtonTapped:
//                                                           widget.onButtonTapped,
//                                                     ),
//                                                   ),
//                                                 );
//                                               }
//                                             },
//                                           ),
//                                           Text(
//                                             'My Prices',
//                                             style: TextStyle(
//                                               fontFamily: 'Gilroy',
//                                               fontSize: ScreenUtil().setSp(15,
//                                                   allowFontScalingSelf: true),
//                                               color: Colors.white,
//                                               fontWeight: FontWeight.bold,
//                                             ),
//                                           )
//                                         ],
//                                       ),
//                                     ),
//                                     Container(
//                                       child: Column(
//                                         children: <Widget>[
//                                           IconButton(
//                                             icon: Icon(Provider.of<Pagination>(
//                                                         context,
//                                                         listen: false)
//                                                     .isVerified
//                                                 ? Icons.computer
//                                                 : Icons.verified_user),
//                                             color: Colors.white,
//                                             iconSize: ScreenUtil().setSp(40,
//                                                 allowFontScalingSelf: true),
//                                             onPressed: () async {
//                                               if (Provider.of<Pagination>(
//                                                       context,
//                                                       listen: false)
//                                                   .isVerified)
//                                                 Navigator.push(
//                                                   context,
//                                                   MaterialPageRoute(
//                                                     builder: (context) =>
//                                                         AccountInfo(),
//                                                   ),
//                                                 );
//                                               else {
//                                                 String date =
//                                                     await Provider.of<UserInfo>(
//                                                             context,
//                                                             listen: false)
//                                                         .getDate();
//                                                 if (date != null) {
//                                                   int d = DateTime.now()
//                                                       .difference(
//                                                           DateTime.parse(date))
//                                                       .inDays;
//                                                   if (d >= 1) {
//                                                     Navigator.push(
//                                                       context,
//                                                       MaterialPageRoute(
//                                                         builder: (context) =>
//                                                             CompleteSignUp(),
//                                                       ),
//                                                     );
//                                                   } else {
//                                                     dataSelect(
//                                                         context,
//                                                         'Request has already been noted!',
//                                                         '',
//                                                         'ok', () {
//                                                       Navigator.pop(context);
//                                                     });
//                                                   }
//                                                 } else {
//                                                   Navigator.push(
//                                                     context,
//                                                     MaterialPageRoute(
//                                                       builder: (context) =>
//                                                           CompleteSignUp(),
//                                                     ),
//                                                   );
//                                                 }
//                                               }
//                                             },
//                                           ),
//                                           Text(
//                                             Provider.of<Pagination>(context,
//                                                         listen: false)
//                                                     .isVerified
//                                                 ? 'Account\nDetails'
//                                                 : 'Complete\nSignUp',
//                                             style: TextStyle(
//                                               fontFamily: 'Gilroy',
//                                               fontSize: ScreenUtil().setSp(15,
//                                                   allowFontScalingSelf: true),
//                                               color: Colors.white,
//                                               fontWeight: FontWeight.bold,
//                                             ),
//                                             textAlign: TextAlign.center,
//                                           )
//                                         ],
//                                       ),
//                                     )
//                                   ],
//                                 )
//                               : Center(
//                                   child: GestureDetector(
//                                     onTap: () async {
//                                       String date = await Provider.of<UserInfo>(
//                                               context,
//                                               listen: false)
//                                           .getDate();
//                                       if (date != null) {
//                                         int d = DateTime.now()
//                                             .difference(DateTime.parse(date))
//                                             .inDays;
//                                         if (d >= 1) {
//                                           Navigator.push(
//                                             context,
//                                             MaterialPageRoute(
//                                               builder: (context) =>
//                                                   CompleteSignUp(),
//                                             ),
//                                           );
//                                         } else {
//                                           dataSelect(
//                                               context,
//                                               'Request has already been noted!',
//                                               '',
//                                               'ok', () {
//                                             Navigator.pop(context);
//                                           });
//                                         }
//                                       } else {
//                                         Navigator.push(
//                                           context,
//                                           MaterialPageRoute(
//                                             builder: (context) =>
//                                                 CompleteSignUp(),
//                                           ),
//                                         );
//                                       }
//                                     },
//                                     child: Container(
//                                       padding: EdgeInsets.all(3.0),
//                                       width: ScreenUtil().setWidth(175),
//                                       decoration: BoxDecoration(
//                                         border: Border(
//                                           bottom: BorderSide(
//                                             color: Colors
//                                                 .white, // Text colour here
//                                             width: 1.0, // Underline width
//                                           ),
//                                         ),
//                                         // border: Border.all(
//                                         //     color: Colors.white, width: 1.5),
//                                         // borderRadius: BorderRadius.circular(30),
//                                       ),
//                                       child: Row(
//                                         children: <Widget>[
//                                           SvgPicture.asset(
//                                             "assets/icons/completeSignUp.svg",
//                                             color: Colors.white,
//                                             height: ScreenUtil().setHeight(30),
//                                             width: ScreenUtil().setWidth(30),
//                                           ),
//                                           SizedBox(
//                                             width: ScreenUtil().setWidth(10),
//                                           ),
//                                           Text(
//                                             'Complete Sign-Up',
//                                             style: TextStyle(
//                                               fontFamily: 'Gilroy',
//                                               // decoration:
//                                               //     TextDecoration.underline,
//                                               // height: 1.5,
//                                               fontSize: ScreenUtil().setSp(15,
//                                                   allowFontScalingSelf: true),
//                                               color: Colors.white,
//                                               fontWeight: FontWeight.bold,
//                                             ),
//                                             textAlign: TextAlign.center,
//                                           )
//                                         ],
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                           SizedBox(
//                             height: ScreenUtil().setHeight(25),
//                           ),
//                           Column(
//                             children: <Widget>[
//                               Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceEvenly,
//                                 children: <Widget>[
//                                   cardDetails(
//                                     'Options we have',
//                                     '5',
//                                     Padding(
//                                       padding: const EdgeInsets.fromLTRB(
//                                           15.0, 20.0, 20.0, 0.0),
//                                       child: SvgPicture.asset(
//                                         "assets/icons/options.svg",
//                                         fit: BoxFit.contain,
//                                         height: ScreenUtil().setHeight(41),
//                                         width: ScreenUtil().setWidth(41),
//                                         // height: 41.0,
//                                         // width: 41.0,
//                                         color: Colors.amber[300],
//                                       ),
//                                     ),
//                                   ),
//                                   cardDetails(
//                                     'Orders Placed',
//                                     // 'assets/images/box.png',
//                                     '2',
//                                     Padding(
//                                       padding: const EdgeInsets.fromLTRB(
//                                           15.0, 20.0, 20.0, 0.0),
//                                       // child: Text(
//                                       //   '💎',
//                                       //   style: TextStyle(
//                                       //     fontSize: 35.0,
//                                       //   ),
//                                       // ),
//                                       child: SvgPicture.asset(
//                                         "assets/icons/diamond.svg",
//                                         fit: BoxFit.contain,
//                                         height: ScreenUtil().setHeight(41),
//                                         width: ScreenUtil().setWidth(41),
//                                         // height: 41.0,
//                                         // width: 41.0,
//                                         // color: Colors.amber[300],
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                               SizedBox(height: ScreenUtil().setHeight(10)),
//                               Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceEvenly,
//                                 children: <Widget>[
//                                   cardDetails(
//                                     'Nose Pins I like',
//                                     // 'assets/images/trucks.png',
//                                     Provider.of<Pagination>(context,
//                                             listen: true)
//                                         .favProducts
//                                         .length
//                                         .toString(),
//                                     Padding(
//                                       padding: const EdgeInsets.fromLTRB(
//                                           15.0, 15.0, 20.0, 0.0),
//                                       // child: Text(
//                                       //   '💙',
//                                       //   style: TextStyle(
//                                       //     fontSize: 35.0,
//                                       //   ),
//                                       // ),
//                                       child: Icon(
//                                         Icons.favorite,
//                                         color: Colors.cyan[200],
//                                         size: ScreenUtil().setSp(40,
//                                             allowFontScalingSelf: true),
//                                       ),
//                                     ),
//                                   ),
//                                   cardDetails(
//                                     'Today\'s Gold Price',
//                                     // 'assets/images/returnbox.png',
//                                     Provider.of<Pagination>(context,
//                                             listen: false)
//                                         .goldPrice
//                                         .toString(),
//                                     Padding(
//                                       padding: const EdgeInsets.fromLTRB(
//                                           15.0, 15.0, 20.0, 0.0),
//                                       child: Icon(
//                                         MyFlutterApp.gold_bar,
//                                         color: Colors.amber[300],
//                                         size: ScreenUtil().setSp(40,
//                                             allowFontScalingSelf: true),
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                               SizedBox(
//                                 height: ScreenUtil().setHeight(5),
//                               )
//                             ],
//                           ),
//                           SizedBox(
//                             height: ScreenUtil().setWidth(10),
//                           ),
//                           ListWidgetUserDetails(
//                             // leadingIcon: Icon(
//                             //   Icons.thumb_up,
//                             //   color: Colors.black,
//                             // ),
//                             leadingIcon: Padding(
//                               padding: const EdgeInsets.all(0.0),
//                               child: SvgPicture.asset(
//                                 "assets/icons/rate.svg",
//                                 height: ScreenUtil().setHeight(38.75),
//                                 width: ScreenUtil().setWidth(20.55),
//                               ),
//                             ),
//                             text: "Testimonies",
//                             tap: () {
//                               Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                   builder: (context) => TestimonyPage(),
//                                 ),
//                               );
//                             },
//                           ),
//                           ListWidgetUserDetails(
//                             leadingIcon: Padding(
//                               padding: const EdgeInsets.only(left: 5.0),
//                               child: SvgPicture.asset(
//                                 "assets/icons/logout1.svg",
//                                 height: ScreenUtil().setHeight(31),
//                                 width: ScreenUtil().setWidth(16.44),
//                               ),
//                             ),
//                             text: "Logout",
//                             tap: () async {
//                               await dataSelectConfirmMessage(
//                                 context,
//                                 'Alert!',
//                                 "Are you sure, You want to logout",
//                                 'Request Prices',
//                               ).then((value) async {
//                                 if (value) {
//                                   value2 = value;
//                                   if (value2) {
//                                     Navigator.of(context).pop();
//                                     Navigator.popAndPushNamed(context, '/');
//                                     Provider.of<Auth>(context, listen: false)
//                                         .logout();
//                                   }
//                                 }
//                               });

//                               // Navigator.push(
//                               //   context,
//                               //   MaterialPageRoute(
//                               //     builder: (context) => MyPrice(),
//                               //   ),
//                               // );
//                             },
//                           ),
//                         ],
//                       )
//                     ]),
//                   ])
//                 ]),
//     );
//   }

//   Widget cardDetails(String title, String valueCount, Widget iconWidget) {
//     return Material(
//       elevation: 4.0,
//       borderRadius: BorderRadius.circular(7.0),
//       child: Container(
//         height: ScreenUtil().setHeight(135),
//         width: ScreenUtil().setWidth(185),
//         decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(7.0), color: Colors.white),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: <Widget>[
//             // SizedBox(height: 5.0),
//             iconWidget,
//             SizedBox(
//               height: ScreenUtil().setHeight(14),
//             ),
//             Padding(
//               padding: EdgeInsets.only(left: 15.0),
//               child: Text(
//                 title,
//                 style: TextStyle(
//                   fontFamily: 'Gilroy',
//                   fontSize: ScreenUtil().setSp(17, allowFontScalingSelf: true),
//                   color: Colors.black,
//                 ),
//               ),
//             ),
//             SizedBox(height: 3.0),
//             Padding(
//               padding: EdgeInsets.only(left: 15.0),
//               child: Text(
//                 valueCount,
//                 style: TextStyle(
//                   fontFamily: 'Gilroy',
//                   fontSize: ScreenUtil().setSp(19, allowFontScalingSelf: true),
//                   color: kPrimaryColor,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }

// class ListWidgetUserDetails extends StatefulWidget {
//   final Padding leadingIcon;
//   final String text;
//   final Function tap;

//   const ListWidgetUserDetails({Key key, this.leadingIcon, this.text, this.tap})
//       : super(key: key);
//   @override
//   _ListWidgetUserDetailsState createState() => _ListWidgetUserDetailsState();
// }

// class _ListWidgetUserDetailsState extends State<ListWidgetUserDetails> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       // margin: EdgeInsets.all(4.0),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(18.0),
//         // boxShadow: <BoxShadow>[
//         //   BoxShadow(
//         //     color: Colors.black12,
//         //     blurRadius: 10.0,
//         //     offset: Offset(0.0, 10.0),
//         //   ),
//         // ],
//       ),
//       width: ScreenUtil().setWidth(411),
//       height: ScreenUtil().setHeight(70),
//       child: Center(
//         child: ListTile(
//           leading: widget.leadingIcon,
//           onTap: widget.tap,
//           trailing: Icon(
//             Icons.arrow_forward_ios,
//             color: Colors.black,
//           ),
//           title: Text(
//             widget.text,
//             style: TextStyle(
//               fontSize: ScreenUtil().setSp(20, allowFontScalingSelf: true),
//               fontFamily: 'Gilroy',
//               color: Colors.black,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'dart:io';

import 'package:Flutter/providers/auth.dart';
import 'package:Flutter/providers/pagination.dart';
import 'package:Flutter/providers/user.dart';
import 'package:Flutter/screens/profileImage.dart';
import 'package:Flutter/widgets/snackbar.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_networkimage/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:image_picker/image_picker.dart';

import 'accountinfo.dart';
import 'completeSignUp.dart';
import 'my_order.dart';
import 'my_price.dart';
import 'testimony_page.dart';

class UserPage extends StatefulWidget {
  final int pageIndex;
  final PageController pageController;
  final void Function(int) onButtonTapped;
  final cont;

  const UserPage(
      {Key key,
      this.pageIndex,
      this.pageController,
      this.onButtonTapped,
      this.cont})
      : super(key: key);

  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage>
    with SingleTickerProviderStateMixin {
  GlobalKey globalKey = GlobalKey();
  bool value2;
  bool isLoading = false;

  bool isLoadingimage = false;

  bool storeCheckValue = false;
  int timerVal = 0;

  bool isSwitched;

  @override
  void initState() {
    super.initState();
    if (Provider.of<UserInfo>(context, listen: false).check == false)
      setState(() {
        isLoading = true;
      });
    Future.delayed(Duration(seconds: 0), () async {
      try {
        if (Provider.of<UserInfo>(context, listen: false).check == false) {
          await Provider.of<UserInfo>(context, listen: false).getuser(context);
          isSwitched = Provider.of<UserInfo>(context, listen: false).noti;
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
      } finally {
        setState(() {
          isLoading = false;
        });
      }
    });
  }

  void didChangeDependencies() {
    super.didChangeDependencies();
    isSwitched = Provider.of<UserInfo>(context, listen: false).noti;
  }

  void requestPrice() async {
    await Provider.of<Pagination>(context, listen: false)
        .requestPrice(context: context);
    Navigator.of(context).pop();
  }

  Future<bool> _showDialog(BuildContext context) async {
    bool p = await Provider.of<Auth>(context, listen: false).getPassword();
    GlobalKey<FormState> _key = GlobalKey();
    bool value2 = false;
    await showDialog(
      context: context,
      builder: (context) {
        // return AlertDialog(
        //   content:
        //   actions: <Widget>[
        //     FlatButton(
        //       child: const Text('CANCEL'),
        //       onPressed: () {
        //         Navigator.pop(context);
        //         setState(() {
        //           value2 = false;
        //         });
        //         // return false;
        //       },
        //     ),
        //     FlatButton(
        //       child: const Text('OPEN'),
        //       onPressed: () {
        //         if (_key.currentState.validate()) {
        //           _key.currentState.save();
        //           Navigator.pop(context);
        //           setState(() {
        //             value2 = true;
        //           });
        //           // return true;
        //         }
        //       },
        //     ),
        //   ],
        // );
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          contentPadding: EdgeInsets.all(0),
          content: Container(
            width: ScreenUtil().setWidth(400),
            height: ScreenUtil().setHeight(200),
            child: Column(
              children: <Widget>[
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.end,
                //   children: <Widget>[
                //     IconButton(
                //       icon: Icon(Icons.clear),
                //       color: Colors.black,
                //       onPressed: () {
                //         Navigator.pop(context);
                //         setState(() {
                //           value2 = false;
                //         });
                //       },
                //     ),
                //   ],
                // ),
                Container(
                  width: ScreenUtil().setWidth(400),
                  height: ScreenUtil().setHeight(150),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white,
                  ),
                  child: Form(
                    key: _key,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          height: ScreenUtil().setHeight(15),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 15.0),
                          child: Text(
                            'Enter your password',
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: "Gilroy Medium",
                              fontSize: ScreenUtil()
                                  .setSp(18, allowFontScalingSelf: true),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 20, right: 20),
                          width: ScreenUtil().setWidth(290),
                          // flex: 11,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            gradient: LinearGradient(
                              colors: [
                                Color(0xFF34BDDD),
                                Color(0xFF367DC8),
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                          ),
                          padding: EdgeInsets.all(3),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            padding: EdgeInsets.only(left: 10),
                            child: TextFormField(
                              style: TextStyle(
                                fontFamily: 'Gilroy Regular',
                                fontSize: ScreenUtil()
                                    .setSp(16, allowFontScalingSelf: true),
                              ),
                              obscureText: true,
                              decoration: InputDecoration(
                                icon: SvgPicture.asset(
                                  "assets/icons/lock.svg",
                                  height: ScreenUtil().setWidth(18),
                                  width: ScreenUtil().setHeight(21),
                                  color: Colors.black,
                                ),
                                hintText: "Password",
                                border: InputBorder.none,
                              ),
                              validator: (value) {
                                if (value.isEmpty) {
                                  return "Enter Password";
                                } else if (Provider.of<Auth>(context,
                                            listen: false)
                                        .password !=
                                    value) {
                                  return "Incorrect Password";
                                } else if (p == false) {
                                  return "Something went wrong";
                                }
                                return null;
                              },
                              autofocus: true,
                            ),
                          ),
                        ),
                        // SizedBox(
                        //   height: ScreenUtil().setHeight(5),
                        // )
                      ],
                    ),
                  ),
                ),
                Container(
                  width: ScreenUtil().setWidth(400),
                  height: ScreenUtil().setHeight(50),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(15),
                      bottomRight: Radius.circular(15),
                    ),
                    gradient: LinearGradient(
                      colors: [
                        Color(0xFF34BDDD),
                        Color(0xFF367DC8),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: Material(
                    type: MaterialType.transparency,
                    elevation: 6.0,
                    color: Colors.transparent,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(15),
                      bottomRight: Radius.circular(15),
                    ),
                    child: InkWell(
                      splashColor: Colors.cyan[50].withOpacity(0.5),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(15),
                        bottomRight: Radius.circular(15),
                      ),
                      onTap: () {
                        if (_key.currentState.validate()) {
                          _key.currentState.save();
                          Navigator.pop(context);
                          setState(() {
                            value2 = true;
                          });
                          // return true;
                        }
                      },
                      child: Center(
                        child: Text(
                          "Confirm",
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: "Gilroy Medium",
                            fontSize: ScreenUtil()
                                .setSp(16, allowFontScalingSelf: true),
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
    print(value2);
    return value2;
  }

  void _settingModalBottomSheet(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
            height: 100,
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  width: 10,
                ),
                Container(
                    padding: EdgeInsets.all(10.0),
                    child: Column(
                      children: <Widget>[
                        Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                        Text(
                          'Remvoe Photo',
                          style: TextStyle(
                            fontFamily: "Gilroy Medium",
                            fontSize: ScreenUtil()
                                .setSp(16, allowFontScalingSelf: true),
                          ),
                          softWrap: true,
                        )
                      ],
                    )),
                SizedBox(
                  width: 10,
                ),
                Container(
                    padding: EdgeInsets.all(10.0),
                    child: Column(
                      children: <Widget>[
                        Icon(Icons.camera),
                        Text(
                          'Camera',
                          style: TextStyle(
                            fontFamily: "Gilroy Medium",
                            fontSize: ScreenUtil()
                                .setSp(16, allowFontScalingSelf: true),
                          ),
                        )
                      ],
                    )),
                SizedBox(
                  width: 10,
                ),
                Container(
                    padding: EdgeInsets.all(10.0),
                    child: Column(
                      children: <Widget>[
                        Icon(Icons.photo),
                        Text(
                          'Gallery',
                          style: TextStyle(
                            fontFamily: "Gilroy Medium",
                            fontSize: ScreenUtil()
                                .setSp(16, allowFontScalingSelf: true),
                          ),
                        )
                      ],
                    )),
              ],
            ),
          );
        });
  }

  File image;
  final picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
      context,
      width: 411.42857142857144,
      height: 774.8571428571429,
      allowFontScaling: true,
    );
    return Scaffold(
      key: globalKey,
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              color: Color(0xFFF4F4F4),
              child: Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  Positioned(
                    top: ScreenUtil().setHeight(-360),
                    child: Container(
                      height: ScreenUtil().setHeight(800),
                      width: ScreenUtil().setWidth(800),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        // borderRadius: BorderRadius.circular(800),
                        gradient: LinearGradient(
                          colors: [
                            Color(0xFF34BDDD),
                            Color(0xFF3680C9),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0.0,
                    left: 0.0,
                    child: Container(
                      height: ScreenUtil().setHeight(775),
                      width: ScreenUtil().setWidth(411),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(
                            height: ScreenUtil().setHeight(46),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              SizedBox(
                                width: ScreenUtil().setWidth(51),
                              ),
                              Container(
                                width: ScreenUtil().setWidth(60),
                                height: ScreenUtil().setHeight(60),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  gradient: LinearGradient(
                                    colors: [
                                      Colors.white,
                                      Colors.white
                                      // Color(0xFF34BDDD),
                                      // Color(0xFF367DC8),
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                ),
                                padding: EdgeInsets.all(2),
                                child: Hero(
                                  tag: 'tag2',
                                  child: GestureDetector(
                                    onTap: () async {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => ProfileImage(
                                                  url: Provider.of<UserInfo>(
                                                          context,
                                                          listen: true)
                                                      .profileImage,
                                                )),
                                      );
                                      // showDialog(
                                      //   context: context,
                                      //   builder: (BuildContext context) {
                                      //     return AlertDialog(
                                      //       title: Text('Alert'),
                                      //       content: Text(
                                      //           "Are You Sure Want To Process ?"),
                                      //       actions: <Widget>[
                                      //         FlatButton(
                                      //           child: Text("YES"),
                                      //           onPressed: () async {
                                      // Navigator.of(context).pop();
                                      // showDialog(
                                      //   context: context,
                                      //   builder:
                                      //       (BuildContext context) {
                                      //     return SimpleDialog(
                                      //       elevation: 100.0,
                                      //       contentPadding:
                                      //           EdgeInsets.all(0),
                                      //       shape:
                                      //           RoundedRectangleBorder(
                                      //         borderRadius:
                                      //             BorderRadius
                                      //                 .circular(20),
                                      //       ),
                                      //       children: <Widget>[
                                      //         Container(
                                      //           width: ScreenUtil()
                                      //               .setWidth(250),
                                      //           child: Column(
                                      //             children: <Widget>[
                                      //               Padding(
                                      //                 padding:
                                      //                     const EdgeInsets
                                      //                             .all(
                                      //                         15.0),
                                      //                 child: Text(
                                      //                   'Select Image from the following options available from below!',
                                      //                   textAlign:
                                      //                       TextAlign
                                      //                           .center,
                                      //                   style:
                                      //                       TextStyle(
                                      //                     fontFamily:
                                      //                         "Gilroy Medium",
                                      //                     fontSize: ScreenUtil().setSp(
                                      //                         16,
                                      //                         allowFontScalingSelf:
                                      //                             true),
                                      //                   ),
                                      //                 ),
                                      //               ),
                                      //               SizedBox(
                                      //                 height:
                                      //                     ScreenUtil()
                                      //                         .setHeight(
                                      //                             25),
                                      //               ),
                                      //               Divider(
                                      //                 color: Colors
                                      //                     .black,
                                      //                 thickness: 0.8,
                                      //               ),
                                      //               GestureDetector(
                                      //                 onTap:
                                      //                     () async {
                                      //                   final i = await picker
                                      //                       .getImage(
                                      //                           source:
                                      //                               ImageSource.gallery);
                                      //                   print(i.path);
                                      //                   if (i.path !=
                                      //                       null) {
                                      //                     setState(
                                      //                         () {
                                      //                       isLoadingimage =
                                      //                           true;
                                      //                     });
                                      //                     try {
                                      //                       if (context !=
                                      //                           null)
                                      //                         print(
                                      //                             "SDCD");
                                      //                       await Provider.of<UserInfo>(context, listen: false).changeImage(
                                      //                           context:
                                      //                               context,
                                      //                           image:
                                      //                               File(i.path));
                                      //                       await Provider.of<UserInfo>(
                                      //                               context,
                                      //                               listen:
                                      //                                   false)
                                      //                           .getuser(
                                      //                               context);

                                      //                       // image = File(
                                      //                       //     i.path);
                                      //                     } catch (err) {
                                      //                       dataSelect(
                                      //                           context:
                                      //                               context,
                                      //                           titleText:
                                      //                               'Alert!',
                                      //                           buttonText:
                                      //                               'Okay',
                                      //                           contentText: err
                                      //                               .toString(),
                                      //                           onPressed:
                                      //                               () {
                                      //                             Navigator.pop(context);
                                      //                           },
                                      //                           gif:
                                      //                               "assets/images/alert.gif");
                                      //                     } finally {
                                      //                       Navigator.pop(
                                      //                           context);
                                      //                       setState(
                                      //                           () {
                                      //                         isLoadingimage =
                                      //                             false;
                                      //                       });
                                      //                     }
                                      //                   }
                                      //                 },
                                      //                 child: Text(
                                      //                   'Gallery',
                                      //                   style:
                                      //                       TextStyle(
                                      //                     fontFamily:
                                      //                         "Gilroy Regular",
                                      //                     fontSize: ScreenUtil().setSp(
                                      //                         12,
                                      //                         allowFontScalingSelf:
                                      //                             true),
                                      //                   ),
                                      //                 ),
                                      //               ),
                                      //               Divider(
                                      //                 color: Colors
                                      //                     .black,
                                      //                 thickness: 0.8,
                                      //               ),
                                      //               GestureDetector(
                                      //                 onTap:
                                      //                     () async {
                                      //                   final i = await picker
                                      //                       .getImage(
                                      //                           source:
                                      //                               ImageSource.camera);

                                      //                   if (i.path !=
                                      //                       null) {
                                      //                     try {
                                      //                       setState(
                                      //                           () {
                                      //                         isLoadingimage =
                                      //                             true;
                                      //                       });
                                      //                       if (context !=
                                      //                           null)
                                      //                         await Provider.of<UserInfo>(context, listen: false).changeImage(
                                      //                             context:
                                      //                                 context,
                                      //                             image:
                                      //                                 File(i.path));
                                      //                       await Provider.of<UserInfo>(
                                      //                               context,
                                      //                               listen:
                                      //                                   false)
                                      //                           .getuser(
                                      //                               context);

                                      //                       image = File(
                                      //                           i.path);
                                      //                     } catch (err) {
                                      //                       dataSelect(
                                      //                           context:
                                      //                               context,
                                      //                           titleText:
                                      //                               'Alert!',
                                      //                           buttonText:
                                      //                               'Okay',
                                      //                           contentText: err
                                      //                               .toString(),
                                      //                           onPressed:
                                      //                               () {
                                      //                             Navigator.pop(context);
                                      //                           },
                                      //                           gif:
                                      //                               "assets/images/alert.gif");
                                      //                     } finally {
                                      //                       Navigator.pop(
                                      //                           context);
                                      //                       setState(
                                      //                           () {
                                      //                         isLoadingimage =
                                      //                             false;
                                      //                       });
                                      //                     }
                                      //                   }
                                      //                 },
                                      //                 child: Text(
                                      //                   'Camera',
                                      //                   style:
                                      //                       TextStyle(
                                      //                     fontFamily:
                                      //                         "Gilroy Regular",
                                      //                     fontSize: ScreenUtil().setSp(
                                      //                         12,
                                      //                         allowFontScalingSelf:
                                      //                             true),
                                      //                   ),
                                      //                 ),
                                      //               ),
                                      //               SizedBox(
                                      //                 height:
                                      //                     ScreenUtil()
                                      //                         .setHeight(
                                      //                             15),
                                      //               ),
                                      //             ],
                                      //           ),
                                      //         ),
                                      //       ],
                                      //     );
                                      //   },
                                      //             // );
                                      //           },
                                      //         ),
                                      //         FlatButton(
                                      //           child: Text("NO"),
                                      //           onPressed: () {
                                      //             Navigator.of(context).pop();
                                      //           },
                                      //         ),
                                      //         FlatButton(
                                      //           child: Text("CANCEL"),
                                      //           onPressed: () {
                                      //             Navigator.of(context).pop();
                                      //           },
                                      //         ),
                                      //       ],
                                      //     );
                                      //   },
                                      // );
                                    },
                                    child: isLoadingimage
                                        ? Center(
                                            child: CircularProgressIndicator(),
                                          )
                                        : Container(
                                            height: ScreenUtil().setHeight(58),
                                            width: ScreenUtil().setWidth(58),
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              image: DecorationImage(
                                                fit: BoxFit.fill,
                                                image: AdvancedNetworkImage(
                                                  Provider.of<UserInfo>(context,
                                                          listen: true)
                                                      .profileImage,
                                                  useDiskCache: true,
                                                  cacheRule: CacheRule(
                                                    maxAge:
                                                        const Duration(days: 3),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: ScreenUtil().setWidth(11),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    Provider.of<UserInfo>(context, listen: true)
                                        .fullname,
                                    style: TextStyle(
                                      fontFamily: 'Gilroy Bold',
                                      fontSize: ScreenUtil().setSp(22,
                                          allowFontScalingSelf: true),
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(
                                    height: ScreenUtil().setHeight(
                                        Provider.of<Pagination>(context,
                                                    listen: false)
                                                .isVerified
                                            ? 5
                                            : 0),
                                  ),
                                  Provider.of<Pagination>(context,
                                              listen: false)
                                          .isVerified
                                      ? Text(
                                          Provider.of<UserInfo>(context,
                                                  listen: true)
                                              .firm,
                                          style: TextStyle(
                                            fontFamily: 'Gilroy Bold',
                                            fontSize: ScreenUtil().setSp(10,
                                                allowFontScalingSelf: true),
                                            color: Colors.white,
                                          ),
                                        )
                                      : SizedBox(
                                          height: 0.0,
                                        ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            height: ScreenUtil().setHeight(34),
                          ),
                          Provider.of<Pagination>(context, listen: false)
                                  .isVerified
                              ? Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    // SizedBox(
                                    //   width: ScreenUtil().setWidth(46),
                                    // ),
                                    GestureDetector(
                                      onTap: () async {
                                        if (!Provider.of<Pagination>(context,
                                                listen: false)
                                            .isVerified) {
                                          if (storeCheckValue) {
                                          } else {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    CompleteSignUp(),
                                              ),
                                            );
                                          }
                                        } else if (!Provider.of<Pagination>(
                                                context,
                                                listen: false)
                                            .isPriced) {
                                          try {
                                            String date =
                                                await Provider.of<UserInfo>(
                                                        context,
                                                        listen: false)
                                                    .getPriceDate();
                                            if (date != null) {
                                              int d = DateTime.now()
                                                  .difference(
                                                      DateTime.parse(date))
                                                  .inDays;
                                              if (d >= 1) {
                                                dataSelect(
                                                    context: context,
                                                    titleText: 'Important!',
                                                    buttonText:
                                                        'Request Prices',
                                                    contentText:
                                                        "To see prices you must first request a quotation from Team Gemstory",
                                                    onPressed: requestPrice,
                                                    gif:
                                                        "assets/images/alert.gif");
                                              } else {
                                                dataSelect(
                                                    context: context,
                                                    titleText: 'Alert!',
                                                    buttonText: 'Okay',
                                                    contentText:
                                                        'Request has already been noted!',
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    gif:
                                                        "assets/images/identi.gif");
                                              }
                                            } else {
                                              dataSelect(
                                                  context: context,
                                                  titleText: 'Important!',
                                                  buttonText: 'Request Prices',
                                                  contentText:
                                                      "To see prices you must first request a quotation from Team Gemstory",
                                                  onPressed: requestPrice,
                                                  gif:
                                                      "assets/images/alert.gif");
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
                                        } else {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => MyOrder(),
                                            ),
                                          );
                                        }
                                      },
                                      child: Column(
                                        children: <Widget>[
                                          // ShaderMask(
                                          // shaderCallback: (bounds) => LinearGradient(
                                          //   colors: [
                                          //     Color(0xFF34BDDD),
                                          //     Color(0xFF367DC8),
                                          //   ],
                                          //   begin: Alignment.topLeft,
                                          //   end: Alignment.bottomRight,
                                          // ).createShader(
                                          //   Rect.fromLTWH(
                                          //       0, 0, bounds.width, bounds.height),
                                          // ),
                                          SvgPicture.asset(
                                            'assets/icons/orders.svg',
                                            height: ScreenUtil().setHeight(40),
                                            width: ScreenUtil().setWidth(38),
                                            // color: Colors.white,
                                          ),
                                          // ),
                                          SizedBox(
                                            height: ScreenUtil().setHeight(17),
                                          ),
                                          Text(
                                            'ORDERS',
                                            style: TextStyle(
                                              fontFamily: 'Gilroy Bold',
                                              fontSize: ScreenUtil().setSp(16,
                                                  allowFontScalingSelf: true),
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () async {
                                        if (!Provider.of<Pagination>(context,
                                                listen: false)
                                            .isVerified) {
                                          String date =
                                              await Provider.of<UserInfo>(
                                                      context,
                                                      listen: false)
                                                  .getDate();
                                          if (date != null) {
                                            int d = DateTime.now()
                                                .difference(
                                                    DateTime.parse(date))
                                                .inDays;
                                            if (d >= 1) {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      CompleteSignUp(),
                                                ),
                                              );
                                            } else {
                                              dataSelect(
                                                  context: context,
                                                  titleText: 'Alert!',
                                                  buttonText: 'Okay',
                                                  contentText:
                                                      'Request has already been noted!',
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  gif:
                                                      "assets/images/identi.gif");
                                            }
                                          } else {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    CompleteSignUp(),
                                              ),
                                            );
                                          }
                                        } else if (!Provider.of<Pagination>(
                                                context,
                                                listen: false)
                                            .isPriced) {
                                          try {
                                            String date =
                                                await Provider.of<UserInfo>(
                                                        context,
                                                        listen: false)
                                                    .getPriceDate();
                                            if (date != null) {
                                              int d = DateTime.now()
                                                  .difference(
                                                      DateTime.parse(date))
                                                  .inDays;
                                              if (d >= 1) {
                                                dataSelect(
                                                    context: context,
                                                    titleText: 'Important!',
                                                    buttonText:
                                                        'Request Prices',
                                                    contentText:
                                                        "To see prices you must first request a quotation from Team Gemstory",
                                                    onPressed: requestPrice,
                                                    gif:
                                                        "assets/images/alert.gif");
                                              } else {
                                                dataSelect(
                                                    context: context,
                                                    titleText: 'Alert!',
                                                    buttonText: 'Okay',
                                                    contentText:
                                                        'Request has already been noted!',
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    gif:
                                                        "assets/images/identi.gif");
                                              }
                                            } else {
                                              dataSelect(
                                                  context: context,
                                                  titleText: 'Important!',
                                                  buttonText: 'Request Prices',
                                                  contentText:
                                                      "To see prices you must first request a quotation from Team Gemstory",
                                                  onPressed: requestPrice,
                                                  gif:
                                                      "assets/images/alert.gif");
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
                                        } else {
                                          bool value2 = false;

                                          await _showDialog(
                                            globalKey.currentContext,
                                            // 'Alert!',
                                            // "Are you sure, You want to open Whatsapp?",
                                            // 'Open Whatsapp',
                                          ).then((value) async {
                                            if (value) {
                                              setState(() {
                                                value2 = value;
                                              });
                                            }
                                          });
                                          if (value2)
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => MyPrice(
                                                  onButtonTapped:
                                                      widget.onButtonTapped,
                                                ),
                                              ),
                                            );
                                        }
                                      },
                                      child: Column(
                                        children: <Widget>[
                                          SvgPicture.asset(
                                            'assets/icons/price.svg',
                                            height: ScreenUtil().setHeight(40),
                                            width: ScreenUtil().setWidth(38),
                                            // color: Colors.white,
                                          ),
                                          SizedBox(
                                            height: ScreenUtil().setHeight(17),
                                          ),
                                          Text(
                                            'PRICES',
                                            style: TextStyle(
                                              fontFamily: 'Gilroy Bold',
                                              fontSize: 16,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () async {
                                        if (Provider.of<Pagination>(context,
                                                listen: false)
                                            .isVerified)
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  AccountInfo(),
                                            ),
                                          );
                                        else {
                                          String date =
                                              await Provider.of<UserInfo>(
                                                      context,
                                                      listen: false)
                                                  .getDate();
                                          if (date != null) {
                                            int d = DateTime.now()
                                                .difference(
                                                    DateTime.parse(date))
                                                .inDays;
                                            if (d >= 1) {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      CompleteSignUp(),
                                                ),
                                              );
                                            } else {
                                              dataSelect(
                                                  context: context,
                                                  titleText: 'Alert!',
                                                  buttonText: 'Okay',
                                                  contentText:
                                                      'Request has already been noted!',
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  gif:
                                                      "assets/images/identi.gif");
                                            }
                                          } else {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    CompleteSignUp(),
                                              ),
                                            );
                                          }
                                        }
                                      },
                                      child: Column(
                                        children: <Widget>[
                                          SvgPicture.asset(
                                            'assets/icons/accountInfo.svg',
                                            height: ScreenUtil().setHeight(40),
                                            width: ScreenUtil().setWidth(38),
                                            // color: Colors.white,
                                          ),
                                          SizedBox(
                                            height: ScreenUtil().setHeight(17),
                                          ),
                                          Text(
                                            'ACCOUNT',
                                            style: TextStyle(
                                              fontFamily: 'Gilroy Bold',
                                              fontSize: ScreenUtil().setSp(16,
                                                  allowFontScalingSelf: true),
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                TestimonyPage(),
                                          ),
                                        );
                                      },
                                      child: Column(
                                        children: <Widget>[
                                          SvgPicture.asset(
                                            'assets/icons/reviews.svg',
                                            height: ScreenUtil().setHeight(40),
                                            width: ScreenUtil().setWidth(38),
                                            // color: Colors.white,
                                          ),
                                          SizedBox(
                                            height: ScreenUtil().setHeight(17),
                                          ),
                                          Text(
                                            'REVIEWS',
                                            style: TextStyle(
                                              fontFamily: 'Gilroy Bold',
                                              fontSize: ScreenUtil().setSp(16,
                                                  allowFontScalingSelf: true),
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                )
                              : Center(
                                  child: GestureDetector(
                                    onTap: () async {
                                      String date = await Provider.of<UserInfo>(
                                              context,
                                              listen: false)
                                          .getDate();
                                      if (date != null) {
                                        int d = DateTime.now()
                                            .difference(DateTime.parse(date))
                                            .inDays;
                                        if (d >= 1) {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  CompleteSignUp(),
                                            ),
                                          );
                                        } else {
                                          dataSelect(
                                              context: context,
                                              titleText: 'Alert!',
                                              buttonText: 'Okay',
                                              contentText:
                                                  'Request has already been noted!',
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              gif:
                                                  "assets/images/alert.identi");
                                        }
                                      } else {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                CompleteSignUp(),
                                          ),
                                        );
                                      }
                                    },
                                    child: Column(
                                      children: <Widget>[
                                        // ShaderMask(
                                        // shaderCallback: (bounds) => LinearGradient(
                                        //   colors: [
                                        //     Color(0xFF34BDDD),
                                        //     Color(0xFF367DC8),
                                        //   ],
                                        //   begin: Alignment.topLeft,
                                        //   end: Alignment.bottomRight,
                                        // ).createShader(
                                        //   Rect.fromLTWH(
                                        //       0, 0, bounds.width, bounds.height),
                                        // ),
                                        SvgPicture.asset(
                                          'assets/icons/completeSignUp.svg',
                                          height: ScreenUtil().setHeight(40),
                                          width: ScreenUtil().setWidth(38),
                                          color: Colors.white,
                                        ),
                                        // ),
                                        SizedBox(
                                          height: ScreenUtil().setHeight(17),
                                        ),
                                        Text(
                                          'COMPLETE SIGNUP',
                                          style: TextStyle(
                                            fontFamily: 'Gilroy Bold',
                                            fontSize: ScreenUtil().setSp(16,
                                                allowFontScalingSelf: true),
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                          SizedBox(
                            height: ScreenUtil().setHeight(31),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              // SizedBox(
                              //   width: ScreenUtil().setWidth(51),
                              // ),
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  boxShadow: <BoxShadow>[
                                    BoxShadow(
                                        blurRadius: 10,
                                        color: Colors.black.withOpacity(0.37),
                                        offset: Offset(2, 5)),
                                  ],
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                height: ScreenUtil().setHeight(122),
                                width: ScreenUtil().setWidth(129),
                                // padding: EdgeInsets.only(left: 15),
                                child: Material(
                                  type: MaterialType.transparency,
                                  elevation: 6.0,
                                  color: Colors.transparent,
                                  borderRadius: BorderRadius.circular(20),
                                  child: InkWell(
                                    splashColor: Colors.cyan[50],
                                    borderRadius: BorderRadius.circular(20),
                                    onTap: () async {
                                      bool value2 = false;
                                      await dataSelectConfirmMessage(
                                        context: globalKey.currentContext,
                                        titleText: 'Alert!',
                                        contentText:
                                            "Are you sure, You want to open Whatsapp?",
                                        gif: 'assets/images/whatsappGIF.gif',
                                      ).then((value) async {
                                        if (value) {
                                          value2 = value;
                                        }
                                      });
                                      if (value2) {
                                        if (await canLaunch(
                                            "https://api.whatsapp.com/send?phone=919004801229&text=Hi, I want to make my own Design.")) {
                                          await launch(
                                              "https://api.whatsapp.com/send?phone=919004801229&text=Hi, I want to make my own Design.");
                                        } else {
                                          throw 'Could not launch https://api.whatsapp.com/send?phone=919004801229&text=Hi, I want to make my own Design.';
                                        }
                                      }
                                    },
                                    child: Row(
                                      children: <Widget>[
                                        SizedBox(
                                          width: ScreenUtil().setWidth(15),
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            SizedBox(
                                              height:
                                                  ScreenUtil().setHeight(14),
                                            ),
                                            ShaderMask(
                                              shaderCallback: (bounds) =>
                                                  LinearGradient(
                                                colors: [
                                                  Color(0xFF34BDDD),
                                                  Color(0xFF367DC8),
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
                                              child: SvgPicture.asset(
                                                "assets/icons/makeDesign.svg",
                                                height:
                                                    ScreenUtil().setHeight(47),
                                                width:
                                                    ScreenUtil().setWidth(38),
                                                color: Colors.white,
                                              ),
                                            ),
                                            SizedBox(
                                              height:
                                                  ScreenUtil().setHeight(14),
                                            ),
                                            Container(
                                              width: ScreenUtil().setWidth(99),
                                              child: Text(
                                                'MAKE YOUR OWN DESIGN',
                                                style: TextStyle(
                                                  fontFamily: 'Gilroy Medium',
                                                  fontSize: ScreenUtil().setSp(
                                                      12,
                                                      allowFontScalingSelf:
                                                          true),
                                                  color: Colors.black,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: ScreenUtil().setWidth(28),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  boxShadow: <BoxShadow>[
                                    BoxShadow(
                                        blurRadius: 10,
                                        color: Colors.black.withOpacity(0.37),
                                        offset: Offset(2, 5)),
                                  ],
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                height: ScreenUtil().setHeight(122),
                                width: ScreenUtil().setWidth(129),
                                // padding: EdgeInsets.only(left: 15),
                                child: Material(
                                  type: MaterialType.transparency,
                                  elevation: 6.0,
                                  color: Colors.transparent,
                                  borderRadius: BorderRadius.circular(20),
                                  child: InkWell(
                                    splashColor: Colors.cyan[50],
                                    borderRadius: BorderRadius.circular(20),
                                    onTap: () async {
                                      if (!Provider.of<Pagination>(context,
                                              listen: false)
                                          .isVerified) {
                                        if (storeCheckValue) {
                                        } else {
                                          // Navigator.push(
                                          //   context,
                                          //   MaterialPageRoute(
                                          //     builder: (context) =>
                                          //         CompleteSignUp(),
                                          //   ),
                                          // );
                                        }
                                      } else if (!Provider.of<Pagination>(
                                              context,
                                              listen: false)
                                          .isPriced) {
                                        try {
                                          String date =
                                              await Provider.of<UserInfo>(
                                                      context,
                                                      listen: false)
                                                  .getPriceDate();
                                          if (date != null) {
                                            int d = DateTime.now()
                                                .difference(
                                                    DateTime.parse(date))
                                                .inDays;
                                            if (d >= 1) {
                                              dataSelect(
                                                  context: context,
                                                  titleText: 'Important!',
                                                  buttonText: 'Request Prices',
                                                  contentText:
                                                      "To see prices you must first request a quotation from Team Gemstory",
                                                  onPressed: requestPrice,
                                                  gif:
                                                      "assets/images/alert.gif");
                                            } else {
                                              dataSelect(
                                                  context: context,
                                                  titleText: 'Important!',
                                                  buttonText: 'Request Prices',
                                                  contentText:
                                                      "To see prices you must first request a quotation from Team Gemstory",
                                                  onPressed: requestPrice,
                                                  gif:
                                                      "assets/images/alert.gif");
                                              dataSelect(
                                                  context: context,
                                                  titleText: 'Alert!',
                                                  buttonText: 'Okay',
                                                  contentText:
                                                      'Request has already been noted!',
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  gif:
                                                      "assets/images/identi.gif");
                                            }
                                          } else {
                                            dataSelect(
                                                context: context,
                                                titleText: 'Important!',
                                                buttonText: 'Request Prices',
                                                contentText:
                                                    "To see prices you must first request a quotation from Team Gemstory",
                                                onPressed: requestPrice,
                                                gif: "assets/images/alert.gif");
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
                                      } else {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => MyOrder(),
                                          ),
                                        );
                                      }
                                    },
                                    child: Row(
                                      children: <Widget>[
                                        SizedBox(
                                          width: ScreenUtil().setWidth(15),
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            SizedBox(
                                              height:
                                                  ScreenUtil().setHeight(14),
                                            ),
                                            ShaderMask(
                                              shaderCallback: (bounds) =>
                                                  LinearGradient(
                                                colors: [
                                                  Color(0xFF34BDDD),
                                                  Color(0xFF367DC8),
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
                                              child: SvgPicture.asset(
                                                "assets/icons/ordersyet.svg",
                                                height:
                                                    ScreenUtil().setHeight(47),
                                                width:
                                                    ScreenUtil().setWidth(38),
                                                color: Colors.white,
                                              ),
                                            ),
                                            SizedBox(
                                              height:
                                                  ScreenUtil().setHeight(14),
                                            ),
                                            Text(
                                              '9000000',
                                              style: TextStyle(
                                                fontFamily: 'Gilroy Medium',
                                                fontSize: ScreenUtil().setSp(12,
                                                    allowFontScalingSelf: true),
                                                color: Colors.black,
                                              ),
                                            ),
                                            Text(
                                              'ORDERS YET',
                                              style: TextStyle(
                                                fontFamily: 'Gilroy Medium',
                                                fontSize: ScreenUtil().setSp(12,
                                                    allowFontScalingSelf: true),
                                                color: Colors.black,
                                              ),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: ScreenUtil().setHeight(22),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              // SizedBox(
                              //   width: ScreenUtil().setWidth(51),
                              // ),
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  boxShadow: <BoxShadow>[
                                    BoxShadow(
                                        blurRadius: 10,
                                        color: Colors.black.withOpacity(0.37),
                                        offset: Offset(2, 5)),
                                  ],
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                height: ScreenUtil().setHeight(122),
                                width: ScreenUtil().setWidth(129),
                                // padding: EdgeInsets.only(left: 15),
                                child: Material(
                                  type: MaterialType.transparency,
                                  elevation: 6.0,
                                  color: Colors.transparent,
                                  borderRadius: BorderRadius.circular(20),
                                  child: InkWell(
                                    splashColor: Colors.cyan[50],
                                    borderRadius: BorderRadius.circular(20),
                                    onTap: () async {
                                      bool value2 = false;
                                      await dataSelectConfirmMessage(
                                        context: globalKey.currentContext,
                                        titleText: 'Alert!',
                                        contentText:
                                            "Are you sure, You want to open Whatsapp?",
                                        gif: 'assets/images/whatsappGIF.gif',
                                      ).then((value) async {
                                        if (value) {
                                          value2 = value;
                                        }
                                      });
                                      if (value2) {
                                        if (await canLaunch(
                                            "https://api.whatsapp.com/send?phone=919004801229&text=Hi, I want to use my own Diamonds.")) {
                                          await launch(
                                              "https://api.whatsapp.com/send?phone=919004801229&text=Hi, I want to use my own Diamonds.");
                                        } else {
                                          throw 'Could not launch https://api.whatsapp.com/send?phone=919004801229&text=Hi, I want to use my own Diamonds.';
                                        }
                                      }
                                    },
                                    child: Row(
                                      children: <Widget>[
                                        SizedBox(
                                          width: ScreenUtil().setWidth(15),
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            SizedBox(
                                              height:
                                                  ScreenUtil().setHeight(14),
                                            ),
                                            ShaderMask(
                                              shaderCallback: (bounds) =>
                                                  LinearGradient(
                                                colors: [
                                                  Color(0xFF34BDDD),
                                                  Color(0xFF367DC8),
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
                                              child: SvgPicture.asset(
                                                "assets/icons/userDiamonds.svg",
                                                height:
                                                    ScreenUtil().setHeight(46),
                                                width:
                                                    ScreenUtil().setWidth(38),
                                                color: Colors.white,
                                              ),
                                            ),
                                            SizedBox(
                                              height:
                                                  ScreenUtil().setHeight(14),
                                            ),
                                            Container(
                                              width: ScreenUtil().setWidth(99),
                                              child: Text(
                                                'USE YOUR OWN DIAMONDS',
                                                style: TextStyle(
                                                  fontFamily: 'Gilroy Medium',
                                                  fontSize: ScreenUtil().setSp(
                                                      12,
                                                      allowFontScalingSelf:
                                                          true),
                                                  color: Colors.black,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: ScreenUtil().setWidth(28),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  boxShadow: <BoxShadow>[
                                    BoxShadow(
                                        blurRadius: 10,
                                        color: Colors.black.withOpacity(0.37),
                                        offset: Offset(2, 5)),
                                  ],
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                height: ScreenUtil().setHeight(122),
                                width: ScreenUtil().setWidth(129),
                                // padding: EdgeInsets.only(left: 15),
                                child: Material(
                                  type: MaterialType.transparency,
                                  elevation: 6.0,
                                  color: Colors.transparent,
                                  borderRadius: BorderRadius.circular(20),
                                  child: InkWell(
                                    splashColor: Colors.cyan[50],
                                    borderRadius: BorderRadius.circular(20),
                                    onTap: () async {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => TestimonyPage(),
                                        ),
                                      );
                                    },
                                    child: Row(
                                      children: <Widget>[
                                        SizedBox(
                                          width: ScreenUtil().setWidth(15),
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            SizedBox(
                                              height:
                                                  ScreenUtil().setHeight(23),
                                            ),
                                            ShaderMask(
                                              shaderCallback: (bounds) =>
                                                  LinearGradient(
                                                colors: [
                                                  Color(0xFF34BDDD),
                                                  Color(0xFF367DC8),
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
                                              child: SvgPicture.asset(
                                                "assets/icons/userslove.svg",
                                                height:
                                                    ScreenUtil().setHeight(33),
                                                width:
                                                    ScreenUtil().setWidth(38),
                                                color: Colors.white,
                                              ),
                                            ),
                                            SizedBox(
                                              height:
                                                  ScreenUtil().setHeight(20),
                                            ),
                                            Container(
                                              width: ScreenUtil().setWidth(99),
                                              child: Text(
                                                'OUR USERS LOVE US',
                                                style: TextStyle(
                                                  fontFamily: 'Gilroy Medium',
                                                  fontSize: ScreenUtil().setSp(
                                                      12,
                                                      allowFontScalingSelf:
                                                          true),
                                                  color: Colors.black,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: ScreenUtil().setHeight(20),
                          ),
                          Row(
                            children: <Widget>[
                              SizedBox(
                                width: ScreenUtil().setWidth(42),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                    width: ScreenUtil().setWidth(300),
                                    child: Material(
                                      type: MaterialType.transparency,
                                      elevation: 6.0,
                                      color: Colors.transparent,
                                      borderRadius: BorderRadius.circular(30),
                                      child: InkWell(
                                        splashColor: Colors.cyan[50],
                                        borderRadius: BorderRadius.circular(30),
                                        onTap: () {},
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              9, 0, 9, 0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: <Widget>[
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: <Widget>[
                                                  Container(
                                                    margin: EdgeInsets.only(
                                                        right: 6.0),
                                                    height: ScreenUtil()
                                                        .setHeight(22),
                                                    width: ScreenUtil()
                                                        .setWidth(20),
                                                    child: SvgPicture.asset(
                                                      'assets/icons/notificationIcon.svg',
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: ScreenUtil()
                                                        .setWidth(14),
                                                  ),
                                                  Text(
                                                    'NOTIFICATIONS',
                                                    style: TextStyle(
                                                      fontFamily:
                                                          'Gilroy Medium',
                                                      fontSize: ScreenUtil().setSp(
                                                          14,
                                                          allowFontScalingSelf:
                                                              true),
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Switch(
                                                value: isSwitched,
                                                onChanged: (value) async {
                                                  bool value2 = false;
                                                  // if (value2) {
                                                  setState(() {
                                                    isSwitched = value;
                                                    print(isSwitched);
                                                  });
                                                  await dataSelectConfirmMessage(
                                                    context: globalKey
                                                        .currentContext,
                                                    titleText: 'Alert!',
                                                    contentText:
                                                        "Are you sure, you want to turn ${value ? "On" : "Off"} the Notification?",
                                                    gif:
                                                        'assets/images/notification1.gif',
                                                  ).then((value) async {
                                                    setState(() {
                                                      value2 = value;
                                                    });
                                                  });
                                                  // }
                                                  if (!value2) {
                                                    setState(() {
                                                      isSwitched = !value;
                                                      print(isSwitched);
                                                    });
                                                  } else {
                                                    try {
                                                      await Provider.of<
                                                                  UserInfo>(
                                                              context,
                                                              listen: false)
                                                          .notification(
                                                              context: context);
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
                                                  }
                                                },
                                                activeTrackColor:
                                                    Colors.lightBlueAccent[100],
                                                activeColor: Colors.blue,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  // SizedBox(
                                  //   height: ScreenUtil().setHeight(18),
                                  // ),
                                  Container(
                                    width: ScreenUtil().setWidth(300),
                                    child: Material(
                                      type: MaterialType.transparency,
                                      elevation: 6.0,
                                      color: Colors.transparent,
                                      borderRadius: BorderRadius.circular(20),
                                      child: InkWell(
                                        splashColor: Colors.cyan[50],
                                        borderRadius: BorderRadius.circular(20),
                                        onTap: () {},
                                        child: Padding(
                                          padding: const EdgeInsets.all(9),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: <Widget>[
                                              Container(
                                                margin:
                                                    EdgeInsets.only(right: 6.0),
                                                height:
                                                    ScreenUtil().setHeight(22),
                                                width:
                                                    ScreenUtil().setWidth(20),
                                                child: SvgPicture.asset(
                                                  'assets/icons/terms.svg',
                                                  color: Colors.black,
                                                ),
                                              ),
                                              SizedBox(
                                                width:
                                                    ScreenUtil().setWidth(14),
                                              ),
                                              Text(
                                                'TERMS AND PRIVACY',
                                                style: TextStyle(
                                                  fontFamily: 'Gilroy Medium',
                                                  fontSize: ScreenUtil().setSp(
                                                      14,
                                                      allowFontScalingSelf:
                                                          true),
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  // SizedBox(
                                  //   height: ScreenUtil().setHeight(18),
                                  // ),
                                  Container(
                                    width: ScreenUtil().setWidth(300),
                                    child: Material(
                                      type: MaterialType.transparency,
                                      elevation: 6.0,
                                      color: Colors.transparent,
                                      borderRadius: BorderRadius.circular(20),
                                      child: InkWell(
                                        splashColor: Colors.cyan[50],
                                        borderRadius: BorderRadius.circular(20),
                                        onTap: () async {
                                          await dataSelectConfirmMessage(
                                            context: globalKey.currentContext,
                                            titleText: 'Alert!',
                                            contentText:
                                                "Are you sure you want to logout?",
                                            gif:
                                                'assets/images/notification1.gif',
                                          ).then((value) async {
                                            if (value) {
                                              value2 = value;
                                              if (value2) {
                                                // Navigator.of(context).pop();
                                                Navigator.popAndPushNamed(
                                                    context, '/');
                                                Provider.of<Auth>(context,
                                                        listen: false)
                                                    .logout();
                                              }
                                            }
                                          });
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.all(9.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: <Widget>[
                                              Container(
                                                margin:
                                                    EdgeInsets.only(right: 6.0),
                                                height:
                                                    ScreenUtil().setHeight(22),
                                                width:
                                                    ScreenUtil().setWidth(20),
                                                child: Icon(
                                                  Icons.power_settings_new,
                                                  color: Colors.black,
                                                ),
                                              ),
                                              SizedBox(
                                                width:
                                                    ScreenUtil().setWidth(14),
                                              ),
                                              Text(
                                                'LOGOUT',
                                                style: TextStyle(
                                                  fontFamily: 'Gilroy Medium',
                                                  fontSize: ScreenUtil().setSp(
                                                      14,
                                                      allowFontScalingSelf:
                                                          true),
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            height: ScreenUtil().setHeight(32 - 22),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            // text: TextSpan(
                            children: <Widget>[
                              Text(
                                "Handcrafted with ❤ by ",
                                style: TextStyle(
                                  color: Color(0xFF747474),
                                  fontFamily: "Gilroy Medium",
                                  fontSize: ScreenUtil()
                                      .setSp(13, allowFontScalingSelf: true),
                                ),
                              ),
                              GestureDetector(
                                onTap: () async {
                                  if (await canLaunch("https://daxy.in/")) {
                                    await launch("https://daxy.in/");
                                  } else {
                                    throw 'Could not launch https://daxy.in/';
                                  }
                                },
                                child: ShaderMask(
                                  shaderCallback: (bounds) => LinearGradient(
                                    colors: [
                                      Color(0xFF34BDDD),
                                      Color(0xFF367DC8),
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ).createShader(
                                    Rect.fromLTWH(
                                        0, 0, bounds.width, bounds.height),
                                  ),
                                  child: Text(
                                    "Team daxy.in",
                                    style: TextStyle(
                                      color: Colors.white,
                                      decoration: TextDecoration.underline,
                                      fontFamily: "Gilroy Medium",
                                      fontSize: ScreenUtil().setSp(13,
                                          allowFontScalingSelf: true),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                            // ),
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
