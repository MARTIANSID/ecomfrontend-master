import 'dart:io';

import 'package:Flutter/constant/const.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'auth.dart';
import 'cart.dart';

class ProductDetails {
  String styleNumber;
  String displayImage;
  int quantity;
  String build;
  String color;
  String certificate;
  String diamondQuality;
  Map<dynamic, dynamic> imageUrl;
  ProductDetails(
      {this.styleNumber,
      this.build,
      this.certificate,
      this.color,
      this.diamondQuality,
      this.displayImage,
      this.imageUrl,
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

class Orders with ChangeNotifier {
  List<dynamic> completedOrders = [];
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
      await Provider.of<Auth>(context, listen: false)
          .authenticate(number, password, 'user/login');
    }
    try {
      final response = await http.get(
        uurl + 'order',
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
                      imageUrl: Map<dynamic, dynamic>.from(i['images']),
                      quantity: i['options']['quantity'],
                      build: i['options']['build'],
                      certificate: i['options']["certificate"],
                      color: i['options']['color'],
                      diamondQuality: i['options']['diamondQuality']))
                  .toList()))
          .toList();
    } on FormatException {
      throw "Oops Something Went Wrong!";
    } on PlatformException {
      throw 'Oops Something went wrong';
    } on SocketException {
      throw 'No Internet Connection! Please connect to Internet.';
    } catch (err) {
      throw err;
    }
  }

  void completeOrderSeperation() {
    completedOrders = [...orderProducts];
    completedOrders.retainWhere((element) => element.status == 5);
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
      await Provider.of<Auth>(context, listen: false)
          .authenticate(number, password, 'user/login');
    }
    try {
      final response = await http.post(
        uurl + 'order',
        headers: {
          'Authorization':
              'Bearer ' + Provider.of<Auth>(context, listen: false).token,
        },
      );
      if (response.statusCode == 200) {
        Provider.of<Cart>(context, listen: false).cartNull();
      }
    } on FormatException {
      throw "Oops Something Went Wrong!";
    } on PlatformException {
      throw 'Oops Something went wrong';
    } on SocketException {
      throw 'No Internet Connection! Please connect to Internet.';
    } catch (err) {
      throw err;
    }
  }
}
