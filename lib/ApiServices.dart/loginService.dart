import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:trio_ai/ApiServices.dart/data.dart';

class LoginService {
  Future<bool> login(String username) async {
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
        return true;
      } else {
        print("different status code ");

        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> Register(String username) async {
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
