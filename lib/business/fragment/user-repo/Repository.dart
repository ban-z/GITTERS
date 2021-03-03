import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:github/github.dart';
import 'package:gitters/application.dart';
import 'package:gitters/business/widgets/avatar.dart';
import 'package:gitters/business/widgets/toast.dart';
import 'package:gitters/framework/global/constants/language/Localizations.dart';
import 'package:gitters/framework/global/provider/BaseModel.dart';
import 'package:gitters/framework/utils/utils.dart';
import 'package:gitters/models/branchInfo.dart';
import 'package:gitters/models/repoDof.dart';
import 'package:provider/provider.dart';

class StarConfig {
  bool isStar;
  String starHint;
  IconData starIcon;
  bool isUpdate;

  StarConfig(this.isStar, this.starHint, this.starIcon, this.isUpdate);
}

class UserRepositoryHome extends StatefulWidget {
  RepositorySlug slug;

  UserRepositoryHome(this.slug, {Key key}) : super(key: key);

  @override
  _UserRepositoryHomeState createState() => _UserRepositoryHomeState();
}

class _UserRepositoryHomeState extends State<UserRepositoryHome> {
  GitHubFile readMe = GitHubFile();
  BranchInfo curBranchInfo;
  Future repoInfo;

  StarConfig starConfig = StarConfig(false, '--', Icons.star_border, false);
  IconData watchIcon;

  @override
  void initState() {
    super.initState();
    repoInfo = getRepositoryInfo(widget.slug);

    watchIcon = Icons.remove_red_eye_outlined;
  }

  Future getRepositoryInfo(RepositorySlug slug) async {
    String branchConfig = '/repos/${slug.fullName}/branches/master';
    String readMePath = '/repos/${slug.fullName}/contents/README.md';
    return Future.wait([
      gitHubClient.repositories.getRepository(slug),
      gitHubClient.request('GET', readMePath),
      gitHubClient.request('GET', branchConfig),
      gitHubClient.activity.isStarred(slug),
    ]);
  }

  void refreshRepoInfo() {
    setState(() {
      repoInfo = getRepositoryInfo(widget.slug);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(GittersLocalizations.of(context).Repository.toString()),
      ),
      body: FutureBuilder(
          future: repoInfo,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.active ||
                snapshot.connectionState == ConnectionState.waiting) {
              return new Center(
                child: new CircularProgressIndicator(),
              );
            }

            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                return Text(
                    GittersLocalizations.of(context).CannotViewRepo.toString());
              } else if (snapshot.hasData) {
                try {
                  Repository repo = snapshot.data[0];
                  GitHubFile readMeFile = GitHubFile.fromJson(
                      stringToJsonMap(snapshot.data[1].body));
                  if (curBranchInfo == null) {
                    curBranchInfo = BranchInfo.fromJson(
                        stringToJsonMap(snapshot.data[2].body));
                  }
                  if (snapshot.data[3] && !starConfig.isUpdate) {
                    starConfig = StarConfig(
                        true,
                        GittersLocalizations.of(context)
                            .UnStarButton
                            .toString(),
                        Icons.star,
                        false);
                  } else if (!snapshot.data[3] && !starConfig.isUpdate) {
                    starConfig = StarConfig(
                        false,
                        GittersLocalizations.of(context).StarButton.toString(),
                        Icons.star_border,
                        false);
                  }
                  print(starConfig.toString());
                  return buildRepoHome(repo, readMeFile);
                } catch (e) {
                  return Text(GittersLocalizations.of(context)
                      .CannotViewRepo
                      .toString());
                }
                ;
              }
            }
            //请求未完成时弹出loading
            return CircularProgressIndicator();
          }),
    );
  }

  Widget buildRepoHome(Repository repository, GitHubFile readMeFile) {
    return RefreshIndicator(
      onRefresh: () {
        refreshRepoInfo();
      },
      child: Container(
          padding: EdgeInsets.symmetric(horizontal: 12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: Row(
                        children: [
                          GitterAvatar(repository.owner.avatarUrl,
                              isClipRect: true, width: 48.0, height: 36.0),
                          buildPaddingInHV(3, 0),
                          Text(
                            repository.owner.login ?? '',
                            style: TextStyle(
                                fontSize: 24.0, fontWeight: FontWeight.w600),
                          )
                        ],
                      ),
                    ),
                    Container(
                      child: Row(
                        children: [
                          Text('➤',
                              style: TextStyle(
                                  color: context
                                      .read<BaseModel>()
                                      .themeData
                                      .primaryColor)),
                          buildPaddingInHV(3, 0),
                          Text(
                            repository.language ?? '--',
                            style: TextStyle(
                                fontSize: 16.0, fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                repository.fullName ?? '',
                style: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w800),
              ),
              buildPaddingInHV(0, 6.0),
              Text(
                repository.description ??
                    GittersLocalizations.of(context).NoDes.toString(),
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
              ),
              buildPaddingInHV(0, 6.0),
              buildKVRichText(
                  context,
                  GittersLocalizations.of(context).CloneUrl.toString(),
                  repository.cloneUrl),
              buildDivider(context),
              buildKVRichText(
                  context,
                  GittersLocalizations.of(context).RepoStar.toString(),
                  repository.stargazersCount.toString() ?? ''),
              buildPaddingInHV(0, 6),
              buildKVRichText(
                  context,
                  GittersLocalizations.of(context).RepoSubscribe.toString(),
                  repository.subscribersCount.toString() ?? ''),
              buildPaddingInHV(0, 6),
              // buildKVRichText(
              //     context,
              //     GittersLocalizations.of(context).RepoForks.toString(),
              //     repository.forksCount.toString() ?? ''),
              // buildDivider(context),
              buildKVRichText(
                  context,
                  GittersLocalizations.of(context).UpdateAt.toString(),
                  repository.updatedAt.toString() ?? ''),
              buildDivider(context),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    FlatButton(
                      color: context.read<BaseModel>().themeData.primaryColor,
                      clipBehavior: Clip.hardEdge,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Icon(starConfig.starIcon),
                          Text(starConfig.starHint)
                        ],
                      ),
                      onPressed: () {
                        if (starConfig.isStar) {
                          gitHubClient.activity.unstar(widget.slug).then((res) {
                            // 取消关注成功
                            StarConfig config = StarConfig(
                                false,
                                GittersLocalizations.of(context)
                                    .StarButton
                                    .toString(),
                                Icons.star_border,
                                true);
                            setState(() {
                              starConfig = config;
                              print('');
                            });
                          }).catchError((err) {
                            showToast('Network Error: ' + err.toString());
                          });
                        } else {
                          gitHubClient.activity.star(widget.slug).then((res) {
                            // 关注成功
                            StarConfig config = StarConfig(
                                true,
                                GittersLocalizations.of(context)
                                    .UnStarButton
                                    .toString(),
                                Icons.star,
                                true);
                            setState(() {
                              starConfig = config;
                              print('');
                            });
                          }).catchError((err) {
                            showToast('Network Error: ' + err.toString());
                          });
                        }
                      },
                    ),
                    FlatButton(
                      color: context.read<BaseModel>().themeData.primaryColor,
                      clipBehavior: Clip.hardEdge,
                      onPressed: () {
                        showToast('暂无 API，此功能未开放!');
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Icon(watchIcon),
                          Text(GittersLocalizations.of(context)
                              .WatchButton
                              .toString())
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              buildDivider(context),
              buildKVRichText(
                  context,
                  GittersLocalizations.of(context).CurBranch.toString(),
                  curBranchInfo.name ??
                      (curBranchInfo.name ?? (repository.defaultBranch ?? '')),
                  onClick: () {
                gotoUserRepositoryBranch(context, widget.slug)
                    .then((curBranchName) {
                  gitHubClient
                      .request('GET',
                          '/repos/${widget.slug.fullName}/branches/${curBranchName}')
                      .then((value) {
                    BranchInfo branchInfo =
                        BranchInfo.fromJson(stringToJsonMap(value.body));
                    setState(() {
                      curBranchInfo = branchInfo;
                    });
                  });
                });
              }),
              buildPaddingInHV(0, 6.0),
              buildKVRichText(
                  context,
                  GittersLocalizations.of(context).ViewCodes.toString(),
                  repository.name ?? '', onClick: () {
                gotoUserRepositoryContent(
                    context,
                    'https://api.github.com/repos/${repository.fullName}/contents?ref=${curBranchInfo.name ?? repository.defaultBranch}',
                    Type.DIR,
                    repoContentTitle: curBranchInfo.name);
              }),
              buildDivider(context),
              buildPaddingInHV(0, 5.0),
              Text(
                "README.md",
                style: TextStyle(
                    fontSize: 24.0,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w900),
              ),
              buildPaddingInHV(0, 5.0),
              Expanded(
                child: Markdown(
                    data: readMeFile.text ??
                        GittersLocalizations.of(context).NoReadMe.toString()),
              )
            ],
          )),
    );
  }
}

Widget buildKVRichText(BuildContext context, String title, String content,
    {Function onClick}) {
  return GestureDetector(
    onTap: onClick,
    child: Text.rich(TextSpan(children: [
      TextSpan(
          text: title,
          style: TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.w500,
              color: context.read<BaseModel>().themeData.primaryColor)),
      TextSpan(
          text: content,
          style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w700)),
    ])),
  );
}

Padding buildPaddingInHV(double h, double v) {
  return Padding(padding: EdgeInsets.symmetric(horizontal: h, vertical: v));
}

Widget buildDivider(BuildContext context) {
  return Container(
    height: 2,
    color: context.read<BaseModel>().themeData.primaryColor,
    margin: EdgeInsets.symmetric(vertical: 16.0),
  );
}

Widget buildActionButton(
    BuildContext context, IconData iconData, String content, Function onClick) {
  return FlatButton(
    color: context.read<BaseModel>().themeData.primaryColor,
    clipBehavior: Clip.hardEdge,
    onPressed: onClick,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [Icon(iconData), Text(content)],
    ),
  );
}
