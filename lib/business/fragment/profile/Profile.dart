import 'package:flutter/material.dart';
import 'package:github/github.dart';
import 'package:gitters/application.dart';
import 'package:gitters/business/widgets/iconBtn.dart';
import 'package:gitters/business/widgets/userbar.dart';
import 'package:gitters/framework/global/constants/Constant.dart';
import 'package:gitters/framework/global/constants/language/Localizations.dart';
import 'package:gitters/framework/router/RouterConfig.dart';
import 'package:gitters/framework/utils/utils.dart';

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
                    flex: 5,
                    child: UserBar(
                      user: curUser,
                    )),
                Expanded(
                  flex: 7,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      GitterIconButtonLR(
                        GittersLocalizations.of(context).MyRepository,
                        Icons.keyboard_arrow_right,
                        onClick: () {
                          fluroRouter.navigateTo(
                              context, RouterList.FollowingRepos.value,
                              routeSettings: RouteSettings(
                                  arguments: FollowingPageRouterArguments(
                                      curUser: curUser.login,
                                      pageTitle: curUser.login)));
                        },
                      ),
                      // GitterIconButton(
                      //   GittersLocalizations.of(context).UserInformation,
                      //   Icons.keyboard_arrow_right,
                      //   onClick: null,
                      // ),
                      GitterIconButtonLR(
                        GittersLocalizations.of(context).AppThemeSetting,
                        Icons.keyboard_arrow_right,
                        onClick: () {
                          fluroRouter.navigateTo(
                              context, RouterList.AppThemeSetting.value);
                        },
                      ),
                      GitterIconButtonLR(
                        GittersLocalizations.of(context).Internationalization,
                        Icons.keyboard_arrow_right,
                        onClick: () {
                          fluroRouter.navigateTo(
                              context, RouterList.Internationalization.value);
                        },
                      ),
                      GitterIconButtonLR(
                        GittersLocalizations.of(context).UserFeedBack,
                        Icons.keyboard_arrow_right,
                        onClick: () {
                          fluroRouter.navigateTo(
                              context, RouterList.UserHelperCenter.value);
                        },
                      ),
                      GitterIconButtonLR(
                        GittersLocalizations.of(context).AboutApp,
                        Icons.keyboard_arrow_right,
                        onClick: () {
                          fluroRouter.navigateTo(
                              context, RouterList.AboutGitHubApp.value);
                        },
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
