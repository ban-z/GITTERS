import 'package:fluro/fluro.dart';
import 'package:github/github.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Application类用来做App通用的配置：Router，Provider等

FluroRouter fluroRouter;

GitHub gitHubClient;

SharedPreferences diskCache;
