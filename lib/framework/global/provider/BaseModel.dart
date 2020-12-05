import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gitters/application.dart';
import 'package:gitters/framework/global/constants/Constant.dart';

class BaseModel with ChangeNotifier, DiagnosticableTreeMixin {
  ThemeData _themeData = ThemeData(primarySwatch: Colors.grey);

  static String language;
  static String country;
  Locale _locale;

  BaseModel() {
    language = diskCache.getString(Constant.LANGUAGE);
    country = diskCache.getString(Constant.COUNTER);
    _locale = Locale(language, country);
  }

  ThemeData get themeData => _themeData;

  Locale get locale => _locale;

  void updateThemeData(ThemeData themeData) {
    _themeData = themeData;
    notifyListeners();
  }

  void changeLanuage(Locale locale) {
    _locale = locale;
    notifyListeners();
  }
}
