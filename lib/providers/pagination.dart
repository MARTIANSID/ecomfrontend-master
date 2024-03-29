import 'dart:io';

import 'package:Flutter/constant/const.dart';
import 'package:Flutter/providers/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'auth.dart';
import 'http_exception.dart';

class Product {
  String styleNumber;
  var diamondWeight;
  var goldWeight;
  var diamondCount;
  // Map<String, bool> designDetails;
  var designDimensions;
  bool isFavourite;
  Map<dynamic, dynamic> imageUrl;
  var prices;
  bool count = false;
  bool weight = false;
  bool gWeight = false;
  int quantity = 0;
  int height = 150;

  Product(
      {this.styleNumber,
      this.diamondWeight,
      this.goldWeight,
      this.diamondCount,
      this.isFavourite = false,
      this.prices,
      // this.designDetails,
      this.imageUrl,
      this.designDimensions,
      this.height = 150});
}

class Pagination with ChangeNotifier {
  bool c = false;
  bool isVerified;
  bool isPriced;
  // bool sortChange = false;
  String count = 'styleNumber';
  int sort = 1;

  Future<void> setSort(value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('sort', value);
    sort = value;
  }

  Future<void> setCount(value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('count', value);
    count = value;
  }

  Future<void> getSortData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    count = prefs.getString('count') == null
        ? 'styleNumber'
        : prefs.getString('count');
    sort = prefs.getInt('sort') == null ? -1 : prefs.getInt('sort');
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
  List<dynamic> productDetailsForSearch = [];
  Map<dynamic, dynamic> diamondPrices;
  int comm;
  var goldPrice;

  var pageAll = 1;
  var pageFeatured = 1;
  var pageNew = 1;
  var pageHighest = 1;
  var pageDiamond = 1;

  void pageAdd(select) {
    if (select == 'all') pageAll++;

    if (select == 'isnew') pageNew++;

    if (select == 'featured') pageFeatured++;

    if (select == 'navratna') pageHighest++;

    if (select == 'fancyDiamond') pageDiamond++;
  }

  void pageStart() {
    pageAll = pageNew = pageFeatured = pageHighest = pageDiamond = 1;
    // print(pageAll.toString() + 'all;;');
    notifyListeners();
  }

  void change() {
    c = !c;
    notifyListeners();
  }

  // final uurl = "https://echo.gemstory.in/";
  // final req = "https://echo.gemstory.in/";

  Future<void> requestPrice({context}) async {
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
        uurl + 'user/requestprice',
        headers: {
          'Authorization':
              'Bearer ' + Provider.of<Auth>(context, listen: false).token,
        },
      );
      final responseData = json.decode(response.body);
      if (responseData['error'] != false) {
        throw HttpException(responseData['details']['message']);
      }
      await Provider.of<UserInfo>(context, listen: false)
          .storePricDate(DateTime.now().toString());
    } on FormatException {
      throw "Oops Something Went Wrong!";
    } on SocketException {
      throw 'No Internet Connection! Please connect to Internet.';
    } on PlatformException {
      throw "Oops Something Went Wrong!";
    } catch (err) {
      throw err;
    }
  }

  Future<void> getProducts(
      {context,
      sort,
      sortby,
      page = 1,
      select = 'all',
      addition = false}) async {
    final url = 'product/paginated?select=' +
        select.toString() +
        '&sortby=' +
        sortby.toString() +
        '&sort=' +
        sort.toString() +
        '&page=' +
        page.toString() +
        '&quant=30';
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
        uurl + url,
        headers: {
          'Authorization':
              'Bearer ' + Provider.of<Auth>(context, listen: false).token,
        },
      );

      final extractedData = json.decode(response.body);
      // print("Select: " +
      //     extractedData["select"].toString() +
      //     "  Total Products: " +
      //     extractedData["totalProducts"].toString() +
      //     "  Products in this request: " +
      //     extractedData["prodsInThisReq"].toString());
      // print(select + extractedData.toString());
      if (extractedData['error'] != false) {
        throw HttpException(extractedData['details']['message']);
      }
      isPriced = extractedData['user']['priced'];

      build = extractedData["productOptions"]["build"];
      color = extractedData["productOptions"]["color"];
      cert = extractedData["productOptions"]["certification"];
      isVerified = extractedData['user']['verified'];
      if (isPriced) {
        goldPrice = extractedData['prices']['goldToday'];
        diamondPrices =
            Map<dynamic, dynamic>.from(extractedData['prices']['diamond']);
        buildPrices =
            Map<dynamic, dynamic>.from(extractedData['prices']['labour']);
        certPrices = Map<dynamic, dynamic>.from(
            extractedData['prices']['certification']);
        certPrices.putIfAbsent('NONE', () => 0);
        comm = extractedData['prices']['comission'];
      }
      diamondQuality = extractedData["productOptions"]["diamondQuality"];
      if (addition) {
        extractedData['products'].forEach((prod) {
          if (select == 'all')
            allProducts.add(
              Product(
                  // // designDetails: Map<String, bool>.from(prod['designDetails']),
                  styleNumber: prod['styleNumber'],
                  diamondWeight: prod['diamondWeight'],
                  goldWeight: prod['goldWeight'],
                  diamondCount: prod['diamondCount'],
                  isFavourite: prod['isFavourite'],
                  imageUrl: Map<dynamic, dynamic>.from(prod['images']),
                  prices: prod['prices'] == null
                      ? null
                      : Map<dynamic, dynamic>.from(prod['prices']),
                  designDimensions: prod['designDimensions']),
            );
          if (select == 'featured')
            featuredProducts.add(
              Product(
                  // // designDetails: Map<String, bool>.from(prod['designDetails']),
                  styleNumber: prod['styleNumber'],
                  diamondWeight: prod['diamondWeight'],
                  goldWeight: prod['goldWeight'],
                  diamondCount: prod['diamondCount'],
                  isFavourite: prod['isFavourite'],
                  imageUrl: Map<dynamic, dynamic>.from(prod['images']),
                  prices: prod['prices'] == null
                      ? null
                      : Map<dynamic, dynamic>.from(prod['prices']),
                  designDimensions: prod['designDimensions']),
            );
          if (select == 'navratna')
            highestSellingProducts.add(
              Product(
                  // // designDetails: Map<String, bool>.from(prod['designDetails']),
                  styleNumber: prod['styleNumber'],
                  diamondWeight: prod['diamondWeight'],
                  goldWeight: prod['goldWeight'],
                  diamondCount: prod['diamondCount'],
                  isFavourite: prod['isFavourite'],
                  imageUrl: Map<dynamic, dynamic>.from(prod['images']),
                  prices: prod['prices'] == null
                      ? null
                      : Map<dynamic, dynamic>.from(prod['prices']),
                  designDimensions: prod['designDimensions']),
            );

          if (select == 'fancyDiamond')
            fancyDiamond.add(
              Product(
                  // // designDetails: Map<String, bool>.from(prod['designDetails']),
                  styleNumber: prod['styleNumber'],
                  diamondWeight: prod['diamondWeight'],
                  goldWeight: prod['goldWeight'],
                  diamondCount: prod['diamondCount'],
                  isFavourite: prod['isFavourite'],
                  imageUrl: Map<dynamic, dynamic>.from(prod['images']),
                  prices: prod['prices'] == null
                      ? null
                      : Map<dynamic, dynamic>.from(prod['prices']),
                  designDimensions: prod['designDimensions']),
            );
          if (select == 'isnew')
            newProducts.add(
              Product(
                  // // designDetails: Map<String, bool>.from(prod['designDetails']),
                  styleNumber: prod['styleNumber'],
                  diamondWeight: prod['diamondWeight'],
                  goldWeight: prod['goldWeight'],
                  diamondCount: prod['diamondCount'],
                  isFavourite: prod['isFavourite'],
                  imageUrl: Map<dynamic, dynamic>.from(prod['images']),
                  prices: prod['prices'] == null
                      ? null
                      : Map<dynamic, dynamic>.from(prod['prices']),
                  designDimensions: prod['designDimensions']),
            );
        });
        if (addition) notifyListeners();
      } else {
        isVerified = extractedData['user']['verified'];
        // List<dynamic> loadedProducts = extractedData['products']
        //     .map(
        //       (prod) => Product(
        //           // // designDetails: Map<String, bool>.from(prod['designDetails']),
        //           styleNumber: prod['styleNumber'],
        //           diamondWeight: prod['diamondWeight'],
        //           goldWeight: prod['goldWeight'],
        //           diamondCount: prod['diamondCount'],
        //           isFavourite: prod['isFavourite'],
        //           prices: prod['prices'] == null
        //               ? null
        //               : Map<dynamic, dynamic>.from(prod['prices']),
        //           imageUrl: Map<dynamic, dynamic>.from(prod['images']),
        //           designDimensions: prod['designDimensions']),
        //     )
        //     .toList();

        if (select == 'all') {
          allProducts = [];
          allProducts = extractedData['products']
              .map(
                (prod) => Product(
                    // // designDetails: Map<String, bool>.from(prod['designDetails']),
                    styleNumber: prod['styleNumber'],
                    diamondWeight: prod['diamondWeight'],
                    goldWeight: prod['goldWeight'],
                    diamondCount: prod['diamondCount'],
                    isFavourite: prod['isFavourite'],
                    prices: prod['prices'] == null
                        ? null
                        : Map<dynamic, dynamic>.from(prod['prices']),
                    imageUrl: Map<dynamic, dynamic>.from(prod['images']),
                    designDimensions: prod['designDimensions']),
              )
              .toList();
          // print('all');
          // print(allProducts.length);
          notifyListeners();
        } else if (select == 'featured') {
          featuredProducts = [];
          featuredProducts = extractedData['products']
              .map(
                (prod) => Product(
                    // // designDetails: Map<String, bool>.from(prod['designDetails']),
                    styleNumber: prod['styleNumber'],
                    diamondWeight: prod['diamondWeight'],
                    goldWeight: prod['goldWeight'],
                    diamondCount: prod['diamondCount'],
                    isFavourite: prod['isFavourite'],
                    prices: prod['prices'] == null
                        ? null
                        : Map<dynamic, dynamic>.from(prod['prices']),
                    imageUrl: Map<dynamic, dynamic>.from(prod['images']),
                    designDimensions: prod['designDimensions']),
              )
              .toList();
          // print(featuredProducts.length);
          // print('feat');

          notifyListeners();
        } else if (select == 'navratna') {
          highestSellingProducts = [];
          highestSellingProducts = extractedData['products']
              .map(
                (prod) => Product(
                    // // designDetails: Map<String, bool>.from(prod['designDetails']),
                    styleNumber: prod['styleNumber'],
                    diamondWeight: prod['diamondWeight'],
                    goldWeight: prod['goldWeight'],
                    diamondCount: prod['diamondCount'],
                    isFavourite: prod['isFavourite'],
                    prices: prod['prices'] == null
                        ? null
                        : Map<dynamic, dynamic>.from(prod['prices']),
                    imageUrl: Map<dynamic, dynamic>.from(prod['images']),
                    designDimensions: prod['designDimensions']),
              )
              .toList();
          // print('heigh');
          // print(highestSellingProducts.length);
          notifyListeners();
        } else if (select == 'fancyDiamond') {
          fancyDiamond = [];
          fancyDiamond = extractedData['products']
              .map(
                (prod) => Product(
                    // // designDetails: Map<String, bool>.from(prod['designDetails']),
                    styleNumber: prod['styleNumber'],
                    diamondWeight: prod['diamondWeight'],
                    goldWeight: prod['goldWeight'],
                    diamondCount: prod['diamondCount'],
                    isFavourite: prod['isFavourite'],
                    prices: prod['prices'] == null
                        ? null
                        : Map<dynamic, dynamic>.from(prod['prices']),
                    imageUrl: Map<dynamic, dynamic>.from(prod['images']),
                    designDimensions: prod['designDimensions']),
              )
              .toList();
          // print('fanc');
          // print(fancyDiamond.length);
          notifyListeners();
        } else {
          newProducts = [];
          newProducts = extractedData['products']
              .map(
                (prod) => Product(
                    // // designDetails: Map<String, bool>.from(prod['designDetails']),
                    styleNumber: prod['styleNumber'],
                    diamondWeight: prod['diamondWeight'],
                    goldWeight: prod['goldWeight'],
                    diamondCount: prod['diamondCount'],
                    isFavourite: prod['isFavourite'],
                    prices: prod['prices'] == null
                        ? null
                        : Map<dynamic, dynamic>.from(prod['prices']),
                    imageUrl: Map<dynamic, dynamic>.from(prod['images']),
                    designDimensions: prod['designDimensions']),
              )
              .toList();
          // print('new');
          // print(newProducts.length);
          notifyListeners();
        }
      }
    } on FormatException {
      throw "Oops Something Went Wrong!";
    } on PlatformException {
      throw "Oops Something Went Wrong!";
    } on SocketException {
      throw 'No Internet Connection! Please connect to Internet.';
    } catch (err) {
      throw err;
    }
  }

  Future<void> getFav(context) async {
    final url = 'user/favourite/';
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
        uurl + url,
        headers: {
          'Authorization':
              'Bearer ' + Provider.of<Auth>(context, listen: false).token,
        },
      );
      List<dynamic> loadedProducts;

      final extractedData = json.decode(response.body);
      if (extractedData['error'] != false) {
        throw HttpException(extractedData['details']['message']);
      }

      if (extractedData['products'] == null) {
        loadedProducts = [];
      } else {
        loadedProducts = extractedData['products']
            .map(
              (prod) => Product(
                // // designDetails: Map<String, bool>.from(prod['designDetails']),
                styleNumber: prod['styleNumber'],
                diamondWeight: prod['diamondWeight'],
                goldWeight: prod['goldWeight'],
                diamondCount: prod['diamondCount'],
                isFavourite: true,
                imageUrl: Map<dynamic, dynamic>.from(prod['images']),
                designDimensions: prod['designDimensions'],
                prices: prod['prices'] == null
                    ? null
                    : Map<dynamic, dynamic>.from(prod['prices']),
              ),
            )
            .toList();
      }

      favProducts = loadedProducts;
      notifyListeners();
      // print(favProducts);
    } on FormatException {
      throw "Oops Something Went Wrong!";
    } on PlatformException {
      throw "Oops Something Went Wrong!";
    } on SocketException {
      throw 'No Internet Connection! Please connect to Internet.';
    } catch (err) {
      throw err;
    }
  }

  Future<void> toogleFavourite(
      {String styleNumber, context, select, product}) async {
    int index;
    int check = 0;
    bool k = false;
    if (allProducts
            .indexWhere((element) => element.styleNumber == styleNumber) >=
        0) {
      check = 1;
      index = allProducts
          .indexWhere((element) => element.styleNumber == styleNumber);
      allProducts[index].isFavourite = !allProducts[index].isFavourite;
      // if (allProducts[index].isFavourite) {

      //   favProducts.add(allProducts[index]);
      // } else {

      //   favProducts.remove(allProducts[index]);
      // }
      check = 1;
    }
    if (newProducts
            .indexWhere((element) => element.styleNumber == styleNumber) >=
        0) {
      index = newProducts
          .indexWhere((element) => element.styleNumber == styleNumber);
      newProducts[index].isFavourite = !newProducts[index].isFavourite;
      // if (newProducts[index].isFavourite) {

      //   favProducts.add(newProducts[index]);
      // } else {

      //   favProducts.remove(newProducts[index]);
      // }
      check = 1;
    }
    if (featuredProducts
            .indexWhere((element) => element.styleNumber == styleNumber) >=
        0) {
      index = featuredProducts
          .indexWhere((element) => element.styleNumber == styleNumber);
      featuredProducts[index].isFavourite =
          !featuredProducts[index].isFavourite;
      // if (featuredProducts[index].isFavourite) {

      //   favProducts.add(featuredProducts[index]);
      // } else {

      //   favProducts.remove(featuredProducts[index]);
      // }

      check = 1;
    }
    if (fancyDiamond
            .indexWhere((element) => element.styleNumber == styleNumber) >=
        0) {
      index = fancyDiamond
          .indexWhere((element) => element.styleNumber == styleNumber);
      fancyDiamond[index].isFavourite = !fancyDiamond[index].isFavourite;
      // if (fancyDiamond[index].isFavourite) {

      //   favProducts.add(fancyDiamond[index]);
      // } else {

      //   favProducts.remove(fancyDiamond[index]);
      // }

      check = 1;
    }
    if (highestSellingProducts
            .indexWhere((element) => element.styleNumber == styleNumber) >=
        0) {
      index = highestSellingProducts
          .indexWhere((element) => element.styleNumber == styleNumber);
      highestSellingProducts[index].isFavourite =
          !highestSellingProducts[index].isFavourite;
      // if (highestSellingProducts[index].isFavourite) {

      //   favProducts.add(highestSellingProducts[index]);
      // } else {

      //   favProducts.remove(highestSellingProducts[index]);
      // }

      check = 1;
    }
    if (favProducts
            .indexWhere((element) => element.styleNumber == styleNumber) >=
        0) {
      k = true;

      index = favProducts
          .indexWhere((element) => element.styleNumber == styleNumber);

      favProducts.remove(favProducts[index]);
    } else {
      favProducts.add(product);
    }
    if (productDetailsForSearch.length > 0) {
      if (productDetailsForSearch[0].styleNumber == styleNumber) {
        productDetailsForSearch[0].isFavourite =
            !productDetailsForSearch[0].isFavourite;
      }
    }
    notifyListeners();

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
      final response = await http.post(uurl + 'user/favourite/toggle',
          headers: {
            'Authorization':
                'Bearer ' + Provider.of<Auth>(context, listen: false).token
          },
          body: {
            'styleNumber': styleNumber
          });
      final responseBody = json.decode(response.body);
      if (responseBody['error'] == true) {
        if (allProducts
                .indexWhere((element) => element.styleNumber == styleNumber) >=
            0) {
          check = 1;
          index = allProducts
              .indexWhere((element) => element.styleNumber == styleNumber);
          allProducts[index].isFavourite = !allProducts[index].isFavourite;
        }
        if (newProducts
                .indexWhere((element) => element.styleNumber == styleNumber) >=
            0) {
          index = newProducts
              .indexWhere((element) => element.styleNumber == styleNumber);
          newProducts[index].isFavourite = !newProducts[index].isFavourite;
        }
        if (featuredProducts
                .indexWhere((element) => element.styleNumber == styleNumber) >=
            0) {
          index = featuredProducts
              .indexWhere((element) => element.styleNumber == styleNumber);
          featuredProducts[index].isFavourite =
              !featuredProducts[index].isFavourite;

          check = 1;
        }
        if (fancyDiamond
                .indexWhere((element) => element.styleNumber == styleNumber) >=
            0) {
          index = fancyDiamond
              .indexWhere((element) => element.styleNumber == styleNumber);
          fancyDiamond[index].isFavourite = !fancyDiamond[index].isFavourite;

          check = 1;
        }
        if (highestSellingProducts
                .indexWhere((element) => element.styleNumber == styleNumber) >=
            0) {
          index = highestSellingProducts
              .indexWhere((element) => element.styleNumber == styleNumber);
          highestSellingProducts[index].isFavourite =
              !highestSellingProducts[index].isFavourite;

          check = 1;
        }
        if (favProducts
                .indexWhere((element) => element.styleNumber == styleNumber) >=
            0) {
          index = favProducts
              .indexWhere((element) => element.styleNumber == styleNumber);
          favProducts.remove(favProducts[index]);
        } else {
          favProducts.add(product);
        }
        if (productDetailsForSearch.length > 0) {
          if (productDetailsForSearch[0].styleNumber == styleNumber) {
            productDetailsForSearch[0].isFavourite =
                !productDetailsForSearch[0].isFavourite;
          }
        }
        notifyListeners();
        throw HttpException(responseBody['details']['message']);
      }
    } on SocketException {
      if (allProducts
              .indexWhere((element) => element.styleNumber == styleNumber) >=
          0) {
        check = 1;
        index = allProducts
            .indexWhere((element) => element.styleNumber == styleNumber);
        allProducts[index].isFavourite = !allProducts[index].isFavourite;
      }
      if (newProducts
              .indexWhere((element) => element.styleNumber == styleNumber) >=
          0) {
        index = newProducts
            .indexWhere((element) => element.styleNumber == styleNumber);
        newProducts[index].isFavourite = !newProducts[index].isFavourite;
      }
      if (featuredProducts
              .indexWhere((element) => element.styleNumber == styleNumber) >=
          0) {
        index = featuredProducts
            .indexWhere((element) => element.styleNumber == styleNumber);
        featuredProducts[index].isFavourite =
            !featuredProducts[index].isFavourite;
        check = 1;
      }
      if (fancyDiamond
              .indexWhere((element) => element.styleNumber == styleNumber) >=
          0) {
        index = fancyDiamond
            .indexWhere((element) => element.styleNumber == styleNumber);
        fancyDiamond[index].isFavourite = !fancyDiamond[index].isFavourite;

        check = 1;
      }
      if (highestSellingProducts
              .indexWhere((element) => element.styleNumber == styleNumber) >=
          0) {
        index = highestSellingProducts
            .indexWhere((element) => element.styleNumber == styleNumber);
        highestSellingProducts[index].isFavourite =
            !highestSellingProducts[index].isFavourite;
        check = 1;
      }
      if (favProducts
              .indexWhere((element) => element.styleNumber == styleNumber) >=
          0) {
        index = favProducts
            .indexWhere((element) => element.styleNumber == styleNumber);
        favProducts.remove(favProducts[index]);
      } else {
        favProducts.add(product);
      }
      if (productDetailsForSearch.length > 0) {
        if (productDetailsForSearch[0].styleNumber == styleNumber) {
          productDetailsForSearch[0].isFavourite =
              !productDetailsForSearch[0].isFavourite;
        }
      }
      notifyListeners();

      throw 'No Internet Connection! Please connect to Internet.';
    } on PlatformException {
      throw "Oops Something Went Wrong!";
    } on FormatException {
      throw "Oops Something Went Wrong!";
    } catch (error) {
      if (allProducts
              .indexWhere((element) => element.styleNumber == styleNumber) >=
          0) {
        check = 1;
        index = allProducts
            .indexWhere((element) => element.styleNumber == styleNumber);
        allProducts[index].isFavourite = !allProducts[index].isFavourite;
      }
      if (newProducts
              .indexWhere((element) => element.styleNumber == styleNumber) >=
          0) {
        index = newProducts
            .indexWhere((element) => element.styleNumber == styleNumber);
        newProducts[index].isFavourite = !newProducts[index].isFavourite;
      }
      if (featuredProducts
              .indexWhere((element) => element.styleNumber == styleNumber) >=
          0) {
        index = featuredProducts
            .indexWhere((element) => element.styleNumber == styleNumber);
        featuredProducts[index].isFavourite =
            !featuredProducts[index].isFavourite;
        check = 1;
      }
      if (fancyDiamond
              .indexWhere((element) => element.styleNumber == styleNumber) >=
          0) {
        index = fancyDiamond
            .indexWhere((element) => element.styleNumber == styleNumber);
        fancyDiamond[index].isFavourite = !fancyDiamond[index].isFavourite;

        check = 1;
      }
      if (highestSellingProducts
              .indexWhere((element) => element.styleNumber == styleNumber) >=
          0) {
        index = highestSellingProducts
            .indexWhere((element) => element.styleNumber == styleNumber);
        highestSellingProducts[index].isFavourite =
            !highestSellingProducts[index].isFavourite;
        check = 1;
      }
      if (favProducts
              .indexWhere((element) => element.styleNumber == styleNumber) >=
          0) {
        index = favProducts
            .indexWhere((element) => element.styleNumber == styleNumber);
        favProducts.remove(favProducts[index]);
      } else {
        favProducts.add(product);
      }
      if (productDetailsForSearch.length > 0) {
        if (productDetailsForSearch[0].styleNumber == styleNumber) {
          productDetailsForSearch[0].isFavourite =
              !productDetailsForSearch[0].isFavourite;
        }
      }
      notifyListeners();
      throw error;
    }
  }

  Future<void> getProductDetail({context, styleNumber}) async {
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
        uurl + 'product/single?styleNumber=$styleNumber',
        headers: {
          'Authorization':
              'Bearer ' + Provider.of<Auth>(context, listen: false).token
        },
      );
      final responseData = json.decode(response.body);
      if (responseData['error'] != false) {
        throw HttpException(responseData['details']['message']);
      }

      List<dynamic> loadedProducts = responseData['product']
          .map(
            (prod) => Product(
                // // designDetails: Map<String, bool>.from(prod['designDetails']),
                styleNumber: prod['styleNumber'],
                diamondWeight: prod['diamondWeight'],
                goldWeight: prod['goldWeight'],
                diamondCount: prod['diamondCount'],
                isFavourite: prod['isFavourite'],
                imageUrl: Map<dynamic, dynamic>.from(prod['images']),
                prices: prod['prices'] == null
                    ? null
                    : Map<dynamic, dynamic>.from(prod['prices']),
                designDimensions: prod['designDimensions']),
          )
          .toList();
      productDetailsForSearch = loadedProducts;
    } on FormatException {
      throw "Oops Something Went Wrong!";
    } on PlatformException {
      throw "Oops Something Went Wrong!";
    } on SocketException {
      throw 'No Internet Connection! Please connect to Internet.';
    } catch (err) {
      throw err;
    }
  }

  Future<void> setCom({comm, context}) async {
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
    this.comm = comm;

    try {
      final response = await http.patch(uurl + 'user/comission', headers: {
        'Authorization':
            'Bearer ' + Provider.of<Auth>(context, listen: false).token
      }, body: {
        "comission": comm.toString()
      });
      final responseData = json.decode(response.body);
      if (responseData['error'] != false) {
        throw HttpException(responseData['details']['message']);
      }
    } on FormatException {
      throw "Oops Something Went Wrong!";
    } on PlatformException {
      throw "Oops Something Went Wrong!";
    } on SocketException {
      throw 'No Internet Connection! Please connect to Internet.';
    } catch (err) {
      throw err;
    }
  }
}
