import 'dart:convert';
import 'package:Flutter/screens/appui.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import 'auth.dart';

class ExtraCart {
  String displayImage;
  String styleNumber;
}

class Cartt {
  Object product; //styleNumber,imageUrl,
  String id;
  int quantity;
  String cert;
  String color;
  String diamond;
  String build;
  int colorValue;
  int diamondValue;
  int buildValue;
  int certValue;

  Cartt(
      {this.product,
      this.quantity,
      this.cert,
      this.color,
      this.diamond,
      this.build,
      this.buildValue,
      this.certValue,
      this.colorValue,
      this.diamondValue,
      this.id});
}

class Cart with ChangeNotifier {
  List<dynamic> cart = [];
  bool check;

  Future<void> addCart(
      {context,
      product,
      color,
      cert,
      diamond,
      build,
      quantity,
      colorValue,
      buildValue,
      diamondValue,
      certvalue,
      update}) async {
    int index;
    if (!update) {
      index = cart.indexWhere(
          (element) => element.product.styleNumber == product.styleNumber);

      if (index >= 0) {
        if (cart[index].color == color &&
            cart[index].build == build &&
            cart[index].diamond == diamond &&
            cart[index].cert == cert) {
          cart[index].quantity = cart[index].quantity + quantity;
          check = false;
        } else {
          check = true;
        }
      } else {
        check = true;
      }
    } else {
      index = cart.indexWhere(
          (element) => element.product.styleNumber == product.styleNumber);
      cart[index].build = build;
      cart[index].color = color;
      cart[index].diamond = diamond;
      cart[index].cert = cert;
      cart[index].colorValue = colorValue;
      cart[index].diamondValue = diamondValue;
      cart[index].buildValue = buildValue;
      cart[index].certValue = certvalue;
      cart[index].quantity = quantity;
      check = false;

      notifyListeners();
    }

    final url = 'https://alexa.gemstory.in/cart/add';
    if (check) {
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
            "diamondQuality": diamond,
            "build": build,
            "certificate": cert,
            "color": color.toUpperCase(),
            "quantity": quantity
          }),
        );

        final responseData = json.decode(response.body);

        responseData['cart']['products'].forEach((i) => {
              if (i['options']['quantity'] == quantity &&
                  i['options']['build'] == build &&
                  i['options']['color'] == color.toUpperCase() &&
                  i['options']['certificate'] == cert &&
                  i['options']['diamondQuality'] == diamond &&
                  i['styleNumber'] == product.styleNumber)
                {
                  cart.add(Cartt(
                    id: i['id'],
                    product: product,
                    quantity: quantity,
                    cert: cert,
                    color: color,
                    diamond: diamond,
                    build: build,
                    buildValue: buildValue,
                    colorValue: colorValue,
                    certValue: certvalue,
                    diamondValue: diamondValue,
                  ))
                }
            });
        print(cart[0].id);

        print(response);
        print(cart);
        notifyListeners();
      } catch (error) {
        print(error);
        throw error;
      }
    } else {
      try {
        final response = await http.patch(
          'https://alexa.gemstory.in/cart',
          headers: {
            'Authorization':
                'Bearer ' + Provider.of<Auth>(context, listen: false).token,
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: json.encode({
            "id": cart[index].id,
            "diamondQuality": diamond,
            "build": build,
            "certificate": cert,
            "color": color.toUpperCase(),
            "quantity": quantity
          }),
        );
        print(json.decode(response.body));
      } catch (err) {
        throw err;
      }
    }
  }

  Future<void> getCart({context}) async {
    final url = 'https://alexa.gemstory.in/cart';

    try {
      final response = await http.get(
        url,
        headers: {
          'Authorization':
              'Bearer ' + Provider.of<Auth>(context, listen: false).token,
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









  void buildChange(value, index) {
    cart[index].buildValue = value;
    notifyListeners();
  }

  void colorChange(value, index) {
    cart[index].colorValue = value;
    notifyListeners();
  }

  void certChange(value, index) {
    cart[index].certValue = value;
    notifyListeners();
  }

  void diamondChange(value, index) {
    cart[index].diamondValue = value;
    notifyListeners();
  }

  void decQuantity(index) {
    cart[index].quantity = cart[index].quantity - 1;
    notifyListeners();
  }

  void incQuantity(index) {
    cart[index].quantity = cart[index].quantity + 1;
    notifyListeners();
  }
}
