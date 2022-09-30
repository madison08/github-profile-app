import 'package:flutter/material.dart';
import 'package:github_profile/providers/DataProvider.dart';
import 'package:github_profile/screens/Splash_screen.dart';
import 'package:github_profile/screens/home_screen.dart';
import 'package:github_profile/screens/login_screen.dart';
import 'package:github_profile/screens/profile_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => DataProvider(),
        ),
      ],
      child: const MyApp(),
    ),
  );
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
        "/home": (context) => HomeScreen(),
        "/profile": (context) => ProfileScreen(),
      },
    );
  }
}
