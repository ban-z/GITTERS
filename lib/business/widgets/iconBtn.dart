import 'package:flutter/material.dart';

class GitterIconButton extends StatelessWidget {
  GitterIconButton(
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
          color: Colors.grey[300],
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
