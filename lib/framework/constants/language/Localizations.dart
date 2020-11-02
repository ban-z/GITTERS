import 'package:flutter/material.dart';

class GittersLocalizations {
  final Locale locale;

  GittersLocalizations(this.locale);

  static Map<String, Map<String, String>> _localizedValuesMap = {
    'en': {
      'Application_name': 'Gitters',
      'market_place': 'Marketplace',
      'search': 'Search',
      'profile': 'Mine',
      'change_language': 'You have switched to English!',
    },
    'zh': {
      'Application_name': 'Gitters',
      'market_place': '市场',
      'search': '搜索',
      'profile': '我的',
      'change_language': '您已切换到中文!',
    },
  };

  get testText {
    // 注意用 locale.toString()而非locale
    return _localizedValuesMap[locale.languageCode]['test_text'];
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

  // GittersLocalizations的实例是在 Localizations中通过 GittersLocalizationsDelegate实例化,
  // 应用中要使用 GittersLocalizations的实例需要通过 Localizations这个 Widget来获取
  static GittersLocalizations of(BuildContext context) {
    return Localizations.of(context, GittersLocalizations);
  }
}
