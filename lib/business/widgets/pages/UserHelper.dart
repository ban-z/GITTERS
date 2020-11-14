import 'dart:io';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class UserHelperCenter extends StatefulWidget {
  UserHelperCenter({Key key}) : super(key: key);

  @override
  _UserHelperCenterState createState() => _UserHelperCenterState();
}

class _UserHelperCenterState extends State<UserHelperCenter> {

  @override
  void initState() {
    super.initState();
    if(Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text("用户帮助中心"),
        ),
        body: Container(
          child: WebView(
            initialUrl: 'https://docs.github.com/en/free-pro-team@latest/github/authenticating-to-github/creating-a-personal-access-token',
          ),
        ),
      ),
    );
  }
}
