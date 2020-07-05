import 'dart:math';
import 'package:Flutter/providers/cart.dart';
import 'package:Flutter/providers/options.dart';
import 'package:Flutter/providers/order.dart';
import 'package:Flutter/providers/pagination.dart';
import 'package:Flutter/providers/search.dart';
import 'package:Flutter/providers/testimony.dart';
import 'package:Flutter/providers/user.dart';
import 'package:Flutter/screens/profile_screeen.dart';
import 'package:Flutter/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:provider/provider.dart';
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
  initScreen3 = prefs.getInt("initScreen3");
  await prefs.setInt("initScreen3", 1);
  // print('initScreen3 ${initScreen3}');
  runApp(MyApp());
}

// class MyApp extends StatelessWidget {

//   @override
//   Widget build(BuildContext context) {
//     // SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp,DeviceOrientation.portraitDown]);
//     return MaterialApp(
//       builder: (BuildContext context, Widget child){
//         return MediaQuery(
//           data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0,alwaysUse24HourFormat: false),
//           child: child,
//         );
//       },
//       theme: ThemeData(
//         primaryColor: Color(0xFF0F2985),
//         primarySwatch: Colors.blue,
//       ),
//       debugShowCheckedModeBanner: false,
//       home: UserPage(),
//     );
//   }
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         primaryColor: const Color.fromARGB(255, 0, 199, 0),
//         accentColor: const Color.fromARGB(255, 222, 233, 226),
//         brightness: Brightness.dark,
//         canvasColor: Colors.black,
//       ),
//       home: MyHomePage(),
//       debugShowCheckedModeBanner: false,
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   @override
//   State createState() => MyHomePageState();
// }

// class MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
//   Animation<int> _characterCount;

//   int _stringIndex;
//   static const List<String> _kStrings = const <String>[
//     'Call trans opt: received. 2-19-98 13:24:18 REC:Log>',
//     'Trace program running.',
//     '[312]555-0690',
//   ];
//   String get _currentString => _kStrings[_stringIndex % _kStrings.length];

//   @override
//   Widget build(BuildContext context) {
//     ThemeData theme = Theme.of(context);
//     TextStyle textStyle = theme.textTheme.title.copyWith(
//       fontFamily: 'Courier New',
//       color: theme.primaryColor,
//     );
//     return Scaffold(
//       floatingActionButton: FloatingActionButton(
//         child: Icon(Icons.navigate_next),
//         onPressed: () async {
//           AnimationController controller = AnimationController(
//             duration: const Duration(milliseconds: 4000),
//             vsync: this,
//           );
//           setState(() {
//             _stringIndex = _stringIndex == null ? 0 : _stringIndex + 1;
//             _characterCount = StepTween(begin: 0, end: _currentString.length)
//                 .animate(
//                     CurvedAnimation(parent: controller, curve: Curves.easeIn));
//           });
//           await controller.forward();
//           controller.dispose();
//         },
//       ),
//       body: Container(
//         margin: EdgeInsets.symmetric(vertical: 50.0, horizontal: 10.0),
//         child: _characterCount == null
//             ? null
//             : AnimatedBuilder(
//                 animation: _characterCount,
//                 builder: (BuildContext context, Widget child) {
//                   String text =
//                       _currentString.substring(0, _characterCount.value);
//                   return Text(text, style: textStyle);
//                 },
//               ),
//       ),
//     );
//   }
// }

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(

    // ));
    OneSignal.shared.init(
      "83761a89-31cd-43d2-8aa5-76d81afa7709",
    );
    OneSignal.shared.setNotificationReceivedHandler((notification) {
      notification.payload.smallIcon = "ic_stat_onesignal_default.png";
      notification.payload.largeIcon = "ic_onesignal_large_icon_default.png";
      notification.payload.smallIconAccentColor = "FF32FFF3";
      // notification.payload.ledColor = "FF4267B2";
    });
    OneSignal.shared
        .setInFocusDisplayType(OSNotificationDisplayType.notification);

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
        ChangeNotifierProvider.value(value: Testimony()),
        ChangeNotifierProvider.value(value: Orders()),
      ],
      child: Consumer<Auth>(
        builder: (ctx, auth, child) => MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primaryColor: Colors.blue,
          ),
          initialRoute: initScreen3 == 0 || initScreen3 == null ? "first" : "/",
          routes: {
            '/': (context) =>
                Provider.of<Auth>(context, listen: true).token != null
                    ? Home()
                    : FutureBuilder(
                        future: auth.tryAutoLogin(context),
                        builder: (ctx, authResultSnapshot) => authResultSnapshot
                                    .connectionState ==
                                ConnectionState.waiting
                            ? SplashScreen()
                            : authResultSnapshot.data ? Home() : LoginScreen(),
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
    return Container(
      width: ScreenUtil().setWidth(20),
      child: Center(
        child: Material(
          color: page == 1 ? Color(0xFFFAAB35) : Colors.black,
          type: MaterialType.circle,
          child: Container(
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
        height: ScreenUtil().setHeight(775),
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
            SizedBox(
              height: ScreenUtil().setHeight(260),
            ),
            Image.asset(
              "assets/images/logo_colour.png",
              fit: BoxFit.contain,
              height: ScreenUtil().setHeight(130),
              width: ScreenUtil().setWidth(130),
            ),
            SizedBox(
              height: ScreenUtil().setHeight(30),
            ),
            Text(
              'GEMSTORY',
              style: TextStyle(
                fontFamily: 'Gilroy Black',
                color: Colors.black,
                fontSize: ScreenUtil().setSp(35, allowFontScalingSelf: true),
                fontWeight: FontWeight.w800,
              ),
            ),
            SizedBox(
              height: ScreenUtil().setHeight(110),
            ),
            Text(
              '"Craft of Perfection"',
              style: TextStyle(
                  fontSize: ScreenUtil().setSp(24, allowFontScalingSelf: true),
                  color: Colors.black,
                  fontFamily: 'Gilroy'),
            ),
          ],
        ),
      ),
      Container(
        width: ScreenUtil().setWidth(411),
        height: ScreenUtil().setHeight(775),
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
            SizedBox(
              height: ScreenUtil().setHeight(260),
            ),
            Image.asset(
              "assets/images/logo_colour.png",
              fit: BoxFit.contain,
              height: ScreenUtil().setHeight(130),
              width: ScreenUtil().setWidth(130),
            ),
            SizedBox(
              height: ScreenUtil().setHeight(30),
            ),
            Text(
              'GEMSTORY',
              style: TextStyle(
                fontFamily: 'Gilroy Black',
                color: Color(0xFFFAAB35),
                fontSize: ScreenUtil().setSp(35, allowFontScalingSelf: true),
                fontWeight: FontWeight.w800,
              ),
            ),
            SizedBox(
              height: ScreenUtil().setHeight(110),
            ),
            Text(
              '"Craft of Perfection"',
              style: TextStyle(
                  fontSize: ScreenUtil().setSp(24, allowFontScalingSelf: true),
                  color: Color(0xFFFAAB35),
                  fontFamily: 'Gilroy'),
            ),
          ],
        ),
      ),
      Container(
        width: ScreenUtil().setWidth(411),
        height: ScreenUtil().setHeight(775),
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
            SizedBox(
              height: ScreenUtil().setHeight(260),
            ),
            Image.asset(
              "assets/images/logo.png",
              fit: BoxFit.contain,
              height: ScreenUtil().setHeight(130),
              width: ScreenUtil().setWidth(130),
            ),
            SizedBox(
              height: ScreenUtil().setHeight(30),
            ),
            Text(
              'GEMSTORY',
              style: TextStyle(
                fontFamily: 'Gilroy Black',
                color: Colors.black,
                fontSize: ScreenUtil().setSp(35, allowFontScalingSelf: true),
                fontWeight: FontWeight.w800,
              ),
            ),
            SizedBox(
              height: ScreenUtil().setHeight(110),
            ),
            Text(
              '"Craft of Perfection"',
              style: TextStyle(
                  fontSize: ScreenUtil().setSp(24, allowFontScalingSelf: true),
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
              child: GestureDetector(
                onTap: () {
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
                    fontSize:
                        ScreenUtil().setSp(21, allowFontScalingSelf: true),
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
