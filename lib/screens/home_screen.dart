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

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool logoutLoder = false;

  var username;

  void getUsername() async {
    final prefs = await SharedPreferences.getInstance();

    username = prefs.getString("username");

    // print("USERNAME: $username");
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();

    getUsername();
    // print("USERNAME: $username");
  }

  @override
  Widget build(BuildContext context) {
    var _deviceWidth = MediaQuery.of(context).size.width;

    print(
        "USER LOG ${Provider.of<DataProvider>(context, listen: false).getUserLogName}");

    var userlogname =
        Provider.of<DataProvider>(context, listen: false).getUserLogName;

    getUsername();

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
            Icons.sort,
            size: 32.0,
          ),
          actions: [
            Icon(
              Icons.account_circle,
              color: ColorManager.sombreGrey,
              size: 32.0,
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
                  contentPadding: EdgeInsets.all(10.0),
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
                  label: Row(
                    children: [
                      Icon(
                        Icons.search,
                        color: ColorManager.sombreGrey,
                        size: 32.0,
                      ),
                      Text(
                        "Rechercher...",
                        style: TextStyle(
                          color: ColorManager.sombreGrey,
                        ),
                      )
                    ],
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
                    "Repositories récents",
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
                    return Center(child: CircularProgressIndicator());
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
                    return Center(child: CircularProgressIndicator());
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
