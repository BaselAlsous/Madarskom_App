import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ignore: camel_case_types


class SetLocalization {
  final Locale locale;

  SetLocalization(this.locale);



  static SetLocalization of(BuildContext context) {
    return Localizations.of<SetLocalization>(context, SetLocalization);
  }

 static  LocalizationsDelegate <SetLocalization> localizationsDelegate = _GetlocalizationsDelegate();

  Map<String, String> _localizedvalues;
  // ignore: missing_return
  Future<bool> load() async
  {
    String jsonStringValues = await rootBundle.loadString('lang/${locale.languageCode}.json');
    // ignore: non_constant_identifier_names
    Map<String, dynamic> Mappedjason = json.decode(jsonStringValues);
    _localizedvalues =Mappedjason.map((key, value) => MapEntry(key, value.toString()));
  }
  String getTranslateValue(String key) {
     return _localizedvalues[key];
  }
}


class _GetlocalizationsDelegate extends LocalizationsDelegate<SetLocalization>{
  @override
  bool isSupported(Locale locale) {
    return ["en", "ar"].contains(locale.languageCode);
  }

  @override
  Future<SetLocalization> load(Locale locale) async{
    SetLocalization localization = new SetLocalization(locale);
      await localization.load();
       return localization;
  }

  @override
  bool shouldReload(covariant LocalizationsDelegate old) {
    return false;
  }

}
