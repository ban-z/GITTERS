import 'package:flutter/material.dart';
import 'package:github/github.dart';
import 'package:gitters/application.dart';
import 'package:gitters/business/widgets/repository.dart';
import 'package:gitters/business/widgets/toast.dart';
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

  void updateState() {
    setState(() {});
  }

  Future<List<Repository>> getFollowsRepos() async {
    followingUsers =
        await gitHubClient.users.listCurrentUserFollowing().toList();
    return gitHubClient.repositories
        .listUserRepositories(followingUsers[0].login)
        .toList();
  }

  Widget buildFollowTabContent(BuildContext context) {
    var buildList = (AsyncSnapshot snapshot) {
      List<User> followings = snapshot.data;
      return RefreshIndicator(
          onRefresh: () {
            updateState();
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
                            curUser: curUser.login,
                            avatorUrl: curUser.avatarUrl,
                            pageTitle: curUser.login)),
                  );
                },
              );
            },
          ));
    };

    return buildBaseCommonList(
        gitHubClient.users.listCurrentUserFollowing().toList(), buildList);
  }

  Widget buildFollowersTabContent(BuildContext context) {
    var buildList = (AsyncSnapshot snapshot) {
      List<User> followings = snapshot.data;
      return RefreshIndicator(
          onRefresh: () {
            updateState();
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
                            curUser: curUser.login,
                            avatorUrl: curUser.avatarUrl,
                            pageTitle: curUser.login)),
                  );
                },
              );
            },
          ));
    };

    return buildBaseCommonList(
        gitHubClient.users.listCurrentUserFollowers().toList(), buildList);
  }

  Widget buildPopularTabContent(BuildContext context) {
    return buildCommonList<Repository, RepoItem>(
      context,
      gitHubClient.request('GET', '/repositories'),
      (Repository repo) => RepoItem(repo, () {
        if (repo.isPrivate) {
          showToast('私有仓库，不可查看');
        } else {
          gotoUserRepository(
              context, RepositorySlug(repo.owner.login, repo.name));
        }
      }),
      (Map<String, dynamic> json) => Repository.fromJson(json),
      () {
        updateState();
      },
    );
  }

  Widget buildMineTabContent(BuildContext context) {
    return buildCommonList<Repository, RepoItem>(
        context,
        gitHubClient.repositories.listRepositories().toList(),
        (Repository repo) => RepoItem(repo, () {
              if (repo.isPrivate) {
                showToast('私有仓库，不可查看');
              } else {
                gotoUserRepository(
                    context, RepositorySlug(repo.owner.login, repo.name));
              }
            }),
        (Map<String, dynamic> json) => Repository.fromJson(json), () {
      updateState();
    });
  }

  Widget buildStarTabContent(BuildContext context) {
    return buildCommonList<Repository, RepoItem>(
        context,
        gitHubClient.request('GET', '/user/starred'),
        (Repository repo) => RepoItem(repo, () {
              if (repo.isPrivate) {
                showToast('私有仓库，不可查看');
              } else {
                gotoUserRepository(
                    context, RepositorySlug(repo.owner.login, repo.name));
              }
            }),
        (Map<String, dynamic> json) => Repository.fromJson(json), () {
      updateState();
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 5,
        child: Scaffold(
          appBar: AppBar(
            title: Text(GittersLocalizations.of(context).Marketplace),
            // TabBar 默认将会在 Widget 树中向上寻找离它最近的一个 DefaultTabController 节点作为自己的 TabController
            // 如果想手动创建 TabController，那必须将它作为参数传给 TabBar
            bottom: TabBar(
                isScrollable: true,
                onTap: (index) {
                  if (index == 3) {
                    showToast('Popular频道目前为测试频道，数据来源较为复杂，可能存在不能查看的情况!');
                  }
                },
                tabs: [
                  Tab(
                      text: GittersLocalizations.of(context)
                          .TabFollow
                          .toString()),
                  Tab(
                      text: GittersLocalizations.of(context)
                          .TabFollowers
                          .toString()),
                  Tab(
                      text:
                          GittersLocalizations.of(context).TabStar.toString()),
                  Tab(
                      text: GittersLocalizations.of(context)
                          .TabPopular
                          .toString()),
                  Tab(
                      text:
                          GittersLocalizations.of(context).TabMine.toString()),
                ]),
          ),
          body: TabBarView(children: [
            buildFollowTabContent(context),
            buildFollowersTabContent(context),
            buildStarTabContent(context),
            buildPopularTabContent(context),
            buildMineTabContent(context),
          ]),
        ));
  }
}
