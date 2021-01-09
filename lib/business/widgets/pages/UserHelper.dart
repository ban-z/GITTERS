import 'dart:io';
import 'package:flutter/material.dart';
import 'package:gitters/framework/global/constants/language/Localizations.dart';
import 'package:webview_flutter/webview_flutter.dart';

class UserHelperCenter extends StatefulWidget {
  UserHelperCenter({Key key}) : super(key: key);

  @override
  _UserHelperCenterState createState() => _UserHelperCenterState();
}

class _UserHelperCenterState extends State<UserHelperCenter> {
  String _loginProblem = '很抱歉，由于GitHub平台对于用户以GitHub API 或 CLi(命令行工具)等第三方访问形式的限制，' +
      '用户暂时不可以用: \n【账号+密码】\n组合的方式完成登录功能，而是应该提供\n【Personal Access Tokens(PATs：个人Token令牌)】\n作为【密码】\n的方式登录';

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) {
      WebView.platform = SurfaceAndroidWebView();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text("User Helper"),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                '1.登录问题:',
                style: TextStyle(
                  fontSize: 24.0,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10.0),
              child: Text(
                _loginProblem,
                style: TextStyle(
                  fontSize: 15.0,
                ),
              ),
            ),
            Padding(
                padding: EdgeInsets.only(top: 12.0),
                child: Align(
                  alignment: Alignment.center,
                  child: FlatButton(
                    color: Colors.grey[300],
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return PersonalAcessTokensWebView();
                      }));
                    },
                    child: Text(
                      GittersLocalizations.of(context).SolveProblem,
                      style: TextStyle(
                        fontSize: 24.0,
                      ),
                    ),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}

class PersonalAcessTokensWebView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text(GittersLocalizations.of(context).UserHelperCenter),
        ),
        body: Container(
          child: WebView(
            initialUrl:
                'https://docs.github.com/en/free-pro-team@latest/github/authenticating-to-github/creating-a-personal-access-token',
            javascriptMode: JavascriptMode.unrestricted,
          ),
        ),
      ),
    );
  }
}

class AboutGitHubApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title:Text(GittersLocalizations.of(context).UserHelperCenter),
        ),
        body: Container(
          child: WebView(
            initialUrl:
                'https://developer.github.com/program/',
            javascriptMode: JavascriptMode.unrestricted,
          ),
        ),
      ),
    );
  }
}
