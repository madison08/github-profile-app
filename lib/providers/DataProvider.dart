import 'dart:convert';
import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:github_profile/api_const.dart';
import 'package:github_profile/models/Repositorie.dart';
import 'package:github_profile/models/User.dart';
import 'package:github_profile/models/http_exception.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class DataProvider with ChangeNotifier {
  dynamic error;

  bool loadingLogin = false;

  String? userConnected;

  List<User>? _users;

  List<Repositorie>? _repos;

  String? _username;

  String? get getUserLogName {
    return _username;
  }

  bool get isAuth {
    return userConnected != null;
  }

  List<User>? get users {
    return _users;
  }

  List<Repositorie>? get repositories {
    return _repos;
  }

  Future<void> getUserLog(username) async {
    error = null;
    loadingLogin = true;
    notifyListeners();
    print("loding true moment: $username");
    try {
      var response = await http.get(Uri.parse("$BASE_URL/users/$username"));

      var data = jsonDecode(response.body);

      switch (response.statusCode) {
        case 200:
          print("user login");
          print(User.fromJson(data));

          final prefs = await SharedPreferences.getInstance();

          prefs.setString("username", username);
          userConnected = username;

          _username = username;

          break;
        case 404:
          print("ENTER IN REQUEST");

          // throw HttpException(message: "l'utilisatuer n'existe pas");

          error = HttpException(message: "L'utilisatuer n'existe pas");
          break;
        default:
          error = HttpException(message: data["message"]);
      }

      // if (response.statusCode == 404) {
      //   print("l'utilisatuer n'existe pas");
      //   throw HttpException(message: "l'utilisatuer n'existe pas");
      // }
    } on SocketException {
      error = "Vous n'avez pas internet";
    } catch (err) {
      print(err);
      error = err.toString();
    }

    loadingLogin = false;

    notifyListeners();
  }

  Future<bool> tryAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();

    if (!prefs.containsKey('username')) {
      return false;
    }

    return true;
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();

    prefs.clear();
  }

  Future<dynamic> getSomeUsers() async {
    error = null;
    try {
      var response = await http.get(Uri.parse("$BASE_URL/users"));

      var data = jsonDecode(response.body);

      // print("users datas :");
      // print(data);

      switch (response.statusCode) {
        case 200:
          List<User> loadedData = [];

          for (var user in data) {
            loadedData.add(User.fromJson(user));
          }

          _users = loadedData;

          break;
        case 404:
          print("ENTER IN REQUEST");

          error = HttpException(message: "erreur");
          break;
        default:
          error = HttpException(message: data["message"]);
      }
    } on SocketException {
      error = "Vous n'avez pas internet";
    } catch (err) {
      // print(err);
      error = err.toString();
    }

    loadingLogin = false;

    notifyListeners();

    return users;
  }

  Future<dynamic> getAllrepos(username) async {
    error = null;
    try {
      var response =
          await http.get(Uri.parse("$BASE_URL/users/$username/repos"));

      // dynamic data = jsonEncode(response.body);

      var data = jsonDecode(response.body);

      print("users datas :");
      // print(data);

      switch (response.statusCode) {
        case 200:
          List<Repositorie> loadedData = [];

          for (var repo in data) {
            // print(repo);
            loadedData.add(Repositorie.fromJson(repo));
          }
          // print("OUR DATA: $loadedData");

          _repos = loadedData;

          break;
        case 404:
          print("ENTER IN REQUEST");

          error = HttpException(message: "erreur");
          break;
        default:
          error = HttpException(message: data["message"]);
      }
    } on SocketException {
      error = "Vous n'avez pas internet";
    } catch (err) {
      print(err);
      error = err.toString();
    }

    loadingLogin = false;

    notifyListeners();

    return repositories;
  }
}
