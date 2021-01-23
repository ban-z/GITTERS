import 'package:flutter/material.dart';

class GittersLocalizations {
  final Locale locale;

  GittersLocalizations(this.locale);

  static Map<String, Map<String, String>> _localizedValuesMap = {
    'en': {
      'Application_name': 'Gitters',
      'login_content': "Log In",
      'market_place': 'Home',
      'search': 'Search in GitHub',
      'profile': 'Mine',
      'change_language': 'You have switched to English!',
      'user_helper_center': 'User Helper Center',
      'login_problem': 'Login Problem',
      'about_gitters': 'About Gitters',
      'hint_account': 'Account',
      'hint_password': 'Password',
      'hint_input_account': 'Please enter your account...',
      'hint_input_password': 'Please enter your password...',
      'warning_null_account': 'The account cannot be empty!',
      'warning_null_password': 'The password cannot be empty!',
      'solve_problem': '|Solve problem|',
      'app_theme_setting': 'App Theme Setting',
      'internationalization': 'internationalization',
      'about_app': 'About App',
      'user_feedback': 'User FeedBack',
      'my_repos': 'My Repository',
      'user_information': 'User Information',
      'tab_follow': 'Follow',
      'tab_followers': 'Followers',
      'tab_star': "Star",
      'tab_popular': 'Popular',
      'tab_mine': 'Mine',
      'following_user': 'Following User',
      'tab_about_me': 'About Me',
      'tab_pulic': 'Public Event',
      'icon_following': "Following",
      'icon_followers': "Followers",
      'icon_repo': "Repositories",
      'repository': "Repository",
      'no_des': 'No description yet...',
      'clone_url': 'Clone Url: ',
      'repo_stars': 'Repository Stars: ',
      'repo_subscribe': 'Repository Watchs: ',
      'repo_forks:': 'Repository Forks: ',
      'btn_star': "Star",
      'btn_watch': "Watch",
      'cur_branch': 'Current Branch: ',
      'view_codes': 'View Codes: ',
      'no_readMe': 'The author of this repository does not have the README.md file...',
      'cannot_view_repo': 'Viewing such repositories is not supported at this time！',
    },
    'zh': {
      'Application_name': 'Gitters',
      'login_content': "登录",
      'market_place': '主页',
      'search': '搜索GitHub',
      'profile': '我的',
      'change_language': '您已切换到中文!',
      'user_helper_center': '用户帮助中心',
      'login_problem': '登录问题',
      'about_gitters': '关于Gitters',
      'hint_account': '账号',
      'hint_password': '密码',
      'hint_input_account': '请输入账号...',
      'hint_input_password': '请输入密码...',
      'warning_null_account': '账号不能为空!',
      'warning_null_password': '密码不能为空!',
      'solve_problem': '|解决问题|',
      'app_theme_setting': '应用主题设置',
      'internationalization': '国际化',
      'about_app': '关于应用',
      'user_feedback': '用户反馈',
      'my_repos': '我的仓库',
      'user_information': '用户信息',
      'tab_follow': '关注',
      'tab_followers': '粉丝',
      'tab_star': "Star",
      'tab_popular': '推荐',
      'tab_mine': '我的',
      'following_user': '关注的人',
      'tab_about_me': '与我相关',
      'tab_pulic': '公开事件',
      'icon_following': "关注",
      'icon_followers': "粉丝",
      'icon_repo': "仓库",
      'repository': "仓库",
      'cannot_view_repo': '暂时不支持查看此类仓库！',
      'no_des': '暂时没有描述...',
      'clone_url': '克隆 Url: ',
      'repo_stars': '仓库关注人数: ',
      'repo_subscribe': '仓库订阅人数: ',
      'repo_forks:': '仓库复制人数: ',
      'btn_star': 'Star',
      'btn_watch': "Watch",
      'cur_branch': '目前的分支: ',
      'view_codes': '浏览代码: ',
      'no_readMe': '此仓库作者暂无ReadMe.md文件...',
    },
  };

  // 使用示🌰
  // GittersLocalizations.of(context).ProfileName

  get testText {
    // 注意用 locale.toString()而非locale
    return _localizedValuesMap[locale.languageCode]['test_text'];
  }

  get NoDes {
    // 注意用 locale.toString()而非locale
    return _localizedValuesMap[locale.languageCode]['no_des'];
  }

  get CloneUrl {
    // 注意用 locale.toString()而非locale
    return _localizedValuesMap[locale.languageCode]['clone_url'];
  }

  get RepoStar {
    // 注意用 locale.toString()而非locale
    return _localizedValuesMap[locale.languageCode]['repo_stars'];
  }

  get RepoSubscribe {
    // 注意用 locale.toString()而非locale
    return _localizedValuesMap[locale.languageCode]['repo_subscribe'];
  }

  get RepoForks {
    // 注意用 locale.toString()而非locale
    return _localizedValuesMap[locale.languageCode]['repo_forks'];
  }

  get StarButton {
    // 注意用 locale.toString()而非locale
    return _localizedValuesMap[locale.languageCode]['btn_star'];
  }

  get WatchButton {
    // 注意用 locale.toString()而非locale
    return _localizedValuesMap[locale.languageCode]['btn_watch'];
  }

  get CurBranch {
    // 注意用 locale.toString()而非locale
    return _localizedValuesMap[locale.languageCode]['cur_branch'];
  }

  get ViewCodes {
    // 注意用 locale.toString()而非locale
    return _localizedValuesMap[locale.languageCode]['view_codes'];
  }

  get NoReadMe {
    // 注意用 locale.toString()而非locale
    return _localizedValuesMap[locale.languageCode]['no_readMe'];
  }

  get Repository {
    // 注意用 locale.toString()而非locale
    return _localizedValuesMap[locale.languageCode]['repository'];
  }

  get CannotViewRepo {
    return _localizedValuesMap[locale.languageCode]['cannot_view_repo'];
  }

  get IconFollowingDes {
    // 注意用 locale.toString()而非locale
    return _localizedValuesMap[locale.languageCode]['icon_following'];
  }

  get IconFollowersDes {
    // 注意用 locale.toString()而非locale
    return _localizedValuesMap[locale.languageCode]['icon_followers'];
  }

  get IconRepositoryDes {
    // 注意用 locale.toString()而非locale
    return _localizedValuesMap[locale.languageCode]['icon_repo'];
  }

  get TabFollow {
    // 注意用 locale.toString()而非locale
    return _localizedValuesMap[locale.languageCode]['tab_follow'];
  }

  get TabFollowers {
    // 注意用 locale.toString()而非locale
    return _localizedValuesMap[locale.languageCode]['tab_followers'];
  }

  get TabStar {
    // 注意用 locale.toString()而非locale
    return _localizedValuesMap[locale.languageCode]['tab_star'];
  }

  get FollowingUser {
    return _localizedValuesMap[locale.languageCode]['following_user'];
  }

  get TabPopular {
    // 注意用 locale.toString()而非locale
    return _localizedValuesMap[locale.languageCode]['tab_popular'];
  }

  get TabMine {
    // 注意用 locale.toString()而非locale
    return _localizedValuesMap[locale.languageCode]['tab_mine'];
  }

  get TabAboutMe {
    // 注意用 locale.toString()而非locale
    return _localizedValuesMap[locale.languageCode]['tab_about_me'];
  }

  get TabPulic {
    // 注意用 locale.toString()而非locale
    return _localizedValuesMap[locale.languageCode]['tab_pulic'];
  }

  get AppThemeSetting {
    return _localizedValuesMap[locale.languageCode]['app_theme_setting'];
  }

  get Internationalization {
    return _localizedValuesMap[locale.languageCode]['internationalization'];
  }

  get AboutApp {
    return _localizedValuesMap[locale.languageCode]['about_app'];
  }

  get UserFeedBack {
    return _localizedValuesMap[locale.languageCode]['user_feedback'];
  }

  get MyRepository {
    return _localizedValuesMap[locale.languageCode]['my_repos'];
  }

  get UserInformation {
    return _localizedValuesMap[locale.languageCode]['user_information'];
  }

  get SolveProblem {
    return _localizedValuesMap[locale.languageCode]['solve_problem'];
  }

  get LoginProblem {
    return _localizedValuesMap[locale.languageCode]['login_problem'];
  }

  get AboutGitters {
    return _localizedValuesMap[locale.languageCode]['about_gitters'];
  }

  get HintAccount {
    return _localizedValuesMap[locale.languageCode]['hint_account'];
  }

  get HintPassword {
    return _localizedValuesMap[locale.languageCode]['hint_password'];
  }

  get HintInputAccount {
    return _localizedValuesMap[locale.languageCode]['hint_input_account'];
  }

  get HintInputPassword {
    return _localizedValuesMap[locale.languageCode]['hint_input_password'];
  }

  get WarningNullAccount {
    return _localizedValuesMap[locale.languageCode]['warning_null_account'];
  }

  get WarningNullPassword {
    return _localizedValuesMap[locale.languageCode]['warning_null_password'];
  }

  get ApplicationName {
    return _localizedValuesMap[locale.languageCode]['Application_name'];
  }

  get Marketplace {
    return _localizedValuesMap[locale.languageCode]['market_place'];
  }

  get SearchName {
    return _localizedValuesMap[locale.languageCode]['search'];
  }

  get ProfileName {
    return _localizedValuesMap[locale.languageCode]['profile'];
  }

  get Changelanguage {
    return _localizedValuesMap[locale.languageCode]['change_language'];
  }

  get UserHelperCenter {
    return _localizedValuesMap[locale.languageCode]['user_helper_center'];
  }

  get LoginContent {
    return _localizedValuesMap[locale.languageCode]['login_content'];
  }

  // GittersLocalizations的实例是在 Localizations中通过 GittersLocalizationsDelegate实例化,
  // 应用中要使用 GittersLocalizations的实例需要通过 Localizations这个 Widget来获取
  static GittersLocalizations of(BuildContext context) {
    return Localizations.of(context, GittersLocalizations);
  }
}
