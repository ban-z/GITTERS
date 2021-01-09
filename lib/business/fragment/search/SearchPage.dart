import 'package:flutter/material.dart';
import 'package:github/github.dart';
import 'package:gitters/business/widgets/event.dart';
import 'package:gitters/framework/global/constants/language/Localizations.dart';
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
    return FutureBuilder<List<Event>>(
        future: gitHubClient.activity.listPublicEvents().toList(),
        builder: (BuildContext context, AsyncSnapshot<List<Event>> snapshot) {
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
              List<Event> events = snapshot.data;
              return ListView.builder(
                itemCount: events.length,
                itemBuilder: (context, index) {
                  Event event = events[index];
                  return EventItem(event);
                },
              );
            }
          }
          //请求未完成时弹出loading
          return CircularProgressIndicator();
        });
  }
}
