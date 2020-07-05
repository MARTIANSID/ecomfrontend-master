import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'auth.dart';
import 'cart.dart';
import 'http_exception.dart';

class ProductDetails {
  String styleNumber;
  String displayImage;
  int quantity;
  String build;
  String color;
  String certificate;
  String diamondQuality;
  ProductDetails(
      {this.styleNumber,
      this.build,
      this.certificate,
      this.color,
      this.diamondQuality,
      this.displayImage,
      this.quantity});
}

class Order {
  int status;
  String orderNumber;
  String datePlaced;
  List<dynamic> products;
  Order({this.orderNumber, this.datePlaced, this.status, this.products});
}

// class Order {
//   int status;
//   String orderNumber;
//   String datePlaced;
// }

final uurl = "https://alexa.gemstory.in/";

class Orders with ChangeNotifier {
  List<dynamic> orderProducts = [];
  Future<void> getOrders({context}) async {
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
      Provider.of<Auth>(context, listen: false)
          .authenticate(number, password, 'user/login');
    }
    try {
      final response = await http.get(
        uurl + '/order',
        headers: {
          'Authorization':
              'Bearer ' + Provider.of<Auth>(context, listen: false).token,
        },
      );
      final responseData = json.decode(response.body);

      orderProducts = responseData['user']['orders']
          .map((i) => Order(
              status: i['status'],
              orderNumber: i['orderNumber'],
              datePlaced: i['datePlaced'],
              products: i['products']
                  .map((i) => ProductDetails(
                      styleNumber: i['styleNumber'],
                      displayImage: i['displayImage'],
                      quantity: i['options']['quantity'],
                      build: i['options']['build'],
                      certificate: i['options']["certificate"],
                      color: i['options']['diamondQuality']))
                  .toList()))
          .toList();
      print(orderProducts);
    } on PlatformException {
      throw 'Oops Something went wrong';
    } on SocketException {
      throw 'No Internet';
    } catch (err) {
      throw err;
    }
  }

  Future<void> placeOrder({context}) async {
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
      Provider.of<Auth>(context, listen: false)
          .authenticate(number, password, 'user/login');
    }
    try {
      final response = await http.post(
        uurl + '/order',
        headers: {
          'Authorization':
              'Bearer ' + Provider.of<Auth>(context, listen: false).token,
        },
      );
      if (response.statusCode == 200) {
        Provider.of<Cart>(context, listen: false).cartNull();
      }
    } on PlatformException {
      throw 'Oops Something went wrong';
    } on SocketException {
      throw 'No Internet';
    } catch (err) {
      throw err;
    }
  }
}
