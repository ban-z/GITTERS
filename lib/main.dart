import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:gitters/business/home/HomePage.dart';
import 'package:gitters/framework/constants/language/Localizations.dart';
import 'package:gitters/framework/global/BaseModel.dart';
import 'package:gitters/framework/global/Global.dart';
import 'package:gitters/framework/global/UserModel.dart';
import 'package:provider/provider.dart';
import 'application.dart';
import 'framework/router/RouterConfig.dart';
import 'framework/constants/language/GittersLocalizationsDelegate.dart';
import 'framework/utils/I18NWidget.dart';

/* 初始化路由 */
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Global.init();
  FluroRouter router = new FluroRouter();
  RouterConfig.configRouter(router);
  Application.router = router;
  runApp(Wrapper(child: MyApp()));
}

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
        ChangeNotifierProvider(create: (_) => UserModel())
      ],
      child: child,
    );
  }
}

/* 国际化配置 */
/* 根容器 */
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
          child: HomePage(),
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
