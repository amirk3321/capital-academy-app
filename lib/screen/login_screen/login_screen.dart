import 'package:capital_academy_app/bloc/registration/registor_event.dart' as prefix1;
import 'package:capital_academy_app/bloc/registration/registor_state.dart' as prefix0;
import 'package:capital_academy_app/bloc/repository/firebase_repository.dart';
import 'package:capital_academy_app/screen/comman/custom_textfield.dart';
import 'package:capital_academy_app/screen/registration_screen/registration_screen.dart';
import 'package:capital_academy_app/validators/validators.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kiwi/kiwi.dart' as Kiwi;
import 'package:capital_academy_app/bloc/login/bloc.dart';
import 'package:capital_academy_app/bloc/authentication/bloc.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  LoginBloc _loginBloc;


  TextEditingController _emailController =TextEditingController();

  TextEditingController _passwordController = TextEditingController();


  bool get isPopulated =>
      _emailController.text.isNotEmpty && _passwordController.text.isNotEmpty;




  final textStyle =
      TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold);

  @override
  void initState() {
    _loginBloc=LoginBloc(userRepository: FirebaseUserRepository());
    _emailController.addListener(_onChangeEmail);
    _passwordController.addListener(_onChangePassword);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        builder: (_) => _loginBloc,
        child: BlocListener<LoginBloc,LoginState>(
          listener: (context,LoginState state){

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
            if (state is SuccessState){
              BlocProvider.of<AuthBloc>(context).dispatch(
                LoggedIn()
              );
            }
            if (state is FailureState) {
              Scaffold.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(SnackBar(
                  content: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text('error occurr'),
                      CircularProgressIndicator(),
                    ],
                  ),
                  backgroundColor: Colors.red,
                ));
            }
          },

          child: BlocBuilder<LoginBloc,LoginState>(builder: (BuildContext context, LoginState state){
            return _buildScaffold(context);
          }),
        ),
      ),
    );
  }



  Scaffold _buildScaffold(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      body: ListView(
        children: <Widget>[
          Column(
            children: <Widget>[
              SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    height: 150,
                    width: 150,
                    child: Image.asset('assets/logo.png'),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                padding: EdgeInsets.all(8),
                width: MediaQuery.of(context).size.width / 100 * 80,
                height: MediaQuery.of(context).size.height / 100 * 55,
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
                      controller: _emailController,
                    ),
                    CustomTextField(
                      label: 'Password',
                      icon: Icons.lock,
                      obscureText: true,
                      controller: _passwordController,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    _buildForgetPasswordButton("Forget password?"),
                    Spacer(),
                    LoginButton(
                      tittle: "Login",
                      onPressed: (){
                        if (isPopulated){
                          _loginBloc.dispatch(
                            Submitted(
                              email: _emailController.text,
                              password: _passwordController.text
                            )
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),

              SizedBox(
                height: 20,
              ),
              _buildRegistrationScreenBtn("Create an Account"),
            ],
          ),
        ],
      ),
    );
  }

  void _onChangeEmail(){
    Validators.isValidEmail(_emailController.text);
  }

  void _onChangePassword(){
   Validators.isValidPassword(_emailController.text);
  }


  @override
  void dispose() {
    _passwordController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  _buildRegistrationScreenBtn(tittle) => FlatButton(
        onPressed: () {
            Navigator.push(context, MaterialPageRoute(
              builder: (_) => RegistrationScreen()
            ));
        },
        child: Text(
          tittle,
          style: textStyle,
        ),
      );

  _buildForgetPasswordButton(tittle) => FlatButton(
        onPressed: () {

        },
        child: Text(
          tittle,
          style: TextStyle(color: Colors.green),
        ),
      );

}

//login Button
class LoginButton extends StatelessWidget {
  final String tittle;
  final VoidCallback onPressed;

  LoginButton({Key key, this.tittle, this.onPressed}) : super(key: key);

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
