import 'package:flutter/material.dart';
import 'package:github/github.dart';
import 'package:gitters/application.dart';

class RepoContent extends StatelessWidget {
  RepositorySlug slug;
  String branch;
  String path;

  RepoContent(this.slug, this.branch, this.path, {Key key})
      : super(key: key);

  String getRequestPath(String branch, String path) {
    return '/repos/${slug.fullName}/branches/${branch}/';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('分支'),
      ),
      body: FutureBuilder(
          future: gitHubClient.request('GET', getRequestPath(branch, path)),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
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
                RepositoryContents cotents = snapshot.data.body;
                return ListView.builder(
                  itemCount: 11,
                  itemBuilder: (context, index) {},
                );
              }
            }
            //请求未完成时弹出loading
            return CircularProgressIndicator();
          }),
    );
  }
}
