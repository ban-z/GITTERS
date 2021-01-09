import 'package:flutter/material.dart';
import 'package:gitters/framework/global/constants/language/Localizations.dart';
import 'package:gitters/framework/utils/I18n.dart';

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
                changeLanguage(context);
              },
              child: Text(
                '中文',
              )),
          FlatButton(
              onPressed: () {
                changeLanguage(context);
              },
              child: Text(
                'Englist',
              )),
        ],
      ),
    ));
  }
}
