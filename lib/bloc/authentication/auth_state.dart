import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class AuthState extends Equatable {
  AuthState([List props = const <dynamic>[]]) : super(props);
}

class Uninitialized extends AuthState {
  @override
  String toString() => 'Uninitialized';
}

class Authenticated extends AuthState {
  final String userId;

  Authenticated(this.userId) : super([userId]);

  @override
  String toString() => 'Authenticated { userId: $userId }';
}

class Unauthenticated extends AuthState {
  @override
  String toString() => 'Unauthenticated';
}