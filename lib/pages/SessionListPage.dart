import 'package:flutter/material.dart';
import 'package:trio_ai/ApiServices.dart/chat_work_api.dart';
import 'package:trio_ai/pages/SessionListPage.dart';
import 'package:trio_ai/pages/chat_app.dart';
import 'package:trio_ai/pages/loginPage.dart';
import 'package:trio_ai/utilities/chatbubble.dart';
import 'package:trio_ai/utilities/drawer.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class SessionPage extends StatefulWidget {
  final String UserID;
  SessionPage({super.key, required this.UserID});

  @override
  State<SessionPage> createState() => _SessionPageState();
}

class _SessionPageState extends State<SessionPage> {
  List Sessions = [];

  void SetSessions() async {
    Sessions = await ChatService().loadSessions(widget.UserID);
    setState(() {
      Sessions = Sessions;
      print("loaded sessions");
    }); // Update UI after loading sessions
  }

  @override
  void initState() {
    super.initState();
    // Initialize sessions when the widget is created
    SetSessions();
  }

  void deleteSession(int id) async {
    await ChatService().DeleteSession(username: widget.UserID, session_id: id);
    SetSessions();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;
    double height = MediaQuery.sizeOf(context).height;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.green.shade800,
        title: Text(
          "HERMIONE",
          style: TextStyle(
            letterSpacing: width / 30,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => loginPage()));
              },
              icon: Icon(Icons.create))
        ],
      ),
      body: Center(
        child: Sessions.isEmpty
            ? Center(
                child: CircularProgressIndicator()) // Show loading indicator
            : ListView.builder(
                itemCount: Sessions.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => chatPage(
                                    id: widget.UserID,
                                    session_id: Sessions[index]["id"])));
                      },
                      child: ListTile(
                        title: Slidable(
                          startActionPane: ActionPane(
                            motion: ScrollMotion(),
                            children: [
                              SlidableAction(
                                borderRadius:
                                    BorderRadius.circular(height / 40),
                                onPressed: (context) {
                                  deleteSession(Sessions[index]["id"]);
                                },
                                backgroundColor: Colors.cyanAccent,
                                label: "delete",
                                icon: (Icons.delete),
                              ),
                            ],
                          ),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: width / 10, vertical: height / 40),
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(height / 40),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  child: RichText(
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                          text:
                                              '${Sessions[index]["name"]} ', // First part of the text
                                          style: TextStyle(
                                              fontSize: 16.0,
                                              color: Colors
                                                  .black), // Adjust the style
                                        ),
                                        TextSpan(
                                          text:
                                              '${Sessions[index]}', // Second part of the text
                                          style: TextStyle(
                                              fontSize: 16.0,
                                              color: Colors
                                                  .black), // Adjust the style
                                        ),
                                      ],
                                    ),
                                    overflow: TextOverflow
                                        .visible, // Wrap text to new line if it overflows
                                    maxLines:
                                        2, // Limit to 2 lines, adjust as needed
                                  ),
                                ),
                                Icon(Icons.arrow_forward_ios),
                              ],
                            ),
                          ),
                        ),
                      ));
                },
              ),
      ),
    );
  }
}
