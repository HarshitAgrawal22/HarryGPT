import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:trio_ai/ApiServices.dart/data.dart';
import 'package:trio_ai/database/Storage.dart';

class LoginService {
  Future<String> login({required String username}) async {
    String LoginApiUrl = data().url + "/login/";
    try {
      final response = await http.post(
        Uri.parse(LoginApiUrl),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(
          {"username": username, "password": "1810"},
        ),
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print(data["tokens"]["access"]);
        print(response.statusCode);
        return data["tokens"]["access"];
      } else {
        print(jsonDecode(response.body));
        print(response.statusCode);
        print("different status code ");

        return "";
      }
    } catch (e) {
      print(e);
      return "";
    }
  }

  Future<bool> Register({required String username}) async {
    String RegisterApiUrl = data().url + "/register/";
    print(RegisterApiUrl);
    try {
      final response = await http.post(
        Uri.parse(RegisterApiUrl),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(
          {"username": username, "password": "1810"},
        ),
      );

      if (response.statusCode == 201) {
        final data = jsonDecode(response.body);
        print(response.body);

        print(data["tokens"]["access"]);
        database().putUserId(username);
        return true;
      } else {
        throw Exception('Failed to load response');
      }
    } catch (e) {
      print(e);
      return false;
    }
  }
}
