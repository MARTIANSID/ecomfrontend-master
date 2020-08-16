import 'dart:convert';
import 'dart:io';

import 'package:Flutter/constant/const.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'auth.dart';

class Noti {
  String title;
  String body;
  String name;
  String link;
  bool read;
  DateTime createdAt;

  var id;
  Noti(
      {this.body,
      this.createdAt,
      this.title,
      this.id,
      this.link,
      this.name,
      this.read});
}

class Notif with ChangeNotifier {
  // final uurl = "https://echo.gemstory.in/";
  List<dynamic> notifications = [];

  Future<void> readNNotification({context, id}) async {
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
    int index = notifications.indexWhere((element) => element.id == id);
    if (notifications[index].read == false) {
      try {
        final response = await http.post(uurl + 'notification/read', headers: {
          'Authorization':
              'Bearer ' + Provider.of<Auth>(context, listen: false).token,
        }, body: {
          "notifid": id,
        });
        if (response.statusCode == 200) {
          int index = notifications.indexWhere((element) => element.id == id);
          notifications[index].read = true;
          notifyListeners();
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

  Future<void> deleteNotification({context, id}) async {
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
    var ele;
    try {
      int index = notifications.indexWhere((element) => element.id == id);
      ele = notifications[index];
      notifications.removeWhere((element) => element.id == id);
      notifyListeners();
      final response = await http.post(uurl + 'notification/delete/', headers: {
        'Authorization':
            'Bearer ' + Provider.of<Auth>(context, listen: false).token,
      }, body: {
        "notifid": id
      });
      if (response.statusCode == 200) {
        // print('done!!!');
      }
    } on FormatException {
      throw "Oops Something Went Wrong!";
    } on PlatformException {
      throw "Oops Something Went Wrong!";
    } on SocketException {
      throw 'No Internet Connection! Please connect to Internet.';
    } catch (err) {
      notifications.add(ele);
      throw err;
    }
  }

  Future<void> getNotification({context}) async {
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
        uurl + 'notification',
        headers: {
          'Authorization':
              'Bearer ' + Provider.of<Auth>(context, listen: false).token,
        },
      );
      final responseData = json.decode(response.body);
      List<dynamic> list = responseData['notifications']
          .map((i) => Noti(
              body: i['body'],
              title: i['title'],
              createdAt: DateFormat("yyyy-MM-ddTHH:mm:ss")
                  .parse(i['createdAt'], true)
                  .toLocal(),
              name: i['data']['name'],
              link: i['data'] == null ? '' : i['data']['link'],
              read: i['read'],
              id: i['_id']))
          .toList();
      notifications = list.reversed.toList();
      // print(notifications);

      notifyListeners();
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

  bool checkForDelete() {
    var check = true;
    notifications.forEach((element) {
      if (element.read == false) {
        check = false;
      }
    });
    return check;
  }

  Future<void> deleteAll({context}) async {
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
        uurl + 'notification/delete/all',
        headers: {
          'Authorization':
              'Bearer ' + Provider.of<Auth>(context, listen: false).token,
        },
      );
      final responseData = json.decode(response.body);
      if (response.statusCode == 200) {
        notifications = [];
        notifyListeners();
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

  Future<void> readAll({context}) async {
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
        uurl + 'notification/read/all',
        headers: {
          'Authorization':
              'Bearer ' + Provider.of<Auth>(context, listen: false).token,
        },
      );

      if (response.statusCode == 200) {
        notifications.forEach((element) {
          if (element.read == false) {
            int indx = notifications.indexOf(element);
            notifications[indx].read = true;
          }
          notifyListeners();
        });
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
