import 'package:Flutter/screens/cart_screen.dart';
import 'package:Flutter/screens/favourite_screen.dart';
import 'package:Flutter/screens/profile_screeen.dart';
import 'package:Flutter/screens/search.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart' as cnb;
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/svg.dart';
import '../constant/const.dart';
import '../constant/const.dart';
import '../constant/const.dart';
import '../constant/const.dart';
import '../constant/const.dart';
import '../providers/user.dart';
import './product_overview_screen.dart';
import 'profile_screeen.dart';
import 'profile_screeen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_animator/flutter_animator.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _bottomNavigationKey = GlobalKey();
  var _currentIndex = 2;
  final controller = ScrollController();
  ScrollController _scrollController;
  bool _visible = true;
  GlobalKey<AnimatorWidgetState> _key = GlobalKey<AnimatorWidgetState>();

  void _onTap(int a) {
    setState(() {
      _currentIndex = a;
    });
  }

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      if (_scrollController.position.userScrollDirection ==
          ScrollDirection.idle) {
        setState(() => _visible = true);
      }
      if (_scrollController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        setState(() => {
              _visible = false,
            });
        // _key.currentState.reverse();
      }
      if (_scrollController.position.userScrollDirection ==
          ScrollDirection.forward) {
        setState(() => {
              _visible = true,
            });
        // _key.currentState.forward();
      }
      // print(_visible);
    });
  }

  @override
  Widget build(BuildContext context) {
    // print(.height);
    ScreenUtil.init(context,
        width: 411.42857142857144,
        height: 774.8571428571429,
        allowFontScaling: true);
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: [
        UserPage(
          onButtonTapped: _onTap,
        ),
        FavouriteScreen(
          scrollController: _scrollController,
          onButtonTapped: _onTap,
          val: _visible,
        ),
        ProductOverViewScreen(
          scrollController: _scrollController,
          onButtonTapped: _onTap,
          val: _visible,
        ),
         Search(
           
        ),

        // Text('Search Screen'),
        // CartScreen(),
      ][_currentIndex],
      bottomNavigationBar: !_visible
          ? FadeOut(
              // preferences: AnimationPreferences(duration: Duration(seconds: 4)),
              child: Container(
                height: 0.0,
                color: Colors.white,
              ),
            )
          : FadeInUp(
              // key: _key,
              preferences:
                  AnimationPreferences(duration: Duration(milliseconds: 100)),
              child: cnb.CurvedNavigationBar(
                onTap: _onTap,
                key: _bottomNavigationKey,
                index: _currentIndex,
                height: ScreenUtil().setHeight(60.0),
                items: <Widget>[
                  Icon(Icons.person, size: ScreenUtil().setSp(35,allowFontScalingSelf: true), color: Colors.white),
                  Icon(Icons.favorite, size: ScreenUtil().setSp(35,allowFontScalingSelf: true), color: Colors.white),
                  Icon(Icons.home, size: ScreenUtil().setSp(35,allowFontScalingSelf: true), color: Colors.white),
                  Icon(Icons.search, size: ScreenUtil().setSp(35,allowFontScalingSelf: true), color: Colors.white),
                  

                  // Icon(Icons.search, size: ScreenUtil().setSp(35,allowFontScalingSelf: true), color: Colors.white),
                  // SvgPicture.asset(
                  //   "assets/icons/customer2.svg",
                  //   fit: BoxFit.contain,
                  //   height: 50.0,
                  //   width: 50.0,
                  // ),
                  Icon(Icons.shopping_cart, size: ScreenUtil().setSp(35,allowFontScalingSelf: true), color: Colors.white),
                ],
                color: kPrimaryColor,
                //,
                buttonBackgroundColor: kPrimaryColor,
                backgroundColor: Color.fromRGBO(255, 255, 255, 1),
                // Color(0xFF398AE5),s
                animationCurve: Curves.easeInOut,
                animationDuration: Duration(milliseconds: 600),
              ),
            ),
    );
  }
}
