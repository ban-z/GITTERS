import 'package:flutter/material.dart';
import 'package:gitters/application.dart';
import 'package:gitters/framework/global/constants/Constant.dart';

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
