import 'package:Flutter/screens/accountinfo.dart';
import 'package:Flutter/screens/testimony_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import '../constant/const.dart';
import '../providers/auth.dart';
import 'accountinfo.dart';
import 'my_price.dart';
import 'my_order.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UserPage extends StatefulWidget {
  final void Function(int) onButtonTapped;

  const UserPage({Key key, this.onButtonTapped}) : super(key: key);
  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage>
    with SingleTickerProviderStateMixin {
  int getColorHexFromStr(String colorStr) {
    colorStr = "FF" + colorStr;
    colorStr = colorStr.replaceAll("#", "");
    int val = 0;
    int len = colorStr.length;
    for (int i = 0; i < len; i++) {
      int hexDigit = colorStr.codeUnitAt(i);
      if (hexDigit >= 48 && hexDigit <= 57) {
        val += (hexDigit - 48) * (1 << (4 * (len - 1 - i)));
      } else if (hexDigit >= 65 && hexDigit <= 70) {
        // A..F
        val += (hexDigit - 55) * (1 << (4 * (len - 1 - i)));
      } else if (hexDigit >= 97 && hexDigit <= 102) {
        // a..f
        val += (hexDigit - 87) * (1 << (4 * (len - 1 - i)));
      } else {
        throw new FormatException("An error occurred when converting a color");
      }
    }
    return val;
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    ScreenUtil.init(
      context,
      width: 411.42857142857144,
      height: 774.8571428571429,
      allowFontScaling: true,
    );
    return Scaffold(
      body: ListView(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          physics: BouncingScrollPhysics(),
          children: <Widget>[
            Column(children: <Widget>[
              Stack(children: <Widget>[
                Container(
                  height: ScreenUtil().setHeight(232.5),
                  width: double.infinity,
                  color: Colors.blue[400],
                ),
                Positioned(
                  bottom: ScreenUtil().setHeight(460),
                  right: ScreenUtil().setWidth(98.64),
                  child: Container(
                    height: ScreenUtil().setHeight(372),
                    width: ScreenUtil().setWidth(398.67),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(200.0),
                        color: Colors.cyan.withOpacity(0.4)),
                  ),
                ),
                Positioned(
                  bottom: ScreenUtil().setHeight(542),
                  right: ScreenUtil().setWidth(-50),
                  child: Container(
                      height: ScreenUtil().setHeight(279),
                      width: ScreenUtil().setWidth(300),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(150.0),
                          color: Colors.cyan.withOpacity(0.5))),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: ScreenUtil().setHeight(25),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Container(
                              // alignment: Alignment.topLeft,
                              margin: EdgeInsets.only(left: 20.0, right: 15.0),
                              height: ScreenUtil().setHeight(70),
                              width: ScreenUtil().setWidth(70),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                // borderRadius: BorderRadius.circular(37.5),
                                border: Border.all(
                                    color: Colors.white,
                                    style: BorderStyle.solid,
                                    width: 3.0),
                                // image: DecorationImage(
                                //   image: AssetImage('assets/images/chris.jpg'),
                                // ),
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'Yash Karade',
                                  style: TextStyle(
                                    fontFamily: 'Gilroy',
                                    fontSize: ScreenUtil()
                                        .setSp(25, allowFontScalingSelf: true),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  'Firm_Name',
                                  style: TextStyle(
                                    fontFamily: 'Gilroy',
                                    fontSize: ScreenUtil()
                                        .setSp(15, allowFontScalingSelf: true),
                                    color: Colors.black.withOpacity(0.7),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                        Container(
                          alignment: Alignment.topRight,
                          child: IconButton(
                            icon: Icon(Icons.settings),
                            onPressed: () {},
                            color: Colors.white,
                            iconSize: ScreenUtil().setSp(30,allowFontScalingSelf: true),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: ScreenUtil().setHeight(10),),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          child: Column(
                            children: <Widget>[
                              IconButton(
                                icon: Icon(Icons.card_travel),
                                color: Colors.white,
                                iconSize: ScreenUtil().setSp(40,allowFontScalingSelf: true),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => MyOrder(),
                                    ),
                                  );
                                },
                              ),
                              Text(
                                'My Orders',
                                style: TextStyle(
                                  fontFamily: 'Gilroy',
                                  fontSize: ScreenUtil().setSp(15,allowFontScalingSelf: true),
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          child: Column(
                            children: <Widget>[
                              IconButton(
                                icon: Icon(Icons.account_balance_wallet),
                                color: Colors.white,
                                iconSize: ScreenUtil().setSp(40,allowFontScalingSelf: true),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => MyPrice(
                                        onButtonTapped: widget.onButtonTapped,
                                      ),
                                    ),
                                  );
                                },
                              ),
                              Text(
                                'My Prices',
                                style: TextStyle(
                                  fontFamily: 'Gilroy',
                                  fontSize: ScreenUtil().setSp(15,allowFontScalingSelf: true),
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          child: Column(
                            children: <Widget>[
                              IconButton(
                                icon: Icon(Icons.computer),
                                color: Colors.white,
                                iconSize: ScreenUtil().setSp(40,allowFontScalingSelf: true),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => AccountInfo(),
                                    ),
                                  );
                                },
                              ),
                              Text(
                                'Account\nDetails',
                                style: TextStyle(
                                  fontFamily: 'Gilroy',
                                  fontSize: ScreenUtil().setSp(15,allowFontScalingSelf: true),
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: ScreenUtil().setHeight(25),),
                    Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            cardDetails(
                              'Options we have',
                              '5',
                              Padding(
                                padding: const EdgeInsets.fromLTRB(
                                    15.0, 20.0, 20.0, 0.0),
                                child: SvgPicture.asset(
                                  "assets/icons/options.svg",
                                  fit: BoxFit.contain,
                                  height: ScreenUtil().setHeight(41),
                                  width: ScreenUtil().setWidth(41),
                                  // height: 41.0,
                                  // width: 41.0,
                                  color: Colors.amber[300],
                                ),
                              ),
                            ),
                            cardDetails(
                              'Orders Placed',
                              // 'assets/images/box.png',
                              '2',
                              Padding(
                                padding: const EdgeInsets.fromLTRB(
                                    15.0, 20.0, 20.0, 0.0),
                                // child: Text(
                                //   '💎',
                                //   style: TextStyle(
                                //     fontSize: 35.0,
                                //   ),
                                // ),
                                child: SvgPicture.asset(
                                  "assets/icons/diamond.svg",
                                  fit: BoxFit.contain,
                                  height: ScreenUtil().setHeight(41),
                                  width: ScreenUtil().setWidth(41),
                                  // height: 41.0,
                                  // width: 41.0,
                                  // color: Colors.amber[300],
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: ScreenUtil().setHeight(10)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            cardDetails(
                              'Nose Pins I like',
                              // 'assets/images/trucks.png',
                              '8',
                              Padding(
                                padding: const EdgeInsets.fromLTRB(
                                    15.0, 15.0, 20.0, 0.0),
                                // child: Text(
                                //   '💙',
                                //   style: TextStyle(
                                //     fontSize: 35.0,
                                //   ),
                                // ),
                                child: Icon(
                                  Icons.favorite,
                                  color: Colors.cyan[200],
                                  size: ScreenUtil().setSp(40,allowFontScalingSelf: true),
                                ),
                              ),
                            ),
                            cardDetails(
                              'Today\'s Gold Price',
                              // 'assets/images/returnbox.png',
                              '0',
                              Padding(
                                padding: const EdgeInsets.fromLTRB(
                                    15.0, 15.0, 20.0, 0.0),
                                child: Icon(
                                  MyFlutterApp.gold_bar,
                                  color: Colors.amber[300],
                                  size: ScreenUtil().setSp(40,allowFontScalingSelf: true),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: ScreenUtil().setHeight(5),)
                      ],
                    ),
                    SizedBox(
                      height: ScreenUtil().setWidth(10),
                    ),
                    ListWidgetUserDetails(
                      // leadingIcon: Icon(
                      //   Icons.thumb_up,
                      //   color: Colors.black,
                      // ),
                      leadingIcon: Padding(
                        padding: const EdgeInsets.all(0.0),
                        child: SvgPicture.asset(
                          "assets/icons/rate.svg",
                          height: ScreenUtil().setHeight(38.75),
                          width: ScreenUtil().setWidth(20.55),
                        ),
                      ),
                      text: "Testimonies",
                      tap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TestimonyPage(),
                          ),
                        );
                      },
                    ),
                    ListWidgetUserDetails(
                      leadingIcon: Padding(
                        padding: const EdgeInsets.only(left: 5.0),
                        child: SvgPicture.asset(
                          "assets/icons/logout1.svg",
                          height: ScreenUtil().setHeight(31),
                          width: ScreenUtil().setWidth(16.44),
                        ),
                      ),
                      text: "Logout",
                      tap: () {
                        Provider.of<Auth>(context,listen:false).logout();
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) => MyPrice(),
                        //   ),
                        // );
                      },
                    ),
                  ],
                )
              ]),
            ])
          ]),
    );
  }

  Widget cardDetails(String title, String valueCount, Widget iconWidget) {
    var size = MediaQuery.of(context).size;
    return Material(
      elevation: 4.0,
      borderRadius: BorderRadius.circular(7.0),
      child: Container(
        height: ScreenUtil().setHeight(135),
        width: ScreenUtil().setWidth(185),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(7.0), color: Colors.white),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // SizedBox(height: 5.0),
            iconWidget,
            SizedBox(height: ScreenUtil().setHeight(14),),
            Padding(
              padding: EdgeInsets.only(left: 15.0),
              child: Text(
                title,
                style: TextStyle(
                  fontFamily: 'Gilroy',
                  fontSize: ScreenUtil().setSp(17,allowFontScalingSelf: true),
                  color: Colors.black,
                ),
              ),
            ),
            SizedBox(height: 3.0),
            Padding(
              padding: EdgeInsets.only(left: 15.0),
              child: Text(
                valueCount,
                style: TextStyle(
                  fontFamily: 'Gilroy',
                  fontSize: ScreenUtil().setSp(19,allowFontScalingSelf: true),
                  color: kPrimaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ListWidgetUserDetails extends StatefulWidget {
  final Padding leadingIcon;
  final String text;
  final Function tap;

  const ListWidgetUserDetails({Key key, this.leadingIcon, this.text, this.tap})
      : super(key: key);
  @override
  _ListWidgetUserDetailsState createState() => _ListWidgetUserDetailsState();
}

class _ListWidgetUserDetailsState extends State<ListWidgetUserDetails> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      // margin: EdgeInsets.all(4.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18.0),
        // boxShadow: <BoxShadow>[
        //   BoxShadow(
        //     color: Colors.black12,
        //     blurRadius: 10.0,
        //     offset: Offset(0.0, 10.0),
        //   ),
        // ],
      ),
      width: ScreenUtil().setWidth(411),
      height: ScreenUtil().setHeight(70),
      child: Center(
        child: ListTile(
          leading: widget.leadingIcon,
          onTap: widget.tap,
          trailing: Icon(
            Icons.arrow_forward_ios,
            color: Colors.black,
          ),
          title: Text(
            widget.text,
            style: TextStyle(
              fontSize: ScreenUtil().setSp(20,allowFontScalingSelf: true),
              fontFamily: 'Gilroy',
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
