import 'package:cloud_firestore/cloud_firestore.dart';

class TextMessageEntity{
  final String recipientId;
  final String senderId;
  final String senderName;
  final String type;
  final DateTime time;
  final String text;

  TextMessageEntity(this.recipientId,this.senderId,this.senderName,this.type,this.time,this.text);

  Map<String,Object> toJson(){
    return {
      'recipientId' :recipientId,
      'senderId' :senderId,
      'senderName' :senderName,
      'type' :type,
      'time' :time,
      'text' :text,
    };
  }
 static TextMessageEntity formJson(Map<String,Object> json){
    return TextMessageEntity(
      json['recipientId'] as String,
      json['senderId'] as String,
      json['senderName'] as String,
      json['type'] as String,
      json['time'] as DateTime,
      json['text'] as String,
    );
  }

  static TextMessageEntity fromSnapshot(DocumentSnapshot snapshot){
    return TextMessageEntity(
      snapshot.data['recipientId'],
      snapshot.data['senderId'],
      snapshot.data['senderName'],
      snapshot.data['type'],
      snapshot.data['time'],
      snapshot.data['text'],
    );
  }
  Map<String,Object> toDocument(){
    return {
      'recipientId' :recipientId,
      'senderId' :senderId,
      'senderName' :senderName,
      'type' :type,
      'time' :time,
      'text' :text,
    };
  }
}