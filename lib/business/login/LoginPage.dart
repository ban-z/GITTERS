import 'package:flutter/material.dart';
import 'package:github/github.dart';
import 'package:gitters/application.dart';
import 'package:gitters/business/widgets/toast.dart';
import 'package:gitters/framework/constants/Constant.dart';
import 'package:gitters/framework/router/RouterConfig.dart';

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
        body: Container(
          child: Form(
              key: formKey,
              autovalidate: true,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(padding: const EdgeInsets.only(top: 150)),
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
        ));
  }

  void _onLogin() async {
    // 登录前，验证各个表单字段是否合法
    if ((formKey.currentState as FormState).validate()) {
      showLoading(context);
      try {
        gitHubClient = GitHub(
            auth:
                Authentication.basic(nameController.text, pwdController.text));
      } catch (e) {
        //登录失败提示
        if (e.response?.statusCode == 401) {
          showToast("用户名或密码错误，请重试...");
        } else {
          showToast(e.toString());
        }
      } finally {
        // 隐藏loading框
        fluroRouter.pop(context);
      }

      if (gitHubClient != null) {
        // 返回
        diskCache.setString(Constant.USER_NAME, nameController.text);
        diskCache.setString(Constant.PASSWORD, pwdController.text);
        fluroRouter.navigateTo(context, RouterList.Home.value);
      }
    }
  }
}
