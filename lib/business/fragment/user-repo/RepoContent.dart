import 'package:flutter/material.dart';
import 'package:github/github.dart';
import 'package:gitters/application.dart';

class RepoContent extends StatelessWidget {
  String treePath;

  RepoContent(this.treePath, {Key key}) : super(key: key);

  String getCurTreePath(String treePath) {
    String res;
    res = treePath.substring(22); // 截掉域名部分，使用GitHubClient进行网络请求
    return res;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('分支'),
      ),
      body: FutureBuilder(
          future: gitHubClient.request('GET', getCurTreePath(treePath)),
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
                return Text(snapshot.data.body);
              }
            }
            //请求未完成时弹出loading
            return CircularProgressIndicator();
          }),
    );
  }
}
