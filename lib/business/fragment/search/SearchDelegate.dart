import 'package:flutter/material.dart';
import 'package:github/github.dart';
import 'package:gitters/application.dart';
import 'package:gitters/business/widgets/repository.dart';
import 'package:gitters/business/widgets/toast.dart';
import 'package:gitters/business/widgets/userCard.dart';
import 'package:gitters/framework/global/constants/language/Localizations.dart';
import 'package:gitters/framework/global/provider/BaseModel.dart';
import 'package:gitters/framework/router/RouterConfig.dart';
import 'package:gitters/framework/utils/utils.dart';
import 'package:provider/provider.dart';

class SearchBarDelegate extends SearchDelegate {
  String selectedResult;
  List<String> suggestions = [
    "User...",
    "Repository...",
  ];

  // 方法返回一个控件列表，显示为搜索框右边的图标按钮
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.search),
        onPressed: () {
          if (query.isEmpty) {
            showToast(GittersLocalizations.of(context).NoneSearch.toString());
          } else {
            showResults(context);
          }
        },
      ),
    ];
  }

  // 方法返回一个控件，显示为搜索内容区域的建议内容
  // 方法返回一个控件，显示为搜索内容区域的搜索结果内容
  @override
  Widget buildSuggestions(BuildContext context) {
    return Scaffold(
        appBar: null,
        body: ListView.builder(
            itemCount: suggestions.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(suggestions[index]),
                // onTap: () {
                //   selectedResult = suggestions[index];
                //   showResults(context);
                // },
              );
            }));
  }

  @override
  Widget buildResults(BuildContext context) {
    return DefaultTabController(
        initialIndex: 0,
        length: 2,
        child: Scaffold(
            appBar: AppBar(
                leading: Container(),
                automaticallyImplyLeading: false,
                leadingWidth: 0,
                title: TabBar(tabs: [
                  Tab(
                    text: GittersLocalizations.of(context).User.toString(),
                  ),
                  Tab(
                    text:
                        GittersLocalizations.of(context).Repository.toString(),
                  ),
                ])),
            body: TabBarView(children: [
              buildUserSearchResultList(context),
              buildRepoSearchResultList(context)
            ])));
  }

  // 方法返回一个控件，显示为搜索框左侧的按钮，一般设置为返回，这里返回一个具有动态效果的返回按钮
  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow, progress: transitionAnimation),
      onPressed: () {
        fluroRouter.pop(context);
      },
    );
  }

  // 这个方法返回一个主题，也就是可以自定义搜索界面的主题样式
  // @override
  // ThemeData appBarTheme(BuildContext context) {
  //   // TODO: implement appBarTheme
  //   // return super.appBarTheme(context);
  //   assert(context != null);
  //   final ThemeData theme = Theme.of(context);
  //   assert(theme != null);
  //   return theme.copyWith(
  //     primaryColor: Colors.white,
  //     primaryIconTheme: theme.primaryIconTheme.copyWith(color: Colors.grey),
  //     primaryColorBrightness: Brightness.light,
  //     primaryTextTheme: theme.textTheme,
  //   );
  // }

  Widget buildUserSearchResultList(BuildContext context) {
    var buildList = (AsyncSnapshot snapshot) {
      List<User> followings = snapshot.data;
      return ListView.builder(
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
      );
    };

    return buildBaseCommonList(
        gitHubClient.search.users(query).toList(), buildList);
  }

  Widget buildRepoSearchResultList(BuildContext context) {
    return buildCommonList<Repository, RepoItem>(
        context,
        gitHubClient.search.repositories(query).toList(),
        (Repository repo) => RepoItem(repo, () {
              if (repo.isPrivate) {
                showToast('私有仓库，不可查看');
              } else {
                gotoUserRepository(
                    context, RepositorySlug(repo.owner.login, repo.name));
              }
            }),
        (Map<String, dynamic> json) => Repository.fromJson(json),
        () {});
  }
}
