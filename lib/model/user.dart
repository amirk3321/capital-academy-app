

import 'package:capital_academy_app/model/user_entity.dart';

class User {
  final String status;
  final String uid;
  final String name;
  final String profile;

  User({this.status='',this.uid='',this.name='',this.profile=''});

  User copyWith({String status, String uid, String name,String profile}) {
    return User(
      status :status ?? this.status,
      uid: uid ?? this.uid,
      name: name ?? this.name,
      profile: profile ?? this.profile,
    );
  }

  @override
  int get hashCode =>
      status.hashCode ^ status.hashCode ^ name.hashCode ^ uid.hashCode ^profile.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is User &&
              runtimeType == other.runtimeType &&
              status == other.status &&
              name == other.name &&
              profile == other.profile &&
              uid == other.uid;

  @override
  String toString() {
    return 'User { status: $status, name: $name, uid: $uid profile $profile }';
  }

  UserEntity toEntity() {
    return UserEntity(status, uid, name,profile);
  }

  static User fromEntity(UserEntity entity) {
    return User(
      status: entity.status,
      name: entity.name,
      profile: entity.profile,
      uid: entity.uid,
    );
  }
}
