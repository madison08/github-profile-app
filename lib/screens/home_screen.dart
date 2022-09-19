// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:github_profile/providers/DataProvider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool logoutLoder = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            "assets/images/Background-grandient2.png",
          ),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          leading: Icon(
            Icons.filter_list,
          ),
          actions: [
            Icon(Icons.person_rounded),
            SizedBox(
              width: 15.0,
            )
          ],
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Hello les Giters !",
                style: GoogleFonts.shareTechMono(
                  fontSize: 35.0,
                  fontWeight: FontWeight.w900,
                  letterSpacing: -4,
                  color: Colors.white,
                ),
              ),
              SizedBox(
                height: 25.0,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.red,
                ),
                onPressed: () {
                  _logout();
                },
                child: Text("Deconexion"),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _logout() async {
    setState(() {
      logoutLoder = true;
    });
    await Provider.of<DataProvider>(context, listen: false).logout();

    setState(() {
      logoutLoder = false;
    });

    Fluttertoast.showToast(
        msg: "Deconnecter",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);

    Navigator.pushNamedAndRemoveUntil(context, "/login", (route) => false);
  }
}
