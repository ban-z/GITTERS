import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:github/github.dart';
import 'package:gitters/application.dart';
import 'package:gitters/business/widgets/repository.dart';
import 'package:gitters/framework/global/constants/language/Localizations.dart';

class Marketplace extends StatefulWidget {
  Marketplace({Key key}) : super(key: key);

  @override
  _MarketplaceState createState() => _MarketplaceState();
}

class _MarketplaceState extends State<Marketplace> {
  List<User> followingUsers;

  Widget buildCommonTabContent(Future future) {
    return FutureBuilder<List<Repository>>(
        future: future,
        builder:
            (BuildContext context, AsyncSnapshot<List<Repository>> snapshot) {
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
              List<Repository> repos = snapshot.data;
              return ListView.builder(
                itemCount: repos.length,
                itemBuilder: (context, index) {
                  Repository repo = repos[index];
                  return RepoItem(repo);
                },
              );
            }
          }
          //请求未完成时弹出loading
          return CircularProgressIndicator();
        });
  }

  Future setCurUserFollows() async {
    followingUsers =
        await gitHubClient.users.listCurrentUserFollowing().toList();
  }

  Future<List<Repository>> getFollowsRepos() async {
    await setCurUserFollows();
    return gitHubClient.repositories
        .listUserRepositories(followingUsers[0].login)
        .toList();
  }

  Widget buildFollowTabContent() {
    return FutureBuilder<List<Repository>>(
        future: getFollowsRepos(),
        builder:
            (BuildContext context, AsyncSnapshot<List<Repository>> snapshot) {
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
              List<Repository> repos = snapshot.data;
              return ListView.builder(
                itemCount: repos.length,
                itemBuilder: (context, index) {
                  Repository repo = repos[index];
                  return RepoItem(repo);
                },
              );
            }
          }
          //请求未完成时弹出loading
          return CircularProgressIndicator();
        });
  }

  Widget buildPopularTabContent() {
    return buildCommonTabContent(
        gitHubClient.repositories.listRepositories().toList());
  }

  Widget buildMineTabContent() {
    return buildCommonTabContent(
        gitHubClient.repositories.listRepositories().toList());
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            title: Text(GittersLocalizations.of(context).Marketplace),
            // TabBar 默认将会在 Widget 树中向上寻找离它最近的一个 DefaultTabController 节点作为自己的 TabController
            // 如果想手动创建 TabController，那必须将它作为参数传给 TabBar
            bottom: TabBar(tabs: [
              Tab(text: GittersLocalizations.of(context).TabFollow.toString()),
              Tab(text: GittersLocalizations.of(context).TabPopular.toString()),
              Tab(text: GittersLocalizations.of(context).TabMine.toString()),
            ]),
          ),
          body: TabBarView(children: [
            buildFollowTabContent(),
            buildPopularTabContent(),
            buildMineTabContent(),
          ]),
        ));
    // return Scaffold(
    //   appBar: AppBar(
    //     title: Text(GittersLocalizations.of(context).Marketplace),
    //   ),
    //   body: Container(
    //     alignment: Alignment.center,
    //     child: FutureBuilder<List<Repository>>(
    //         future: gitHubClient.repositories.listRepositories().toList(),
    //         builder: (BuildContext context,
    //             AsyncSnapshot<List<Repository>> snapshot) {
    //           if (snapshot.connectionState == ConnectionState.active ||
    //               snapshot.connectionState == ConnectionState.waiting) {
    //             return new Center(
    //               child: new CircularProgressIndicator(),
    //             );
    //           }

    //           if (snapshot.connectionState == ConnectionState.done) {
    //             if (snapshot.hasError) {
    //               return Text(snapshot.error.toString());
    //             } else if (snapshot.hasData) {
    //               List<Repository> repos = snapshot.data;
    //               return ListView.builder(
    //                 itemCount: repos.length,
    //                 itemBuilder: (context, index) {
    //                   Repository repo = repos[index];
    //                   return RepoItem(repo);
    //                 },
    //               );
    //             }
    //           }
    //           //请求未完成时弹出loading
    //           return CircularProgressIndicator();
    //         }),
    //   ),
    // );
  }
}
