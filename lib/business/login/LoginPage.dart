import 'package:flutter/material.dart';
import 'package:gitters/business/widgets/toast.dart';
import 'package:gitters/framework/global/Global.dart';
import 'package:gitters/framework/global/provider/UserModel.dart';
import 'package:gitters/framework/network/Git.dart';
import 'package:gitters/models/index.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  // LoginPage(Set<Object> set, {Key key}) : super(key: key);

  @override
  createState() => new LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  TextEditingController _unameController = new TextEditingController();
  TextEditingController _pwdController = new TextEditingController();
  bool pwdShow = false; //密码是否显示明文
  GlobalKey _formKey = new GlobalKey<FormState>();
  bool _nameAutoFocus = true;

  @override
  void initState() {
    // 自动填充上次登录的用户名，填充后将焦点定位到密码输入框
    _unameController.text = Global.profile.lastLogin;
    if (_unameController.text != null) {
      _nameAutoFocus = false;
    }
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
          // mainAxisAlignment: MainAxisAlignment.center,
          child: Form(
              key: _formKey,
              autovalidate: true,
              child: Column(
                children: [
                  TextFormField(
                      autofocus: _nameAutoFocus,
                      controller: _unameController,
                      decoration: InputDecoration(
                        labelText: "用户名～～～～",
                        hintText: "用户名或邮箱～～～～",
                        prefixIcon: Icon(Icons.person),
                      ),
                      // 校验用户名（不能为空）
                      validator: (v) {
                        return v.trim().isNotEmpty ? null : "请输入用户名～～～～";
                      }),
                  TextFormField(
                    controller: _pwdController,
                    autofocus: !_nameAutoFocus,
                    decoration: InputDecoration(
                        labelText: "密码～～～～",
                        hintText: "请输入密码～～～～",
                        prefixIcon: Icon(Icons.lock),
                        suffixIcon: IconButton(
                          icon: Icon(pwdShow
                              ? Icons.visibility_off
                              : Icons.visibility),
                          onPressed: () {
                            setState(() {
                              pwdShow = !pwdShow;
                            });
                          },
                        )),
                    obscureText: !pwdShow,
                    //校验密码（不能为空）
                    validator: (v) {
                      return v.trim().isNotEmpty ? null : "请输入密码～～～～";
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 25),
                    child: ConstrainedBox(
                      constraints: BoxConstraints.expand(height: 55.0),
                      child: RaisedButton(
                        color: Theme.of(context).primaryColor,
                        onPressed: _onLogin,
                        textColor: Colors.white,
                        child: Text("登录～～～"),
                      ),
                    ),
                  ),
                ],
              )),
        ));
  }

  void _onLogin() async {
    // 提交前，先验证各个表单字段是否合法
    if ((_formKey.currentState as FormState).validate()) {
      showLoading(context);
      User user;
      try {
        user = await Git(context)
            .login(_unameController.text, _pwdController.text);
        // 因为登录页返回后，首页会build，所以我们传false，更新user后不触发更新
        Provider.of<UserModel>(context, listen: false).user = user;
      } catch (e) {
        //登录失败则提示
        if (e.response?.statusCode == 401) {
          showToast("用户名或密码有错误～～～～");
        } else {
          showToast(e.toString());
        }
      } finally {
        // 隐藏loading框
        Navigator.of(context).pop();
      }
      if (user != null) {
        // 返回
        Navigator.of(context).pop();
      }
    }
  }
}
