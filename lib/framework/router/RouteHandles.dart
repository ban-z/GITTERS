import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:gitters/business/fragment/profile/Profile.dart';
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

var profileHandler = Handler(
  handlerFunc: (context, parameters) {
    return Profile();
  },
);

var emptyHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return EmptyPage();
});