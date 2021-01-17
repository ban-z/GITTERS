import 'dart:convert';
import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:github/github.dart';
import 'package:gitters/application.dart';
import 'package:gitters/framework/router/RouterConfig.dart';

class FollowingPageRouterArguments {
  String curUser;
  String pageTitle;
  Set set;

  FollowingPageRouterArguments({this.curUser, this.pageTitle});
}

typedef Widget CardCreator<W, M>(M m);

typedef M ModelCreator<M>(Map<String, dynamic> json);

typedef Widget ItemCreator(AsyncSnapshot snapshot);

typedef Void UpdateState();

Widget buildBaseCommonList(Future future, ItemCreator creator) {
  return FutureBuilder(
      future: future,
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
            return creator(snapshot);
          }
        }
        //请求未完成时弹出loading
        return CircularProgressIndicator();
      });
}

Widget buildCommonList<M, W>(BuildContext context, Future future,
    CardCreator<W, M> card, ModelCreator<M> model, UpdateState updateState) {
  return FutureBuilder(
      future: future,
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
            List<M> items;
            if (isSnapshotHasBody(snapshot)) {
              List<Map<String, dynamic>> response =
                  jsonDecode(snapshot.data.body).cast<Map<String, dynamic>>();
              items =
                  response.map((Map<String, dynamic> it) => model(it)).toList();
            } else {
              items = snapshot.data;
            }
            return RefreshIndicator(
              onRefresh: () {
                updateState();
              },
              color: Theme.of(context).primaryColor,
              child: ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  M item = items[index];
                  return card(item);
                },
              ),
            );
          }
        }
        //请求未完成时弹出loading
        return CircularProgressIndicator();
      });
}

bool isSnapshotHasBody(AsyncSnapshot snapshot) {
  bool hasBody = false;
  // 利用 try catch 判断是否有body
  try {
    hasBody = snapshot.data.body == null ? false : true;
  } catch (err) {
    hasBody = false;
  }
  return hasBody;
}

void gotoUserRepository(BuildContext context, RepositorySlug slug) {
  fluroRouter.navigateTo(context, RouterList.UserRepositoryHome.value,
      routeSettings: RouteSettings(
        arguments: slug,
      ));
}

Map<String, dynamic> stringToJsonMap(String jsons) {
  Map<String, dynamic> res = json.decode(jsons);
  return res;
}

var MINE_REPO = RepositorySlug('ban-z', 'andHttps');
