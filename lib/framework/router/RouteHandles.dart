import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:gitters/business/fragment/profile/Profile.dart';
import 'package:gitters/business/home/HomePage.dart';
import 'package:gitters/business/login/LoginPage.dart';
import 'package:gitters/business/widgets/pages/EmptyPage.dart';
import 'package:gitters/business/widgets/pages/Internationalization.dart';
import 'package:gitters/business/widgets/pages/UserHelper.dart';

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

var userHelperHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return UserHelperCenter();
});

var internationalization = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return AppThemeSetting();
});

var personalAccessTokenHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return PersonalAcessTokensWebView();
});

var aboutGitHubAppHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return AboutGitHubApp();
});

var emptyHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return EmptyPage();
});
