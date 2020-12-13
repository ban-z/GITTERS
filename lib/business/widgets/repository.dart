import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:github/github.dart';
import 'package:gitters/business/widgets/avatar.dart';
import 'package:gitters/framework/global/provider/BaseModel.dart';
import 'package:provider/provider.dart';

class RepoItem extends StatefulWidget {
  // 将`repo.id`作为RepoItem的默认key
  RepoItem(this.repo) : super(key: ValueKey(repo.id));

  final Repository repo;

  @override
  _RepoItemState createState() => _RepoItemState();
}

class _RepoItemState extends State<RepoItem> {
  @override
  Widget build(BuildContext context) {
    var subtitle;
    return Container(
      decoration: BoxDecoration(
          border: Border.all(
              color: context.watch<BaseModel>().themeData.primaryColor,
              width: 1.0),
          borderRadius: BorderRadius.all(Radius.circular(8.0))),
      margin: EdgeInsets.symmetric(vertical: 3.0, horizontal: 5.0),
      padding: const EdgeInsets.only(top: 8.0),
      child: Material(
        color: Colors.white,
        shape: BorderDirectional(
          bottom: BorderSide(
            color: Theme.of(context).dividerColor,
            width: .5,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 0.0, bottom: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ListTile(
                dense: true,
                leading: GitterAvatar(
                  //项目owner头像
                  widget.repo?.owner?.avatarUrl ?? '',
                  width: 36.0,
                  borderRadius: BorderRadius.circular(12),
                ),
                title: Text(
                  widget.repo?.owner?.login ?? '',
                  textScaleFactor: .9,
                  style: TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(widget.repo.createdAt != null
                    ? formatDate(widget.repo?.createdAt,
                        [yyyy, '-', mm, '-', dd, ' - ', hh, ':', nn, ':', ss])
                    : ''),
                trailing: Text(
                  widget.repo?.language ?? '',
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
              ),
              // 构建项目标题和简介
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      widget.repo?.isFork
                          ? widget.repo?.fullName
                          : widget.repo?.name ?? '',
                      style: TextStyle(
                        fontSize: 22.0,
                        color: Colors.blueAccent,
                        fontWeight: FontWeight.bold,
                        fontStyle: widget.repo.isFork
                            ? FontStyle.italic
                            : FontStyle.normal,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8, bottom: 12),
                      child: widget.repo.description == null
                          ? Text(
                              "none description!",
                              style: TextStyle(
                                  fontStyle: FontStyle.italic,
                                  color: Colors.grey[700]),
                            )
                          : Text(
                              widget.repo.description,
                              maxLines: 3,
                              style: TextStyle(
                                height: 1.15,
                                color: Colors.blueGrey[700],
                                fontSize: 13,
                              ),
                            ),
                    ),
                  ],
                ),
              ),
              // 构建卡片底部信息
              _buildBottom()
            ],
          ),
        ),
      ),
    );
  }

  // 构建卡片底部信息
  Widget _buildBottom() {
    const paddingWidth = 10;
    return IconTheme(
      data: IconThemeData(
        color: Colors.grey,
        size: 15,
      ),
      child: DefaultTextStyle(
        style: TextStyle(color: Colors.grey, fontSize: 12),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Builder(builder: (context) {
            var children = <Widget>[
              Icon(
                Icons.star,
                color: Colors.amberAccent,
                size: 18.0,
              ),
              Text(
                " " +
                    widget.repo?.stargazersCount
                        .toString()
                        .padRight(paddingWidth) ?? '',
                style: TextStyle(
                  fontSize: 18.0,
                ),
              ),
              Icon(
                Icons.info_outline,
                color: Colors.redAccent,
                size: 18.0,
              ),
              Text(
                " " +
                    widget.repo?.openIssuesCount
                        .toString()
                        .padRight(paddingWidth) ?? '',
                style: TextStyle(
                  fontSize: 18.0,
                ),
              ),

              Icon(
                Icons.copy,
                color: Colors.cyanAccent,
                size: 18.0,
              ), //我们的自定义图标
              Text(
                widget.repo?.forksCount.toString().padRight(paddingWidth) ?? '',
                style: TextStyle(
                  fontSize: 18.0,
                ),
              ),
            ];

            if (widget.repo.isFork) {
              children.add(Text("Forked".padRight(paddingWidth)));
            }

            if (widget.repo.isPrivate == true) {
              children.addAll(<Widget>[
                Icon(Icons.lock),
                Text(" private".padRight(paddingWidth))
              ]);
            }
            return Row(children: children);
          }),
        ),
      ),
    );
  }
}
