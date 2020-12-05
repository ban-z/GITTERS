import 'package:flutter/material.dart';

// 国际化组件，实现语言的切换功能
class I18nWidget extends StatefulWidget {
  final child;
  I18nWidget({Key key, this.child}) : super(key: key);

  @override
  State<I18nWidget> createState() => I18nWidgetState();
}

class I18nWidgetState extends State<I18nWidget> {
  var _locale;

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
