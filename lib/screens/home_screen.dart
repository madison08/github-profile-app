// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:github_profile/ColorManager.dart';
import 'package:github_profile/models/Repositorie.dart';
import 'package:github_profile/models/User.dart';
import 'package:github_profile/providers/DataProvider.dart';
import 'package:github_profile/utils.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool logoutLoder = false;

  bool reposLoader = false;
  bool profileLoader = false;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    var _deviceWidth = MediaQuery.of(context).size.width;

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
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          leading: Icon(
            Icons.sort,
            size: 32.0,
          ),
          actions: [
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, "/profile");
              },
              child: Icon(
                Icons.account_circle,
                color: ColorManager.sombreGrey,
                size: 32.0,
              ),
            ),
            SizedBox(
              width: 15.0,
            )
          ],
        ),
        body: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(),
            Image.asset("assets/images/Vector.png"),
            SizedBox(
              height: 10.0,
            ),
            Text(
              "Hello les Giters !",
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: 35.0,
                fontWeight: FontWeight.w700,
                // letterSpacing: -4,
                color: Colors.white,
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            SizedBox(
              width: _deviceWidth * 0.7,
              child: TextFormField(
                // validator: (value) {
                //   if (value == null || value.isEmpty) {
                //     return "Veuillez entrer votre nom d'utilisateur";
                //   }
                //   return null;
                // },
                // focusNode: _focusUsername,
                // controller: _usernameController,
                cursorColor: Colors.white,
                style: GoogleFonts.shareTechMono(
                  textStyle: TextStyle(
                    color: Colors.white,
                  ),
                ),
                decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 5.0, vertical: 2.0),
                  filled: true,
                  suffix: GestureDetector(
                    onTap: () {
                      // print("helloooo");
                      // _usernameController.clear();
                      // _focusUsername.requestFocus();
                    },
                    child: Icon(
                      Icons.cancel_outlined,
                      color: Colors.white,
                    ),
                  ),
                  hintText: "Rechercher...",
                  hintStyle: TextStyle(
                    color: ColorManager.sombreGrey,
                    fontSize: 19.0,
                  ),
                  // label: Row(
                  //   children: [
                  //     Icon(
                  //       Icons.search,
                  //       color: ColorManager.sombreGrey,
                  //       size: 32.0,
                  //     ),
                  //     Text(
                  //       "Rechercher...",
                  //       style: TextStyle(
                  //         color: ColorManager.sombreGrey,
                  //       ),
                  //     )
                  //   ],
                  // ),
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
            Container(
              margin: EdgeInsets.symmetric(horizontal: 15.0),
              child: Row(
                children: <Widget>[
                  Icon(
                    Icons.book,
                    color: Colors.white,
                    size: 34.0,
                  ),
                  SizedBox(
                    width: 5.0,
                  ),
                  Text(
                    "Repositories r??cents",
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 16.5,
                    ),
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(
                horizontal: 15.0,
              ),
              child: Align(
                alignment: Alignment.centerLeft,
                child: SizedBox(
                  width: _deviceWidth * 0.75,
                  child: Divider(
                    color: ColorManager.sombreGrey,
                  ),
                ),
              ),
            ),
            FutureBuilder<dynamic>(
                future: Provider.of<DataProvider>(context, listen: false)
                    .getAllrepos(),
                builder: (context, AsyncSnapshot snapshot) {
                  // print("future builder data: ${snapshot.data}");
                  // print("USERNAME IN FUTUREBUILD: $username");

                  List<Repositorie>? repo = snapshot.data;

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Expanded(
                      child: ListView.separated(
                          separatorBuilder: (context, index) {
                            return Shimmer.fromColors(
                              baseColor: Colors.grey,
                              highlightColor: Colors.black,
                              child: Container(
                                margin: EdgeInsets.symmetric(horizontal: 15.0),
                                child: Divider(
                                  color: ColorManager.sombreGrey,
                                ),
                              ),
                            );
                          },
                          itemCount: 2,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: EdgeInsets.symmetric(horizontal: 15.0),
                              child: Column(
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      Shimmer.fromColors(
                                        child: Container(
                                          color: Colors.black,
                                          height: 10.0,
                                          width: 100.0,
                                        ),
                                        baseColor: Colors.grey,
                                        highlightColor: Colors.black,
                                      ),
                                      SizedBox(
                                        width: 7.0,
                                      ),
                                      Shimmer.fromColors(
                                        child: Container(
                                          height: 10.0,
                                          width: 30.0,
                                          decoration: BoxDecoration(
                                            color:
                                                Colors.white.withOpacity(0.2),
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                        ),
                                        baseColor: Colors.grey,
                                        highlightColor: Colors.black,
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 15.0,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Shimmer.fromColors(
                                        child: Container(
                                          color: Colors.black,
                                          height: 10.0,
                                          width: 20.0,
                                        ),
                                        baseColor: Colors.grey,
                                        highlightColor: Colors.black,
                                      ),
                                      Shimmer.fromColors(
                                        child: Container(
                                          color: Colors.black,
                                          height: 10.0,
                                          width: 50.0,
                                        ),
                                        baseColor: Colors.grey,
                                        highlightColor: Colors.black,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          }),
                    );
                  } else if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasError) {
                      return Text("Quelque chose s'est mal passer");
                    } else if (snapshot.hasData) {
                      return Expanded(
                        child: ListView.separated(
                          separatorBuilder: (context, index) {
                            return Container(
                              margin: EdgeInsets.symmetric(horizontal: 15.0),
                              child: Divider(
                                color: ColorManager.sombreGrey,
                              ),
                            );
                          },
                          itemCount: 2,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: EdgeInsets.symmetric(horizontal: 15.0),
                              child: Column(
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      Text(
                                        repo![index].name.toString(),
                                        style: GoogleFonts.shareTechMono(
                                          color: Colors.white,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 7.0,
                                      ),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 7.0,
                                          vertical: 4.0,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.white.withOpacity(0.1),
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        child: Text(
                                          Utils.checkRepoPrivate(
                                              repo[index].private),
                                          style: GoogleFonts.share(
                                            color: Colors.black,
                                            fontSize: 12.0,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text(
                                        Utils.checkRepoLanguage(
                                            repo[index].language),
                                        style: GoogleFonts.shareTechMono(
                                          color: Colors.white,
                                        ),
                                      ),
                                      Text(
                                        Utils.dateFormatter(
                                            repo[index].updatedAt.toString()),
                                        style: GoogleFonts.shareTechMono(
                                          color: ColorManager.sombreGrey,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      );
                    } else {
                      return Text("Pas de repositorie");
                    }
                  } else {
                    return Text("Quelque chose s'est mal passer");
                  }
                }),
            SizedBox(
              height: 10.0,
            ),
            SizedBox(
              width: _deviceWidth * 0.5,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: ColorManager.sombreGrey,
                  // primary: Colors.white.withOpacity(0.1),
                  shape: StadiumBorder(),
                  padding: EdgeInsets.all(10.0),
                  elevation: 0.0,
                ),
                onPressed: () {},
                child: Text(
                  "Voir plus ici",
                  style: GoogleFonts.shareTechMono(
                    textStyle: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 50.0,
            ),
            Text(
              "Suggestions de profils",
              style: GoogleFonts.poppins(
                color: Colors.white,
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            FutureBuilder<dynamic>(
                future: Provider.of<DataProvider>(context, listen: false)
                    .getSomeUsers(),
                builder: (context, AsyncSnapshot snapshot) {
                  // print("future builder data: ${snapshot.data}");

                  List<User>? users = snapshot.data;

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Expanded(
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 10,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: EdgeInsets.only(right: 10.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Shimmer.fromColors(
                                  baseColor: Colors.grey,
                                  highlightColor: Colors.black,
                                  child: CircleAvatar(
                                    radius: 35.0,
                                  ),
                                ),
                                SizedBox(
                                  height: 6.0,
                                ),
                                Shimmer.fromColors(
                                  baseColor: Colors.grey,
                                  highlightColor: Colors.black,
                                  child: Container(
                                    color: Colors.black,
                                    height: 10.0,
                                    width: 50.0,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    );
                  } else if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasError) {
                      return Text("Quelque chose s'est mal passer");
                    } else if (snapshot.hasData) {
                      return Expanded(
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: users!.length,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: EdgeInsets.only(right: 10.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CircleAvatar(
                                    backgroundColor:
                                        Colors.grey.withOpacity(0.2),
                                    radius: 35.0,
                                    backgroundImage: NetworkImage(
                                        users[index].avatarUrl.toString()),
                                  ),
                                  SizedBox(
                                    height: 6.0,
                                  ),
                                  Text(
                                    users[index].login.toString(),
                                    style: GoogleFonts.poppins(
                                      color: Colors.white,
                                    ),
                                  )
                                ],
                              ),
                            );
                          },
                        ),
                      );
                    } else {
                      return Text("Pas d'utilisateur");
                    }
                  } else {
                    return Text("Une erreur s'est produite");
                  }
                }),
          ],
        ),
      ),
    );
  }
}
