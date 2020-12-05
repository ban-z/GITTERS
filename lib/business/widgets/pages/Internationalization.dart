import 'package:flutter/material.dart';
import 'package:gitters/application.dart';
import 'package:gitters/framework/global/constants/Constant.dart';
import 'package:gitters/framework/global/constants/language/Localizations.dart';
import 'package:gitters/framework/global/provider/BaseModel.dart';
import 'package:provider/provider.dart';

class Internationalization extends StatefulWidget {
  Internationalization({Key key}) : super(key: key);

  @override
  _InternationalizationState createState() => _InternationalizationState();
}

class _InternationalizationState extends State<Internationalization> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Scaffold(
      appBar: AppBar(
        title: Text(GittersLocalizations.of(context).Internationalization),
      ),
      body: Column(
        children: [
          FlatButton(
              onPressed: () {
                context
                    .read<BaseModel>()
                    .changeLanuage(const Locale('zh', "CH"));
                print('设置为中文');
                diskCache.setString(Constant.LANGUAGE, 'zh');
                diskCache.setString(Constant.COUNTER, 'CH');
              },
              child: Text(
                '中文',
              )),
          FlatButton(
              onPressed: () {
                context
                    .read<BaseModel>()
                    .changeLanuage(const Locale('en', "US"));
                print('设置为英文');
                diskCache.setString(Constant.LANGUAGE, 'en');
                diskCache.setString(Constant.COUNTER, 'US');
              },
              child: Text(
                'Englist',
              )),
        ],
      ),
    ));
  }
}
