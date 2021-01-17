// To parse this JSON data, do
//
//     final readMe = readMeFromJson(jsonString);

import 'dart:convert';

ReadMe readMeFromJson(String str) => ReadMe.fromJson(json.decode(str));

String readMeToJson(ReadMe data) => json.encode(data.toJson());

class ReadMe {
  ReadMe({
    this.name,
    this.path,
    this.sha,
    this.size,
    this.url,
    this.htmlUrl,
    this.gitUrl,
    this.downloadUrl,
    this.type,
    this.content,
    this.encoding,
    this.links,
  });

  String name;
  String path;
  String sha;
  int size;
  String url;
  String htmlUrl;
  String gitUrl;
  String downloadUrl;
  String type;
  String content;
  String encoding;
  Links links;

  factory ReadMe.fromJson(Map<String, dynamic> json) => ReadMe(
        name: json["name"],
        path: json["path"],
        sha: json["sha"],
        size: json["size"],
        url: json["url"],
        htmlUrl: json["html_url"],
        gitUrl: json["git_url"],
        downloadUrl: json["download_url"],
        type: json["type"],
        content: json["content"],
        encoding: json["encoding"],
        links: Links.fromJson(json["_links"]),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "path": path,
        "sha": sha,
        "size": size,
        "url": url,
        "html_url": htmlUrl,
        "git_url": gitUrl,
        "download_url": downloadUrl,
        "type": type,
        "content": content,
        "encoding": encoding,
        "_links": links.toJson(),
      };
}

class Links {
  Links({
    this.self,
    this.git,
    this.html,
  });

  String self;
  String git;
  String html;

  factory Links.fromJson(Map<String, dynamic> json) => Links(
        self: json["self"],
        git: json["git"],
        html: json["html"],
      );

  Map<String, dynamic> toJson() => {
        "self": self,
        "git": git,
        "html": html,
      };
}
