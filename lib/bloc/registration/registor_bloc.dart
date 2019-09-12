import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:capital_academy_app/bloc/repository/firebase_repository.dart';
import './bloc.dart';
import 'package:meta/meta.dart';

class RegistorBloc extends Bloc<RegistorEvent, RegistorState> {
  FirebaseUserRepository _userRepository;

  RegistorBloc({@required FirebaseUserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository;

  @override
  RegistorState get initialState => InitialState();

  @override
  Stream<RegistorState> mapEventToState(
    RegistorEvent event,
  ) async* {
    if (event is Submitted) {
      yield* _mapSubmittedToState(event);
    }
  }

  Stream<RegistorState> _mapSubmittedToState(Submitted event) async* {
    yield LoadingState();

    try {
      await _userRepository
          .signUp(event.email,event.password);
      await _userRepository.getInitializedCurrentUser(name: event.name,status: event.status);
      yield SuccessState();
    } catch (_) {
      yield FailureState();
    }
  }
}
