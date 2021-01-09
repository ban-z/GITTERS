import 'package:flutter/material.dart';
import 'package:gitters/application.dart';

class SearchBarDelegate extends SearchDelegate {
  String selectedResult;
  List<String> suggestions = [
    "User...",
    "Repository...",
    "Code...",
    "Issues..."
  ];

  // 方法返回一个控件列表，显示为搜索框右边的图标按钮
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = "";
          // 方法显示建议的搜索内容，是Widget buildSuggestions(BuildContext context)方法的的调用
          showSuggestions(context);
        },
      ),
    ];
  }

  // 方法返回一个控件，显示为搜索框左侧的按钮，一般设置为返回，这里返回一个具有动态效果的返回按钮
  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow, progress: transitionAnimation),
      onPressed: () {
        fluroRouter.pop(context);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text(selectedResult),
        ],
      ),
    );
  }

  // 方法返回一个控件，显示为搜索内容区域的建议内容
  // 方法返回一个控件，显示为搜索内容区域的搜索结果内容
  @override
  Widget buildSuggestions(BuildContext context) {
    return ListView.builder(
        itemCount: 4,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(suggestions[index]),
            onTap: () {
              selectedResult = suggestions[index];
              showResults(context);
            },
          );
        });
  }

  // 这个方法返回一个主题，也就是可以自定义搜索界面的主题样式
  @override
  ThemeData appBarTheme(BuildContext context) {
    // TODO: implement appBarTheme
    // return super.appBarTheme(context);
    assert(context != null);
    final ThemeData theme = Theme.of(context);
    assert(theme != null);
    return theme.copyWith(
      primaryColor: Colors.white,
      primaryIconTheme: theme.primaryIconTheme.copyWith(color: Colors.grey),
      primaryColorBrightness: Brightness.light,
      primaryTextTheme: theme.textTheme,
    );
  }
}
