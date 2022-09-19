// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
          child: Text(
            "Hello les Giters !",
            style: GoogleFonts.shareTechMono(
              fontSize: 35.0,
              fontWeight: FontWeight.w900,
              letterSpacing: -4,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
