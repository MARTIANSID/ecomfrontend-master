import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'auth.dart';
import 'http_exception.dart';

class SearchProduct {
  String image;
  String styleNumber;
  SearchProduct({this.image, this.styleNumber});
}

class Searchh with ChangeNotifier {
  List<dynamic> searchResult;

  Future<void> getSearch({String query, context}) async {
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
    final url = 'https://alexa.gemstory.in/product/search?query=$query';
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

      List<dynamic> products = responseData['products']
          .map((i) =>
              SearchProduct(image: i['image'], styleNumber: i['styleNumber']))
          .toList();

      // print(products);

      searchResult = products;
    } on FormatException {
      throw "Oops Something Went Wrong!";
    } on PlatformException {
      throw "Oops Something Went Wrong!";
    } on SocketException {
      throw 'No Internet';
    } catch (err) {
      throw err;
    }

//     void search({String query, context}) {
//       searchResult = Provider.of<Products>(context, listen: false)
//           .products
//           .where((element) => element.styleNumber.contains(query))
//           .toList();
//     }
//   }
// }
  }

  void setZero() {
    searchResult = [];
    notifyListeners();
  }
}
