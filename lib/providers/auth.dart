import 'dart:convert';
import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import './http_exception.dart';

class Auth with ChangeNotifier {
  static const uurl = 'https://alexa.gemstory.in/';

  Future<bool> checkIfRegistered(String number) async {
    final response = await http.get('${uurl}user/isregistered/$number');
    final responsebody = jsonDecode(response.body);
    print('PP checkIfRegistered response: $responsebody');
    return responsebody['registered'];
  }

  bool isLogin = false;
  String _token;
  DateTime _expiryDate;
  String _number;
  Timer _authTimer;
  bool autoLogin = false;

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
    final response = await http
        .post('${uurl}user/resetpasswordrequest', body: {"number": number});
    final responseBody = json.decode(response.body);
    print(
        'PP resetPasswordRequest body details message:${responseBody['details']}');
    if (responseBody['error'] == true)
      throw HttpException(responseBody['details']['message']);
    else
      return true;
  }

  Future<bool> resetPassword(String number, String otp, String password) async {
    final response = await http.patch('${uurl}user/resetpassword/',
        body: {"code": "$otp", "password": "$password","number":number});
    final responseBody = json.decode(response.body);
    print('PP resetPassword body details message:$responseBody');
    if (responseBody['error'] == true)
      throw HttpException(responseBody['details']['message']);
    else
      return true;
  }

  Future<void> _authenticate(String number, String password, String urlSegment,
      [String name]) async {
    try {
      final response = await http.post(
        '$uurl$urlSegment',
        body: name != null
            ? {"fullName": name, "number": number, "password": password}
            : {"number": number, "password": password},
      );
      final responseData = json.decode(response.body);
      if (responseData['error'] != false) {
        throw HttpException(responseData['details']['message']);
      }
      _token = name != null
          ? responseData['details']['token']
          : responseData['token'];
      _number = number;
      _expiryDate = DateTime.now().add(
        Duration(seconds: 3600),
      );
      _autoLogout();
      notifyListeners();
      final prefs = await SharedPreferences.getInstance();
      final userData = json.encode(
        {
          'token': _token,
          'number': _number,
          'expiryDate': _expiryDate.toIso8601String(),
        },
      );
      prefs.setString('userData', userData);
    } catch (error) {
      throw error;
    }
  }

  Future<void> userSignup(
    String name,
    String number,
    String password,
  ) async {
    return _authenticate(number, password, 'user/signup', name);
  }

  Future<void> userLogin(String number, String password) async {
    return _authenticate(number, password, 'user/login');
  }

  Future<bool> tryAutoLogin(context) async {
    final prefs = await SharedPreferences.getInstance();
    print('PP in tryAutologinmethod result: ${prefs.containsKey('userData')}');
    if (!prefs.containsKey('userData')) {
      return false;
    }
    final extractedUserData =
        json.decode(prefs.getString('userData')) as Map<String, Object>;
    final expiryDate = DateTime.parse(extractedUserData['expiryDate']);

    if (expiryDate.isBefore(DateTime.now())) {
      return false;
    }
    _token = extractedUserData['token'];
    _number = extractedUserData['number'];

    _expiryDate = expiryDate;

    autoLogin = true;

    _autoLogout();
    notifyListeners();
    return true;
  }

  Future<void> logout() async {
    _token = null;
    _number = null;
    _expiryDate = null;
    if (_authTimer != null) {
      _authTimer.cancel();
      _authTimer = null;
    }

    final prefs = await SharedPreferences.getInstance();
    // prefs.remove('userData');
    prefs.clear();
    notifyListeners();
  }

  void _autoLogout() {
    if (_authTimer != null) {
      _authTimer.cancel();
    }
    final timeToExpiry = _expiryDate.difference(DateTime.now()).inSeconds;

    _authTimer = Timer(Duration(seconds: timeToExpiry), logout);

    notifyListeners();
  }
}
