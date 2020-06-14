

import 'package:Flutter/providers/cart.dart';
import 'package:Flutter/providers/options.dart';
import 'package:Flutter/providers/pagination.dart';
import 'package:Flutter/providers/search.dart';
import 'package:Flutter/providers/user.dart';
import 'package:Flutter/screens/photo_detail_screen.dart';
import 'package:Flutter/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import './screens/auth_screen.dart';
import './providers/products.dart';
import './providers/auth.dart';
import './screens/home.dart';
//<uses-permission android:name="android.permission.INTERNET" />

void main() => runApp(MyApp());

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
         ChangeNotifierProvider.value(
          value: UserInfo()
        ),
         ChangeNotifierProvider.value(
          value: Products()
        ),
        ChangeNotifierProvider.value(
          value: Cart()
        ),
         ChangeNotifierProvider.value(
          value: Searchh()
        ),
          ChangeNotifierProvider.value(
          value: Pagination()
        ),
          ChangeNotifierProvider.value(
          value: Options()
        ),
      ],
      child: Consumer<Auth>(
        builder: (ctx, auth, _) => MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primaryColor: Color(0xFFD06AA9),
          ),
          home: auth.isAuth
              ? Home()
              : FutureBuilder(
                  future: auth.tryAutoLogin(context),
                  builder: (ctx, authResultSnapshot) =>
                      authResultSnapshot.connectionState ==
                              ConnectionState.waiting
                          ? SplashScreen()
                          : authResultSnapshot.data?Home():LoginScreen(),
                ),
        ),
      ),
    );
  }
}

// MaterialApp(
//         theme: ThemeData(
//           primaryColor: Color(0xFFD06AA9), //Color.fromRGBO(208, 106, 169, 1),
//         ),
//         debugShowCheckedModeBanner: false,
//         home: FutureBuilder(
//           future: Provider.of<Auth>(context, listen: false).tryAutoLogin(),
//           builder: (_, snap) => snap.connectionState == ConnectionState.waiting
//               ? SplashScreen()
//               : Consumer<Auth>(
//                   builder: (_, auth, __) =>
//                       auth.isAuth ? Home() : LoginScreen(),
//                 ),
//         ),
//       ),
