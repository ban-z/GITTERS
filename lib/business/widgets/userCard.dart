import 'package:flutter/material.dart';
import 'package:github/github.dart';
import 'package:gitters/business/widgets/avatar.dart';
import 'package:gitters/framework/global/provider/BaseModel.dart';
import 'package:provider/provider.dart';

class UserCard extends StatefulWidget {
  User user;
  Function onClick;
  UserCard(this.user, {this.onClick, Key key}) : super(key: key);

  @override
  _UserCardState createState() => _UserCardState();
}

class _UserCardState extends State<UserCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onClick,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 5.0),
        padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 12.0),
        decoration: BoxDecoration(
            border: Border.all(
                color: context.watch<BaseModel>().themeData.primaryColor,
                width: 1.0),
            borderRadius: BorderRadius.all(Radius.circular(24.0)),
            boxShadow: [
              BoxShadow(
                color: context.watch<BaseModel>().themeData.primaryColor,
                offset: Offset(-5, -5),
                blurRadius: 1.0,
                spreadRadius: 1.0,
              ),
              BoxShadow(
                color: context.watch<BaseModel>().themeData.backgroundColor,
                offset: Offset(5, 5),
                blurRadius: 1.0,
                spreadRadius: 1.0,
              ),
            ],
            gradient: LinearGradient(colors: [
              context.watch<BaseModel>().themeData.primaryColor,
              context.watch<BaseModel>().themeData.backgroundColor,
            ])),
        child: Row(
          children: [
            GitterAvatar(widget.user.avatarUrl ?? '',
                width: 60.0, height: 60.0),
            Column(
              children: [
                Text(
                  widget.user.login ?? '',
                  style: TextStyle(
                    fontSize: 24.0,
                  ),
                ),
                Text(widget.user.createdAt ?? 'none description'),
              ],
            ),
            Icon(Icons.arrow_right),
          ],
        ),
      ),
    );
  }
}
