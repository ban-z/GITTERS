import 'package:flutter/material.dart';
import 'package:gitters/framework/global/provider/BaseModel.dart';
import 'package:provider/provider.dart';

class GitterIconButtonLR extends StatelessWidget {
  GitterIconButtonLR(
    this.btnContent,
    this.btnIconData, {
    Key key,
    this.isLeft = false,
    this.onClick,
  }) : super(key: key);

  String btnContent;
  IconData btnIconData;
  bool isLeft;
  Function onClick;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: Container(
        height: 48.0,
        margin: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
        decoration: BoxDecoration(
          color: context.watch<BaseModel>().themeData.backgroundColor,
          borderRadius: BorderRadius.all(Radius.circular(12.0)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 18.0),
              child: Text(
                btnContent,
                style: TextStyle(fontSize: 18.0),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 36.0),
              child: Icon(btnIconData),
            )
          ],
        ),
      ),
    );
  }
}

class GitterIconButtonTB extends StatelessWidget {
  IconData iconData;
  String iconDes;
  String iconContent;
  Function onClick;

  GitterIconButtonTB(this.iconData, this.iconDes, this.iconContent,
      {this.onClick, Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onClick();
      },
      child: Container(
        child: Container(
          child: Column(
            children: [
              Icon(iconData),
              Row(
                children: [
                  Text(iconDes),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 3.0),
                    child: Text(''),
                  ),
                  Text(iconContent),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
