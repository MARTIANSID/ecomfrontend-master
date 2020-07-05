import 'package:flutter/cupertino.dart';

class Noti {
  String title;
  String body;
  var data;
  Noti({this.body, this.data, this.title});
}

class Notif with ChangeNotifier {
  List<Noti> notifications = [];

  void notiAdd({title, body, data}) {
    notifications.add(Noti(body: body, title: title, data: data));
  }
}
