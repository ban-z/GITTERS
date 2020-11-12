import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:gitters/business/login/LoginPage.dart';
import 'package:gitters/framework/constants/language/Localizations.dart';
import 'package:gitters/framework/global/provider/BaseModel.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'application.dart';
import 'framework/router/RouterConfig.dart';
import 'framework/constants/language/GittersLocalizationsDelegate.dart';
import 'framework/utils/I18NWidget.dart';

/* main入口方法 */
Future<void> main() async {
  // 路由的初始化
  WidgetsFlutterBinding.ensureInitialized();
  diskCache = await SharedPreferences.getInstance();
  FluroRouter router = new FluroRouter();
  RouterConfig.configRouter(router); // 关联自定义路由配置
  fluroRouter = router; // 存入Application中供全局调用
  runApp(Wrapper(child: MyApp()));
}

// Future<void> main() async {
//   //TODO: 在runApp()执行之前，涉及到异步方法的调用，需要调用次方法，具体原因待查
//   WidgetsFlutterBinding.ensureInitialized();
//   // 自定义Global的初始化
//   Global.init();
//   // 路由的初始化
//   //GitHub github = GitHub(); // 创建一个GitHub Client，TODO:默认情况下使用匿名身份验证，之后可以选择使用此进行登录，或者使用原登录接口，然后注入Token
//   // var github = GitHub(auth: Authentication.basic('username', 'password')); //之后登录替换为此用法
//   FluroRouter router = new FluroRouter();
//   RouterConfig.configRouter(router); // 关联自定义路由配置
//   //Application.github = github; // 保存全局变量github
//   Application.router = router; // 存入Application中供全局调用
//   runApp(Wrapper(child: MyApp()));
// }

/* 国际化Globalkey设置 */
GlobalKey<I18nWidgetState> i18nWidgetStateKey = GlobalKey<I18nWidgetState>();

/* 初始化Provider */
class Wrapper extends StatelessWidget {
  final Widget child;

  Wrapper({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => BaseModel()),
        // ChangeNotifierProvider(create: (_) => UserModel())
      ],
      child: child,
    );
  }
}

/* 根容器：国际化配置 */
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateTitle: (context) {
        // //默认的build()的context对象无法获得 GittersLocalizations对象，所以这里引用 onGenerateTitle的context对象
        return GittersLocalizations.of(context).ApplicationName;
      },
      theme: context.watch<BaseModel>().themeData,
      home: new Builder(builder: (context) {
        return I18nWidget(
          key: i18nWidgetStateKey,
          //child: HomePage(),
          child: LoginPage(),
        );
      }),
      localizationsDelegates: [
        GlobalMaterialLocalizations
            .delegate, // 为Material Components库提供了本地化的字符串和其他值
        GlobalWidgetsLocalizations.delegate, // 定义widget默认的文本方向，从左到右或从右到左
        GittersLocalizationsDelegate.delegate, // 自定义LocalizationsDelegate协议
      ],
      supportedLocales: [
        const Locale('zh', 'CH'),
        const Locale('en', 'US'),
      ],
    );
  }
}
