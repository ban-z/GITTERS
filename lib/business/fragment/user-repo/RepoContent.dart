import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:github/github.dart';
import 'package:gitters/application.dart';
import 'package:gitters/business/fragment/user-repo/Repository.dart';
import 'package:gitters/framework/utils/utils.dart';
import 'package:gitters/models/repoCOT.dart';
import 'package:gitters/models/repoDof.dart';

class RepoContent extends StatelessWidget {
  String treePath;
  String treeType; // tree / blob

  RepoContent(this.treePath, this.treeType, {Key key}) : super(key: key);

  String getCurTreePath(String treePath) {
    String res;
    res = treePath.substring(22); // 截掉域名部分，使用GitHubClient进行网络请求
    return res;
  }

  bool isTree(String treeType) {
    if (treeType == 'tree') {
      return true;
    }
    return false;
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
                if (isTree(treeType)) {
                  RepoDof dof =
                      RepoDof.fromJson(stringToJsonMap(snapshot.data.body));
                  return ListView.builder(
                    itemCount: dof.tree.length,
                    itemBuilder: (context, index) {
                      return buildDirOrFileItem(dof.tree[index], onClick: () {
                        gotoUserRepositoryContent(
                            context, dof.tree[index].url, dof.tree[index].type);
                      });
                    },
                  );
                } else {
                  RepoCot cot =
                      RepoCot.fromJson(stringToJsonMap(snapshot.data.body));
                  return Text(cot.content);
                }
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

Widget buildDirOrFileItem(Tree tree, {Function onClick}) {
  return GestureDetector(
    onTap: onClick,
    child: Container(
      child: Row(
        children: [
          Image.asset(
            getTypeIcon(tree.type),
            width: 42.0,
            height: 42.0,
          ),
          buildPaddingInHV(5.0, 0),
          Text(
            tree.path,
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w500,
            ),
          )
        ],
      ),
    ),
  );
}
