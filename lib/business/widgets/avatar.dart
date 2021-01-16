import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

Widget GitterAvatar(
  String url, {
  double width = 30,
  double height,
  BoxFit fit,
  BorderRadius borderRadius,
  bool isClipRect = false,
}) {
  var placeholder = Image.asset("images/default_avatar.png", //头像占位图，加载过程中显示
      width: width,
      height: height);

  if (!isClipRect) {
    return ClipOval(
      child: CachedNetworkImage(
        imageUrl: url,
        width: width,
        height: height,
        fit: fit,
        placeholder: (context, url) => placeholder,
        errorWidget: (context, url, error) => placeholder,
      ),
    );
  } else {
    return ClipRRect(
      borderRadius: borderRadius ?? BorderRadius.circular(8),
      child: CachedNetworkImage(
        imageUrl: url,
        width: width,
        height: height,
        fit: fit,
        placeholder: (context, url) => placeholder,
        errorWidget: (context, url, error) => placeholder,
      ),
    );
  }
}
