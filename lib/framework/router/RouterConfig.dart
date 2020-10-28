import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:gitters/business/home/HomePage.dart';
import 'package:gitters/application.dart';
import 'RouteHandles.dart';

class RouterConfig {
  static String homePage = RouterList.Home.value; // 一定要配置默认主页 "/"顶级根路由
  static String loginPage = RouterList.Login.value;

  static void configRouter(FluroRouter router) {
    router.define(homePage, handler: homeHandler);
    router.define(loginPage, handler: loginHandler);
    router.notFoundHandler = emptyHandler; //空页面
  }
}
