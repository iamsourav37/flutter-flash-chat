import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_flash_chat/components/roundedButton.dart';
import 'package:flutter_flash_chat/screens/RegistrationScreen.dart';

import 'LoginScreen.dart';

class WelcomeScreen extends StatefulWidget {
  static const ID = "WelcomeScreen";
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Container(
                  height: 60.0,
                  child: Hero(
                    tag: "logo",
                    child: Image.asset('assets/images/logo.png'),
                  ),
                ),
                Container(
                  child: TypewriterAnimatedTextKit(
                    speed: Duration(milliseconds: 500),
                    repeatForever: true,
                    text: ["Flash Chat"],
                    textStyle: TextStyle(
                      fontSize: 45.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 50.0,
            ),
            RoundedButton(
              btnText: "Login",
              btnColor: Colors.lightBlueAccent,
              onPressed: () {
                Navigator.pushNamed(context, LoginScreen.ID);
              },
            ),
            RoundedButton(
              onPressed: () {
                Navigator.pushNamed(context, RegistrationScreen.ID);
              },
              btnColor: Colors.blueAccent,
              btnText: "Register",
            ),
          ],
        ),
      ),
    );
  }
}
