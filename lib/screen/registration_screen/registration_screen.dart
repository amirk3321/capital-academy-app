import 'package:capital_academy_app/bloc/authentication/bloc.dart';
import 'package:capital_academy_app/bloc/registration/registor_bloc.dart';
import 'package:capital_academy_app/bloc/registration/registor_event.dart';
import 'package:capital_academy_app/bloc/registration/registor_state.dart';
import 'package:capital_academy_app/bloc/repository/firebase_repository.dart';
import 'package:capital_academy_app/screen/comman/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegistrationScreen extends StatefulWidget {
  RegistrationScreen({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => RegistrationScreenState();
}

class RegistrationScreenState extends State<RegistrationScreen> {
  RegistorBloc _registorBloc;

  TextEditingController _emailController;
  TextEditingController _nameController;
  TextEditingController _passwordController;
  TextEditingController _statusController;

  final textStyle =
      TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold);

  @override
  void initState() {
    _registorBloc=RegistorBloc(userRepository: FirebaseUserRepository());
    _emailController = TextEditingController();
    _nameController = TextEditingController();
    _passwordController = TextEditingController();
    _statusController =
        TextEditingController(text: "Hi there i am using this app");

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<RegistorBloc>(
        builder: (_) => _registorBloc,
        child: BlocListener<RegistorBloc,RegistorState>(
          listener: (context,state){
            if (state is LoadingState){
              Scaffold.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(SnackBar(
                  content: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text('SettingUp an account...'),
                      CircularProgressIndicator(),
                    ],
                  ),
                  backgroundColor: Colors.green,
                ));
            }
            if (state is FailureState){
              Scaffold.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(SnackBar(
                  content: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text('error occure...'),
                    ],
                  ),
                  backgroundColor: Colors.red,
                ));
            }
            if (state is SuccessState){
              BlocProvider.of<AuthBloc>(context).dispatch(LoggedIn());
              Navigator.pop(context);
            }
          },
          child: BlocBuilder<RegistorBloc,RegistorState>(
          builder: (context,state){
            return  buildScaffold(context);
          },
          ),
        ),
      ),
    );
  }

  Scaffold buildScaffold(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 15,
              ),
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(8),
                width: MediaQuery.of(context).size.width / 100 * 80,
                height: MediaQuery.of(context).size.height / 100 * 70,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  verticalDirection: VerticalDirection.down,
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: 100,
                    ),
                    CustomTextField(
                        label: 'Email',
                        icon: Icons.email,
                        obscureText: false,
                        controller: _emailController),
                    CustomTextField(
                        label: 'Username',
                        icon: Icons.person,
                        obscureText: false,
                        controller: _nameController),
                    CustomTextField(
                        label: 'status',
                        icon: Icons.title,
                        obscureText: false,
                        controller: _statusController),
                    CustomTextField(
                        label: 'Password',
                        icon: Icons.lock,
                        obscureText: true,
                        controller: _passwordController),
                    SizedBox(
                      height: 10,
                    ),
                    Spacer(),
                    RegistrationButton(
                      tittle: "Registor  >  ",
                      onPressed: () {
                        if (_emailController.text.isNotEmpty &&
                            _passwordController.text.isNotEmpty &&
                            _nameController.text.isNotEmpty) {
                          _registorBloc.dispatch(
                            Submitted(
                              email: _emailController.text,
                              password: _passwordController.text,
                              name: _nameController.text,
                              status: _statusController.text,
                            )
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 40,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class RegistrationButton extends StatelessWidget {
  final String tittle;
  final VoidCallback onPressed;

  RegistrationButton({Key key, this.tittle, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 25),
      decoration: BoxDecoration(
          color: Colors.green, borderRadius: BorderRadius.circular(40)),
      child: FlatButton(
        onPressed: onPressed,
        child: Text(
          tittle,
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
        ),
      ),
    );
  }
}
