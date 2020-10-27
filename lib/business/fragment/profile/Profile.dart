import 'package:flutter/material.dart';
import 'package:gitters/business/login/LoginPage.dart';

class Profile extends StatefulWidget {
  @override
  ProfileState createState() => ProfileState();
}

class ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
      ),
      body: Center(
        child: LoginPage(),
      ),
    );
  }
}
