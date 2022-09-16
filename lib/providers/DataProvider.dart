import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:github_profile/api_const.dart';
import 'package:github_profile/models/User.dart';
import 'package:http/http.dart' as http;

class DataProvider with ChangeNotifier {
  bool loadingLogin = false;

  Future<void> getUserLog(username) async {
    loadingLogin = true;
    notifyListeners();
    try {
      var response = await http.get(Uri.parse("$BASE_URL/users/$username"));

      var data = jsonDecode(response.body);

      print("user login");
      print(User.fromJson(data));

      loadingLogin = false;

      notifyListeners();
    } catch (err) {
      print(err);
    }
  }
}
