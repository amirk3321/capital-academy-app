import 'package:capital_academy_app/bloc/user/bloc.dart';
import 'package:capital_academy_app/model/text_message_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SingleUserChat extends StatefulWidget {
  final String otherUid;
  final String uid;
  final String name;
  final String profile;

  SingleUserChat({Key key, this.name, this.otherUid, this.profile, this.uid})
      : super(key: key);

  @override
  _SingleUserChatState createState() => _SingleUserChatState();
}

class _SingleUserChatState extends State<SingleUserChat> {
  TextEditingController _textMessagecontroller;

  @override
  void initState() {
    _textMessagecontroller = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.name}"),
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
              padding: const EdgeInsets.only(bottom: 5, left: 2, right: 2),
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  border: Border.all(width: 1, color: Colors.grey[500]),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: _sentMessageInput(context),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _sentMessageInput(BuildContext context) {
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
              child: TextField(
                controller: _textMessagecontroller,
                decoration:
                    InputDecoration.collapsed(hintText: "Start typing ..."),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 2),
              child: IconButton(
                icon: Icon(Icons.send),
                onPressed: () {
                  if (_textMessagecontroller.text.isNotEmpty)
                    BlocProvider.of<UserBloc>(context).dispatch(SendTextMessage(
                        textMessageEntity: TextMessageEntity(
                            widget.otherUid,
                            widget.uid,
                            '',
                            'TEXT',
                            DateTime.now(),
                            _textMessagecontroller.text)));
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
