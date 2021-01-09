import 'package:flutter/material.dart';
import 'package:github/github.dart';
import 'package:gitters/application.dart';
import 'package:gitters/business/widgets/iconBtn.dart';
import 'package:gitters/business/widgets/userbar.dart';
import 'package:gitters/framework/global/constants/language/Localizations.dart';
import 'package:gitters/framework/router/RouterConfig.dart';

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
      ),
      body: buildBody(),
    );
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
                    child: UserBar(
                      user: curUser,
                    )),
                Expanded(
                  flex: 6,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      GitterIconButton(
                        GittersLocalizations.of(context).MyRepository,
                        Icons.keyboard_arrow_right,
                        onClick: null,
                      ),
                      GitterIconButton(
                        GittersLocalizations.of(context).UserInformation,
                        Icons.keyboard_arrow_right,
                        onClick: null,
                      ),
                      GitterIconButton(
                        GittersLocalizations.of(context).AppThemeSetting,
                        Icons.keyboard_arrow_right,
                        onClick: () {
                          fluroRouter.navigateTo(
                              context, RouterList.AppThemeSetting.value);
                        },
                      ),
                      GitterIconButton(
                        GittersLocalizations.of(context).Internationalization,
                        Icons.keyboard_arrow_right,
                        onClick: () {
                          fluroRouter.navigateTo(
                              context, RouterList.Internationalization.value);
                        },
                      ),
                      GitterIconButton(
                        GittersLocalizations.of(context).UserFeedBack,
                        Icons.keyboard_arrow_right,
                        onClick: null,
                      ),
                      GitterIconButton(
                        GittersLocalizations.of(context).AboutApp,
                        Icons.keyboard_arrow_right,
                        onClick: null,
                      ),
                    ],
                  ),
                )
              ],
            );
          }
        });
  }
}
