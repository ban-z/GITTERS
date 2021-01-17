import 'package:fluro/fluro.dart';
import 'RouteHandles.dart';

// 定义路由列表，收敛相关常量定义
class RouterList {
  final _value;
  const RouterList._internal(this._value);
  String get value => _value;

  // 定义常用路由
  static const Home = const RouterList._internal("/");
  static const Login = const RouterList._internal('/login');
  static const Profile = const RouterList._internal('/profile');
  static const UserHelperCenter = const RouterList._internal('/user_helper');
  static const PersonalAcessTokensWebView =
      const RouterList._internal('/user_helper/personal_access_token');
  static const AboutGitHubApp = const RouterList._internal('/about_github_app');
  static const AppThemeSetting =
      const RouterList._internal('/profile/app_theme_setting');
  static const Internationalization =
      const RouterList._internal('/profile/internationalization');
  static const FollowingRepos =
      const RouterList._internal('/marketPlace/following/repos');
  static const UserRepositoryHome =
      const RouterList._internal('/user/repository/home');
  static const UserRepositoryBranch =
      const RouterList._internal('/user/repository/branch');
}

class RouterConfig {
  // static String homePage = RouterList.Home.value; // 一定要配置默认主页 "/"顶级根路由
  // static String loginPage = RouterList.Login.value;
  // static String profilePage = RouterList.Profile.value;
  // static String userHelperPage = RouterList.UserHelperCenter.value;

  static void configRouter(FluroRouter router) {
    router.define(RouterList.Home.value, handler: homeHandler);
    router.define(RouterList.Login.value, handler: loginHandler);
    router.define(RouterList.Profile.value, handler: profileHandler);
    router.define(RouterList.UserHelperCenter.value,
        handler: userHelperHandler);
    router.define(RouterList.PersonalAcessTokensWebView.value,
        handler: personalAccessTokenHandler);
    router.define(RouterList.AboutGitHubApp.value,
        handler: aboutGitHubAppHandler);
    router.define(RouterList.AppThemeSetting.value, handler: appThemeSetting);
    router.define(RouterList.Internationalization.value,
        handler: internationalization);
    router.define(RouterList.FollowingRepos.value,
        handler: followingReposHandler);
    router.define(RouterList.UserRepositoryHome.value,
        handler: userRepositoryHome);
    router.define(RouterList.UserRepositoryBranch.value,
        handler: userRepositoryBranch);
    router.notFoundHandler = emptyHandler; //空页面
  }
}
