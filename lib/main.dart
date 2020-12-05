import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:gitters/business/login/LoginPage.dart';
import 'package:gitters/framework/global/provider/BaseModel.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'application.dart';
import 'framework/global/constants/language/GittersLocalizationsDelegate.dart';
import 'framework/global/constants/language/Localizations.dart';
import 'framework/router/RouterConfig.dart';
import 'framework/utils/I18n.dart';

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

/* 初始化Provider */
class Wrapper extends StatelessWidget {
  final Widget child;

  Wrapper({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => BaseModel()),
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
      locale: context.watch<BaseModel>().locale,
      theme: context.watch<BaseModel>().themeData,
      home: LoginPage(),
      localizationsDelegates: [
        GlobalMaterialLocalizations
            .delegate, // 为Material Components库提供了本地化的字符串和其他值
        GlobalCupertinoLocalizations.delegate,
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
