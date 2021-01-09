import 'package:flutter/material.dart';
import 'package:gitters/framework/global/constants/language/Localizations.dart';
import 'package:gitters/framework/global/provider/BaseModel.dart';
import 'package:provider/provider.dart';

class AppThemeSetting extends StatefulWidget {
  AppThemeSetting({Key key}) : super(key: key);

  @override
  _AppThemeSettingState createState() => _AppThemeSettingState();
}

class _AppThemeSettingState extends State<AppThemeSetting> {
  List<MaterialColor> materialColors = [
    Colors.amber,
    Colors.blue,
    Colors.blueGrey,
    Colors.brown,
    Colors.cyan,
    Colors.deepOrange,
    Colors.green,
    Colors.grey,
    Colors.indigo,
    Colors.lightBlue,
    Colors.lightGreen,
    Colors.lime,
    Colors.orange,
    Colors.pink,
    Colors.purple,
    Colors.red,
    Colors.teal,
    Colors.yellow,
  ];

  void changeAppTheme(BuildContext context, MaterialColor color) {
    context.read<BaseModel>().updateThemeData(ThemeData(primarySwatch: color));
  }

  List<Widget> buildthemeColorsList(
      BuildContext context, List<MaterialColor> themeColors) {
    List<Widget> widgets = new List<Widget>();

    themeColors.forEach((color) {
      widgets.add(new FlatButton(
        onPressed: () {
          changeAppTheme(context, color);
        },
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 45.0, vertical: 8.0),
          height: 40,
          color: color,
        ),
      ));
    });
    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(GittersLocalizations.of(context).AppThemeSetting),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: buildthemeColorsList(context, materialColors),
        ),
      ),
    );
  }
}
