import 'package:capital_academy_app/bloc/authentication/auth_bloc.dart';
import 'package:capital_academy_app/bloc/authentication/auth_event.dart';
import 'package:capital_academy_app/bloc/authentication/auth_state.dart';
import 'package:capital_academy_app/bloc/repository/firebase_repository.dart';
import 'package:capital_academy_app/bloc/user/user_bloc.dart';
import 'package:capital_academy_app/bloc/user/user_event.dart';
import 'package:capital_academy_app/screen/home_screen.dart';
import 'package:capital_academy_app/screen/login_screen/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'bloc/delegate/simple_delegate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  BlocSupervisor.delegate = SimpleDelegate();
  runApp(myApp());
}

class myApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => myAppState();
}

class myAppState extends State<myApp> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          builder: (_) => AuthBloc(
            userRepository: FirebaseUserRepository(),
          )..dispatch(AppStarted()),
        ),
        BlocProvider<UserBloc>(
          builder: (_) => UserBloc(
            userRepository: FirebaseUserRepository(),
          )..dispatch(LoadUser()),
        )
      ],
      child: MaterialApp(
        title: 'Capital Institude',
        theme: ThemeData(
          primaryColor: Colors.green.shade600,
          accentColor: Colors.white,
          accentColorBrightness: Brightness.light,
        ),
        routes: {
          '/': (context) {
            return BlocBuilder<AuthBloc, AuthState>(
              builder: (context, state) {
                if (state is Authenticated) {
                  return HomeScreen(
                    currentUID: state.userId,
                  );
                }
                if (state is Unauthenticated) {
                  return LoginScreen();
                }
                return Center(child: CircularProgressIndicator());
              },
            );
          },
        },
      ),
    );
  }
}
