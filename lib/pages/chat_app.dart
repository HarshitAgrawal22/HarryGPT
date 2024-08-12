import 'package:flutter/material.dart';
import 'package:trio_ai/utilities/chatbubble.dart';
import 'package:trio_ai/utilities/drawer.dart';

class chatPage extends StatefulWidget {
  const chatPage({super.key});

  @override
  State<chatPage> createState() => _chatPageState();
}

class _chatPageState extends State<chatPage> {
  void ClearHistory() {
    //TODO add code here
    Navigator.of(context).pop();
  }

  TextEditingController chatController = new TextEditingController();
  void ConfirmDelete() {
    showDialog(
        context: context,
        builder: (Context) => AlertDialog(
            backgroundColor: Colors.red,
            title: Text(
              "Delete History ?",
              style: TextStyle(color: Colors.yellow), // TODO change this color
            ),
            content: GestureDetector(
              onTap: () => ClearHistory(),
              child: Container(child: Text("Delete")),
            )));
  }

  List<String> data = [
    """// screens/chat_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hive/hive.dart';
import '../services/chat_service.dart';
import '../models/message.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  late Box<Message> _messageBox;

  @override
  void initState() {
    super.initState();
    _messageBox = Hive.box<Message>('messages');
  }

  void _sendMessage() async {
    final text = _controller.text;
    if (text.isEmpty) return;

    final newMessage = Message(text: text, isUser: true);
    _messageBox.add(newMessage);

    _controller.clear();

    final chatService = Provider.of<ChatService>(context, listen: false);
    try {
      final response = await chatService.sendMessage(text, _messageBox.values.toList());
      final botMessage = Message(text: response, isUser: false);
      _messageBox.add(botMessage);
    } catch (e) {
      // Handle error
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ChatGPT Clone'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ValueListenableBuilder(
              valueListenable: _messageBox.listenable(),
              builder: (context, Box<Message> box, _) {
                final messages = box.values.toList().cast<Message>();
                return ListView.builder(
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final message = messages[index];
                    return ListTile(
                      title: Align(
                        alignment: message.isUser ? Alignment.centerRight : Alignment.centerLeft,
                        child: Container(
                          padding: EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            color: message.isUser ? Colors.blue : Colors.grey[300],
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Text(
                            message.text,
                            style: TextStyle(color: message.isUser ? Colors.white : Colors.black),
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: 'Enter your message...',
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
""",
    """// screens/chat_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hive/hive.dart';
import '../services/chat_service.dart';
import '../models/message.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  late Box<Message> _messageBox;

  @override
  void initState() {
    super.initState();
    _messageBox = Hive.box<Message>('messages');
  }

  void _sendMessage() async {
    final text = _controller.text;
    if (text.isEmpty) return;

    final newMessage = Message(text: text, isUser: true);
    _messageBox.add(newMessage);

    _controller.clear();

    final chatService = Provider.of<ChatService>(context, listen: false);
    try {
      final response = await chatService.sendMessage(text, _messageBox.values.toList());
      final botMessage = Message(text: response, isUser: false);
      _messageBox.add(botMessage);
    } catch (e) {
      // Handle error
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ChatGPT Clone'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ValueListenableBuilder(
              valueListenable: _messageBox.listenable(),
              builder: (context, Box<Message> box, _) {
                final messages = box.values.toList().cast<Message>();
                return ListView.builder(
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final message = messages[index];
                    return ListTile(
                      title: Align(
                        alignment: message.isUser ? Alignment.centerRight : Alignment.centerLeft,
                        child: Container(
                          padding: EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            color: message.isUser ? Colors.blue : Colors.grey[300],
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Text(
                            message.text,
                            style: TextStyle(color: message.isUser ? Colors.white : Colors.black),
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: 'Enter your message...',
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
"""
  ];

  void addMessage() {
    setState(() {
      data.add(chatController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width,
        height = MediaQuery.sizeOf(context).height;

    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.green.shade800, //TODO colors need to change
          title: Text(
            "HERMIONE",
            style: TextStyle(
              letterSpacing: width / 30,
            ),
          ), //TOdo colors need to be updated
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: ConfirmDelete,
              icon: Icon(Icons.delete),

              splashColor: Colors.black, //Todo : need to be updated
            )
          ],
        ),
        drawer: myDrawer(),
        body: Column(children: [
          Expanded(
            child: ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Align(
                    alignment:
                        true ? Alignment.centerRight : Alignment.centerLeft,
                    child: bubble(
                      data: data[index],
                      bgColor: false ? Colors.yellow : Colors.blue,
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
                        decoration: InputDecoration(),
                      ))),
              GestureDetector(
                  onTap: () {
                    addMessage();
                    chatController.clear();
                    // Navigator.pop(context);
                  },
                  child: Container(
                    decoration: BoxDecoration(color: Colors.green),
                    width: width / 5,
                    child: Icon(Icons.send),
                  ))
            ],
          )
        ]));
  }
}
