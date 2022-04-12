import 'package:flutter/material.dart';
import 'package:madarskom/Services/ThemeApp/SharedPreferenceTheme/Colors_App.dart';

ThemeData lightTheme(){
  return ThemeData(
    cardColor: ConstantColor.cardColor,
    primaryColor: PrimaryColor.lightTheme, // is a main color of app for example it change the color of appbar
    hintColor: HintColor.lightTheme,
    scaffoldBackgroundColor: ScafolledBackGroundColor.lightTheme,
   canvasColor:CanvasColor.lightTheme ,
    appBarTheme:AppBarTheme(
        elevation: 10,
        iconTheme: IconThemeData(
          color: ConstantColor.appBarIcon,
        )
    ),





    textTheme: ThemeData.dark().textTheme.copyWith(
      bodyText1: TextStyle(
        color: Colors.black, fontSize: 20,
      ),
      bodyText2: TextStyle(
          color: Colors.indigo[900], fontSize: 20,
          fontWeight: FontWeight.bold
      ),)
  );
}
