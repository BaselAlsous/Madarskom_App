import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';


class ThemeProviders with ChangeNotifier{

  var tm = ThemeMode.system;
  String themeText = "s";

  void themeModeChange(newThemValue) async{
    tm = newThemValue;
    _getThemeText(tm);
    notifyListeners();
    SharedPreferences prefs =await SharedPreferences.getInstance();
    prefs.setString("themeText", themeText);

    print(prefs.getString("themeText"));
  }
  _getThemeText(ThemeMode tm ){
    if(tm==ThemeMode.dark) themeText="d";
    else if(tm==ThemeMode.light) themeText="l";
    else if(tm==ThemeMode.system) themeText="s";
    notifyListeners();
  }
  getThemeMode()async{
    SharedPreferences prefs =await SharedPreferences.getInstance();
    themeText =  prefs.getString("themeText")??"s";
    if(themeText=="d") tm=ThemeMode.dark;
    else if(themeText=="l") tm=ThemeMode.light;
    else if(themeText=="s") tm=ThemeMode.system;
    notifyListeners();
  }

}