import 'package:flutter/material.dart';
import 'package:github/github.dart';
import 'package:gitters/application.dart';
import 'package:gitters/business/widgets/repository.dart';
import 'package:gitters/framework/global/constants/language/Localizations.dart';

class FollowingRepos extends StatefulWidget {
  String user;
  String title;
  FollowingRepos(this.user, {this.title, Key key}) : super(key: key);

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
        appBar: AppBar(
          title: Text(getPageTitle(context)),
        ),
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
                    itemCount: followingRepos.length,
                    itemBuilder: (context, index) {
                      Repository repo = followingRepos[index];
                      return RepoItem(repo);
                    },
                  );
                }
              }
              //请求未完成时弹出loading
              return CircularProgressIndicator();
            }));
  }
}
