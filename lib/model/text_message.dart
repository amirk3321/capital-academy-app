import 'package:capital_academy_app/app_constent.dart';
import 'package:capital_academy_app/model/text_message_entity.dart';

class TextMessage {
  final String recipientId;
  final String senderId;
  final String senderName;
  final String type;
  final DateTime time;
  final String text;

  TextMessage(
      {this.recipientId = '',
      this.senderId = '',
      this.senderName = '',
      this.type = MessageType.TEXT,
      this.time,
      this.text = ''});

  TextMessage copyWith({
    String recipientId,
    String senderId,
    String senderName,
    String type,
    DateTime time,
    String text,
  }) {
    return TextMessage(
        recipientId: recipientId ?? this.recipientId,
        senderId: senderId ?? this.senderId,
        senderName: senderName ?? this.senderName,
        type: type ?? this.type,
        time: time ?? this.time,
        text: text ?? this.text);
  }

  @override
  int get hashCode =>
      recipientId.hashCode ^
      senderId.hashCode ^
      senderName.hashCode ^
      type.hashCode ^
      time.hashCode ^
      text.hashCode;

  @override
  bool operator ==(other) =>
      identical(this, TextMessage) ||
      other is TextMessage &&
          runtimeType == other.runtimeType &&
          recipientId == other.recipientId &&
          senderId == other.senderId &&
          senderName == other.senderName &&
          type == other.type &&
          time == other.time &&
          text == other.text;

  @override
  String toString() => '''
  recipientId :$recipientId , 
  senderId $senderId, 
  senderName $senderName, 
  type $type ,
  time $time ,
  text $text
  ''';

  TextMessageEntity toEntity() =>
    TextMessageEntity(recipientId,senderId,senderName,type,time,text);


  static TextMessage fromEntity(TextMessageEntity messageEntity)
  => TextMessage(
    recipientId: messageEntity.recipientId,
    senderId: messageEntity.senderId,
    senderName: messageEntity.senderName,
    type: messageEntity.type,
    time: messageEntity.time,
    text: messageEntity.text
  );
}
