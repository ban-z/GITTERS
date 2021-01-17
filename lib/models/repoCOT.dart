// To parse this JSON data, do
//
//     final repoCot = repoCotFromJson(jsonString);

import 'dart:convert';

RepoCot repoCotFromJson(String str) => RepoCot.fromJson(json.decode(str));

String repoCotToJson(RepoCot data) => json.encode(data.toJson());

class RepoCot {
  RepoCot({
    this.sha,
    this.nodeId,
    this.size,
    this.url,
    this.content,
    this.encoding,
  });

  String sha;
  String nodeId;
  int size;
  String url;
  String content;
  String encoding;

  factory RepoCot.fromJson(Map<String, dynamic> json) => RepoCot(
        sha: json["sha"],
        nodeId: json["node_id"],
        size: json["size"],
        url: json["url"],
        content: json["content"],
        encoding: json["encoding"],
      );

  Map<String, dynamic> toJson() => {
        "sha": sha,
        "node_id": nodeId,
        "size": size,
        "url": url,
        "content": content,
        "encoding": encoding,
      };
}
