import 'package:flutter/material.dart';
import 'package:github/github.dart';
import 'package:gitters/business/widgets/avatar.dart';
import 'package:gitters/business/widgets/iconBtn.dart';
import 'package:gitters/framework/global/constants/language/Localizations.dart';
import 'package:gitters/framework/global/provider/BaseModel.dart';
import 'package:provider/provider.dart';

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
        gradient: LinearGradient(colors: [
          context.watch<BaseModel>().themeData.primaryColor,
          context.watch<BaseModel>().themeData.backgroundColor
        ]),
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(24.0),
            bottomRight: Radius.circular(24.0)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 24.0),
            child: Container(
              width: 84.0,
              height: 84.0,
              // color: Colors.cyan,
              child: GitterAvatar(widget.user.avatarUrl, width: 60, height: 60),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 12.0),
            child: Column(
              children: [
                Text(
                  widget.user.login ?? 'default',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 44.0),
                ),
                Padding(padding: EdgeInsets.all(5.0)),
                Text(
                  widget.user.htmlUrl ?? 'No registered email address',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 16.0),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 36.0, left: 48.0, right: 48.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GitterIconButtonTB(
                    Icons.accessibility_new,
                    GittersLocalizations.of(context)
                        .IconFollowingDes
                        .toString(),
                    widget.user.followingCount.toString()),
                GitterIconButtonTB(
                    Icons.people,
                    GittersLocalizations.of(context)
                        .IconFollowersDes
                        .toString(),
                    widget.user.followersCount.toString()),
                GitterIconButtonTB(
                    Icons.home_filled,
                    GittersLocalizations.of(context)
                        .IconRepositoryDes
                        .toString(),
                    widget.user.publicReposCount.toString()),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
