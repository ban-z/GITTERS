import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:github/github.dart';
import 'package:gitters/business/fragment/profile/Profile.dart';
import 'package:gitters/business/fragment/user-repo/Branches.dart';
import 'package:gitters/business/fragment/user-repo/RepoContent.dart';
import 'package:gitters/business/fragment/user-repo/Repository.dart';
import 'package:gitters/business/home/HomePage.dart';
import 'package:gitters/business/login/LoginPage.dart';
import 'package:gitters/business/widgets/pages/EmptyPage.dart';
import 'package:gitters/business/widgets/pages/Internationalization.dart';
import 'package:gitters/business/widgets/pages/appThemeSetting.dart';
import 'package:gitters/business/widgets/pages/UserHelper.dart';
import 'package:gitters/business/widgets/pages/repos.dart';
import 'package:gitters/framework/utils/utils.dart';

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

var userHelperHandler = Handler(handlerFunc: (context, parameters) {
  return UserHelperCenter();
});

var followingReposHandler = Handler(
  handlerFunc: (context, parameters) {
    final args = context.settings.arguments as FollowingPageRouterArguments;
    String curUserLogin = args.curUser;
    String pageTitle = args?.pageTitle ?? '';
    return FollowingRepos(
      curUserLogin,
      title: pageTitle,
    );
  },
);

var userRepositoryHome = Handler(
  handlerFunc: (context, parameters) {
    final slug = context.settings.arguments as RepositorySlug;
    return UserRepositoryHome(slug);
  },
);

var userRepositoryBranch = Handler(
  handlerFunc: (context, parameters) {
    final slug = context.settings.arguments as RepositorySlug;
    return Branches(slug);
  },
);

var userRepositoryContents = Handler(
  handlerFunc: (context, parameters) {
    final args = context.settings.arguments as String;
    return RepoContent(args);
  },
);

var appThemeSetting = Handler(handlerFunc: (context, parameters) {
  return AppThemeSetting();
});

var internationalization = Handler(handlerFunc: (context, parameters) {
  return Internationalization();
});

var personalAccessTokenHandler = Handler(handlerFunc: (context, parameters) {
  return PersonalAcessTokensWebView();
});

var aboutGitHubAppHandler = Handler(handlerFunc: (context, parameters) {
  return AboutGitHubApp();
});

var emptyHandler = Handler(handlerFunc: (context, parameters) {
  return EmptyPage();
});
