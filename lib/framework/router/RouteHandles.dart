import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:gitters/business/home/HomePage.dart';
import 'package:gitters/business/login/LoginPage.dart';
import 'package:gitters/framework/utils/pages/EmptyPage.dart';

var loginHandler = Handler(
  handlerFunc: (context, parameters) {
    return LoginPage();
  },
);

var homeHandler = Handler(
  handlerFunc: (context, parameters) {
    return HomePage();
  },
);

var emptyHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return EmptyPage();
});

// 参考
/* //空页面
var emptyHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      return PageEmpty();
    });

//A页面
var aHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<Object>> params) {
      return PageA();
    });

//B页面
var bHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<Object>> params) {
      return PageB();
    }); */
