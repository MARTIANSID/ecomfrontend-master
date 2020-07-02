import 'dart:convert';
import 'dart:io';
import 'package:Flutter/providers/http_exception.dart';
import 'package:Flutter/providers/pagination.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import 'auth.dart';

class ExtraCart {
  String displayImage;
  String styleNumber;
}

class Cartt {
  Object product; //styleNumber,imageUrl,prices
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
  int totalPrice;
  int totalQuantity;
  var url = 'https://alexa.gemstory.in/cart';

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
          check = true;
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
// {
//   quantity: 1,
//   build: 'SCREW',
//   color: 'WHITE',
//   certificate: 'IGI',
//   diamondQuality: null
// }
        final responseData = json.decode(response.body);
           if (responseData['error'] != false) {
        throw HttpException(responseData['details']['message']);
      }
        totalPrice=responseData['cart']['totalPrice'];

        cart = responseData['cart']['products']
            .map((i) => Cartt(
                build: i['options']['build'],
                color: i['options']['color'].toLowerCase(),
                diamond: i['options']['diamondQuality'],
                cert: i['options']['certificate'],
                id: i['id'],
                quantity: i['options']['quantity'],
                buildValue: Provider.of<Pagination>(context, listen: false)
                    .build
                    .indexOf(i['options']['build']),
                certValue: Provider.of<Pagination>(context, listen: false)
                    .cert
                    .indexOf(i['options']['certificate']),
                colorValue: Provider.of<Pagination>(context, listen: false)
                    .color
                    .indexOf(i['options']['color']),
                diamondValue: Provider.of<Pagination>(context, listen: false)
                    .diamondQuality
                    .indexOf(i['options']['diamondQuality']),
                product: Product(
                    imageUrl: Map<dynamic, dynamic>.from(i['images']),
                    prices: Map<dynamic, dynamic>.from(i['prices']),
                    styleNumber: i["styleNumber"])))
            .toList();

        // responseData['cart']['products'].forEach((i) => {
        //       if (i['options']['quantity'] == quantity &&
        //           i['options']['build'] == build &&
        //           i['options']['color'] == color.toUpperCase() &&
        //           i['options']['certificate'] == cert &&
        //           i['options']['diamondQuality'] == diamond &&
        //           i['styleNumber'] == product.styleNumber)
        //         {
        //           cart.add(Cartt(
        //             id: i['id'],
        //             product: product,
        //             quantity: quantity,
        //             cert: cert,
        //             color: color,
        //             diamond: diamond,
        //             build: build,
        //             buildValue: buildValue,
        //             colorValue: colorValue,
        //             certValue: certvalue,
        //             diamondValue: diamondValue,
        //           ))
        //         }
        //     });
        print(cart[0].id);

        print(response);
        print(cart);
        notifyListeners();
      } on SocketException {
      throw 'No Internet';
      
    } catch (error) {
       throw error;
      }
    } else {
      try {
        final response = await http.patch(
          this.url,
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
        final responseData = json.decode(response.body);
           if (responseData['error'] != false) {
        throw HttpException(responseData['details']['message']);
      }
         totalPrice=responseData['cart']['totalPrice'];
        cart = responseData['cart']['products']
            .map((i) => Cartt(
                build: i['options']['build'],
                color: i['options']['color'].toLowerCase(),
                diamond: i['options']['diamondQuality'],
                cert: i['options']['certificate'],
                id: i['id'],
                quantity: i['options']['quantity'],
                buildValue: Provider.of<Pagination>(context, listen: false)
                    .build
                    .indexOf(i['options']['build']),
                certValue: Provider.of<Pagination>(context, listen: false)
                    .cert
                    .indexOf(i['options']['certificate']),
                colorValue: Provider.of<Pagination>(context, listen: false)
                    .color
                    .indexOf(i['options']['color']),
                diamondValue: Provider.of<Pagination>(context, listen: false)
                    .diamondQuality
                    .indexOf(i['options']['diamondQuality']),
                product: Product(
                    imageUrl: Map<dynamic, dynamic>.from(i['images']),
                    prices: Map<dynamic, dynamic>.from(i['prices']),
                    styleNumber: i["styleNumber"])))
            .toList();
            notifyListeners();
      
      } on SocketException {
      throw 'No Internet';
      
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
         if (responseData['error'] != false) {
        throw HttpException(responseData['details']['message']);
      }
       totalPrice=responseData['cart']['totalPrice'];

      cart = responseData['cart']['products']
          .map((i) => Cartt(
              build: i['options']['build'],
              color: i['options']['color'].toLowerCase(),
              diamond: i['options']['diamondQuality'],
              cert: i['options']['certificate'],
              id: i['id'],
              quantity: i['options']['quantity'],
              buildValue: Provider.of<Pagination>(context, listen: false)
                  .build
                  .indexOf(i['options']['build']),
              certValue: Provider.of<Pagination>(context, listen: false)
                  .cert
                  .indexOf(i['options']['certificate']),
              colorValue: Provider.of<Pagination>(context, listen: false)
                  .color
                  .indexOf(i['options']['color']),
              diamondValue: Provider.of<Pagination>(context, listen: false)
                  .diamondQuality
                  .indexOf(i['options']['diamondQuality']),
              product: Product(
                  imageUrl: Map<dynamic, dynamic>.from(i['images']),
                  prices: Map<dynamic, dynamic>.from(i['prices']),
                  styleNumber: i["styleNumber"])))
          .toList();

      print(responseData);

      print(cart);
      notifyListeners();
    } on SocketException {
      throw 'No Internet';
      
    } catch (error) {
      print(error);
      throw error;
    }
  }

  Future<void> deleteCart({String id, context}) async {
    try {
      final response = await http.patch(
        this.url,
        headers: {
          'Authorization':
              'Bearer ' + Provider.of<Auth>(context, listen: false).token,
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode({"id": id, "quantity": 0}),
      );

      final responseData = json.decode(response.body);
         if (responseData['error'] != false) {
        throw HttpException(responseData['details']['message']);
      }
       totalPrice=responseData['cart']['totalPrice'];

      cart = responseData['cart']['products']

          .map((i) => Cartt(
              build: i['options']['build'],
              color: i['options']['color'].toLowerCase(),
              diamond: i['options']['diamondQuality'],
              cert: i['options']['certificate'],
              id: i['id'],
              quantity: i['options']['quantity'],
              buildValue: Provider.of<Pagination>(context, listen: false)
                  .build
                  .indexOf(i['options']['build']),
              certValue: Provider.of<Pagination>(context, listen: false)
                  .cert
                  .indexOf(i['options']['certificate']),
              colorValue: Provider.of<Pagination>(context, listen: false)
                  .color
                  .indexOf(i['options']['color']),
              diamondValue: Provider.of<Pagination>(context, listen: false)
                  .diamondQuality
                  .indexOf(i['options']['diamondQuality']),
              product: Product(
                  imageUrl: Map<dynamic, dynamic>.from(i['images']),
                  prices: Map<dynamic, dynamic>.from(i['prices']),
                  styleNumber: i["styleNumber"])))
          .toList();

      notifyListeners();
    }on SocketException {
      throw 'No Internet';
      
    }  catch (err) {
      throw err;
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

  Future<void> decQuantity({ index,context, product, color, cert, diamond, build,
      quantity, colorValue, buildValue, diamondValue, certvalue, update}) async {
    await Provider.of<Cart>(context,listen: false).addCart(
        context: context,
        color: color,
        cert: cert,
        colorValue: colorValue,
        certvalue: certvalue,
        build: build,
        buildValue: buildValue,
        update: true,
        diamond: diamond,
        diamondValue: diamondValue,
        product: product,
        quantity: cart[index].quantity-1);

    notifyListeners();
  }

  Future<void> incQuantity({index, context, product, color, cert, diamond, build,
      quantity, colorValue, buildValue, diamondValue, certvalue, update}) async {
    await Provider.of<Cart>(context,listen: false).addCart(
        context: context,
        color: color,
        cert: cert,
        colorValue: colorValue,
        certvalue: certvalue,
        build: build,
        buildValue: buildValue,
        quantity: cart[index].quantity+1,
        update: true,
        diamond: diamond,
        diamondValue: diamondValue,
        product: product,
        );

    notifyListeners();
  }
}

// {
//     "error": false,
//     "user": {
//         "number": 12345,
//         "role": "USER"
//     },
//     "cart": {
//         "totalQuantity": 5,
//         "totalPrice": 605248,
//         "products": [
//             {
//                 "id": "5ef32b351248b40991785704",
//                 "isFavourite": false,
//                 "styleNumber": "GS11123",
//                 "displayImage": "https://staticimg.titan.co.in/Mia/Catalog/552818OWDAAA22_3.jpg?pView=pdp",
//                 "diamondWeight": 1.9,
//                 "diamondCount": 186,
//                 "designDimensions": "10x40 mm",
//                 "goldWeight": 3.903,
//                 "price": 121050,
//                 "prices":[],
//                 images:[],
//                 "options": {
//                     "quantity": 5,
//                     "build": "SCREW",
//                     "color": "ROSE",
//                     "certificate": "IGI",
//                     "diamondQuality": "VVS_EF"
//                 }
//             }
//         ]
//     }
// }
