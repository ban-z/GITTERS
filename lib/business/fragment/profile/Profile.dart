import 'package:flutter/material.dart';
import 'package:github/github.dart';
import 'package:gitters/application.dart';
import 'package:gitters/business/widgets/repository.dart';
import 'package:gitters/business/widgets/userbar.dart';
import 'package:gitters/framework/global/constants/language/Localizations.dart';
import 'package:gitters/main.dart';

class Profile extends StatefulWidget {
  @override
  ProfileState createState() => ProfileState();
}

class ProfileState extends State<Profile> {
  var flag = false;
  var _futureBuilders;

  CurrentUser curUser;
  List<Repository> repos;

  @override
  void initState() {
    _futureBuilders = getProfileFutures();
    super.initState();
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
      body: buildBody(),
    );
  }

  void changeLocale() {
    if (flag) {
      i18nWidgetStateKey.currentState.changeLanguage(const Locale('zh', "CH"));
    } else {
      i18nWidgetStateKey.currentState.changeLanguage(const Locale('en', "US"));
    }
    flag = !flag;
  }

  Future getProfileFutures() {
    return Future.wait([getCurrentUser(), getOwnerRepos()]);
  }

  Future getCurrentUser() async {
    curUser = await gitHubClient.users.getCurrentUser();
  }

  Future getOwnerRepos() async {
    repos = await gitHubClient.repositories.listRepositories().toList();
  }

  buildBody() {
    return FutureBuilder(
        future: getProfileFutures(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.active ||
              snapshot.connectionState == ConnectionState.waiting) {
            return new Center(
              child: new CircularProgressIndicator(),
            );
          }

          if (snapshot.connectionState == ConnectionState.done) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  flex: 4,
                    child: UserBar(user: curUser,)
                ),
                Expanded(
                  flex: 6,
                  child: ListView.builder(
                    itemCount: repos.length,
                    itemBuilder: (context, index) {
                      Repository repo = repos[index];
                      return RepoItem(repo);
                    },
                  ),
                )
              ],
            );
          }
        });
  }
}
