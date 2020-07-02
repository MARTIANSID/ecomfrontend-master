import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Product {
  // final String id;
  // final String title;
  // final String imageUrl;
  // bool isFavourite;
  // bool showAll;
  // final List<String> category;
  // String description;

  String styleNumber;
  double diamondWeight;
  double goldWeight;
  int diamondCount;
  Map<String, bool> designDetails;

  bool isFavourite;
  // String vVS_EF;
  // String vVS_FG;
  // String vVS_VS_FG;
  // String vS_FG;
  // String sI_HI;
  String main;
  String white;
  String yellow;
  String rose;

  bool count = false;
  bool weight = false;
  bool gWeight = false;

  int quantity = 0;

  Product(
      {this.styleNumber,
      this.diamondWeight,
      this.goldWeight,
      this.diamondCount,
      this.isFavourite = false,
      // this.sI_HI,
      // this.vS_FG,
      // this.vVS_EF,
      // this.vVS_FG,
      // this.vVS_VS_FG,
      this.designDetails,
      this.white,
      this.main,
      this.rose,
      this.yellow});
}

class Products with ChangeNotifier {
  bool isVerified;
  bool isPriced;
  static const uurl = 'https://alexa.gemstory.in/';
  List<dynamic> _products = []; //

  List<dynamic> get products {
    return [..._products];
  }

  List<dynamic> findByCategory(String a) {
    return a == 'isFavourite'
        ? _products.where((element) => element.isFavourite == true).toList()
        : _products
            .where((element) => element.designDetails[a] == true)
            .toList();
  }

  List<dynamic> get favoproducts {
    return _products.where((prodItem) => prodItem.isFavourite).toList();
  }

  // void showFavoritesOnly() {
  //   _showFavoritesOnly = true;
  //   notifyListeners();
  // }

  // void showAll() {
  //   _showFavoritesOnly = false;
  //   notifyListeners();
  // }

  Future<dynamic> fetchAndSetProducts(
      {bool filterByUser = false, token}) async {
    // final filterString =
    //     filterByUser ? 'orderBy="creatorId"&equalTo="$userId"' : '';
    var url = '${uurl}product';
    // 'https://$_projectName.firebaseio.com/products.json?auth=$authToken&$filterString';
    try {
      final response =
          await http.get(url, headers: {'Authorization': 'Bearer ' + token});

      final extractedData = json.decode(response.body);
      if (extractedData['error'] == true) {
        print('PP in fetchANdSetProduct error in Products');
        return;
      }

      // url ='';
      //'https://$_projectName.firebaseio.com/userFavorites/$userId.json?auth=$authToken';
      // final favoriteResponse = await http.get(url);
      // final favoriteData = json.decode(favoriteResponse.body);

      // extractedData['products']

      List<dynamic> loadedProducts = extractedData['products']
          .map(
            (prod) => Product(
              designDetails: Map<String, bool>.from(prod['designDetails']),
              styleNumber: prod['styleNumber'],
              diamondWeight: prod['diamondWeight'],
              goldWeight: prod['goldWeight'],
              diamondCount: prod['diamondCount'],
              isFavourite: prod['isFavourite'],
              main: prod['images']['main'],
              white: prod['images']['white'],
              yellow: prod['images']['yellow'],
              rose: prod['images']['rose'],
              // vVS_EF: prod['prices']['VVS_EF'],
              // vVS_FG: prod['prices']['VVS_FG'],
              // vVS_VS_FG: prod['prices']['VVS_VS_FG'],
              // vS_FG: prod['prices']['VS_FG'],
              // sI_HI: prod['prices']['SI_HI'],
            ),
          )
          .toList();
      isVerified = extractedData['user']['verified'];
      isPriced = extractedData['user']['priced'];
      print(loadedProducts.length);
      print(loadedProducts);

      _products = loadedProducts;
      notifyListeners();
      return _products;
    } on PlatformException {
      throw "Oops Something Went Wrong!";
    } catch (error) {
      print('ppps in try catch block Error: $error');
      throw (error);
    }
  }

  List<dynamic> nonsortedList;
  String sortType;
  void filterProducts(String filter) {
    sortType = filter;
    if (nonsortedList == null) nonsortedList = _products;
    print('PP now Sorting List');
    if (filter == 'Diamond Count') {
      _products.sort((a, b) => a.diamondCount.compareTo(b.diamondCount));
      _products.forEach((element) {
        element.count = true;
        element.gWeight = false;
        element.weight = false;
      });
    }
    if (filter == 'Diamond Weight') {
      _products.sort((a, b) => a.diamondWeight.compareTo(b.diamondWeight));
      _products.forEach((element) {
        element.weight = true;
        element.count = false;
        element.gWeight = false;
      });
    }
    if (filter == 'Gold Weight') {
      _products.sort((a, b) => a.goldWeight.compareTo(b.goldWeight));
      _products.forEach((element) {
        element.gWeight = true;
        element.count = false;
        element.gWeight = false;
      });
    }

    notifyListeners();
  }

  Future<void> addProduct(Product product) async {
    final url = '';
    //'https://$_projectName.firebaseio.com/products.json?auth=$authToken';
    try {
      final response = await http.post(
        url,
        body: json.encode({
          //'creatorId': userId,
        }),
      );
      final newProduct = Product();
      _products.add(newProduct);
      // _products.insert(0, newProduct); // at the start of the list
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  // Future<void> updateProduct(String id, Product newProduct) async {
  //   final prodIndex = _products.indexWhere((prod) => prod.id == id);
  //   if (prodIndex >= 0) {
  //     final url = '';
  //     //'https://$_projectName.firebaseio.com/products/$id.json?auth=$authToken';
  //     await http.patch(url, body: json.encode({}));
  //     _products[prodIndex] = newProduct;
  //     notifyListeners();
  //   } else {
  //     print('...');
  //   }
  // }

//   Future<void> deleteProduct(String id) async {
//     final url = '';
//     //'https://$_projectName.firebaseio.com/products/$id.json?auth=$authToken';
//     final existingProductIndex = _products.indexWhere((prod) => prod.id == id);
//     var existingProduct = _products[existingProductIndex];
//     _products.removeAt(existingProductIndex);
//     notifyListeners();
//     final response = await http.delete(url);
//     if (response.statusCode >= 400) {
//       _products.insert(existingProductIndex, existingProduct);
//       notifyListeners();
//       //throw HttpException('Could not delete product.');
//     }
//     existingProduct = null;
//   }
// }
}
