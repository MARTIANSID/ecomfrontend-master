import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'dart:convert';

import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'auth.dart';
import 'http_exception.dart';

class TestimonyClass {
  var rating;
  var totalTestimony;
  List<dynamic> testimonies;

  TestimonyClass({this.rating, this.testimonies, this.totalTestimony});
}

class Testimony with ChangeNotifier {
  TestimonyClass userTestimony;

  final String url = 'https://api.nakoda.daxy.in/testimony/';

  Future<void> getTestimony({context}) async {
    if (Provider.of<Auth>(context, listen: false).isAuth == false &&
        Provider.of<Auth>(context, listen: false).remeberMe == false) {
      Navigator.popAndPushNamed(context, '/');
      return;
    } else if (Provider.of<Auth>(context, listen: false).isAuth == false &&
        Provider.of<Auth>(context, listen: false).remeberMe == true) {
      final prefs = await SharedPreferences.getInstance();
      final extractedUserData =
          json.decode(prefs.getString('userData')) as Map<String, Object>;
      String number = extractedUserData['number'];
      String password = extractedUserData['password'];
      await Provider.of<Auth>(context, listen: false)
          .authenticate(number, password, 'user/login');
    }
    try {
      if (Provider.of<Auth>(context, listen: false).isAuth == false) {
        Navigator.popAndPushNamed(context, '/');
      }
      final response = await http.get(
        url,
        headers: {
          'Authorization':
              'Bearer ' + Provider.of<Auth>(context, listen: false).token,
        },
      );
      final responseData = json.decode(response.body);
      if (responseData['error'] != false) {
        throw HttpException(responseData['details']['message']);
      }
      userTestimony = TestimonyClass(
          rating: responseData['overallRating'],
          totalTestimony: responseData['totalTestimonies'],
          testimonies: responseData['Testimonies']);

      //array of maps

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

  Future<void> writeTestimony({rating, comment, context}) async {
    if (Provider.of<Auth>(context, listen: false).isAuth == false &&
        Provider.of<Auth>(context, listen: false).remeberMe == false) {
      Navigator.popAndPushNamed(context, '/');
      return;
    } else if (Provider.of<Auth>(context, listen: false).isAuth == false &&
        Provider.of<Auth>(context, listen: false).remeberMe == true) {
      final prefs = await SharedPreferences.getInstance();
      final extractedUserData =
          json.decode(prefs.getString('userData')) as Map<String, Object>;
      String number = extractedUserData['number'];
      String password = extractedUserData['password'];
      await Provider.of<Auth>(context, listen: false)
          .authenticate(number, password, 'user/login');
    }
    try {
      if (Provider.of<Auth>(context, listen: false).isAuth == false) {
        Navigator.popAndPushNamed(context, '/');
      }
      final response = await http.post(url, headers: {
        'Authorization':
            'Bearer ' + Provider.of<Auth>(context, listen: false).token,
      }, body: {
        "rating": rating.toString(),
        "comment": comment.toString(),
      });
      final responseData = json.decode(response.body);
      if (responseData['error'] != false) {
        throw HttpException(responseData['details']['message']);
      }

      notifyListeners();

      //array of maps

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
