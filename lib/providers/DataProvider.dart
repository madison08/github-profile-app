import 'dart:convert';
import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:github_profile/api_const.dart';
import 'package:github_profile/models/User.dart';
import 'package:github_profile/models/http_exception.dart';
import 'package:http/http.dart' as http;

class DataProvider with ChangeNotifier {
  dynamic error;

  bool loadingLogin = false;

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
          break;
        case 404:
          print("ENTER IN REQUEST");

          // throw HttpException(message: "l'utilisatuer n'existe pas");

          error = HttpException(message: "l'utilisatuer n'existe pas");
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
}
