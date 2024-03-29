import 'package:Flutter/providers/auth.dart';
import 'package:Flutter/providers/cart.dart';
import 'package:Flutter/providers/pagination.dart';
import 'package:Flutter/providers/user.dart';
import 'package:Flutter/screens/cart_screen.dart';
import 'package:Flutter/screens/favourite_screen.dart';
import 'package:Flutter/screens/profile_screeen.dart';
import 'package:Flutter/widgets/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import './product_overview_screen.dart';
import 'completeSignUp.dart';
import 'profile_screeen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  bool loader = true;

  bool f = true;
  void _onTap(int a) {
    setState(() {
      _currentIndex = a;
    });
  }

  int _currentIndex = 2;
  int _previousIndex = 0;
  bool check = false;

  ScrollController _hideButtonController;
  var _isVisible;

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

  void completeSignUp() async {
    Navigator.of(context).pop();
    String date =
        await Provider.of<UserInfo>(context, listen: false).getDate(context);
    if (date != null) {
      int d = DateTime.now().difference(DateTime.parse(date)).inDays;
      if (d >= 1) {
        await Provider.of<UserInfo>(context, listen: false).getuser(context);

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CompleteSignUp(),
          ),
        );
      } else {
        dataSelect(
            context: context,
            titleText: 'Alert!',
            buttonText: 'Okay',
            contentText: 'Request has already been noted!',
            onPressed: () {
              Navigator.pop(context);
            },
            gif: "assets/images/identi.gif");
      }
    } else {
      await Provider.of<UserInfo>(context, listen: false).getuser(context);

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CompleteSignUp(),
        ),
      );
    }
  }

  AnimationController controller;
  Animation<double> heightAnimation;
  Animation<double> opacity;

  @override
  void initState() {
    super.initState();
    _isVisible = true;
    controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 600),
      reverseDuration: Duration(milliseconds: 600),
    );

    opacity = Tween<double>(
      end: 0.0,
      begin: 1.0,
    ).animate(CurvedAnimation(
        curve: Curves.easeIn,
        parent: controller,
        reverseCurve: Curves.easeOut));
    heightAnimation =
        Tween(begin: _isVisible ? 45.0 : 0.0, end: _isVisible ? 0.0 : 45.0)
            .animate(CurvedAnimation(
                curve: Curves.easeIn,
                parent: controller,
                reverseCurve: Curves.easeOut));
    _hideButtonController = ScrollController();
    _hideButtonController.addListener(() {
      if (_hideButtonController.position.userScrollDirection ==
          ScrollDirection.idle) {
        setState(() {
          _isVisible = true;
          // print("**** $_isVisible down");
          controller.reverse();
          // controller.animateTo(0.0);
        });
      } else if (_hideButtonController.position.pixels > 250.0 &&
          _hideButtonController.position.userScrollDirection ==
              ScrollDirection.reverse) {
        if (_isVisible)
          setState(() {
            _isVisible = false;

            // print("**** $_isVisible up");
            controller.forward(from: 0.0);
            // controller.animateTo(1);
          });
      } else if (_hideButtonController.position.userScrollDirection ==
          ScrollDirection.forward) {
        if (!_isVisible)
          setState(() {
            _isVisible = true;
            // print("**** $_isVisible down");
            controller.reverse();
            // controller.animateTo(0.0);
          });
      }
    });

    Future.delayed(Duration(seconds: 0), () async {
      var status = await OneSignal.shared.getPermissionSubscriptionState();
      var playerId = status.subscriptionStatus.userId;
      if (context != null)
        await Provider.of<Auth>(context, listen: false)
            .sendPlayerId(context: context, playerId: playerId);
    });
  }

  // @override
  // void didChangeDependencies() async {
  //   super.didChangeDependencies();

  // }

  void loade(isLoading) {
    if (mounted)
      setState(() {
        loader = isLoading;
      });
  }

  GlobalKey globalKey = GlobalKey();

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
    _hideButtonController.dispose();
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
    //    e       // key: _key,
    //           preferences:
    //               AnimationPreferences(duration: Duration(milliseconds: 100)),
    //           child: cnb.CurvedNavigationBar(
    //             onTap: _onTap,
    //             key: _bottomNavigationKey,
    //             index: _currentIndex,
    //             height: ScreenUtil().setHeight(60.0),
    //             items: <Widget>[
    //               Icon(Icons.person, size: ScrenUtil().setSp(35,allowFontScalingSelf: true), color: Colors.white),
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
    return WillPopScope(
      onWillPop: () async {
        // bool value2 = false;
        // dataSelectConfirmMessage(context, "Alert!",
        //         "Are your sure you want to exit the App?", "buttonText")
        //     .then((value) {
        //   setState(() {
        //     value2 = value;
        //   });
        // });
        // if (value2) {
        await dataSelectConfirmMessageExit(
          context: globalKey.currentContext,
          titleText: 'Alert!',
          contentText: "Are you sure you want to exit the app?",
          // gif:
          //     'assets/images/notification1.gif',
        ).then((value) async {
          if (value) {
            SystemNavigator.pop();
          }
        });
        // }
      },
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          Scaffold(
            key: globalKey,
            resizeToAvoidBottomInset: false,
            resizeToAvoidBottomPadding: false,
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
                  cont: context,
                ),
                FavouriteScreen(
                  // scrollController: _hideButtonController,
                  onButtonTapped: _onTap,
                  val: _isVisible,
                  pageController: pageChanged,
                  pageControllerValue: pageController,
                ),
                ProductOverViewScreen(
                  scrollController: _hideButtonController,
                  opacityAnimation: opacity,
                  onButtonTapped: _onTap,
                  val: _isVisible,
                  loader: loade,
                ),
                // if(check==false)
                CartScreen(),
                Center(child: Text('Navigate to Whatsapp')),
              ],
            ),
          ),
          loader
              ? Text('')
              : FadeTransition(
                  opacity: heightAnimation,
                  child: Container(
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
                          onTap: _isVisible
                              ? () {
                                  // Navigator.push(
                                  //   context,
                                  //   MaterialPageRoute(
                                  //     builder: (context) => UserPage(
                                  //       pageIndex: _previousIndex,
                                  //       pageController: pageController,
                                  //     ),
                                  //   ),
                                  // );
                                  pageController.jumpToPage(
                                    0,
                                  );
                                }
                              : null,
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
                                      Rect.fromLTWH(
                                          0, 0, bounds.width, bounds.height),
                                    )
                                  : LinearGradient(
                                      colors: [
                                        Colors.white,
                                        Colors.white,
                                      ],
                                    ).createShader(
                                      Rect.fromLTWH(
                                          0, 0, bounds.width, bounds.height),
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
                          onTap: _isVisible
                              ? () {
                                  pageController.jumpToPage(
                                    1,
                                  );
                                }
                              : null,
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
                                      Rect.fromLTWH(
                                          0, 0, bounds.width, bounds.height),
                                    )
                                  : LinearGradient(
                                      colors: [
                                        Colors.white,
                                        Colors.white,
                                      ],
                                    ).createShader(
                                      Rect.fromLTWH(
                                          0, 0, bounds.width, bounds.height),
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
                          onTap: _isVisible
                              ? () {
                                  pageController.jumpToPage(
                                    2,
                                  );
                                }
                              : null,
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
                                      Rect.fromLTWH(
                                          0, 0, bounds.width, bounds.height),
                                    )
                                  : LinearGradient(
                                      colors: [
                                        Colors.white,
                                        Colors.white,
                                      ],
                                    ).createShader(
                                      Rect.fromLTWH(
                                          0, 0, bounds.width, bounds.height),
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
                          onTap: _isVisible
                              ? () async {
                                  if (Provider.of<Pagination>(context,
                                              listen: false)
                                          .isVerified ==
                                      false) {
                                    // Navigator.push(
                                    //   context,
                                    //   MaterialPageRoute(
                                    //     builder: (context) => CartScreen(
                                    //       pageIndex: _previousIndex,
                                    //       pageController: pageController,
                                    //     ),
                                    //   ),
                                    // );
                                    var date = await Provider.of<UserInfo>(
                                            context,
                                            listen: false)
                                        .getDate(context);
                                    if (date != null) {
                                      int d = DateTime.now()
                                          .difference(DateTime.parse(date))
                                          .inDays;
                                      if (d < 1) {
                                        f = false;
                                        dataSelect(
                                            context: context,
                                            titleText: 'Alert!',
                                            buttonText: 'Okay',
                                            contentText:
                                                'Request has already been noted!',
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            gif: "assets/images/identi.gif");
                                      }
                                    }
                                  }
                                  if (f == true) {
                                    if (!Provider.of<Pagination>(context,
                                                listen: false)
                                            .isVerified &&
                                        f == true) {
                                      dataSelect(
                                          context: context,
                                          titleText: 'Important!',
                                          buttonText: 'Complete SignUp',
                                          contentText:
                                              'To get complete access of the app, you need to first verify yourself!',
                                          onPressed: completeSignUp,
                                          gif: "assets/images/alert.gif");
                                    } else {
                                      pageController.jumpToPage(
                                        3,
                                      );
                                    }
                                  }
                                }
                              : null,
                          child: Container(
                            height: ScreenUtil().setHeight(39),
                            padding: EdgeInsets.all(_currentIndex != 3 &&
                                    Provider.of<Cart>(context, listen: true)
                                            .cart
                                            .length >
                                        0
                                ? 2.0
                                : 8.0),
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
                                      Rect.fromLTWH(
                                          0, 0, bounds.width, bounds.height),
                                    )
                                  : LinearGradient(
                                      colors: [
                                        Colors.white,
                                        Colors.white,
                                      ],
                                    ).createShader(
                                      Rect.fromLTWH(
                                          0, 0, bounds.width, bounds.height),
                                    ),
                              child: _currentIndex != 3 &&
                                      Provider.of<Cart>(context, listen: true)
                                              .cart
                                              .length >
                                          0
                                  ? SvgPicture.asset(
                                      'assets/icons/cartIconPulse.svg',
                                      color: Colors.white,
                                      height: ScreenUtil().setHeight(25),
                                      width: ScreenUtil().setWidth(25),
                                    )
                                  : SvgPicture.asset(
                                      'assets/icons/cartIcon.svg',
                                      color: Colors.white,
                                      height: ScreenUtil().setHeight(25),
                                      width: ScreenUtil().setWidth(25),
                                    ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: _isVisible
                              ? () async {
                                  bool value2 = false;
                                  await dataSelectConfirmMessage(
                                    context: globalKey.currentContext,
                                    titleText: 'Alert!',
                                    contentText:
                                        "Are you sure, You want to open Whatsapp?",
                                    gif: 'assets/images/whatsappGIF.gif',
                                  ).then((value) async {
                                    // if (value) {
                                    value2 = value;
                                    // }
                                  });
                                  if (value2 != null && value2) {
                                    if (await canLaunch(
                                        "https://api.whatsapp.com/send?phone=919004801229&text=Hello, I like your App.")) {
                                      await launch(
                                          "https://api.whatsapp.com/send?phone=919004801229&text=Hello, I like your App.");
                                    } else {
                                      throw 'Could not launch https://api.whatsapp.com/send?phone=919004801229&text=Hello, I like your App.';
                                    }
                                  }
                                  // pageController.animateToPage(3,
                                  //     duration: Duration(milliseconds: 500),
                                  //     curve: Curves.ease);
                                }
                              : null,
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
                                      Rect.fromLTWH(
                                          0, 0, bounds.width, bounds.height),
                                    )
                                  : LinearGradient(
                                      colors: [
                                        Colors.white,
                                        Colors.white,
                                      ],
                                    ).createShader(
                                      Rect.fromLTWH(
                                          0, 0, bounds.width, bounds.height),
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
                      ],
                    ),
                  ),
                ),
          // Scaffold(
          //  body: _children[_currentIndex],
          // ),
        ],
      ),
    );
  }
}
