import 'package:flutter/material.dart';
import 'package:gitters/application.dart';
import 'package:gitters/business/fragment/marketplace/Marketplace.dart';
import 'package:gitters/business/fragment/profile/Profile.dart';
import 'package:gitters/business/fragment/search/SearchPage.dart';
import 'package:gitters/framework/global/provider/BaseModel.dart';
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
        selectedItemColor: Colors.lightBlue,
        onTap: _onItemTapped,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print("click the change theme button!");
          context
              .read<BaseModel>()
              .updateThemeData(ThemeData(primarySwatch: Colors.cyan));
        },
        child: Icon(Icons.change_history),
      ),
    );
  }

  Widget _buildBody() {
    return Center(
      child: BottomNavigationSetting.Items.elementAt(_selectedIndex),
    );
  }
}
