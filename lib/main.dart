import 'package:flutter/material.dart';
import 'package:github_profile/screens/Splash_screen.dart';
import 'package:github_profile/screens/login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        "/": (context) => SplashScreen(),
        "/login": (context) => LoginScreen(),
      },
    );
  }
}
