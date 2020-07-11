import 'dart:convert';
import 'dart:io';

import 'package:Flutter/providers/pagination.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'auth.dart';
import 'http_exception.dart';
import 'package:path/path.dart';
import 'package:async/async.dart';
import 'package:http_parser/http_parser.dart';

class User {
  String verified;
  String priced;
  String role;
  String street;
  String city;
  String state;
  String pincode;
  String fullname;
  User(
      {this.verified,
      this.priced,
      this.pincode,
      this.state,
      this.street,
      this.city,
      this.fullname,
      this.role});
}

class UserInfo with ChangeNotifier {
  bool verified;
  bool priced;
  var role;
  var street;
  var city;
  var state;
  var fullname;
  var gst;
  var number;
  var firm;
  var pincode;
  var email;
  bool noti;
  String profileImage;
  bool check = false;

  final uurl = "https://alexa.gemstory.in/";

  Future<dynamic> getuser(context) async {
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
      final response = await http.get(uurl + '/user/details', headers: {
        'Authorization':
            'Bearer ' + Provider.of<Auth>(context, listen: false).token
      });
      final responseData = json.decode(response.body);
      if (responseData['error'] != false) {
        throw HttpException(responseData['details']['message']);
      }
      check = true;
      print(responseData);
      if (Provider.of<Pagination>(context, listen: false).isVerified) {
        street = responseData['user']['additionalDetails']['address']['street'];
        city = responseData['user']['additionalDetails']['address']['city'];
        state = responseData['user']['additionalDetails']['address']['state'];
        verified = responseData['user']['verified'];
        priced = responseData['user']['priced'];
        gst = responseData['user']['additionalDetails']['gst'];
        firm = responseData['user']['additionalDetails']['firm'];
        pincode =
            responseData['user']['additionalDetails']['address']['pincode'];
        priced = responseData['user']['priced'];
        email = responseData['user']['email'];
      }
      noti = responseData['user']['notification'];
      fullname = responseData['user']['fullName'];
      number = responseData['user']['number'];
      profileImage = responseData['user']['profileImage'];

      return responseData;
    } on PlatformException {
      throw "Oops Something Went Wrong!";
    } on SocketException {
      throw 'No Internet';
    } catch (err) {
      throw err;
    }
  }

  Future<dynamic> patchuser(
      {context,
      fullname,
      gst,
      firm,
      city,
      street,
      pincode,
      state,
      email}) async {
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
      final response = await http.patch(
        uurl + '/user',
        headers: {
          'Authorization':
              'Bearer ' + Provider.of<Auth>(context, listen: false).token,
          "Content-Type": "application/json"
        },
        body: json.encode({
          "fullName": fullname,
          "email": email,
          "gst": gst == null ? 'NOT GIVEN' : gst,
          "firm": firm,
          "city": city,
          "street": street,
          "pincode": pincode,
          "state": state,
        }),
      );
      final responseData = json.decode(response.body);
      if (responseData['error'] != false) {
        throw HttpException(responseData['details']['message']);
      }
      return responseData;
    } on PlatformException {
      throw "Oops Something Went Wrong!";
    } on SocketException {
      throw 'No Internet';
    } catch (err) {
      throw err;
    }
  }

  Future<dynamic> completeSignUp(
      {context,
      fullname,
      gst,
      firm,
      city,
      street,
      pincode,
      state,
      reference,
      email}) async {
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
      final response = await http.post(
        uurl + '/user/completesignup',
        headers: {
          'Authorization':
              'Bearer ' + Provider.of<Auth>(context, listen: false).token,
          "Content-Type": "application/json"
        },
        body: json.encode({
          "fullName": fullname,
          "gst": gst == null ? 'NOT GIVEN' : gst,
          "firm": firm,
          "city": city,
          "street": street,
          "pincode": pincode,
          "state": state,
          "reference": reference,
          "email": email,
        }),
      );
      final responseData = json.decode(response.body);
      if (responseData['error'] != false) {
        throw HttpException(responseData['details']['message']);
      }
      await storeDate(DateTime.now().toString());

      return responseData;
    } on PlatformException {
      throw "Oops Something Went Wrong!";
    } on SocketException {
      throw 'No Internet';
    } catch (err) {
      throw err;
    }
  }

  Future<String> getDate() async {
    SharedPreferences cc = await SharedPreferences.getInstance();
    return cc.getString('date');
  }

  Future<void> storeDate(date) async {
    SharedPreferences cc = await SharedPreferences.getInstance();
    cc.setString('date', date);

    notifyListeners();
  }

  Future<String> getPriceDate() async {
    SharedPreferences cc = await SharedPreferences.getInstance();
    return cc.getString('priceDate');
  }

  Future<void> storePricDate(date) async {
    SharedPreferences cc = await SharedPreferences.getInstance();
    cc.setString('priceDate', date);

    notifyListeners();
  }

  Future<void> changeImage({File image, context}) async {
    var stream = http.ByteStream(DelegatingStream(image.openRead()));
    var length = await image.length();

    var uri = Uri.parse(uurl + '/user/profileimage');
    Map<String, String> headers = {
      "Authorization":
          "Bearer " + Provider.of<Auth>(context, listen: false).token
    };
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
      var request = http.MultipartRequest("POST", uri);
      var multipartFile = http.MultipartFile('image', stream, length,
          filename: basename(image.path),
          contentType: MediaType('image', 'png'));

      request.files.add(multipartFile);
      request.headers.addAll(headers);
      var response = await request.send();
      print(response);
      print(response.statusCode);
      response.stream.transform(utf8.decoder).listen((value) {
        print(value);
      });
    } on PlatformException {
      throw "Oops Something Went Wrong!";
    } on SocketException {
      throw 'No Internet';
    } catch (err) {
      throw err;
    }
  }

  Future<void> notification({context}) async {
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
      final response = await http.patch(uurl + 'user/notification', headers: {
        'Authorization':
            'Bearer ' + Provider.of<Auth>(context, listen: false).token,
      });
      print(json.decode(response.body));
    } on PlatformException {
      throw "Oops Something Went Wrong!";
    } on SocketException {
      throw 'No Internet';
    } catch (err) {
      throw err;
    }
  }

  Future<void> deleteImage({context}) async {
    try {
      final response = await http.delete(uurl + '/user/profileimage', headers: {
        'Authorization':
            'Bearer ' + Provider.of<Auth>(context, listen: false).token,
      });
      final responseData = json.decode(response.body);
      if (responseData['error'] != false) {
        throw HttpException(responseData['details']['message']);
      }
    } catch (err) {
      throw err;
    }
  }
}
