import 'package:github/github.dart';

class PopularRepos {
  final List<Repository> populars;

  PopularRepos({this.populars});

  factory PopularRepos.fromJson(List<dynamic> parsedJson) {
    List<Repository> repos = new List<Repository>();
    repos = parsedJson.map((i) => Repository.fromJson(i)).toList();
    return PopularRepos(populars: repos);
  }
}
