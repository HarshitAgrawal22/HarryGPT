import 'package:flutter/material.dart';

class myDrawer extends StatelessWidget {
  List Sessions;
  myDrawer({super.key, required this.Sessions});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            child: Text("your sessions".toUpperCase()),
          ),
          Expanded(
              child: ListView.builder(
                  itemCount: Sessions.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: GestureDetector(
                        child: Sessions[index],
                      ),
                    );
                  }))
        ],
      ),
    );
  }
}
