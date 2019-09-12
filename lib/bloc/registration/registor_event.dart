import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class RegistorEvent extends Equatable {
  RegistorEvent([List props = const <dynamic>[]]) : super(props);
}

class Submitted extends RegistorEvent {
  final String email;
  final String password;
  final String status;
  final String name;

  Submitted({
    this.email,
    this.password,
    this.name,
    this.status
  }) : super([email, password,name,status]);

  @override
  String toString() => ''' 
  email : $email,
  password :$password,
  ''';
}
