import 'package:flutter/material.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:trio_ai/ApiServices.dart/data.dart';
import 'package:trio_ai/ApiServices.dart/loginService.dart';
import 'package:trio_ai/pages/chat_app.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool isOkay = true;

  String message = "Stretch Down To Get Started";

  void registerFailure(String error) {
    setState(() {
      isOkay = false;
      message = error;
    });
  }

  Future<void> Register(context) async {
    try {
      bool flag = await LoginService().Register(IDController.text);
      if (flag) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => chatPage(),
          ),
        );
      } else {
        registerFailure("Register Failure");
      }
    } catch (e) {
      registerFailure('$e');
    }
  }

  TextEditingController IDController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size aspect = MediaQuery.sizeOf(context);
    return Scaffold(
        backgroundColor: Colors.white,
        body: LiquidPullToRefresh(
            backgroundColor: Colors.purple, //Todo change the color
            color: Colors.red, //Todo change the color
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: aspect.width / 10, vertical: aspect.height / 20),
              child: Center(
                  child: ListView(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        "Welcome Master",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: aspect.height / 30),
                      ),
                      SizedBox(
                        height: aspect.height / 20,
                      ),
                      Text(
                        "They Call It Cheating We Call It Smartwork",
                        style: TextStyle(color: Colors.blue.shade800),
                      ),
                      SizedBox(
                        height: aspect.height / 20,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(120),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: aspect.width / 20),
                          child: TextField(
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(aspect.height / 70),
                                    ),
                                    borderSide: BorderSide()),
                                hintText: "Phone..",
                                hintStyle: TextStyle(color: Colors.blue)),
                            controller: IDController,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: aspect.height / 10,
                      ),
                      GestureDetector(
                        onTap: () => Register(context),
                        child: Container(
                          decoration: BoxDecoration(
                              color: isOkay ? Colors.blue : Colors.red,
                              borderRadius: BorderRadius.circular(12)),
                          padding: EdgeInsets.symmetric(
                              vertical: aspect.height / 80,
                              horizontal: aspect.width / 80),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                message,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: aspect.height / 50),
                              ),
                              Icon(
                                Icons.swipe_down_sharp,
                                color: Colors.white,
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: aspect.height / 5,
                  ),
                  Container(
                      child: const Center(
                          child: Text(
                    "In Case You Are Caught Cheating With This App In Exam Then We Take No Responsiblity Of It",
                    style: TextStyle(color: Colors.red),
                  ))),
                  SizedBox(
                    height: aspect.height / 20,
                  ),
                ],
              )),
            ),
            onRefresh: () => Register(context)));
  }
}
