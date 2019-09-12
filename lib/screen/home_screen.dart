import 'package:capital_academy_app/bloc/authentication/bloc.dart';
import 'package:capital_academy_app/bloc/user/user_bloc.dart';
import 'package:capital_academy_app/bloc/user/user_state.dart';
import 'package:capital_academy_app/model/user.dart';
import 'package:capital_academy_app/screen/home/profile_page.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'home/page_model.dart';

class HomeScreen extends StatefulWidget {
  final String currentUID;

  HomeScreen({Key key, this.currentUID}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  String get _currentUID => widget.currentUID;


  List<Widget> get _bottomNavigationPages=>[
    ChatPage(),
    PeoplePage(uid: _currentUID),
    GroupPage(),
    CoursesPage()
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        final users = (state as UsersLoaded)
            .user
            .firstWhere((user) => user.uid == widget.currentUID, orElse: null);
        print('my name is :${users.name}');
        return Scaffold(
          bottomNavigationBar: Theme(
            data: Theme.of(context).copyWith(
              canvasColor: Colors.grey.shade100,
            ),
            child: BottomNavigationBar(
              type: BottomNavigationBarType.shifting,
              selectedItemColor: Colors.red,
              backgroundColor: Colors.green,
              iconSize: 24,
              currentIndex: _currentIndex,
              onTap: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              unselectedItemColor: Colors.black,
              items: [
                BottomNavigationBarItem(
                    icon: Icon(Icons.chat), title: Text('chat')),
                BottomNavigationBarItem(
                    icon: Icon(Icons.person_outline), title: Text('people')),
                BottomNavigationBarItem(
                    icon: Icon(Icons.group), title: Text('group')),
                BottomNavigationBarItem(
                    icon: Icon(Icons.book), title: Text('courses')),
              ],
            ),
          ),
          appBar: AppBar(
            actions: <Widget>[
              IconButton(
                icon: Image.asset(users.profile == '' || users.profile == null
                    ? 'assets/default.png'
                    : users.profile),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => ProfilePage(
                                name: users.name,
                                status: users.status,
                                uid: users.uid,
                                profile: users.profile,
                              )));
                },
              ),
              IconButton(
                icon: Icon(Icons.exit_to_app),
                onPressed: () {
                  BlocProvider.of<AuthBloc>(context).dispatch(LoggedOut());
                },
              )
            ],
            title: Text("Home"),
          ),
          body: PageStorage(
            bucket: PageStorageBucket(),
            child: _bottomNavigationPages[_currentIndex],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.pushNamed(context, '/frindlist');
            },
            child: Icon(Icons.add),
            tooltip: 'friendlist',
          ),
        );
      },
    );
  }
}
