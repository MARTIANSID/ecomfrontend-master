import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

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
    final url = 'https://alexa.gemstory.in/product/search?query=$query';
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

      List<dynamic> products = responseData['products']
          .map((i) =>
              SearchProduct(image: i['image'], styleNumber: i['styleNumber']))
          .toList();

      print(products);

      searchResult = products;
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
  void setZero(){
    searchResult=[];
    notifyListeners();
  }
}
