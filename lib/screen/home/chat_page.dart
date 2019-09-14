import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  ChatPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Icon(
          Icons.chat,
          size: 80,
          color: Colors.black.withOpacity(.2),
        ),
      ),
    );
  }
}
