import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:github/github.dart';
import 'package:gitters/application.dart';
import 'package:gitters/business/fragment/user-repo/Repository.dart';
import 'package:gitters/framework/utils/utils.dart';
import 'package:gitters/models/repoCOT.dart';
import 'package:gitters/models/repoDof.dart';
import 'package:webview_flutter/webview_flutter.dart';

class RepoContent extends StatelessWidget {
  Map<String, String> fileRquestHeaders = {
    "Accept": 'application/vnd.github.html',
  };
  String treePath;
  Type treeType; // tree / blob

  RepoContent(this.treePath, this.treeType, {Key key}) : super(key: key);

  String getCurTreePath(String treePath) {
    String res;
    res = treePath.substring(22); // 截掉域名部分，使用GitHubClient进行网络请求
    return res;
  }

  bool isTree(Type treeType) {
    if (treeType == Type.DIR) {
      return true;
    }
    return false;
  }

  Future requestDof(Type treeType) {
    if (treeType == Type.DIR) {
      return gitHubClient.request('GET', getCurTreePath(treePath));
    } else {
      return gitHubClient.request('GET', getCurTreePath(treePath),
          headers: fileRquestHeaders);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('分支'),
      ),
      body: FutureBuilder(
          future: requestDof(treeType),
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
                  List<RepoDof> dofs = repoDofFromJson(snapshot.data.body);
                  return ListView.builder(
                    itemCount: dofs.length,
                    itemBuilder: (context, index) {
                      return buildDirOrFileItem(dofs[index], onClick: () {
                        gotoUserRepositoryContent(
                            context, dofs[index].url, dofs[index].type);
                      });
                    },
                  );
                } else {
                  // RepoCot cot =
                  //     RepoCot.fromJson(stringToJsonMap(snapshot.data.body));
                  // return Text(cot.content);
                  return WebView(
                    initialUrl: new Uri.dataFromString(snapshot.data.body,
                            mimeType: 'text/html')
                        .toString(),
                    javascriptMode: JavascriptMode.unrestricted,
                  );
                }
              }
            }
            //请求未完成时弹出loading
            return CircularProgressIndicator();
          }),
    );
  }
}

String getTypeIcon(Type type) {
  if (type == Type.FILE) {
    return 'images/file.png';
  } else {
    return 'images/dir.png';
  }
}

Widget buildDirOrFileItem(RepoDof dof, {Function onClick}) {
  return GestureDetector(
    onTap: onClick,
    child: Container(
      child: Row(
        children: [
          Image.asset(
            getTypeIcon(dof.type),
            width: 42.0,
            height: 42.0,
          ),
          buildPaddingInHV(5.0, 0),
          Text(
            dof.name,
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
