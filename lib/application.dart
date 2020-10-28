import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

// 定义路由手表，收敛相关常量定义
class RouterList {
  final _value;
  const RouterList._internal(this._value);
  String get value => _value;

  // 定义常用路由
  static const Home = const RouterList._internal("/");
  static const Login = const RouterList._internal('/login');
}

// Application类用来做App通用的配置：Router，Provider等
class Application {
  static FluroRouter router;
}
