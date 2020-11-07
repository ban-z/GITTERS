import 'package:flutter/material.dart';
import 'package:gitters/business/fragment/profile/Profile.dart';
import 'package:gitters/business/fragment/marketplace/Marketplace.dart';
import 'package:gitters/business/fragment/search/SearchPage.dart';

class BottomNavigationSetting {
  static TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  static List<BottomNavigationBarItem> Indexs = <BottomNavigationBarItem>[
    // BottomNavigationBarItem(icon: Icon(Icons.shop_two), title: Text('Marketplace')),
    // BottomNavigationBarItem(icon: Icon(Icons.search), title: Text("Search")),
    // BottomNavigationBarItem(icon: Icon(Icons.person), title: Text("Mine")),
    BottomNavigationBarItem(icon: Icon(Icons.shop_two), title: Container()),
    BottomNavigationBarItem(icon: Icon(Icons.search), title: Container()),
    BottomNavigationBarItem(icon: Icon(Icons.person), title: Container()),
  ];

  static List<Widget> Items = <Widget>[
    Marketplace(),
    SearchPage(),
    Profile(),
  ];
}
