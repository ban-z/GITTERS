import 'package:flutter/material.dart';
import 'package:github/github.dart';
import 'package:gitters/application.dart';
import 'package:gitters/framework/constants/language/Localizations.dart';
import 'package:gitters/framework/router/RouterConfig.dart';
import 'package:gitters/main.dart';

class Profile extends StatefulWidget {
  @override
  ProfileState createState() => ProfileState();
}

class ProfileState extends State<Profile> {
  var flag = false;
  CurrentUser user;
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
              icon: Icon(Icons.brush),
              onPressed: () {
                // TODO:目前因为使用flag的判断方式，所以会导致点击两次BTN才会变换语言
                changeLocale();
                Scaffold.of(context).showSnackBar(SnackBar(
                    content: GittersLocalizations.of(context).Changelanguage));
              })
        ],
      ),
      body: FutureBuilder<CurrentUser>(
          future: Application.github.users.getCurrentUser(),
          builder: (BuildContext context, AsyncSnapshot<CurrentUser> snapshot) {
            if (snapshot.connectionState == ConnectionState.active ||
                snapshot.connectionState == ConnectionState.waiting) {
              return new Center(
                child: new CircularProgressIndicator(),
              );
            }

            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                return Text(snapshot.error.toString());
              } else if (snapshot.hasData) {
                user = snapshot.data;
                print(user.avatarUrl.toString());
                return Center(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Image.network(user.avatarUrl ?? 'https://wx1.sinaimg.cn/mw690/002VTQLVgy1gklq3jwbraj61zo2niqv602.jpg', width: 60, height: 60,),
                          Column(
                            children: [
                              Text(user.name ?? 'default name'),
                              Text(user.email ?? 'default email'),
                            ],
                          ),
                        ],
                      )
                    ],
                  )
                );
              }
            }
            //请求未完成时弹出loading
            return CircularProgressIndicator();
          }),
    );
  }
}
