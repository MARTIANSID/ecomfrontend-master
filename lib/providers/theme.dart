import 'package:flutter/material.dart';

class ThemeP with ChangeNotifier{
  Color _primaryColor=const Color(0xFF19D2C2);//Color(0xFFD06AA9);
   Color _accentColor=const Color(0xFF323031);//;

  void themeRefresh(Color primaryColor,Color accentColor){
    _primaryColor=primaryColor;
    _accentColor=accentColor;
    notifyListeners();
  }
  ThemeData themeProvider(){
    return ThemeData(primaryColor: _primaryColor,accentColor: _accentColor);
  }
}