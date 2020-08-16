import 'dart:convert';
import 'dart:async';
import 'dart:io';
import 'package:Flutter/constant/const.dart';
import 'package:Flutter/screens/product_overview_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import './http_exception.dart';

class Auth with ChangeNotifier {
  Future<bool> checkIfRegistered(String number) async {
    try {
      final response = await http.get('${uurl}user/isregistered/$number');
      final responseBody = jsonDecode(response.body);
      if (responseBody['error'] == true)
        throw HttpException(responseBody['details']['message']);
      // print('PP checkIfRegistered response: $responseBody');
      return responseBody['registered'];
    } on PlatformException {
      throw 'Something went wrong, I\'m unable to connect to our servers. Try again!';
    } on FormatException {
      throw 'Something went wrong, I\'m unable to connect to our servers. Try again!';
    } on SocketException {
      throw 'No Internet Connection! Please connect to Internet.';
    } catch (err) {
      throw err;
    }
  }

  bool isLogin = false;
  String _token;
  DateTime _expiryDate;
  String _number;
  Timer _authTimer;
  bool autoLogin = false;
  bool remeberMe = true;
  String password;
  int once = 0;
  bool flag = false;
  void changeFlage(value) {
    flag = value;
  }

  bool get isAuth {
    return token != null;
  }

  void changeLog() {
    isLogin = !isLogin;
  }

  void changeAuto() {
    autoLogin = !autoLogin;
  }

  String get token {
    if (_expiryDate != null &&
        _expiryDate.isAfter(DateTime.now()) &&
        _token != null) {
      return _token;
    }
    return null;
  }

  String get number {
    return _number;
  }

  Future<bool> resetPasswordRequest(String number) async {
    try {
      final response = await http
          .post('${uurl}user/resetpasswordrequest', body: {"number": number});
      final responseBody = json.decode(response.body);
      // print(
      // 'PP resetPasswordRequest body details message:${responseBody['details']}');
      if (responseBody['error'] == true) {
        if (responseBody['details']['name'] ==
            'waitabit! - Devloper Defined Error!') {
          return true;
        }
        throw HttpException(responseBody['details']['message']);
      } else
        return true;
    } on PlatformException {
      throw 'Something went wrong, I\'m unable to connect to our servers. Try again!';
    } on SocketException {
      throw 'No Internet Connection! Please connect to Internet.';
    } on FormatException {
      throw 'Something went wrong, I\'m unable to connect to our servers. Try again!';
    } catch (err) {
      throw err;
    }
  }

  Future<bool> checkOtp({number, code}) async {
    try {
      final response = await http.post('${uurl}user/resetpassword/checkcode',
          body: {"number": number, "code": code});
      final responseBody = json.decode(response.body);

      if (responseBody['error'] == true)
        throw HttpException(responseBody['details']['message']);
      // print(responseBody['matches']);
      return responseBody['matches'];
    } on FormatException {
      throw 'Something went wrong, I\'m unable to connect to our servers. Try again!';
    } on PlatformException {
      throw 'Something went wrong, I\'m unable to connect to our servers. Try again!';
    } on SocketException {
      throw 'No Internet Connection! Please connect to Internet.';
    } catch (err) {
      throw err;
    }
  }

  Future<bool> resetPassword(String number, String otp, String password) async {
    try {
      final response = await http.patch('${uurl}user/resetpassword/',
          body: {"code": "$otp", "password": "$password", "number": number});
      final responseBody = json.decode(response.body);
      // print('PP resetPassword body details message:$responseBody');
      if (responseBody['error'] == true)
        throw HttpException(responseBody['details']['message']);
      else
        return true;
    } on FormatException {
      throw 'Something went wrong, I\'m unable to connect to our servers. Try again!';
    } on PlatformException {
      throw 'Something went wrong, I\'m unable to connect to our servers. Try again!';
    } on SocketException {
      throw 'No Internet Connection! Please connect to Internet.';
    } catch (err) {
      throw err;
    }
  }

  Future<void> authenticate(String number, String password, String urlSegment,
      [String name]) async {
    try {
      var status = await OneSignal.shared.getPermissionSubscriptionState();

      var playerId = status.subscriptionStatus.userId;

      final response = await http.post(
        '$uurl$urlSegment',
        body: name != null
            ? {
                "fullName": name,
                "number": number,
                "password": password,
                "notifid": playerId == null
                    ? "27e25d0e-54e8-49ae-9d9c-9db6f185edc1"
                    : playerId
              }
            : {
                "number": number,
                "password": password,
                "notifid": playerId == null
                    ? "27e25d0e-54e8-49ae-9d9c-9db6f185edc1"
                    : playerId
              },
      );
      final responseData = json.decode(response.body);

      if (responseData['error'] != false) {
        throw HttpException(responseData['details']['message']);
      }
      _token = name != null
          ? responseData['details']['token']['access']['token']
          : responseData['token']['access']['token'];
      _number = number;
      // Map<String, dynamic> decodedToken = JwtDecoder.decode(_token);

      _expiryDate = DateTime.now().add(Duration(
          seconds: name == null
              ? responseData['token']['access']['expiryin']
              : responseData['details']['token']['access']['expiryin']));
      autoLogout();
      notifyListeners();
      final prefs = await SharedPreferences.getInstance();
      final userData = json.encode(
        {
          'token': _token,
          'number': _number,
          'expiryDate': _expiryDate.toIso8601String(),
          'password': password,
        },
      );
      prefs.setString('userData', userData);
    } on FormatException {
      throw 'Something went wrong, I\'m unable to connect to our servers. Try again!';
    } on PlatformException {
      throw 'Something went wrong, I\'m unable to connect to our servers. Try again!';
    } on SocketException {
      throw 'No Internet Connection! Please connect to Internet.';
    } catch (error) {
      throw error;
    }
  }

  Future<void> resendOtp(number) async {
    try {
      final response = await http
          .post('${uurl}user/resendmessagepassword', body: {"number": number});
      final responseBody = json.decode(response.body);
      // print('PP resetPassword body details message:$responseBody');
      if (responseBody['error'] == true) {
        throw HttpException(responseBody['details']['message']);
      } else
        return true;
    } on FormatException {
      throw 'Something went wrong, I\'m unable to connect to our servers. Try again!';
    } on PlatformException {
      throw 'Something went wrong, I\'m unable to connect to our servers. Try again!';
    } on SocketException {
      throw 'No Internet Connection! Please connect to Internet.';
    } catch (err) {
      throw err;
    }
  }

  Future<void> userSignup(
    String name,
    String number,
    String password,
  ) async {
    return authenticate(number, password, 'user/signup', name);
  }

  Future<void> userLogin(String number, String password) async {
    return authenticate(number, password, 'user/login');
  }

  Future<bool> tryAutoLogin(context) async {
    try {
      final prefs = await SharedPreferences.getInstance();

      // print(
      // 'PP in tryAutologinmethod result: ${prefs.containsKey('userData')}');
      if (!prefs.containsKey('userData')) {
        return false;
      }

      final extractedUserData =
          json.decode(prefs.getString('userData')) as Map<String, Object>;
      final expiryDate = DateTime.parse(extractedUserData['expiryDate']);
      // if (prefs.get('remberMe') != null) {
      //   remeberMe = prefs.get('remberMe');
      // }
      remeberMe =
          prefs.getBool('remberMe') == null ? true : prefs.getBool('remberMe');
      String password;
      _token = extractedUserData['token'];
      _number = extractedUserData['number'];
      password = extractedUserData['password'];

      if (remeberMe) {
        await authenticate(_number, password, 'user/login');
        if (once == 0) {
          autoLogin = true;
          once++;
        }
        autoLogout();
        return true;
      } else {
        if (expiryDate.isBefore(DateTime.now())) {
          return false;
        }
        if (remeberMe == false) {
          _expiryDate = expiryDate;

          autoLogin = true;

          autoLogout();
          notifyListeners();
          return true;
        }
      }
      return false;
    } on FormatException {
      throw 'Something went wrong, I\'m unable to connect to our servers. Try again!';
    } on PlatformException {
      throw 'Something went wrong, I\'m unable to connect to our servers. Try again!';
    } on SocketException {
      throw 'No Internet Connection! Please connect to Internet.';
    } catch (err) {
      throw err;
    }
  }

  Future<void> setRemeber(value) async {
    final prefs = await SharedPreferences.getInstance();
    remeberMe = value;
    prefs.setBool('remberMe', value);
  }

  Future<void> logout({context}) async {
    _token = null;
    _number = null;
    _expiryDate = null;

    if (_authTimer != null) {
      _authTimer.cancel();
      _authTimer = null;
    }

    final prefs = await SharedPreferences.getInstance();
    remeberMe = false;
    prefs.remove('userData');
    prefs.remove('remberMe');
    prefs.remove('count');
    prefs.remove('sort');
    notifyListeners();
  }

  void autoLogout({context}) async {
    if (_authTimer != null) {
      _authTimer.cancel();
    }

    final int timeToExpiry = _expiryDate.difference(DateTime.now()).inSeconds;

    _authTimer = Timer(Duration(seconds: timeToExpiry - 2), () async {
      final prefs = await SharedPreferences.getInstance();
      remeberMe =
          prefs.getBool('remberMe') == null ? true : prefs.getBool('remberMe');
      if (remeberMe) {
        _token = null;

        final extractedUserData =
            json.decode(prefs.getString('userData')) as Map<String, Object>;
        String number = extractedUserData['number'];
        String password = extractedUserData['password'];

        await authenticate(number, password, 'user/login');
      } else {
        logout();
      }
    }
        // remeberMe
        //     ? () async {
        //         _token = null;
        //         final prefs = await SharedPreferences.getInstance();
        //         final extractedUserData = json
        //             .decode(prefs.getString('userData')) as Map<String, Object>;
        //         String number = extractedUserData['number'];
        //         String password = extractedUserData['password'];
        //         print('started!!!!');
        //         await authenticate(number, password, 'user/login');
        //       }
        //     : () {
        //         logout(context: context);
        //       });
        );

    notifyListeners();
  }

  Future<bool> getPassword() async {
    final prefs = await SharedPreferences.getInstance();

    if (!prefs.containsKey('userData')) {
      return false;
    }
    final extractedUserData =
        json.decode(prefs.getString('userData')) as Map<String, Object>;
    password = extractedUserData['password'];

    return true;
  }

  void restart({context}) {
    screenChange = true;
    Phoenix.rebirth(context);
    notifyListeners();
  }

  Future<void> sendPlayerId({context, playerId}) async {
    try {
      final response = await http.post("$uurl/user/playerid",
          headers: {
            'Authorization':
                'Bearer ' + Provider.of<Auth>(context, listen: false).token,
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: json.encode({"notifid": playerId}));

      final responseData = json.decode(response.body);
      if (responseData['error']) {
        throw HttpException(responseData['details']['message']);
      }
    } on FormatException {
      throw "Oops Something Went Wrong!";
    } on PlatformException {
      throw "Oops Something Went Wrong!";
    } on SocketException {
      throw 'No Internet Connection! Please connect to Internet.';
    } catch (err) {
      throw err;
    }
  }
}
