import 'package:equatable/equatable.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserEntity extends Equatable {
  final String status;
  final String uid;
  final String name;
  final String profile;

  UserEntity(this.status, this.uid, this.name,this.profile);

  Map<String, Object> toJson() {
    return {
      'status': status,
      'name': name,
      'uid': uid,
      'profile' :profile
    };
  }

  @override
  String toString() {
    return 'UserEntity { status: $status name: $name, uid: $uid profile $profile}';
  }

  static UserEntity fromJson(Map<String, Object> json) {
    return UserEntity(
      json['status'] as String,
      json['uid'] as String,
      json['name'] as String,
      json['profile'] as String,
    );
  }

  static UserEntity fromSnapshot(DocumentSnapshot snap) {
    return UserEntity(
      snap.data['status'],
      snap.data['uid'],
      snap.data['name'],
      snap.data['profile'],
    );
  }

  Map<String, Object> toDocument() {
    return {
      'status': status,
      'uid': uid,
      'name': name,
      'profile': profile,
    };
  }
}
