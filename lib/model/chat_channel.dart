

class ChatChannel{
  final List<String> userIds;

  ChatChannel({this.userIds=const <String>[]});


  Map<String,Object> toDocument() =>{
    'userIds' : userIds
  };
}