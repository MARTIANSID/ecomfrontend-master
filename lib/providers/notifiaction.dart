import 'dart:convert';

import 'package:flutter/cupertino.dart';
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

  var id;
  Noti({this.body, this.title, this.id, this.link, this.name, this.read});
}

class Notif with ChangeNotifier {
  final uurl = "https://alexa.gemstory.in/";
  List<dynamic> notifications = [];

  // void notiAdd({title, body, link, id}) {
  //   notifications.add(Noti(body: body, title: title, link: link, id: id));
  //   print(notifications);
  //   notifyListeners();
  // }

  // void notiDelete({id}) {
  //   notifications.removeWhere((element) => element.id == id);
  //   notifyListeners();
  // }
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
    try {
      final response = await http.get(
        uurl + '/notifications',
        headers: {
          'Authorization':
              'Bearer ' + Provider.of<Auth>(context, listen: false).token,
        },
      );
      if (response.statusCode == 200) {
        int index = notifications.indexWhere((element) => element.id == id);
        notifications[index].read = !notifications[index].read;
        notifyListeners();
      }
    } catch (err) {
      throw err;
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
    try {
      final response = await http.post(uurl + 'notification/delete/', headers: {
        'Authorization':
            'Bearer ' + Provider.of<Auth>(context, listen: false).token,
      }, body: {
        "notifid": id
      });
      if (response.statusCode == 200) {
        notifications.removeWhere((element) => element.id == id);
        notifyListeners();
      }
    } catch (err) {
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
        uurl + '/notification',
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
              name: i['data']['name'],
              link: i['data'] == null ? '' : i['data']['link'],
              read: i['reade'],
              id: i['_id']))
          .toList();
      notifications = list;
      print(notifications);

      notifyListeners();
    } catch (err) {
      throw err;
    }
  }
}

// }{
//             "_id": "5f0a38d12df6bb1c87733233",
//             "title": "This is a Title 2",
//             "body": "Uh oh! the data you've sent is not as expected #Contact the developer!",
//             "data": {
//                 "name": "Hello",
//                 "link": "GS100027"
//             },
//             "read": false
// //         }
// {
//     "error": false,
//     "notifications": [
//         {
//             "_id": "5f0a33126a9d611a3dae94a6",
//             "title": "This is a Title 2",
//             "body": "Uh oh! the data you've sent is not as expected #Contact the developer!",
//             "read": false
//         },
//         {
//             "_id": "5f0a389a2df6bb1c87733232",
//             "title": "This is a Title 2",
//             "body": "Uh oh! the data you've sent is not as expected #Contact the developer!",
//             "read": false
//         },
//         {
//             "_id": "5f0a38d12df6bb1c87733233",
//             "title": "This is a Title 2",
//             "body": "Uh oh! the data you've sent is not as expected #Contact the developer!",
//             "data": {
//                 "name": "Hello",
//                 "link": "GS100027"
//             },
//             "read": false
//         }
//     ]
// }
