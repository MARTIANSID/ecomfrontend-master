import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Options with ChangeNotifier {
  int build;
  int certificate;
  int color;
  int diamondQuality;
  int sort = 0;
  int sortBy = -1;

  setBuild({build}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('build', build);
    this.build = build;
    notifyListeners();
  }

  setCert({cert}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setInt('certificate', cert);
    this.certificate = cert;
    notifyListeners();
  }

  setColor({color}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setInt('color', color);
    this.color = color;
    notifyListeners();
  }

  setDiamond({diamond}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setInt('diamondQuality', diamond);
    this.diamondQuality = diamond;
    notifyListeners();
  }

  // setSort({sort}) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   prefs.setInt('sort', sort);
  //   this.sort = sort;
  // }

  // setSortBy({sortBy}) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   prefs.setInt('sortBy', sortBy);
  //   this.sortBy = sortBy;
  // }

  getStringValuesSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    build = prefs.getInt('build');
    certificate = prefs.getInt('certificate');
    diamondQuality = prefs.getInt('diamondQuality');
    notifyListeners();
  }

  // void change(select) {
  //   if (select == 'build') {
  //     b = true;
  //     c = false;
  //     co = false;
  //     d = false;
  //     notifyListeners();
  //   }
  //   if(select=='certificate'){
  //      b = false;
  //     c = true;
  //     co = false;
  //     d = false;

  //   notifyListeners();

  //   }
  //     if(select=='color'){
  //        b = false;
  //     c = false;
  //     co = true;
  //     d = false;

  //   notifyListeners();

  //   }
  //     if(select=='diamond'){
  //        b = false;
  //     c = false;
  //     co = false;
  //     d = true;

  //   notifyListeners();

  //   }
  // }

}
