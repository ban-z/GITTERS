import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class BaseModel with ChangeNotifier, DiagnosticableTreeMixin {
  ThemeData _themeData = ThemeData(primarySwatch: Colors.amber);

  ThemeData get themeData => _themeData;

  void updateThemeData(ThemeData themeData) {
    _themeData = themeData;
    notifyListeners();
  }
}
