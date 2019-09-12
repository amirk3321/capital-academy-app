import 'package:capital_academy_app/model/user.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class UserEvent extends Equatable {
  UserEvent([List props = const <dynamic>[]]) : super(props);
}
class LoadUser extends UserEvent {
  @override
  String toString() => 'LoadUser';
}

class AddUser extends UserEvent {
  final User user;

  AddUser(this.user) : super([user]);

  @override
  String toString() => 'AddUser { user: $user }';
}

class UpdateUser extends UserEvent {
  final User updatedUser;

  UpdateUser(this.updatedUser) : super([updatedUser]);

  @override
  String toString() => 'UpdateUser { updatedUser: $updatedUser }';
}

class DeleteUser extends UserEvent {
  final User user;

  DeleteUser(this.user) : super([user]);

  @override
  String toString() => 'DeleteUser { user: $user }';
}

class UsersUpdated extends UserEvent {
  final List<User> user;

  UsersUpdated(this.user);

  @override
  String toString() => 'UsersUpdated';
}