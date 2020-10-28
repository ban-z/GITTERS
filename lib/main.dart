import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:gitters/business/home/HomePage.dart';
import 'package:gitters/framework/model/BaseModel.dart';
import 'package:gitters/framework/model/UserModel.dart';
import 'package:provider/provider.dart';
import 'application.dart';
import 'framework/router/RouterConfig.dart';

/* 初始化路由 */
void main() {
  FluroRouter router = FluroRouter();
  RouterConfig.configRouter(router);
  Application.router = router;
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
        ChangeNotifierProvider(create: (_) => UserModel()),
      ],
      child: child,
    );
  }
}

/* 根容器 */
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gitters',
      theme: context.watch<BaseModel>().themeData,
      home: HomePage(),
    );
  }
}
