import 'package:flutter/material.dart';
import 'package:gitters/framework/constants/language/Localizations.dart';

class Marketplace extends StatefulWidget {
  Marketplace({Key key}) : super(key: key);

  @override
  _MarketplaceState createState() => _MarketplaceState();
}

class _MarketplaceState extends State<Marketplace> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(GittersLocalizations.of(context).Marketplace),
      ),
       body: Text("Marketplace..."),
    );
  }
}