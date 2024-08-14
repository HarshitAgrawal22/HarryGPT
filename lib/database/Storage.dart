import 'package:hive/hive.dart';

class database {
  List SessionList = [];
  String userId = "";
  final myBox = Hive.box("myBox");
  void LoadSessions() {
    SessionList = myBox.get("SessionList");
  }

  String LoadUserId() {
    userId = myBox.get("userId");
    return userId;
  }

  void putUserId(userID) {
    myBox.put("userId", userID);
  }

  void putSessions() {
    myBox.put("SessionList", SessionList);
  }

  bool isRegistered() {
    return myBox.get("userId") == null;
  }
}
