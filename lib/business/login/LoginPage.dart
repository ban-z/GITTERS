import 'package:flutter/material.dart';
import 'package:github/github.dart';
import 'package:gitters/application.dart';
import 'package:gitters/business/widgets/toast.dart';
import 'package:gitters/framework/constants/Constant.dart';
import 'package:gitters/framework/network/Git.dart';
import 'package:gitters/framework/router/RouterConfig.dart';
import 'package:gitters/models/user.dart';

class LoginPage extends StatefulWidget {
  @override
  createState() => new LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  TextEditingController nameController = new TextEditingController();
  TextEditingController pwdController = new TextEditingController();
  bool passwordVisible = false; //密码是否显示明文
  GlobalKey formKey = new GlobalKey<FormState>();
  bool nameAutoFocus = true;

  @override
  void initState() {
    nameController.text = diskCache.getString(Constant.USER_NAME) ?? '';
    pwdController.text = diskCache.getString(Constant.PASSWORD) ?? '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Login"),
          leading: Text(''),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              constraints: BoxConstraints.expand(
                height: 125,
              ),
              padding: const EdgeInsets.all(12.0),
              color: Theme.of(context).primaryColor,
              child: Text(
                'Hello Gitter',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 32,
                    fontStyle: FontStyle.italic),
              ),
              transform: Matrix4.rotationZ(0.04),
            ),
            Container(
              padding: EdgeInsets.only(bottom: 192.0),
              child: Form(
                  key: formKey,
                  autovalidate: true,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      TextFormField(
                          autofocus: nameAutoFocus,
                          controller: nameController,
                          decoration: InputDecoration(
                            labelText: "用户名",
                            hintText: "请输入账号....",
                            prefixIcon: Icon(Icons.person),
                          ),
                          validator: (v) {
                            return v.trim().isNotEmpty ? null : "用户名不能为空！";
                          }),
                      TextFormField(
                        autofocus: !nameAutoFocus,
                        controller: pwdController,
                        decoration: InputDecoration(
                            labelText: "密码",
                            hintText: "请输入密码...",
                            prefixIcon: Icon(Icons.lock),
                            suffixIcon: IconButton(
                              icon: Icon(passwordVisible
                                  ? Icons.visibility_off
                                  : Icons.visibility),
                              onPressed: () {
                                setState(() {
                                  passwordVisible = !passwordVisible;
                                });
                              },
                            )),
                        obscureText: !passwordVisible,
                        validator: (v) {
                          return v.trim().isNotEmpty ? null : "密码不能为空！";
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 50),
                        child: ConstrainedBox(
                          constraints: BoxConstraints.expand(height: 55.0),
                          child: RaisedButton(
                            color: Theme.of(context).primaryColor,
                            onPressed: _onLogin,
                            textColor: Colors.white,
                            child: Text("登录"),
                          ),
                        ),
                      ),
                    ],
                  )),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 24.0),
              child: Text('注册问题｜关于应用'),
            )
          ],
        ));
  }

  void _onLogin() async {
    // 登录前，验证各个表单字段是否合法
    if ((formKey.currentState as FormState).validate()) {
      showLoading(context);
      GNUser user;
      try {
        user =
            await Git(context).login(nameController.text, pwdController.text);
      } catch (e) {
        //登录失败则提示
        if (e.response?.statusCode == 401) {
          showToast("客户端错误，请重试...");
        } else {
          showToast(e.toString());
        }
      } finally {
        // 隐藏loading框
        Navigator.of(context).pop();
      }

      // TODO:login方法在1114不能使用，问题待查
      if (user != null) {
        // 存储用户名与密码
        diskCache.setString(Constant.USER_NAME, nameController.text);
        diskCache.setString(Constant.PASSWORD, pwdController.text);
        // 创建gitHubClient
        gitHubClient = GitHub(
            auth:
                Authentication.basic(nameController.text, pwdController.text));
        // 隐藏loading框
        fluroRouter.pop(context);
        fluroRouter.navigateTo(context, RouterList.Home.value);
      } else {
        // 隐藏loading框
        // fluroRouter.pop(context); // finally 中已经执行过了
        showToast("用户名或密码错误，请重试...");
      }
    }
  }
}
