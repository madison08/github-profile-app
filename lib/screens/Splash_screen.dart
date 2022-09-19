// ignore_for_file: prefer_const_constructors

import 'dart:async';

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:github_profile/screens/login_screen.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Timer(
      Duration(
        seconds: 4,
      ),
      () {
        Navigator.pushNamedAndRemoveUntil(context, "/login", (route) => false);
        // ;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var _deviceHeight = MediaQuery.of(context).size.height;
    var _deviceWidth = MediaQuery.of(context).size.width;

    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            "assets/images/Background-grandient1.png",
          ),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(),
            Image.asset(
              "assets/images/loader-cat-2.gif",
              width: 150.0,
              height: 150.0,
              fit: BoxFit.cover,
            ),
            Container(),
            Text.rich(
              TextSpan(children: [
                TextSpan(
                  text: "Design ",
                  style: GoogleFonts.shareTechMono(
                    color: Colors.white,
                  ),
                ),
                TextSpan(
                  text: "byAyozé",
                  style: GoogleFonts.shareTechMono(
                    decoration: TextDecoration.lineThrough,
                    color: Colors.white,
                  ),
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
