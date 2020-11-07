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
}

class RouterConfig {
  static String homePage = RouterList.Home.value; // 一定要配置默认主页 "/"顶级根路由
  static String loginPage = RouterList.Login.value;
  static String profilePage = RouterList.Profile.value;

  static void configRouter(FluroRouter router) {
    router.define(homePage, handler: homeHandler);
    router.define(loginPage, handler: loginHandler);
    router.define(profilePage, handler: profileHandler);
    router.notFoundHandler = emptyHandler; //空页面
  }
}
