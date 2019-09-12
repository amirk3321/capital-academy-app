import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:capital_academy_app/bloc/repository/firebase_repository.dart';
import './bloc.dart';
import 'package:meta/meta.dart';

class UserBloc extends Bloc<UserEvent, UserState> {

  final FirebaseUserRepository _userRepository;
  StreamSubscription _todosSubscription;

  UserBloc({@required FirebaseUserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository;

  @override
  UserState get initialState => UsersLoading();

  @override
  Stream<UserState> mapEventToState(
    UserEvent event,
  ) async* {
    if (event is LoadUser) {
      yield* _mapLoadUserToState();
    }else if (event is UsersUpdated) {
      yield* _mapTodosUpdateToState(event);
    }else if(event is UpdateUser){
      yield* _mapUpdateUserToState(event);
    }
  }
  Stream<UserState> _mapLoadUserToState() async* {
    _todosSubscription?.cancel();
    _todosSubscription = _userRepository.users().listen(
          (user) {
        dispatch(
          UsersUpdated(user),
        );
      },
    );
  }


  Stream<UserState> _mapTodosUpdateToState(UsersUpdated event) async* {
    yield UsersLoaded(event.user);
  }

  Stream<UserState> _mapUpdateUserToState(UpdateUser event)async*{
    await _userRepository.updateUsers(event.updatedUser);
  }
  @override
  void dispose() {
    _todosSubscription?.cancel();
    super.dispose();
  }
}
