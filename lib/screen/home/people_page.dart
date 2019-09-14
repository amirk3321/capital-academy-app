import 'package:capital_academy_app/bloc/user/bloc.dart';
import 'package:capital_academy_app/model/user.dart';
import 'package:capital_academy_app/screen/home/single_user_chat.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PeoplePage extends StatelessWidget {
  final String uid;
  PeoplePage({Key key,this.uid}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        final users = (state as UsersLoaded)
            .user
            .where((user) => user.uid != uid)
            .toList();

        return Scaffold(
            body: users.isEmpty
                ? Center(
                    child: Icon(
                      Icons.person_outline,
                      size: 80,
                      color: Colors.black.withOpacity(.2),
                    ),
                  )
                : ListView.builder(
                    itemCount: users.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: (){
                          BlocProvider.of<UserBloc>(context).dispatch(
                              UserItemListOnPressed(
                                otherUserId: users[index].uid
                              )
                          );
                          Navigator.push(context, MaterialPageRoute(
                            builder: (_) => SingleUserChat(
                              otherUid: users[index].uid,
                              name: users[index].name,
                              profile: users[index].profile,
                              uid: uid,
                            )
                          ));
                        },
                        child: ListTile(
                          leading: InkWell(
                            onTap: () {
                              print(users[index].name);
                            },
                            child: Image.asset(
                              users[index].profile.isEmpty || users[index] == null
                                  ? 'assets/default.png'
                                  : users[index].profile,
                            ),
                          ),
                          title: Text(users[index].name),
                          subtitle: Text(users[index].status),
                        ),
                      );
                    },
                  ));
      },
    );
  }
}
