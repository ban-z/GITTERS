import 'package:flutter/material.dart';
import 'package:github/github.dart';
import 'package:gitters/application.dart';
import 'package:gitters/business/fragment/user-repo/Repository.dart';

class Branches extends StatelessWidget {
  RepositorySlug slug;

  Branches(this.slug, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('分支'),
      ),
      body: FutureBuilder(
          future: gitHubClient.repositories.listBranches(slug).toList(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.active ||
                snapshot.connectionState == ConnectionState.waiting) {
              return new Center(
                child: new CircularProgressIndicator(),
              );
            }

            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                return Text(snapshot.error.toString());
              } else if (snapshot.hasData) {
                List<Branch> branches = snapshot.data;

                return ListView.builder(
                  itemCount: branches.length,
                  itemBuilder: (context, index) {
                    Branch branch = branches[index];
                    return buildBranchItem(branch, () {
                      fluroRouter.pop(context, branch.name);
                    });
                  },
                );
              }
            }
            //请求未完成时弹出loading
            return CircularProgressIndicator();
          }),
    );
  }
}

Widget buildBranchItem(Branch branch, Function onClick) {
  return GestureDetector(
    onTap: onClick,
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
      child: Row(
        children: [
          Image.asset(
            'images/branches.png',
            width: 24.0,
            height: 24.0,
          ),
          buildPaddingInHV(5.0, 0),
          Text(
            branch.name ?? '',
            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600),
          )
        ],
      ),
    ),
  );
}
