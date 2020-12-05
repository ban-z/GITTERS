import 'package:flutter/material.dart';
import 'package:gitters/application.dart';
import 'package:gitters/business/fragment/marketplace/Marketplace.dart';
import 'package:gitters/business/fragment/profile/Profile.dart';
import 'package:gitters/business/fragment/search/SearchPage.dart';
import 'package:gitters/framework/global/provider/BaseModel.dart';
import 'package:gitters/framework/utils/I18n.dart';
import 'package:gitters/main.dart';
import 'package:provider/provider.dart';
import 'HomeSetting.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  HomePageState createState() => new HomePageState();
}

class HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final _bodyList = [Marketplace(), SearchPage(), Profile()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // body: _buildBody(),
      body: IndexedStack(
        index: _selectedIndex,
        children: _bodyList,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: BottomNavigationSetting.Indexs,
        currentIndex: _selectedIndex,
        // selectedItemColor: context.watch<BaseModel>().themeData.primaryColor,
        selectedItemColor: context.watch<BaseModel>().themeData.primaryColor,
        onTap: _onItemTapped,
      ),
    );
  }

  Widget _buildBody() {
    return Center(
      child: BottomNavigationSetting.Items.elementAt(_selectedIndex),
    );
  }
}
