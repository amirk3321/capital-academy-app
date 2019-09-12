import 'dart:async';
import 'package:capital_academy_app/bloc/registration/registor_state.dart' as prefix0;
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:capital_academy_app/bloc/registration/registor_event.dart' as prefix1;
import 'package:capital_academy_app/bloc/repository/firebase_repository.dart';
import './bloc.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {

  FirebaseUserRepository _userRepository;

  LoginBloc({@required FirebaseUserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository;

  @override
  LoginState get initialState => InitialState();

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if (event is Submitted){
      yield* _mapSubmittedToState(event);
    }
  }
  Stream<LoginState> _mapSubmittedToState(Submitted event)async*{
    yield LoadingState();

    try{
      await _userRepository.signIn(event.email, event.password);
      yield SuccessState();
    }catch(e){
      yield FailureState();
    }
  }
}
