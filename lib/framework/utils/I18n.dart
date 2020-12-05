import 'package:flutter/material.dart';
import 'package:gitters/application.dart';
import 'package:gitters/framework/global/constants/Constant.dart';
import 'package:gitters/framework/global/provider/BaseModel.dart';
import 'package:provider/provider.dart';

void changeLanguage(BuildContext context) {
  Locale locale = Localizations.localeOf(context);
  Locale Chinese = Locale('zh', 'CH');
  Locale English = Locale('en', 'US');
  Locale currentLanguage;

  if (locale == English) {
    currentLanguage = Chinese;
  } else if (locale == Chinese) {
    currentLanguage = English;
  }
  context.read<BaseModel>().changeLanuage(currentLanguage);
  diskCache.setString(Constant.LANGUAGE, currentLanguage.languageCode);
  print("缓存的语言: " + currentLanguage.languageCode);
  diskCache.setString(Constant.COUNTER, currentLanguage.countryCode);
  print("缓存的国家: " + currentLanguage.countryCode);
}

// 废弃...
// 国际化组件，实现语言的切换功能
class I18nWidget extends StatefulWidget {
  final child;
  I18nWidget({Key key, this.child}) : super(key: key);

  @override
  State<I18nWidget> createState() => I18nWidgetState();
}

class I18nWidgetState extends State<I18nWidget> {
  Locale _locale = Locale(diskCache.get(Constant.LANGUAGE) ?? 'en',
      diskCache.get(Constant.COUNTER) ?? 'US');

  Locale get locale => _locale;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _locale = Localizations.localeOf(context);
  }

  void changeLanguage(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Localizations.override(
      context: context,
      locale: _locale,
      child: widget.child,
    );
  }
}
