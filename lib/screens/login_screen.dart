// ignore_for_file: prefer_const_constructors

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:github_profile/providers/DataProvider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  var isLoading = false;

  FocusNode _focusUsername = FocusNode();
  FocusNode _focusPassword = FocusNode();

  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _focusUsername.addListener(_onFocusChange);
    _focusPassword.addListener(_onFocusPassChange);
  }

  void _onFocusChange() {
    log("Focus: ${_focusUsername.hasFocus.toString()}");
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
    _focusUsername.removeListener(_onFocusChange);
    _focusUsername.dispose();
    _usernameController.dispose();

    _focusPassword.removeListener(_onFocusPassChange);
    _focusPassword.dispose();
  }

  var error = null;

  void _submit() async {
    _focusUsername.unfocus();

    if (!_formKey.currentState!.validate()) {
      return;
    }
    setState(() {
      isLoading = true;
    });
    _formKey.currentState?.save();

    await Provider.of<DataProvider>(context, listen: false)
        .getUserLog(_usernameController.text);

    setState(() {
      isLoading = false;
    });

    error = Provider.of<DataProvider>(context, listen: false).error;

    if (error == null) {
      showDialog(message: "connecter", color: Colors.green);
      Navigator.pushNamed(context, "/home");
    }

    if (error != null) {
      showDialog(message: error.toString(), color: Colors.red);
    }
  }

  @override
  Widget build(BuildContext context) {
    var Data_Provider = Provider.of<DataProvider>(context, listen: false);

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
                  child: Form(
                    key: _formKey,
                    child: TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Veuillez entrer votre nom d'utilisateur";
                        }
                        return null;
                      },
                      focusNode: _focusUsername,
                      controller: _usernameController,
                      cursorColor: Colors.white,
                      style: GoogleFonts.shareTechMono(
                        textStyle: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      decoration: InputDecoration(
                        filled: true,
                        suffix: GestureDetector(
                          onTap: () {
                            print("helloooo");
                            _usernameController.clear();
                            _focusUsername.requestFocus();
                          },
                          child: Icon(
                            Icons.cancel_outlined,
                            color: Colors.white,
                          ),
                        ),
                        label: _focusUsername.hasFocus
                            ? Container(
                                padding: EdgeInsets.all(5.0),
                                color: Colors.white,
                                child: Text(
                                  "Username",
                                  style: TextStyle(color: Colors.black),
                                ),
                              )
                            : Text(
                                "Username",
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
                ),
                SizedBox(
                  height: 30.0,
                ),
                // SizedBox(
                //   width: _deviceWidth * 0.8,
                //   child: TextField(
                //     focusNode: _focusPassword,
                //     controller: _passwordController,
                //     cursorColor: Colors.white,
                //     obscureText: true,
                //     style: GoogleFonts.shareTechMono(
                //       textStyle: TextStyle(
                //         color: Colors.white,
                //       ),
                //     ),
                //     decoration: InputDecoration(
                //       filled: true,
                //       suffix: Icon(
                //         Icons.cancel_outlined,
                //         color: Colors.white,
                //       ),
                //       label: _focusPassword.hasFocus
                //           ? Container(
                //               padding: EdgeInsets.all(5.0),
                //               color: Colors.white,
                //               child: Text(
                //                 "Mot de passe",
                //                 style: TextStyle(color: Colors.black),
                //               ),
                //             )
                //           : Text(
                //               "Mot de passe",
                //               style: TextStyle(color: Colors.white),
                //             ),
                //       border: OutlineInputBorder(
                //         borderRadius: BorderRadius.circular(5.0),
                //         borderSide: BorderSide(
                //           color: Colors.white,
                //         ),
                //       ),
                //       enabledBorder: OutlineInputBorder(
                //         borderRadius: BorderRadius.circular(5.0),
                //         borderSide: BorderSide(
                //           color: Colors.white,
                //         ),
                //       ),
                //       focusedBorder: OutlineInputBorder(
                //         borderRadius: BorderRadius.circular(5.0),
                //         borderSide: BorderSide(
                //           color: Colors.white,
                //         ),
                //       ),
                //     ),
                //   ),
                // ),
                // SizedBox(
                //   height: 30.0,
                // ),
                SizedBox(
                  width: _deviceWidth * 0.8,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.all(13.0),
                      primary: Colors.white.withOpacity(0.1),
                      shape: StadiumBorder(),
                      elevation: 0.0,
                    ),
                    onPressed: () {
                      _submit();
                    },
                    child: isLoading
                        ? CircularProgressIndicator()
                        : Text(
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

  void showDialog({required String message, Color? color}) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: color,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}
