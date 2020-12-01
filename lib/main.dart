import 'package:flutter/material.dart';
import 'package:flutter_flash_chat/screens/LoginScreen.dart';
import 'package:flutter_flash_chat/screens/RegistrationScreen.dart';
import 'package:flutter_flash_chat/screens/WelcomeScreen.dart';
import 'package:flutter_flash_chat/screens/ChatScreen.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: WelcomeScreen.ID,
      routes: {
        WelcomeScreen.ID: (context) => WelcomeScreen(),
        LoginScreen.ID: (context) => LoginScreen(),
        RegistrationScreen.ID: (context) => RegistrationScreen(),
        ChatScreen.ID: (context) => ChatScreen(),
      },
    );
  }
}
