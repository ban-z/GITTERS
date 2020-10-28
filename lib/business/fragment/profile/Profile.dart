import 'package:flutter/material.dart';
import 'package:gitters/business/login/LoginPage.dart';
import 'package:gitters/application.dart';

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
        child: RaisedButton(
            onPressed: () =>
                Application.router.navigateTo(context, RouterList.Login.value),
            child: Text(
              "GO LOGIN!",
              style: TextStyle(color: Colors.blue),
            )),
      ),
    );
  }
}
