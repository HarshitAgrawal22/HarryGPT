import 'package:flutter/material.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:trio_ai/pages/chat_app.dart';

class loginPage extends StatefulWidget {
  const loginPage({super.key});

  @override
  State<loginPage> createState() => _loginPageState();
}

TextEditingController IDController = new TextEditingController();

class _loginPageState extends State<loginPage> {
  Future<void> handleLogin(context) async {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => chatPage()));
  }

  @override
  Widget build(BuildContext context) {
    Size aspect = MediaQuery.sizeOf(context);
    return Scaffold(
        backgroundColor: Colors.grey,
        body: LiquidPullToRefresh(
            backgroundColor: Colors.purple, //Todo change the color
            color: Colors.red, //Todo change the color
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: aspect.width / 10, vertical: aspect.height / 20),
              child: Center(
                  child: ListView(
                children: [
                  Text(
                    "Welcome Master",
                    style: TextStyle(color: Colors.blue),
                  ),
                  Container(
                      decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(120)),
                      // color: Colors.red,
                      child: TextField(
                        decoration: InputDecoration(
                            hintText: "Unique ID...",
                            hintStyle: TextStyle(color: Colors.yellow)),
                        controller: IDController,
                      )),
                  Container(
                      decoration: BoxDecoration(
                          color: Colors.purple,
                          borderRadius: BorderRadius.circular(12)),
                      padding: EdgeInsets.symmetric(
                          vertical: aspect.height / 80,
                          horizontal: aspect.width / 80),
                      child: Row(
                        children: [
                          Text("Pull Down to Login"),
                          Icon(Icons.swipe_down_sharp)
                        ],
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                      )),
                ],
              )),
            ),
            onRefresh: () => handleLogin(context)));
  }
}
