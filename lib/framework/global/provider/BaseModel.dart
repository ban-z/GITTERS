import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class BaseModel with ChangeNotifier, DiagnosticableTreeMixin {
  ThemeData _themeData = ThemeData(primarySwatch: Colors.grey);

  ThemeData get themeData => _themeData;

  void updateThemeData(ThemeData themeData) {
    _themeData = themeData;
    notifyListeners();
  }
}
