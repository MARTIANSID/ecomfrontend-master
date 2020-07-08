import 'package:flutter/cupertino.dart';

class Noti {
  String title;
  String body;
  String link;
  var id;
  Noti({this.body, this.link, this.title, this.id});
}

class Notif with ChangeNotifier {
  List<Noti> notifications = [];

  void notiAdd({title, body, link, id}) {
    notifications.add(Noti(body: body, title: title, link: link, id: id));
    print(notifications);
    notifyListeners();
  }

  void notiDelete({id}) {
    notifications.removeWhere((element) => element.id == id);
    notifyListeners();
  }
}
