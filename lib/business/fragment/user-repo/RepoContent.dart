import 'package:flutter/material.dart';
import 'package:github/github.dart';
import 'package:gitters/application.dart';
import 'package:gitters/business/fragment/user-repo/Repository.dart';
import 'package:gitters/framework/utils/utils.dart';
import 'package:gitters/models/repoDof.dart';

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
                RepoDof dof =
                    RepoDof.fromJson(stringToJsonMap(snapshot.data.body));
                return ListView.builder(
                  itemCount: dof.tree.length,
                  itemBuilder: (context, index) {
                    return buildDirOrFileItem(dof.tree[index]);
                  },
                );
              }
            }
            //请求未完成时弹出loading
            return CircularProgressIndicator();
          }),
    );
  }
}

String getTypeIcon(String type) {
  if (type == 'blob') {
    return 'images/file.png';
  } else {
    return 'images/dir.png';
  }
}

Widget buildDirOrFileItem(Tree tree) {
  return Container(
    child: Row(
      children: [
        Image.asset(
          getTypeIcon(tree.type),
          width: 24.0,
          height: 24.0,
        ),
        buildPaddingInHV(5.0, 0),
        Text(tree.path)
      ],
    ),
  );
}
