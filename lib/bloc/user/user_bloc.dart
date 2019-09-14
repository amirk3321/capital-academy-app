import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:capital_academy_app/bloc/repository/firebase_repository.dart';
import 'package:capital_academy_app/model/text_message_entity.dart';
import 'package:capital_academy_app/utils/shared_pref.dart';
import './bloc.dart';
import 'package:meta/meta.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final FirebaseUserRepository _userRepository;
  StreamSubscription _usersSubscription;

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
    } else if (event is UsersUpdated) {
      yield* _mapUsersUpdateToState(event);
    } else if (event is UpdateUser) {
      yield* _mapUpdateUserToState(event);
    } else if (event is UserItemListOnPressed) {
      yield* _mapUserItemListOnPressedToState(event);
    } else if (event is SendTextMessage) {
      yield* _mapSendTextMessage(event);
    }
  }

  Stream<UserState> _mapLoadUserToState() async* {
    _usersSubscription?.cancel();
    _usersSubscription = _userRepository.users().listen(
      (user) {
        dispatch(
          UsersUpdated(user),
        );
      },
    );
  }

  Stream<UserState> _mapUsersUpdateToState(UsersUpdated event) async* {
    yield UsersLoaded(event.user);
  }

  Stream<UserState> _mapUpdateUserToState(UpdateUser event) async* {
    await _userRepository.updateUsers(event.updatedUser);
  }


  Stream<UserState> _mapUserItemListOnPressedToState(
      UserItemListOnPressed event) async* {

    await _userRepository.getCreateChatChannel(otherUserId: event.otherUserId,onSave: (uid)async{
      print('channlId $uid');
      await SharedPref.setChannelId(uid);
    });

  }

  Stream<UserState> _mapSendTextMessage(SendTextMessage event) async* {
      String channelId=await SharedPref.getChannelId();
      print(channelId);
      await _userRepository.sendMessage(event.textMessageEntity, channelId);
  }

  @override
  void dispose() {
    _usersSubscription?.cancel();
    super.dispose();
  }
}
