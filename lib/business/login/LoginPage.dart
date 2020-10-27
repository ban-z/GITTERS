import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  // LoginPage(Set<Object> set, {Key key}) : super(key: key);

  @override
  createState() => new LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  // var account = GlobalKey<FormState>();
  // var password = GlobalKey<FormState>();
  String account;
  String password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Form(
            // key: account,
            child: TextFormField(
              decoration:
                  const InputDecoration(hintText: "Input your account..."),
              validator: (value) {
                if (value.isEmpty) {
                  return "The account cannot be empty!";
                }
                return null;
              },
            )),
        Padding(padding: const EdgeInsets.symmetric(vertical: 16.0)),
        Form(
            // key: account,
            child: TextFormField(
              decoration:
                  const InputDecoration(hintText: "Input your password..."),
              validator: (value) {
                if (value.isEmpty) {
                  return "The password cannot be empty!";
                }
                return null;
              },
            )),
        ElevatedButton(
            onPressed: () {
              // if (account.currentState.validate() &&
              //     account.currentState.validate()) {
              //   // ...
              // }
            },
            child: Text("Sign in"))
      ],
    );,
    );
  }
}
