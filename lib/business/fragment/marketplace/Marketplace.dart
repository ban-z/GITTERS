import 'package:flutter/material.dart';
import 'package:github/github.dart';
import 'package:gitters/application.dart';
import 'package:gitters/business/widgets/repository.dart';
import 'package:gitters/business/widgets/usercard.dart';
import 'package:gitters/framework/global/constants/language/Localizations.dart';
import 'package:gitters/framework/router/RouterConfig.dart';
import 'package:gitters/framework/utils/utils.dart';

class Marketplace extends StatefulWidget {
  Marketplace({Key key}) : super(key: key);

  @override
  _MarketplaceState createState() => _MarketplaceState();
}

class _MarketplaceState extends State<Marketplace> {
  List<User> followingUsers;

  Future<List<Repository>> getFollowsRepos() async {
    followingUsers =
        await gitHubClient.users.listCurrentUserFollowing().toList();
    return gitHubClient.repositories
        .listUserRepositories(followingUsers[0].login)
        .toList();
  }

  Widget buildFollowTabContent() {
    var buildList = (AsyncSnapshot snapshot) {
      List<User> followings = snapshot.data;
      return RefreshIndicator(
          onRefresh: () {
            setState(() {});
          },
          color: Theme.of(context).primaryColor,
          child: ListView.builder(
            itemCount: followings.length,
            itemBuilder: (context, index) {
              User curUser = followings[index];
              return UserCard(
                curUser,
                onClick: () {
                  fluroRouter.navigateTo(
                    context,
                    RouterList.FollowingRepos.value,
                    routeSettings: RouteSettings(
                        arguments: FollowingPageRouterArguments(
                            curUser: curUser.login, pageTitle: curUser.login)),
                  );
                },
              );
            },
          ));
    };

    return buildBaseCommonList(
        gitHubClient.users.listCurrentUserFollowing().toList(), buildList);
  }

  Widget buildPopularTabContent() {
    return buildCommonList<Repository, RepoItem>(
        gitHubClient.request('GET', '/repositories'),
        (Repository repo) => RepoItem(repo),
        (Map<String, dynamic> json) => Repository.fromJson(json));
  }

  Widget buildMineTabContent() {
    return buildCommonList<Repository, RepoItem>(
        gitHubClient.repositories.listRepositories().toList(),
        (Repository repo) => RepoItem(repo),
        (Map<String, dynamic> json) => Repository.fromJson(json));
  }

  Widget buildStarTabContent() {
    return buildCommonList<Repository, RepoItem>(
        gitHubClient.request('GET', '/user/starred'),
        (Repository repo) => RepoItem(repo),
        (Map<String, dynamic> json) => Repository.fromJson(json));
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: AppBar(
            title: Text(GittersLocalizations.of(context).Marketplace),
            // TabBar 默认将会在 Widget 树中向上寻找离它最近的一个 DefaultTabController 节点作为自己的 TabController
            // 如果想手动创建 TabController，那必须将它作为参数传给 TabBar
            bottom: TabBar(tabs: [
              Tab(text: GittersLocalizations.of(context).TabFollow.toString()),
              Tab(text: GittersLocalizations.of(context).TabStar.toString()),
              Tab(text: GittersLocalizations.of(context).TabPopular.toString()),
              Tab(text: GittersLocalizations.of(context).TabMine.toString()),
            ]),
          ),
          body: TabBarView(children: [
            buildFollowTabContent(),
            buildStarTabContent(),
            buildPopularTabContent(),
            buildMineTabContent(),
          ]),
        ));
  }
}
