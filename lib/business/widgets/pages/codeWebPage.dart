import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webview_flutter/webview_flutter.dart';

class CodeDetailPageWeb extends StatefulWidget {
  final String userName;

  final String reposName;

  final String path;

  final String data;

  final String title;

  final String branch;

  final String htmlUrl;

  CodeDetailPageWeb(
      {this.title,
      this.userName,
      this.reposName,
      this.path,
      this.data,
      this.branch,
      this.htmlUrl});

  @override
  _CodeDetailPageState createState() => _CodeDetailPageState();
}

class _CodeDetailPageState extends State<CodeDetailPageWeb> {
  bool isLand = false;

  Future<String> _getData() async {
    // if (widget.data != null) {
    //   return widget.data;
    // }
    // var res = await ReposDao.getReposFileDirDao(
    //     widget.userName, widget.reposName,
    //     path: widget.path, branch: widget.branch, text: true, isHtml: true);
    // if (res != null && res.result) {
    //   String data2 = HtmlUtils.resolveHtmlFile(res, "java");
    //   String url = new Uri.dataFromString(data2,
    //           mimeType: 'text/html', encoding: Encoding.getByName("utf-8"))
    //       .toString();
    //   return url;
    // }
    // return "";
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: Text(widget.title),
      ),
      body: FutureBuilder(
          future: _getData(),
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
                return WebView(
                  initialUrl: snapshot.data,
                  javascriptMode: JavascriptMode.unrestricted,
                );
              }
            }
            //请求未完成时弹出loading
            return CircularProgressIndicator();
          }),
    );
  }
}
