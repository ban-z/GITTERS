// To parse this JSON data, do
//
//     final repoDof = repoDofFromJson(jsonString);

import 'dart:convert';

RepoDof repoDofFromJson(String str) => RepoDof.fromJson(json.decode(str));

String repoDofToJson(RepoDof data) => json.encode(data.toJson());

class RepoDof {
  RepoDof({
    this.sha,
    this.url,
    this.tree,
    this.truncated,
  });

  String sha;
  String url;
  List<Tree> tree;
  bool truncated;

  factory RepoDof.fromJson(Map<String, dynamic> json) => RepoDof(
        sha: json["sha"],
        url: json["url"],
        tree: List<Tree>.from(json["tree"].map((x) => Tree.fromJson(x))),
        truncated: json["truncated"],
      );

  Map<String, dynamic> toJson() => {
        "sha": sha,
        "url": url,
        "tree": List<dynamic>.from(tree.map((x) => x.toJson())),
        "truncated": truncated,
      };
}

class Tree {
  Tree({
    this.path,
    this.mode,
    this.type,
    this.sha,
    this.size,
    this.url,
  });

  String path;
  String mode;
  String type;
  String sha;
  int size;
  String url;

  factory Tree.fromJson(Map<String, dynamic> json) => Tree(
        path: json["path"],
        mode: json["mode"],
        type: json["type"],
        sha: json["sha"],
        size: json["size"] == null ? null : json["size"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "path": path,
        "mode": mode,
        "type": type,
        "sha": sha,
        "size": size == null ? null : size,
        "url": url,
      };
}
