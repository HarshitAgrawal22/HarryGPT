import 'package:flutter/material.dart';
import 'package:trio_ai/ApiServices.dart/chat_work_api.dart';
import 'package:trio_ai/database/Storage.dart';
import 'package:trio_ai/pages/chat_app.dart';
import 'package:trio_ai/pages/loginPage.dart';
import 'package:trio_ai/pages/register_page.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

void main() async {
  await Hive.initFlutter();
  var box = await Hive.openBox("myBox");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final myBox = Hive.box('myBox');
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: database().isRegistered()
          ? RegisterPage()
          : loginPage(), // Here we are manually checking if the userId exists or not
    );
  }
}
