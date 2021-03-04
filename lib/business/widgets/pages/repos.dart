import 'package:flutter/material.dart';
import 'package:github/github.dart';
import 'package:gitters/application.dart';
import 'package:gitters/business/widgets/repository.dart';
import 'package:gitters/business/widgets/toast.dart';
import 'package:gitters/framework/global/constants/language/Localizations.dart';
import 'package:gitters/framework/global/provider/BaseModel.dart';
import 'package:gitters/framework/utils/utils.dart';
import 'package:provider/provider.dart';

class StarConfig {
  bool isStar;
  String starHint;
  IconData starIcon;

  StarConfig(this.isStar, this.starHint, this.starIcon);
}

class FollowingRepos extends StatefulWidget {
  String user;
  String avatorUrl;
  String title;
  FollowingRepos(this.user, this.avatorUrl, {this.title, Key key})
      : super(key: key);

  @override
  _FollowingReposState createState() => _FollowingReposState();
}

class _FollowingReposState extends State<FollowingRepos> {
  User curUser;
  StarConfig starConfig = StarConfig(false, '--', Icons.star_border);
  Future userReposInfoFuture;

  String following;
  String followers;

  String getPageTitle(BuildContext context) {
    return widget.title ??
        (GittersLocalizations.of(context).FollowingUser ?? 'Following');
  }

  Future getUserReposInfo() {
    return gitHubClient.repositories.listUserRepositories(widget.user).toList();
  }

  @override
  void initState() {
    userReposInfoFuture = getUserReposInfo();

    gitHubClient.users.getUser(widget.user).then((user) {
      setState(() {
        curUser = user;
      });
    }).catchError((err) {
      setState(() {
        curUser = null;
      });
    });

    gitHubClient.users.isFollowingUser(widget.user).then((res) {
      starConfig.isStar = res;
    }).catchError((err) {
      starConfig.isStar = false;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (starConfig.isStar) {
      starConfig.starHint =
          GittersLocalizations.of(context).UnStarButton.toString();
      starConfig.starIcon = Icons.star;
    } else {
      starConfig.starHint =
          GittersLocalizations.of(context).StarButton.toString();
      starConfig.starIcon = Icons.star_border;
    }
    return Scaffold(
        body: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return [
                SliverAppBar(
                  expandedHeight: 280.0,
                  pinned: true,
                  elevation: 99.0,
                  flexibleSpace: FlexibleSpaceBar(
                    title: Text(getPageTitle(context)),
                    background: Image.network(
                      widget.avatorUrl,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.all(0.0),
                  sliver: new SliverGrid(
                    //Grid
                    gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, //Grid按两列显示
                      mainAxisSpacing: 10.0,
                      crossAxisSpacing: 10.0,
                      childAspectRatio: 4.0,
                    ),
                    delegate: new SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        following = curUser?.followingCount?.toString() ?? '--';
                        followers = curUser?.followersCount?.toString() ?? '--';

                        //创建子widget
                        switch (index) {
                          case 0:
                            return new Container(
                              alignment: Alignment.center,
                              color: context
                                  .read<BaseModel>()
                                  .themeData
                                  .backgroundColor,
                              child: new Text(GittersLocalizations.of(context)
                                      .TabFollow
                                      .toString() +
                                  ': ${following}'),
                            );
                            break;
                          case 1:
                            return new Container(
                              alignment: Alignment.center,
                              color: context
                                  .read<BaseModel>()
                                  .themeData
                                  .backgroundColor,
                              child: new Text(GittersLocalizations.of(context)
                                      .TabFollowers
                                      .toString() +
                                  ': ${followers}'),
                            );
                            break;
                          case 2:
                            return new Container(
                              alignment: Alignment.center,
                              color: context
                                  .read<BaseModel>()
                                  .themeData
                                  .backgroundColor,
                              child: FlatButton(
                                clipBehavior: Clip.hardEdge,
                                onPressed: () {
                                  setState(() {
                                    starConfig.starIcon = Icons.autorenew;
                                    starConfig.starHint = '';
                                  });
                                  if (starConfig.isStar) {
                                    gitHubClient.users
                                        .unfollowUser(widget.user)
                                        .then((res) {
                                      setState(() {
                                        starConfig = StarConfig(
                                            false,
                                            GittersLocalizations.of(context)
                                                .StarButton
                                                .toString(),
                                            Icons.star_border);
                                        // followers =
                                        //     (curUser?.followersCount - 1)
                                        //             ?.toString() ??
                                        //         '--';
                                        print('');
                                      });
                                    }).catchError((err) {});
                                  } else {
                                    gitHubClient.users
                                        .followUser(widget.user)
                                        .then((res) {
                                      setState(() {
                                        starConfig = StarConfig(
                                            true,
                                            GittersLocalizations.of(context)
                                                .UnStarButton
                                                .toString(),
                                            Icons.star);
                                        // followers =
                                        //     (curUser?.followersCount + 1)
                                        //             ?.toString() ??
                                        //         '--';
                                        print('');
                                      });
                                    }).catchError((err) {});
                                  }
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(starConfig.starIcon),
                                    Text(starConfig.starHint)
                                  ],
                                ),
                              ),
                            );
                            break;
                          case 3:
                            return new Container(
                              alignment: Alignment.center,
                              color: context
                                  .read<BaseModel>()
                                  .themeData
                                  .backgroundColor,
                              child: new Text(''),
                            );
                            break;
                          default:
                            return Container();
                        }
                      },
                      childCount: 4,
                    ),
                  ),
                ),
              ];
            },
            body: FutureBuilder<List<Repository>>(
                future: userReposInfoFuture,
                builder: (BuildContext context,
                    AsyncSnapshot<List<Repository>> snapshot) {
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
                      List<Repository> followingRepos = snapshot.data;
                      return ListView.builder(
                        padding: EdgeInsets.only(top: 5.0),
                        itemCount: followingRepos.length,
                        itemBuilder: (context, index) {
                          Repository repo = followingRepos[index];
                          return RepoItem(repo, () {
                            if (repo.isPrivate) {
                              showToast('私有仓库，不可查看');
                            } else {
                              gotoUserRepository(context,
                                  RepositorySlug(repo.owner.login, repo.name));
                            }
                          });
                        },
                      );
                    }
                  }
                  //请求未完成时弹出loading
                  return CircularProgressIndicator();
                })));
  }
}
