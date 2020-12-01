import 'package:flutter/material.dart';
import 'package:flutter_flash_chat/components/roundedButton.dart';
import 'package:flutter_flash_chat/constant.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'ChatScreen.dart';

class LoginScreen extends StatefulWidget {
  static const ID = "LoginScreen";

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String email, password;
  final FirebaseAuth auth = FirebaseAuth.instance;
  bool isLoading = false;

  void logIn() async {
    setState(() {
      isLoading = true;
    });
    try {
      await auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );

      Navigator.pushNamed(context, ChatScreen.ID);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
        this._showMyDialog('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
        this._showMyDialog('Wrong password provided for that user.');
      } else {
        print("Problem : $e");
        this._showMyDialog(e.toString());
      }
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> _showMyDialog(String errorMsg) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Something Wrong'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(errorMsg),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Try again'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: isLoading
          ? Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            )
          : Container(
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
                      keyboardType: TextInputType.emailAddress,
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
                      decoration:
                          kInputDecoration.copyWith(hintText: "password"),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    RoundedButton(
                      onPressed: () {
                        this.logIn();
                      },
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
