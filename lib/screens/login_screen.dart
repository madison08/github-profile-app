// ignore_for_file: prefer_const_constructors

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  FocusNode _focusEmail = FocusNode();
  FocusNode _focusPassword = FocusNode();

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _focusEmail.addListener(_onFocusChange);
    _focusPassword.addListener(_onFocusPassChange);
  }

  void _onFocusChange() {
    log("Focus: ${_focusEmail.hasFocus.toString()}");
    setState(() {});
  }

  void _onFocusPassChange() {
    log("Focus: ${_focusPassword.hasFocus.toString()}");
    setState(() {});
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _focusEmail.removeListener(_onFocusChange);
    _focusEmail.dispose();

    _focusPassword.removeListener(_onFocusPassChange);
    _focusPassword.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.transparent,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(),
            Image.asset(
              "assets/images/loader-cat-2.gif",
              width: 125.0,
              height: 125.0,
            ),
            Container(),
            Column(
              children: [
                SizedBox(
                  width: _deviceWidth * 0.8,
                  child: TextField(
                    focusNode: _focusEmail,
                    controller: _emailController,
                    cursorColor: Colors.white,
                    style: GoogleFonts.shareTechMono(
                      textStyle: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    decoration: InputDecoration(
                      filled: true,
                      suffix: Icon(
                        Icons.cancel_outlined,
                        color: Colors.white,
                      ),
                      label: _focusEmail.hasFocus
                          ? Container(
                              padding: EdgeInsets.all(5.0),
                              color: Colors.white,
                              child: Text(
                                "Email",
                                style: TextStyle(color: Colors.black),
                              ),
                            )
                          : Text(
                              "Email",
                              style: TextStyle(color: Colors.white),
                            ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide: BorderSide(
                          color: Colors.white,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide: BorderSide(
                          color: Colors.white,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide: BorderSide(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30.0,
                ),
                SizedBox(
                  width: _deviceWidth * 0.8,
                  child: TextField(
                    focusNode: _focusPassword,
                    controller: _passwordController,
                    cursorColor: Colors.white,
                    obscureText: true,
                    style: GoogleFonts.shareTechMono(
                      textStyle: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    decoration: InputDecoration(
                      filled: true,
                      suffix: Icon(
                        Icons.cancel_outlined,
                        color: Colors.white,
                      ),
                      label: _focusPassword.hasFocus
                          ? Container(
                              padding: EdgeInsets.all(5.0),
                              color: Colors.white,
                              child: Text(
                                "Mot de passe",
                                style: TextStyle(color: Colors.black),
                              ),
                            )
                          : Text(
                              "Mot de passe",
                              style: TextStyle(color: Colors.white),
                            ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide: BorderSide(
                          color: Colors.white,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide: BorderSide(
                          color: Colors.white,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide: BorderSide(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30.0,
                ),
                SizedBox(
                  width: _deviceWidth * 0.8,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.all(13.0),
                      primary: Colors.white.withOpacity(0.1),
                      shape: StadiumBorder(),
                      elevation: 0.0,
                    ),
                    onPressed: () {},
                    child: Text(
                      "Se connecter",
                      style: GoogleFonts.shareTechMono(
                        textStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 17.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              width: _deviceWidth * 0.8,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Color(0xFF504646),
                  // primary: Colors.white.withOpacity(0.1),
                  shape: StadiumBorder(),
                  padding: EdgeInsets.all(10.0),
                  elevation: 0.0,
                ),
                onPressed: () {},
                child: Text(
                  "Pas maintenant",
                  style: GoogleFonts.shareTechMono(
                    textStyle: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
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
