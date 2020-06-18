import 'package:Flutter/screens/cart_screen.dart';
import 'package:Flutter/screens/favourite_screen.dart';
import 'package:Flutter/screens/profile_screeen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher.dart';
import './product_overview_screen.dart';
import 'profile_screeen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_animator/flutter_animator.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // final controller = ScrollController();
  ScrollController _scrollController;
  bool _visible = true;

  void _onTap(int a) {
    setState(() {
      _currentIndex = a;
    });
  }

  int _currentIndex = 2;
  int _previousIndex = 0;
  PageController pageController = PageController(
    initialPage: 2,
    keepPage: false,
  );
  void pageChanged(int index) {
    setState(() {
      _previousIndex = _currentIndex;
      _currentIndex = index;
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
    // var size = MediaQuery.of(context).size;
    // return Scaffold(
    //   body: [
    //     UserPage(
    //       onButtonTapped: _onTap,
    //     ),
    //     FavouriteScreen(
    //       scrollController: _scrollController,
    //       onButtonTapped: _onTap,
    //       val: _visible,
    //     ),
    //     ProductOverViewScreen(
    //       scrollController: _scrollController,
    //       onButtonTapped: _onTap,
    //       val: _visible,
    //     ),
    //      Search(

    //     ),

    //     // Text('Search Screen'),
    //     // CartScreen(),
    //   ][_currentIndex],
    //   bottomNavigationBar: !_visible
    //       ? FadeOut(
    //           // preferences: AnimationPreferences(duration: Duration(seconds: 4)),
    //           child: Container(
    //             height: 0.0,
    //             color: Colors.white,
    //           ),
    //         )
    //       : FadeInUp(
    //           // key: _key,
    //           preferences:
    //               AnimationPreferences(duration: Duration(milliseconds: 100)),
    //           child: cnb.CurvedNavigationBar(
    //             onTap: _onTap,
    //             key: _bottomNavigationKey,
    //             index: _currentIndex,
    //             height: ScreenUtil().setHeight(60.0),
    //             items: <Widget>[
    //               Icon(Icons.person, size: ScreenUtil().setSp(35,allowFontScalingSelf: true), color: Colors.white),
    //               Icon(Icons.favorite, size: ScreenUtil().setSp(35,allowFontScalingSelf: true), color: Colors.white),
    //               Icon(Icons.home, size: ScreenUtil().setSp(35,allowFontScalingSelf: true), color: Colors.white),
    //               Icon(Icons.search, size: ScreenUtil().setSp(35,allowFontScalingSelf: true), color: Colors.white),

    //               // Icon(Icons.search, size: ScreenUtil().setSp(35,allowFontScalingSelf: true), color: Colors.white),
    //               // SvgPicture.asset(
    //               //   "assets/icons/customer2.svg",
    //               //   fit: BoxFit.contain,
    //               //   height: 50.0,
    //               //   width: 50.0,
    //               // ),
    //               Icon(Icons.shopping_cart, size: ScreenUtil().setSp(35,allowFontScalingSelf: true), color: Colors.white),
    //             ],
    //             color: kPrimaryColor,
    //             //,
    //             buttonBackgroundColor: kPrimaryColor,
    //             backgroundColor: Color.fromRGBO(255, 255, 255, 1),
    //             // Color(0xFF398AE5),s
    //             animationCurve: Curves.easeInOut,
    //             animationDuration: Duration(milliseconds: 600),
    //           ),
    //         ),
    // );
    return Stack(
      alignment: Alignment.bottomCenter,
      children: <Widget>[
        Scaffold(
          // body: _children[_currentIndex],
          body: PageView(
            controller: pageController,
            // allowImplicitScrolling: false,
            physics: NeverScrollableScrollPhysics(),
            onPageChanged: (index) {
              pageChanged(index);
            },
            children: [
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
              Center(child: Text('Navigate to Whatsapp')),
              CartScreen(),
            ],
          ),
        ),
        Container(
          width: ScreenUtil().setWidth(244),
          height: ScreenUtil().setHeight(45),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(50.0),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  blurRadius: 10,
                  color: Colors.black.withOpacity(0.25),
                  offset: Offset(0, 4),
                )
              ]),
          margin: const EdgeInsets.only(bottom: 16.0),
          // padding: const EdgeInsets.all(20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UserPage(
                        pageIndex: _previousIndex,
                        pageController: pageController,
                      ),
                    ),
                  );
                  // pageController.animateToPage(0,
                  //     duration: Duration(milliseconds: 500),
                  //     curve: Curves.ease);
                },
                child: Container(
                  height: ScreenUtil().setHeight(39),
                  padding: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: _currentIndex == 0
                        ? LinearGradient(
                            colors: [
                              Color(0xFF34B0D9),
                              Color(0xFF3685CB),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          )
                        : LinearGradient(
                            colors: [
                              Colors.white,
                              Colors.white,
                            ],
                          ),
                  ),
                  child: ShaderMask(
                    shaderCallback: (bounds) => _currentIndex != 0
                        ? LinearGradient(
                            colors: [
                              Color(0xFF34B0D9),
                              Color(0xFF3685CB),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ).createShader(
                            Rect.fromLTWH(0, 0, bounds.width, bounds.height),
                          )
                        : LinearGradient(
                            colors: [
                              Colors.white,
                              Colors.white,
                            ],
                          ).createShader(
                            Rect.fromLTWH(0, 0, bounds.width, bounds.height),
                          ),
                    child: SvgPicture.asset(
                      'assets/icons/personIcon.svg',
                      color: Colors.white,
                      height: ScreenUtil().setHeight(25),
                      width: ScreenUtil().setWidth(25),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  pageController.animateToPage(1,
                      duration: Duration(milliseconds: 500),
                      curve: Curves.ease);
                },
                child: Container(
                  height: ScreenUtil().setHeight(39),
                  padding: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: _currentIndex == 1
                        ? LinearGradient(
                            colors: [
                              Color(0xFF34B0D9),
                              Color(0xFF3685CB),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          )
                        : LinearGradient(
                            colors: [
                              Colors.white,
                              Colors.white,
                            ],
                          ),
                  ),
                  child: ShaderMask(
                    shaderCallback: (bounds) => _currentIndex != 1
                        ? LinearGradient(
                            colors: [
                              Color(0xFF34B0D9),
                              Color(0xFF3685CB),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ).createShader(
                            Rect.fromLTWH(0, 0, bounds.width, bounds.height),
                          )
                        : LinearGradient(
                            colors: [
                              Colors.white,
                              Colors.white,
                            ],
                          ).createShader(
                            Rect.fromLTWH(0, 0, bounds.width, bounds.height),
                          ),
                    child: SvgPicture.asset(
                      'assets/icons/heartIcon.svg',
                      color: Colors.white,
                      height: ScreenUtil().setHeight(25),
                      width: ScreenUtil().setWidth(25),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  pageController.animateToPage(2,
                      duration: Duration(milliseconds: 500),
                      curve: Curves.ease);
                },
                child: Container(
                  height: ScreenUtil().setHeight(39),
                  padding: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: _currentIndex == 2
                        ? LinearGradient(
                            colors: [
                              Color(0xFF34B0D9),
                              Color(0xFF3685CB),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          )
                        : LinearGradient(
                            colors: [
                              Colors.white,
                              Colors.white,
                            ],
                          ),
                  ),
                  child: ShaderMask(
                    shaderCallback: (bounds) => _currentIndex != 2
                        ? LinearGradient(
                            colors: [
                              Color(0xFF34B0D9),
                              Color(0xFF3685CB),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ).createShader(
                            Rect.fromLTWH(0, 0, bounds.width, bounds.height),
                          )
                        : LinearGradient(
                            colors: [
                              Colors.white,
                              Colors.white,
                            ],
                          ).createShader(
                            Rect.fromLTWH(0, 0, bounds.width, bounds.height),
                          ),
                    child: SvgPicture.asset(
                      'assets/icons/homeIcon.svg',
                      color: Colors.white,
                      height: ScreenUtil().setHeight(25),
                      width: ScreenUtil().setWidth(25),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () async {
                  if (await canLaunch(
                      "https://wa.me/919322244007")) {
                    await launch(
                        "https://wa.me/919322244007");
                  } else {
                    throw 'Could not launch https://wa.me/919322244007';
                  }
                  // pageController.animateToPage(3,
                  //     duration: Duration(milliseconds: 500),
                  //     curve: Curves.ease);
                },
                child: Container(
                  height: ScreenUtil().setHeight(39),
                  padding: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: _currentIndex == 3
                        ? LinearGradient(
                            colors: [
                              Color(0xFF34B0D9),
                              Color(0xFF3685CB),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          )
                        : LinearGradient(
                            colors: [
                              Colors.white,
                              Colors.white,
                            ],
                          ),
                  ),
                  child: ShaderMask(
                    shaderCallback: (bounds) => _currentIndex != 3
                        ? LinearGradient(
                            colors: [
                              Color(0xFF34B0D9),
                              Color(0xFF3685CB),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ).createShader(
                            Rect.fromLTWH(0, 0, bounds.width, bounds.height),
                          )
                        : LinearGradient(
                            colors: [
                              Colors.white,
                              Colors.white,
                            ],
                          ).createShader(
                            Rect.fromLTWH(0, 0, bounds.width, bounds.height),
                          ),
                    child: SvgPicture.asset(
                      'assets/icons/whatsappIcon.svg',
                      color: Colors.white,
                      height: ScreenUtil().setHeight(25),
                      width: ScreenUtil().setWidth(25),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => CartScreen(
                  //       pageIndex: _previousIndex,
                  //       pageController: pageController,
                  //     ),
                  //   ),
                  // );
                  pageController.animateToPage(4,
                      duration: Duration(milliseconds: 500),
                      curve: Curves.ease);
                },
                child: Container(
                  height: ScreenUtil().setHeight(39),
                  padding: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: _currentIndex == 4
                        ? LinearGradient(
                            colors: [
                              Color(0xFF34B0D9),
                              Color(0xFF3685CB),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          )
                        : LinearGradient(
                            colors: [
                              Colors.white,
                              Colors.white,
                            ],
                          ),
                  ),
                  child: ShaderMask(
                    shaderCallback: (bounds) => _currentIndex != 4
                        ? LinearGradient(
                            colors: [
                              Color(0xFF34B0D9),
                              Color(0xFF3685CB),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ).createShader(
                            Rect.fromLTWH(0, 0, bounds.width, bounds.height),
                          )
                        : LinearGradient(
                            colors: [
                              Colors.white,
                              Colors.white,
                            ],
                          ).createShader(
                            Rect.fromLTWH(0, 0, bounds.width, bounds.height),
                          ),
                    child: SvgPicture.asset(
                      'assets/icons/cartIcon.svg',
                      color: Colors.white,
                      height: ScreenUtil().setHeight(25),
                      width: ScreenUtil().setWidth(25),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        // Scaffold(
        //  body: _children[_currentIndex],
        // ),
      ],
    );
  }
}
