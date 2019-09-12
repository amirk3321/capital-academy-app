import 'package:flutter/material.dart';

class SingleUserChat extends StatelessWidget {
  String uid;
  String name;
  String profile;

  SingleUserChat({Key key, this.name, this.uid, this.profile})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("$name"),
      ),
      body: Material(
        color: Colors.grey[200],
        child: Column(
          children: <Widget>[
            Flexible(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                  reverse: true,
                  itemBuilder: (context, index) {},
                ),
              ),
            ),
            Divider(
              height: 1.0,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 5,left: 2,right: 2),
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  border: Border.all(width: 1,color: Colors.grey[500]),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: _sentMessageInput(),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _sentMessageInput() {
    return IconTheme(
      data: IconThemeData(color: Colors.red),
      child: Container(
        child: Row(
          children: <Widget>[
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 2),
              child: IconButton(
                icon: Icon(Icons.image),
                onPressed: () {},
              ),
            ),
             Flexible(
              child:  TextField(
                decoration:
                     InputDecoration.collapsed(hintText: "Start typing ..."),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 2),
              child: IconButton(
                icon: Icon(Icons.send),
                onPressed: () {},
              ),
            )
          ],
        ),
      ),
    );
  }
}
