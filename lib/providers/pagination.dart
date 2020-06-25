import 'package:flutter/cupertino.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import 'auth.dart';
import 'http_exception.dart';

class Product {
  String styleNumber;
  var diamondWeight;
  var goldWeight;
  var diamondCount;
  Map<String, bool> designDetails;
  var designDimensions;

  bool isFavourite;
  // String vVS_EF;
  // String vVS_FG;
  // String vVS_VS_FG;
  // String vS_FG;
  // String sI_HI;

  Map<dynamic, dynamic> imageUrl;
  Map<dynamic, dynamic> prices;
  // List<String> imgUrls;

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
      this.prices,
      this.designDetails,
      this.imageUrl,
      this.designDimensions});
}

class Pagination with ChangeNotifier {
  bool c = false;
  bool isVerified;
  bool isPriced;
  String count = 'styleNumber';
  int sort = 1;

  void setSort(value) {
    sort = value;
  }

  void setCount(value) {
    count = value;
  }

  List<dynamic> allProducts;
  List<dynamic> fancyDiamond;
  List<dynamic> highestSellingProducts;
  List<dynamic> newProducts;
  List<dynamic> featuredProducts;
  List<dynamic> favProducts;
  List<dynamic> cert;
  List<dynamic> build;
  List<dynamic> color;
  List<dynamic> diamondQuality;
  Map<dynamic, dynamic> buildPrices;
  Map<dynamic, dynamic> certPrices;
  List<dynamic> productDetailsForSearch;
  int comm;
  var goldPrice;

  var pageAll = 1;
  var pageFeatured = 1;
  var pageNew = 1;
  var pageHighest = 1;
  var pageDiamond = 1;

  void pageAdd(select) {
    if (select == 'all') pageAll++;

    if (select == 'new') pageNew++;

    if (select == 'featured') pageFeatured++;

    if (select == 'highestSelling') pageHighest++;

    if (select == 'fancyDiamond') pageDiamond++;
  }

  void pageStart() {
    pageAll = pageNew = pageFeatured = pageHighest = pageDiamond = 1;
    print(pageAll.toString() + 'all;;');
    notifyListeners();
  }

  void change() {
    c = !c;
    notifyListeners();
  }

  final uurl = "alexa.gemstory.in/";

  Future<void> getProducts(
      {context,
      sort = 1,
      sortby = 'styleNumber',
      page = 1,
      select = 'all',
      addition = false}) async {
    final url =
        'https://alexa.gemstory.in/product/paginated?select=$select&sortby=$sortby&sort=$sort&page=$page&quant=20';
    try {
      final response = await http.get(
        url,
        headers: {
          'Authorization':
              'Bearer ' + Provider.of<Auth>(context, listen: false).token,
        },
      );

      final extractedData = json.decode(response.body);

      build = extractedData["productOptions"]["build"];
      color = extractedData["productOptions"]["color"];
      cert = extractedData["productOptions"]["certification"];
      goldPrice = extractedData['prices']['goldToday'];

      diamondQuality = extractedData["productOptions"]["diamondQuality"];
      buildPrices =
          Map<dynamic, dynamic>.from(extractedData['prices']['labour']);
      certPrices =
          Map<dynamic, dynamic>.from(extractedData['prices']['certification']);
      comm = extractedData['prices']['comission'];

      if (addition) {
        extractedData['products'].forEach((prod) {
          if (select == 'all')
            allProducts.add(
              Product(
                  designDetails: Map<String, bool>.from(prod['designDetails']),
                  styleNumber: prod['styleNumber'],
                  diamondWeight: prod['diamondWeight'],
                  goldWeight: prod['goldWeight'],
                  diamondCount: prod['diamondCount'],
                  isFavourite: prod['isFavourite'],
                  imageUrl: Map<dynamic, dynamic>.from(prod['images']),
                  prices: Map<dynamic, dynamic>.from(prod['prices']),
                  designDimensions: prod['designDimensions']),
            );
          if (select == 'featured')
            featuredProducts.add(
              Product(
                  designDetails: Map<String, bool>.from(prod['designDetails']),
                  styleNumber: prod['styleNumber'],
                  diamondWeight: prod['diamondWeight'],
                  goldWeight: prod['goldWeight'],
                  diamondCount: prod['diamondCount'],
                  isFavourite: prod['isFavourite'],
                  imageUrl: Map<dynamic, dynamic>.from(prod['images']),
                  prices: Map<dynamic, dynamic>.from(prod['prices']),
                  designDimensions: prod['designDimensions']),
            );
          if (select == 'highestSelling')
            highestSellingProducts.add(
              Product(
                  designDetails: Map<String, bool>.from(prod['designDetails']),
                  styleNumber: prod['styleNumber'],
                  diamondWeight: prod['diamondWeight'],
                  goldWeight: prod['goldWeight'],
                  diamondCount: prod['diamondCount'],
                  isFavourite: prod['isFavourite'],
                  imageUrl: Map<dynamic, dynamic>.from(prod['images']),
                  prices: Map<dynamic, dynamic>.from(prod['prices']),
                  designDimensions: prod['designDimensions']),
            );

          if (select == 'fancyDiamond')
            fancyDiamond.add(
              Product(
                  designDetails: Map<String, bool>.from(prod['designDetails']),
                  styleNumber: prod['styleNumber'],
                  diamondWeight: prod['diamondWeight'],
                  goldWeight: prod['goldWeight'],
                  diamondCount: prod['diamondCount'],
                  isFavourite: prod['isFavourite'],
                  imageUrl: Map<dynamic, dynamic>.from(prod['images']),
                  prices: Map<dynamic, dynamic>.from(prod['prices']),
                  designDimensions: prod['designDimensions']),
            );
          if (select == 'new')
            newProducts.add(
              Product(
                  designDetails: Map<String, bool>.from(prod['designDetails']),
                  styleNumber: prod['styleNumber'],
                  diamondWeight: prod['diamondWeight'],
                  goldWeight: prod['goldWeight'],
                  diamondCount: prod['diamondCount'],
                  isFavourite: prod['isFavourite'],
                  imageUrl: Map<dynamic, dynamic>.from(prod['images']),
                  prices: Map<dynamic, dynamic>.from(prod['prices']),
                  designDimensions: prod['designDimensions']),
            );
        });
        if (addition) notifyListeners();
      } else {
        List<dynamic> loadedProducts = extractedData['products']
            .map(
              (prod) => Product(
                  designDetails: Map<String, bool>.from(prod['designDetails']),
                  styleNumber: prod['styleNumber'],
                  diamondWeight: prod['diamondWeight'],
                  goldWeight: prod['goldWeight'],
                  diamondCount: prod['diamondCount'],
                  isFavourite: prod['isFavourite'],
                  imageUrl: Map<dynamic, dynamic>.from(prod['images']),
                  prices: Map<dynamic, dynamic>.from(prod['prices']),
                  designDimensions: prod['designDimensions']),
            )
            .toList();

        isVerified = extractedData['user']['verified'];
        isPriced = extractedData['user']['priced'];

        if (select == 'all') {
          allProducts = [];
          allProducts = loadedProducts;
          print('all');
          print(allProducts);
          notifyListeners();
        }

        if (select == 'featured') {
          featuredProducts = [];
          featuredProducts = loadedProducts;
          print('feat');
          print(featuredProducts[0]);
          print(featuredProducts[2].prices);
          notifyListeners();
        }

        if (select == 'highestSelling') {
          highestSellingProducts = [];
          highestSellingProducts = loadedProducts;
          print('heigh');
          print(highestSellingProducts);
          notifyListeners();
        }

        if (select == 'fancyDiamond') {
          fancyDiamond = [];
          fancyDiamond = loadedProducts;
          print('fanc');
          print(fancyDiamond);
          notifyListeners();
        }

        if (select == 'new') {
          newProducts = [];
          newProducts = loadedProducts;
          print('new');
          print(newProducts);
          notifyListeners();
        }
      }
    } catch (err) {
      throw err;
    }
  }

  Future<void> getFav(context) async {
    final url = 'https://alexa.gemstory.in/user/favourite/';
    try {
      final response = await http.get(
        url,
        headers: {
          'Authorization':
              'Bearer ' + Provider.of<Auth>(context, listen: false).token,
        },
      );
      List<dynamic> loadedProducts;

      final extractedData = json.decode(response.body);
      if (extractedData['favourites'] == null) {
        loadedProducts = [];
      } else {
        loadedProducts = extractedData['favourites']
            .map(
              (prod) => Product(
                  designDetails: Map<String, bool>.from(prod['designDetails']),
                  styleNumber: prod['styleNumber'],
                  diamondWeight: prod['diamondWeight'],
                  goldWeight: prod['goldWeight'],
                  diamondCount: prod['diamondCount'],
                  isFavourite: true,
                  imageUrl: Map<dynamic, dynamic>.from(prod['images']),
                  designDimensions: prod['designDimensions'],
                  // vVS_EF: prod['prices']['VVS_EF'],
                  // vVS_FG: prod['prices']['VVS_FG'],
                  // vVS_VS_FG: prod['prices']['VVS_VS_FG'],
                  // vS_FG: prod['prices']['VS_FG'],
                  // sI_HI: prod['prices']['SI_HI'],
                  ),
            )
            .toList();
      }

      favProducts = loadedProducts;
    } catch (err) {
      throw err;
    }
  }

  Future<void> toogleFavourite({String styleNumber, context, select}) async {
    int index;

    if (select == 'all') {
      index = allProducts
          .indexWhere((element) => element.styleNumber == styleNumber);
      allProducts[index].isFavourite = !allProducts[index].isFavourite;
      if (allProducts[index].isFavourite) {
        favProducts.add(allProducts[index]);
      } else {
        favProducts.remove(allProducts[index]);
      }

      notifyListeners();
    }
    if (select == 'new') {
      index = newProducts
          .indexWhere((element) => element.styleNumber == styleNumber);
      newProducts[index].isFavourite = !newProducts[index].isFavourite;
      if (newProducts[index].isFavourite) {
        favProducts.add(newProducts[index]);
      } else {
        favProducts.remove(newProducts[index]);
      }

      notifyListeners();
    }
    if (select == 'featured') {
      index = featuredProducts
          .indexWhere((element) => element.styleNumber == styleNumber);
      featuredProducts[index].isFavourite =
          !featuredProducts[index].isFavourite;
      if (featuredProducts[index].isFavourite) {
        favProducts.add(featuredProducts[index]);
      } else {
        favProducts.remove(featuredProducts[index]);
      }

      notifyListeners();
    }
    if (select == 'fancyDiamond') {
      index = fancyDiamond
          .indexWhere((element) => element.styleNumber == styleNumber);
      fancyDiamond[index].isFavourite = !fancyDiamond[index].isFavourite;
      if (fancyDiamond[index].isFavourite) {
        favProducts.add(fancyDiamond[index]);
      } else {
        favProducts.remove(fancyDiamond[index]);
      }

      notifyListeners();
    }
    if (select == 'highestSelling') {
      index = highestSellingProducts
          .indexWhere((element) => element.styleNumber == styleNumber);
      highestSellingProducts[index].isFavourite =
          !highestSellingProducts[index].isFavourite;
      if (highestSellingProducts[index].isFavourite) {
        favProducts.add(highestSellingProducts[index]);
      } else {
        favProducts.remove(highestSellingProducts[index]);
      }
      notifyListeners();
    }
    if (select == 'fav') {
      index = favProducts
          .indexWhere((element) => element.styleNumber == styleNumber);
      favProducts[index].isFavourite = !favProducts[index].isFavourite;
      favProducts.remove(favProducts[index]);
      notifyListeners();
    }

    try {
      final response = await http
          .post('https://' + uurl + '/user/favourite/toggle', headers: {
        'Authorization':
            'Bearer ' + Provider.of<Auth>(context, listen: false).token
      }, body: {
        'styleNumber': styleNumber
      });
      final responseBody = json.decode(response.body) as Map<String, dynamic>;
      if (responseBody['error'] == true)
        throw HttpException(responseBody['details']['message']);
    } catch (error) {
      if (select == 'all') {
        allProducts[index].isFavourite = !allProducts[index].isFavourite;
        favProducts.remove(allProducts[index]);
        notifyListeners();
      }
      if (select == 'new') {
        newProducts[index].isFavourite = !newProducts[index].isFavourite;
        favProducts.remove(newProducts[index]);
        notifyListeners();
      }
      if (select == 'featured') {
        featuredProducts[index].isFavourite =
            !featuredProducts[index].isFavourite;
        favProducts.remove(featuredProducts[index]);
        notifyListeners();
      }
      if (select == 'fancyDiamond') {
        fancyDiamond[index].isFavourite = !fancyDiamond[index].isFavourite;
        favProducts.remove(fancyDiamond[index]);
        notifyListeners();
      }
      if (select == 'highestSelling') {
        highestSellingProducts[index].isFavourite =
            !highestSellingProducts[index].isFavourite;
        favProducts.remove(highestSellingProducts[index]);
        notifyListeners();
      }

      print('PP in toogleFavourite error block error: $error');
    }
  }

  Future<void> getProductDetail({context, styleNumber}) async {
    try {
      final response = await http.get(
        'https://' + uurl + '/product/single?styleNumber=$styleNumber',
        headers: {
          'Authorization':
              'Bearer ' + Provider.of<Auth>(context, listen: false).token
        },
      );
      final responseData = json.decode(response.body);
      var prices = Map<dynamic, dynamic>.from(responseData['prices']);

      List<dynamic> loadedProducts = responseData['products']
          .map(
            (prod) => Product(
                designDetails: Map<String, bool>.from(prod['designDetails']),
                styleNumber: prod['styleNumber'],
                diamondWeight: prod['diamondWeight'],
                goldWeight: prod['goldWeight'],
                diamondCount: prod['diamondCount'],
                isFavourite: prod['isFavourite'],
                imageUrl: Map<dynamic, dynamic>.from(prod['images']),
                prices:  Map<dynamic, dynamic>.from(prod['prices']),
                designDimensions: prod['designDimensions']),
          )
          .toList();
      productDetailsForSearch = loadedProducts;
    } catch (err) {
      throw err;
    }
  }
}
