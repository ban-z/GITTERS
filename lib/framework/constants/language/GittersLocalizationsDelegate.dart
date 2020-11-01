import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'Localizations.dart';

class GittersLocalizationsDelegate
    extends LocalizationsDelegate<GittersLocalizations> {
  const GittersLocalizationsDelegate();
  
  static GittersLocalizationsDelegate delegate =
      const GittersLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['en', 'zh'].contains(locale.languageCode);
  }

  @override
  Future<GittersLocalizations> load(Locale locale) {
    // 这里初始化 Localizations类
    return SynchronousFuture<GittersLocalizations>(
        new GittersLocalizations(locale));
  }

  @override
  bool shouldReload(LocalizationsDelegate<GittersLocalizations> old) {
    return false;
  }
}
