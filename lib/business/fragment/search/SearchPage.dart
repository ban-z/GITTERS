import 'dart:convert';

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
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: Text(GittersLocalizations.of(context).SearchName),
            bottom: TabBar(tabs: [
              Tab(text: GittersLocalizations.of(context).TabAboutMe.toString()),
              Tab(text: GittersLocalizations.of(context).TabPulic.toString()),
            ]),
            actions: [
              IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    showSearch(context: context, delegate: SearchBarDelegate());
                  }),
            ],
            centerTitle: true,
          ),
          body: TabBarView(children: [
            buildAboutMeEventTabContent(),
            buildPublicEventTabContent(),
          ]),
        ));
  }

  Widget buildPublicEventTabContent() {
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

  Widget buildAboutMeEventTabContent() {
    String url = '/users/' + gitHubClient.auth.username + '/received_events';
    print(url);
    return FutureBuilder(
        future: gitHubClient.request('GET', url),
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
              List<Map<String, dynamic>> response =
                  jsonDecode(snapshot.data.body).cast<Map<String, dynamic>>();
              List<Event> events = response
                  .map((Map<String, dynamic> it) => Event.fromJson(it))
                  .toList();
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
