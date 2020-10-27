import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:gitters/business/home/HomePage.dart';
import 'RouteHandles.dart';

class RouterConfig {
  static String homePage = "/"; // 一定要配置默认主页 "/"顶级根路由
  static String loginPage = "/login";

  static void configRouter(FluroRouter router) {
    router.define(homePage, handler: homeHandler);
    router.define(loginPage, handler: loginHandler);
    router.notFoundHandler = emptyHandler; //空页面
  }
}
