import 'package:flutter/material.dart';
import 'package:flutter_flash_chat/screens/LoginScreen.dart';
import 'package:flutter_flash_chat/screens/RegistrationScreen.dart';
import 'package:flutter_flash_chat/screens/WelcomeScreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // theme: ThemeData(
      //   primarySwatch: Colors.red,
      // ),
      initialRoute: WelcomeScreen.ID,
      routes: {
        WelcomeScreen.ID: (context) => WelcomeScreen(),
        LoginScreen.ID: (context) => LoginScreen(),
        RegistrationScreen.ID: (context) => RegistrationScreen(),
      },
    );
  }
}
