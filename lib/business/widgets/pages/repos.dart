import 'package:flutter/material.dart';
import 'package:github/github.dart';
import 'package:gitters/application.dart';
import 'package:gitters/business/widgets/repository.dart';
import 'package:gitters/business/widgets/toast.dart';
import 'package:gitters/framework/global/constants/language/Localizations.dart';
import 'package:gitters/framework/utils/utils.dart';

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
  String getPageTitle(BuildContext context) {
    return widget.title ??
        (GittersLocalizations.of(context).FollowingUser ?? 'Following');
  }

  @override
  Widget build(BuildContext context) {
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
                )
              ];
            },
            body: FutureBuilder<List<Repository>>(
                future: gitHubClient.repositories
                    .listUserRepositories(widget.user)
                    .toList(),
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
