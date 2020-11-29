import 'package:flutter/material.dart';
import 'package:flutter_flash_chat/components/roundedButton.dart';
import 'package:flutter_flash_chat/constant.dart';

class LoginScreen extends StatefulWidget {
  static const ID = "LoginScreen";

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String email, password;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: 20.0,
              ),
              Container(
                height: 200,
                child: Hero(
                  tag: "logo",
                  child: Image.asset('assets/images/logo.png'),
                ),
              ),
              SizedBox(
                height: 40.0,
              ),
              TextField(
                onChanged: (value) {
                  email = value;
                },
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20.0,
                ),
                decoration: kInputDecoration.copyWith(hintText: "email"),
              ),
              SizedBox(
                height: 10.0,
              ),
              TextField(
                onChanged: (value) {
                  password = value;
                },
                obscureText: true,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20.0,
                ),
                decoration: kInputDecoration.copyWith(hintText: "password"),
              ),
              SizedBox(
                height: 20.0,
              ),
              RoundedButton(
                onPressed: () {},
                btnColor: Colors.lightBlueAccent,
                btnText: "Login",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
