String generateRouterParams(String key, String value) {
  return key + value;
}

class FollowingPageRouterArguments {
  String curUser;
  String pageTitle;

  FollowingPageRouterArguments({this.curUser, this.pageTitle});
}
