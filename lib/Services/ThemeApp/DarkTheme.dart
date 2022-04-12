import 'package:flutter/material.dart';

import 'SharedPreferenceTheme/Colors_App.dart';

ThemeData darkTheme() {
  var themeData = ThemeData(
      canvasColor: CanvasColor.darkTheme,
      cardColor: ConstantColor.cardColor,
      primaryColor: PrimaryColor.darkTheme,
      // is a main color of app for example it change the color of appbar
      hintColor: HintColor.darkTheme,
      scaffoldBackgroundColor: ScafolledBackGroundColor.darkTheme,
      appBarTheme: AppBarTheme(
          elevation: 10,
          iconTheme: IconThemeData(
            color: ConstantColor.appBarIcon,
          )),
      textTheme: ThemeData.dark().textTheme.copyWith(
            bodyText1: TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
            bodyText2: TextStyle(
                color: Colors.lightBlue[300],
                fontSize: 20,
                fontWeight: FontWeight.bold),
          ));
  return themeData;
}
