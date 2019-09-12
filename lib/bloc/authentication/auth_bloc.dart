import 'dart:async';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:capital_academy_app/bloc/repository/firebase_repository.dart';
import './bloc.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {

  final FirebaseUserRepository _userRepository;

  AuthBloc({@required FirebaseUserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository;

  @override
  AuthState get initialState => Uninitialized();

  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    if (event is AppStarted) {
      yield* _mapAppStartedToState();
    }else if(event is LoggedIn){
      yield* _mapLoggedInToState();
    }else if(event is LoggedOut){
      yield* _mapLoggedOutToState();
    }
  }


  Stream<AuthState> _mapAppStartedToState() async* {
    try {
      final isSignedIn = await _userRepository.isAuthenticated();
      if (isSignedIn) {
        final userId = await _userRepository.getUserId();
        yield Authenticated(userId);
      }else{
        yield Unauthenticated();
      }
    } catch (_) {
      yield Unauthenticated();
    }
  }

  Stream<AuthState> _mapLoggedInToState() async*{
    final userId = await _userRepository.getUserId();
    yield Authenticated(userId);
  }

  Stream<AuthState> _mapLoggedOutToState() async*{
    yield Unauthenticated();
  }
}
