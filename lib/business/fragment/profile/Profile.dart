import 'package:flutter/material.dart';
import 'package:gitters/application.dart';
import 'package:gitters/framework/constants/language/Localizations.dart';
import 'package:gitters/main.dart';

class Profile extends StatefulWidget {
  @override
  ProfileState createState() => ProfileState();
}

class ProfileState extends State<Profile> {
  var flag = false;
  void changeLocale() {
    if (flag) {
      i18nWidgetStateKey.currentState.changeLanguage(const Locale('zh', "CH"));
    } else {
      i18nWidgetStateKey.currentState.changeLanguage(const Locale('en', "US"));
    }
    flag = !flag;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(GittersLocalizations.of(context).ProfileName),
        actions: [
          IconButton(
              icon: Icon(Icons.language),
              onPressed: () {
                changeLocale();
              })
        ],
      ),
      body: Center(
        child: RaisedButton(
            onPressed: () =>
                Application.router.navigateTo(context, RouterList.Login.value),
            child: Text(
              "GO LOGIN!",
              style: TextStyle(color: Colors.blue),
            )),
      ),
    );
  }
}
