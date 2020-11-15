import 'package:flutter/material.dart';
import 'package:gitters/business/widgets/pages/UserHelper.dart';

class GittersLocalizations {
  final Locale locale;

  GittersLocalizations(this.locale);

  static Map<String, Map<String, String>> _localizedValuesMap = {
    'en': {
      'Application_name': 'Gitters',
      'login_content': "Log In",
      'market_place': 'Marketplace',
      'search': 'Search',
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
    },
    'zh': {
      'Application_name': 'Gitters',
      'login_content': "登录",
      'market_place': '市场',
      'search': '搜索',
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
    },
  };

  get testText {
    // 注意用 locale.toString()而非locale
    return _localizedValuesMap[locale.languageCode]['test_text'];
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
