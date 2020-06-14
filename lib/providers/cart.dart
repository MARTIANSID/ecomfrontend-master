import 'dart:convert';
import 'package:Flutter/screens/appui.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import 'auth.dart';

class Cartt {
  Object product;
  int quantity;
  int cert;
  int color;
  int diamond;
  int build;
  Cartt(
      {this.product,
      this.quantity,
      this.cert,
      this.color,
      this.diamond,
      this.build});
}

class Cart with ChangeNotifier {
  List<dynamic> cart = [];

  Future<void> addCart(
      {context, product, color, cert, diamond, build, quantity}) async {
    int index;
    String buildd;
    String colorr;
    String diamondd;
    String certt;
    index = cart.indexWhere(
        (element) => element.product.styleNumber == product.styleNumber);

    if (index >= 0) {
      cart[index].quantity = cart[index].quantity + quantity;
    } else {
      cart.add(Cartt(
          product: product,
          quantity: quantity,
          cert: cert,
          color: color,
          diamond: diamond,
          build: build));
    }

    if (color == 0) {
      colorr = 'YELLOW';
    }
    if (color == 1) {
      colorr = 'WHITE';
    }
    if (color == 2) {
      colorr = 'ROSE';
    }

    if (build == 0) {
      buildd = 'TAAR';
    }
    if (build == 1) {
      buildd = 'SCREW';
    }
    if (cert == 0) {
      certt = 'IGI';
    }
    if (cert == 1) {
      certt = 'WHITE';
    }
    if (cert == 2) {
      certt = 'NONE';
    }
    if (diamond == 0) {
      certt = 'vVS_EF';
    }
    if (diamond == 1) {
      certt = 'vVS_FG';
    }
    if (diamond == 2) {
      certt = 'vVS_VS_FG';
    }
    if (diamond == 3) {
      certt = 'vS_FG';
    }
    if (diamond == 4) {
      certt = 'sI_HI';
    }

    final url = 'https://api.nakoda.daxy.in/cart/add';

    try {
      final response = await http.post(
        url,
        headers: {
          'Authorization':
              'Bearer ' + Provider.of<Auth>(context, listen: false).token,
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: json.encode({
          "styleNumber": product.styleNumber,
          "diamondQuality": certt,
          "build": buildd,
          "certificate": certt,
          "color": colorr,
          "quantity": quantity
        }),
      );

      final responseData = json.decode(response.body);
      print(responseData);
      print(cart);
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  Future<void> getCart({context}) async {
    final url = 'https://api.nakoda.daxy.in/cart/add';

    try {
      final response = await http.get(
        url,
        headers: {
          'Authorization':
              'Bearer ' + Provider.of<Auth>(context, listen: false).token,
          'Content-Type': 'application/json; charset=UTF-8'
        },
      );

      final responseData = json.decode(response.body);
      print(responseData);
      print(cart);
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }
}
