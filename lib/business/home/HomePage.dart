import 'package:flutter/material.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text("Gitters"),
      // ),
      body: Center(
        child: BottomNavigationSetting.Items.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: BottomNavigationSetting.Indexs,
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber,
        onTap: _onItemTapped,
      ),
    );
  }
}
