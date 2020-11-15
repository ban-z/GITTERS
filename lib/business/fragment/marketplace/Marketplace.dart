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
  Dio _dio = new Dio();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(GittersLocalizations.of(context).Marketplace),
      ),
      body: Container(
        alignment: Alignment.center,
        child: FutureBuilder<List<Repository>>(
            future: gitHubClient.repositories.listRepositories().toList(),
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
            }),
      ),
    );
  }
}
