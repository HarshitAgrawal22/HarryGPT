import 'package:flutter/material.dart';

class myDrawer extends StatelessWidget {
  const myDrawer({super.key});

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
                  itemCount: 9,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: GestureDetector(
                        child: Text("data"),
                      ),
                    );
                  }))
        ],
      ),
    );
  }
}
