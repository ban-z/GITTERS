import 'package:flutter/material.dart';
import 'package:github/github.dart';
import 'package:gitters/framework/global/constants/language/Localizations.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../../application.dart';
import './SearchDelegate.dart';

class SearchPage extends StatefulWidget {
  SearchPage({Key key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(GittersLocalizations.of(context).SearchName),
        actions: [
          IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                showSearch(context: context, delegate: SearchBarDelegate());
              }),
        ],
        centerTitle: true,
      ),
      body: buildBody(),
    );
  }

  Widget buildBody() {
    return Container(
      child: WebView(
        initialUrl: 'https://github.com/trending',
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}
