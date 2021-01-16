import 'package:flutter/material.dart';

class ErrorPage extends StatelessWidget {
  String error;

  ErrorPage(this.error, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("错误页")),
      body: Center(
        child: Text(error),
      ),
    );
  }
}
