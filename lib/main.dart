import 'dart:math';
import 'package:Flutter/providers/cart.dart';
import 'package:Flutter/providers/options.dart';
import 'package:Flutter/providers/pagination.dart';
import 'package:Flutter/providers/search.dart';
import 'package:Flutter/providers/user.dart';
import 'package:Flutter/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './screens/auth_screen.dart';
import './providers/products.dart';
import './providers/auth.dart';
import './screens/home.dart';
//<uses-permission android:name="android.permission.INTERNET" />

// void main() => runApp(MyApp());

int initScreen3;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  initScreen3 = await prefs.getInt("initScreen3");
  await prefs.setInt("initScreen3", 1);
  // print('initScreen3 ${initScreen3}');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(

    // ));
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Auth(),
        ),
        ChangeNotifierProvider.value(value: UserInfo()),
        ChangeNotifierProvider.value(value: Products()),
        ChangeNotifierProvider.value(value: Cart()),
        ChangeNotifierProvider.value(value: Searchh()),
        ChangeNotifierProvider.value(value: Pagination()),
        ChangeNotifierProvider.value(value: Options()),
      ],
      child: Consumer<Auth>(
        builder: (ctx, auth, _) => MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primaryColor: Color(0xFFD06AA9),
          ),
          initialRoute: initScreen3 == 0 || initScreen3 == null ? "first" : "/",
          routes: {
            '/': (context) => auth.isAuth
                ? Home()
                : FutureBuilder(
                    future: auth.tryAutoLogin(context),
                    builder: (ctx, authResultSnapshot) =>
                        authResultSnapshot.connectionState ==
                                ConnectionState.waiting
                            ? SplashScreen():
                            // : authResultSnapshot.data ? 
                            Home()
                            //  : LoginScreen(),
                  ),
            "first": (context) => OnboardingScreen(),
          },
        ),
      ),
    );
  }
}

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {

  int page = 0;
  LiquidController liquidController;
  UpdateType updateType;

  @override
  void initState() {
    liquidController = LiquidController();
    super.initState();
  }

  Widget _buildDot(int index) {
    double selectedness = Curves.easeOut.transform(
      max(
        0.0,
        1.0 - ((page ?? 0) - index).abs(),
      ),
    );
    double zoom = 1.0 + (2.0 - 1.0) * selectedness;
    return new Container(
      width: ScreenUtil().setWidth(20),
      child: new Center(
        child: new Material(
          color: page == 1 ? Color(0xFFFAAB35) : Colors.black,
          type: MaterialType.circle,
          child: new Container(
            width: 5.0 * zoom,
            height: 5.0 * zoom,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        width: 411.42857142857144,
        height: 774.8571428571429,
        allowFontScaling: true);
    final pages = [
      Container(
        width: ScreenUtil().setWidth(411),
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            // Image.asset(
            //   'assets/images/1.png',
            //   fit: BoxFit.cover,
            // ),
            Padding(
              padding: const EdgeInsets.only(top: 260.0, bottom: 30.0),
              child: Image.asset(
                "assets/images/group7_gradient.png",
                fit: BoxFit.contain,
                height: ScreenUtil().setHeight(131),
                width: ScreenUtil().setWidth(131),
              ),
            ),
            Text(
              'GEMSTORY',
              style: TextStyle(
                fontFamily: 'Gilroy Black',
                color: Colors.black,
                fontSize: ScreenUtil().setSp(35,allowFontScalingSelf: true),
                fontWeight: FontWeight.w800,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(110.0),
            ),
            Text(
              '"Craft of Perfection"',
              style: TextStyle(
                  fontSize: ScreenUtil().setSp(24,allowFontScalingSelf: true),
                  color: Colors.black,
                  fontFamily: 'Gilroy'),
            ),
          ],
        ),
      ),
      Container(
        width: ScreenUtil().setWidth(411),
        color: Colors.black,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            // Image.asset(
            //   'assets/1.png',
            //   fit: BoxFit.cover,
            // ),
            Padding(
              padding: const EdgeInsets.only(top: 260.0, bottom: 30.0),
              child: Image.asset(
                "assets/images/group7_gradient.png",
                fit: BoxFit.contain,
                height: ScreenUtil().setHeight(131),
                width: ScreenUtil().setWidth(131),
              ),
            ),
            Text(
              'GEMSTORY',
              style: TextStyle(
                fontFamily: 'Gilroy Black',
                color: Color(0xFFFAAB35),
                fontSize: ScreenUtil().setSp(35,allowFontScalingSelf: true),
                fontWeight: FontWeight.w800,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(110.0),
            ),
            Text(
              '"Craft of Perfection"',
              style: TextStyle(
                  fontSize: ScreenUtil().setSp(24,allowFontScalingSelf: true),
                  color: Color(0xFFFAAB35),
                  fontFamily: 'Gilroy'),
            ),
          ],
        ),
      ),
      Container(
        width: ScreenUtil().setWidth(411),
        // color: Colors.greenAccent,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xff52DED5),
              Color(0xff4B9FE1),
            ],
            stops: [0.35, 0.8],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            // Image.asset(
            //   'assets/1.png',
            //   fit: BoxFit.cover,
            // ),
            Padding(
              padding: const EdgeInsets.only(top: 260.0, bottom: 30.0),
              child: Image.asset(
                "assets/images/group7.png",
                fit: BoxFit.contain,
                height: ScreenUtil().setHeight(131),
                width: ScreenUtil().setWidth(131),
              ),
            ),
            Text(
              'GEMSTORY',
              style: TextStyle(
                fontFamily: 'Gilroy Black',
                color: Colors.black,
                fontSize: ScreenUtil().setSp(35,allowFontScalingSelf: true),
                fontWeight: FontWeight.w800,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(110.0),
            ),
            Text(
              '"Craft of Perfection"',
              style: TextStyle(
                  fontSize: ScreenUtil().setSp(24,allowFontScalingSelf: true),
                  color: Colors.black,
                  fontFamily: 'Gilroy'),
            ),
          ],
        ),
      ),
    ];
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Stack(
          children: <Widget>[
            LiquidSwipe(
              pages: pages,
              fullTransitionValue: 1200,
              enableSlideIcon: page == 2 ? false : true,
              enableLoop: false,
              positionSlideIcon: 0.5,
              onPageChangeCallback: pageChangeCallback,
              currentUpdateTypeCallback: updateTypeCallback,
              waveType: WaveType.liquidReveal,
              liquidController: liquidController,
              initialPage: 0,
              slideIconWidget: Icon(
                Icons.arrow_back_ios,
                color: page == 1 ? Colors.white : Colors.black,
              ),
            ),
            Positioned(
              top: ScreenUtil().setHeight(40),
              right: ScreenUtil().setWidth(10),
              // alignment: Alignment.topRight,
              child: FlatButton(
                onPressed: () {
                  if (page != 2) {
                    liquidController.animateToPage(
                        page: pages.length - 1, duration: 500);
                  } else {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginScreen(),
                      ),
                    );
                  }
                },
                child: Text(
                  page == 2 ? "Next" : "skip",
                  style: TextStyle(
                    fontFamily: "Gilroy Black",
                    fontSize: ScreenUtil().setSp(21,allowFontScalingSelf: true),
                    color: page == 1 ? Color(0xFFFAAB35) : Colors.black,
                  ),
                ),
                // color: Colors.white.withOpacity(0.1),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                children: <Widget>[
                  Expanded(child: SizedBox()),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List<Widget>.generate(3, _buildDot),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  pageChangeCallback(int lpage) {
    // print(lpage);
    setState(() {
      page = lpage;
    });
  }

  updateTypeCallback(UpdateType updateType) {
    // print(updateType);
  }
}
