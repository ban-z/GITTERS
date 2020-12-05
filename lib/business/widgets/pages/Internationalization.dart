import 'package:flutter/material.dart';
import 'package:gitters/framework/global/constants/language/Localizations.dart';
import '../../../main.dart';

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
                i18nWidgetStateKey.currentState
                    .changeLanguage(const Locale('zh', "CH"));
              },
              child: Text(
                '中文',
              )),
          FlatButton(
              onPressed: () {
                i18nWidgetStateKey.currentState
                    .changeLanguage(const Locale('en', "US"));
              },
              child: Text(
                'Englist',
              )),
        ],
      ),
    ));
  }
}
