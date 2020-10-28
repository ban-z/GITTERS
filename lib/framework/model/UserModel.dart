import 'package:flutter/material.dart';

// ChangeNotifier，这个类能够帮驻我们自动管理所有 Listener
// 当调用 notifyListeners() 时，它会通知所有 Listener 进行刷新
class UserModel with ChangeNotifier {
  // 用户信息
  String _userName = "";
  String _account = "";
  String _password = "";
  String _token = "";

  String get userName => _userName;
  String get account => _account; // 数据安全，后续调整
  String get password => _password; // 数据安全，后续调整
  String get token => _token;

  // 更新方法
  void changeUserName(String newName) {
    _userName = newName;
    notifyListeners();
  }

  void setAccount(String account) {
    _account = account;
    notifyListeners();
  }

  void setPassword(String password) {
    _password = password;
    notifyListeners();
  }

  void setToekn(String token) {
    _token = token;
    notifyListeners();
  }
}
