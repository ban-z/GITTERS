import 'package:flutter/material.dart';
import 'package:github/github.dart';
import 'package:gitters/business/widgets/avatar.dart';

class UserBar extends StatefulWidget {
  User user;

  UserBar({Key key, this.user}) : super(key: key);

  @override
  _UserBarState createState() => _UserBarState();
}

class _UserBarState extends State<UserBar> {
  @override
  Widget build(BuildContext context) {
    return buildUserbar();
  }

  Widget buildUserbar() {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        // image: DecorationImage(image: NetworkImage(widget.user.avatarUrl)),
        gradient: LinearGradient(colors: [Colors.grey, Colors.grey[100]]),
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(24.0),
            bottomRight: Radius.circular(24.0)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 48.0),
            child: Container(
              width: 96,
              height: 96,
              // color: Colors.cyan,
              child: GitterAvatar(widget.user.avatarUrl, width: 48, height: 48),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 24.0),
            child: Column(
              children: [
                Text(
                  widget.user.login ?? 'default',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 48.0),
                ),
                Padding(padding: EdgeInsets.all(5.0)),
                Text(
                  widget.user.htmlUrl ?? 'No registered email address',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 24.0),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
