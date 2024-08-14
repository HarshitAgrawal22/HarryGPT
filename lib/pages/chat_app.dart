import 'package:flutter/material.dart';
import 'package:trio_ai/ApiServices.dart/chat_work_api.dart';
import 'package:trio_ai/pages/SessionListPage.dart';
import 'package:trio_ai/utilities/chatbubble.dart';
import 'package:trio_ai/utilities/drawer.dart';

class chatPage extends StatefulWidget {
  final String id;
  final int session_id;

  chatPage({super.key, required this.id, required this.session_id});

  @override
  State<chatPage> createState() => _chatPageState();
}

class _chatPageState extends State<chatPage> {
  List<dynamic> Chats = [];

  TextEditingController chatController = TextEditingController();

  // Method to add a new message to the chat
  void addMessage() async {
    await ChatService().ChatWithApi(
        username: widget.id,
        session_id: widget.session_id,
        // widget.session_id,
        input: chatController.text);
    print("here message have been sent");
    loadChats();
  }

  void loadChats() async {
    Chats = await ChatService()
        .LoadChatsOfSession(username: widget.id, session_id: widget.session_id);
    print("$Chats is the chats ");
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadChats();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;
    double height = MediaQuery.sizeOf(context).height;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.green.shade800, // Update the app bar color
        title: Text(
          "HERMIONE",
          style: TextStyle(
            letterSpacing: width / 30,
          ),
        ), // Update this color as needed
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SessionPage(
                              UserID: widget.id,
                            )));
              },
              icon: Icon(
                Icons.list,
              )),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: Chats.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Align(
                    alignment: Chats[index]["sender"] == "user"
                        ? Alignment.centerRight
                        : Alignment.centerLeft,
                    child: bubble(
                      data: Chats[index]["text"],
                      bgColor: Chats[index]["sender"] == "user"
                          ? Colors.yellow
                          : Colors.blue,
                      size: height,
                    ),
                  ),
                );
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Container(
                  color: Colors.purple,
                  width: width * 2 / 3,
                  child: TextField(
                    controller: chatController,
                    decoration: InputDecoration(
                      hintText: 'Enter your message...',
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  addMessage();
                  chatController.clear(); // Clear the input field after sending
                },
                child: Container(
                  decoration: BoxDecoration(color: Colors.green),
                  width: width / 5,
                  child: Icon(Icons.send),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
