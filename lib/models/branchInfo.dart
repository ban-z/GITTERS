// To parse this JSON data, do
//
//     final branchInfo = branchInfoFromJson(jsonString);

import 'dart:convert';

BranchInfo branchInfoFromJson(String str) =>
    BranchInfo.fromJson(json.decode(str));

String branchInfoToJson(BranchInfo data) => json.encode(data.toJson());

class BranchInfo {
  BranchInfo({
    this.name,
    this.commit,
    this.links,
    this.protected,
    this.protection,
    this.protectionUrl,
  });

  String name;
  BranchInfoCommit commit;
  Links links;
  bool protected;
  Protection protection;
  String protectionUrl;

  factory BranchInfo.fromJson(Map<String, dynamic> json) => BranchInfo(
        name: json["name"],
        commit: BranchInfoCommit.fromJson(json["commit"]),
        links: Links.fromJson(json["_links"]),
        protected: json["protected"],
        protection: Protection.fromJson(json["protection"]),
        protectionUrl: json["protection_url"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "commit": commit.toJson(),
        "_links": links.toJson(),
        "protected": protected,
        "protection": protection.toJson(),
        "protection_url": protectionUrl,
      };
}

class BranchInfoCommit {
  BranchInfoCommit({
    this.sha,
    this.nodeId,
    this.commit,
    this.url,
    this.htmlUrl,
    this.commentsUrl,
    this.author,
    this.committer,
    this.parents,
  });

  String sha;
  String nodeId;
  CommitCommit commit;
  String url;
  String htmlUrl;
  String commentsUrl;
  dynamic author;
  dynamic committer;
  List<dynamic> parents;

  factory BranchInfoCommit.fromJson(Map<String, dynamic> json) =>
      BranchInfoCommit(
        sha: json["sha"],
        nodeId: json["node_id"],
        commit: CommitCommit.fromJson(json["commit"]),
        url: json["url"],
        htmlUrl: json["html_url"],
        commentsUrl: json["comments_url"],
        author: json["author"],
        committer: json["committer"],
        parents: List<dynamic>.from(json["parents"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "sha": sha,
        "node_id": nodeId,
        "commit": commit.toJson(),
        "url": url,
        "html_url": htmlUrl,
        "comments_url": commentsUrl,
        "author": author,
        "committer": committer,
        "parents": List<dynamic>.from(parents.map((x) => x)),
      };
}

class CommitCommit {
  CommitCommit({
    this.author,
    this.committer,
    this.message,
    this.tree,
    this.url,
    this.commentCount,
    this.verification,
  });

  Author author;
  Author committer;
  String message;
  Tree tree;
  String url;
  int commentCount;
  Verification verification;

  factory CommitCommit.fromJson(Map<String, dynamic> json) => CommitCommit(
        author: Author.fromJson(json["author"]),
        committer: Author.fromJson(json["committer"]),
        message: json["message"],
        tree: Tree.fromJson(json["tree"]),
        url: json["url"],
        commentCount: json["comment_count"],
        verification: Verification.fromJson(json["verification"]),
      );

  Map<String, dynamic> toJson() => {
        "author": author.toJson(),
        "committer": committer.toJson(),
        "message": message,
        "tree": tree.toJson(),
        "url": url,
        "comment_count": commentCount,
        "verification": verification.toJson(),
      };
}

class Author {
  Author({
    this.name,
    this.email,
    this.date,
  });

  String name;
  String email;
  DateTime date;

  factory Author.fromJson(Map<String, dynamic> json) => Author(
        name: json["name"],
        email: json["email"],
        date: DateTime.parse(json["date"]),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "date": date.toIso8601String(),
      };
}

class Tree {
  Tree({
    this.sha,
    this.url,
  });

  String sha;
  String url;

  factory Tree.fromJson(Map<String, dynamic> json) => Tree(
        sha: json["sha"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "sha": sha,
        "url": url,
      };
}

class Verification {
  Verification({
    this.verified,
    this.reason,
    this.signature,
    this.payload,
  });

  bool verified;
  String reason;
  dynamic signature;
  dynamic payload;

  factory Verification.fromJson(Map<String, dynamic> json) => Verification(
        verified: json["verified"],
        reason: json["reason"],
        signature: json["signature"],
        payload: json["payload"],
      );

  Map<String, dynamic> toJson() => {
        "verified": verified,
        "reason": reason,
        "signature": signature,
        "payload": payload,
      };
}

class Links {
  Links({
    this.self,
    this.html,
  });

  String self;
  String html;

  factory Links.fromJson(Map<String, dynamic> json) => Links(
        self: json["self"],
        html: json["html"],
      );

  Map<String, dynamic> toJson() => {
        "self": self,
        "html": html,
      };
}

class Protection {
  Protection({
    this.enabled,
    this.requiredStatusChecks,
  });

  bool enabled;
  RequiredStatusChecks requiredStatusChecks;

  factory Protection.fromJson(Map<String, dynamic> json) => Protection(
        enabled: json["enabled"],
        requiredStatusChecks:
            RequiredStatusChecks.fromJson(json["required_status_checks"]),
      );

  Map<String, dynamic> toJson() => {
        "enabled": enabled,
        "required_status_checks": requiredStatusChecks.toJson(),
      };
}

class RequiredStatusChecks {
  RequiredStatusChecks({
    this.enforcementLevel,
    this.contexts,
  });

  String enforcementLevel;
  List<dynamic> contexts;

  factory RequiredStatusChecks.fromJson(Map<String, dynamic> json) =>
      RequiredStatusChecks(
        enforcementLevel: json["enforcement_level"],
        contexts: List<dynamic>.from(json["contexts"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "enforcement_level": enforcementLevel,
        "contexts": List<dynamic>.from(contexts.map((x) => x)),
      };
}
