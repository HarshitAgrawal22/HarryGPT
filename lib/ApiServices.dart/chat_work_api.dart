// services/chat_service.dart
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:trio_ai/ApiServices.dart/data.dart';
import 'package:trio_ai/ApiServices.dart/loginService.dart';
import 'package:trio_ai/database/Storage.dart';

class ChatService {
  Future<List<dynamic>> loadSessions(String username) async {
    String LoginApiUrl = data().url + "/list_personal_chats/";
    try {
      String token = await LoginService().login(username: username);
      final response = await http.post(
        Uri.parse(LoginApiUrl),
        headers: {
          'Content-Type': 'application/json',
          "Authorization": "Bearer ${token}"
        },
        body: jsonEncode(
          {},
        ),
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print("$data are all the personal sessions");
        return data["sessions"];
      } else {
        print("different status code ");

        return [
          {"no": 90}
        ];
      }
    } catch (e) {
      print(e);
      print("api error");
      return [
        {"no": 90}
      ];
    }
  }

  Future<int> CreateSession(
      {required String username, required String session_name}) async {
    String LoginApiUrl = data().url + "/chat_session/";
    try {
      String token = await LoginService().login(username: username);
      final response = await http.post(
        Uri.parse(LoginApiUrl),
        headers: {
          'Content-Type': 'application/json',
          "Authorization": "Bearer ${token}"
        },
        body: jsonEncode(
          {"session_name": session_name},
        ),
      );
      if (response.statusCode == 201) {
        final data = jsonDecode(response.body);
        print(data);
        return data["chat_session_id"];
      } else {
        print("different status code ");
        print(response.statusCode);

        return 0;
      }
    } catch (e) {
      print(e);
      return 0;
    }
  }

  Future<int> DeleteSession(
      {required String username, required int session_id}) async {
    String LoginApiUrl = data().url + "/chat_session/";
    try {
      String token = await LoginService().login(username: username);
      final response = await http.delete(
        Uri.parse(LoginApiUrl),
        headers: {
          'Content-Type': 'application/json',
          "Authorization": "Bearer ${token}"
        },
        body: jsonEncode(
          {"session_id": session_id},
        ),
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print(data);

        return data["chat_session_id"];
      } else {
        print("different status code ");
        print(response.statusCode);

        return 0;
      }
    } catch (e) {
      print(e);
      return 0;
    }
  }

  Future<List<dynamic>> LoadChatsOfSession(
      {required String username, required int session_id}) async {
    String LoginApiUrl = data().url + "/get_chat_messages/${session_id}/";
    try {
      String token = await LoginService().login(username: username);
      final response = await http.get(
        Uri.parse(LoginApiUrl),
        headers: {
          'Content-Type': 'application/json',
          "Authorization": "Bearer ${token}"
        },
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print(data);

        return data;
      } else {
        print("different status code ");
        print(response.statusCode);

        return [];
      }
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<String> ChatWithApi(
      {required String username,
      required int session_id,
      required String input}) async {
    String LoginApiUrl = data().url + "/chat/";
    try {
      print(" $session_id is the session id");
      print(input);
      String token = await LoginService().login(username: username);
      final response = await http.post(Uri.parse(LoginApiUrl),
          headers: {
            'Content-Type': 'application/json',
            "Authorization": "Bearer ${token}"
          },
          body: jsonEncode({"input": input, "chat_session_id": session_id}));
      if (true) {
        final data = jsonDecode(response.body);
        print(data);

        return data["response"];
      } else {
        print("different status code ");
        print(response.statusCode);

        return '';
      }
    } catch (e) {
      print(e);
      return '';
    }
  }
}
