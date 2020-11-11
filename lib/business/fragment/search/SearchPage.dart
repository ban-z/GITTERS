import 'package:flukit/flukit.dart';
import 'package:flutter/material.dart';
import 'package:github/github.dart';
import 'package:gitters/business/widgets/repository.dart';
import 'package:gitters/framework/constants/language/Localizations.dart';
import 'package:gitters/models/index.dart';

import '../../../application.dart';

class SearchPage extends StatefulWidget {
  SearchPage({Key key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(GittersLocalizations.of(context).SearchName),
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
                CurrentUser user = snapshot.data;
                print(user.avatarUrl.toString());
                return Center(
                  child: Column(
                    children: [
                      Text(user.ownedPrivateReposCount.toString() ??
                          'default count'),
                      Text(user.avatarUrl.toString() ?? 'default email'),
                    ],
                  ),
                );
              }
            }
            //请求未完成时弹出loading
            return CircularProgressIndicator();
          }),
    );
  }
}
