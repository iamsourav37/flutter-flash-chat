import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_flash_chat/components/roundedButton.dart';
import 'package:flutter_flash_chat/constant.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'ChatScreen.dart';

class RegistrationScreen extends StatefulWidget {
  static const ID = "RegistrationScreen";

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  String email, password;
  final FirebaseAuth auth = FirebaseAuth.instance;
  bool isLoading = false;

  void resigterTheUser() async {
    setState(() {
      isLoading = true;
    });
    try {
      await auth.createUserWithEmailAndPassword(
          email: email.trim(), password: password);

      setState(() {
        Navigator.pushNamed(context, ChatScreen.ID);
        isLoading = false;
        email = "";
        password = "";
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        debugPrint('The password provided is too weak.');
        this._showMyDialog('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        debugPrint('The account already exists for that email.');
        this._showMyDialog('The account already exists for that email.');
      } else {
        this._showMyDialog(e.toString());
      }
    } catch (e) {
      this._showMyDialog(e.toString());
    }
    setState(() {
      isLoading = false;
    });
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
                        this.resigterTheUser();
                      },
                      btnColor: Colors.blueAccent,
                      btnText: "Register",
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
