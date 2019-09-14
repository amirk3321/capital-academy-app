import 'package:capital_academy_app/model/chat_channel.dart';
import 'package:capital_academy_app/model/text_message.dart';
import 'package:capital_academy_app/model/text_message_entity.dart';
import 'package:capital_academy_app/model/user.dart';
import 'package:capital_academy_app/model/user_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

typedef onSaveCallBack = Function(String channelId);

class FirebaseUserRepository {
  String _channelID;
  onSaveCallBack onSave;
  final FirebaseAuth _firebaseAuth;
  final _userCollection = Firestore.instance.collection('user');
  final _chatChannels = Firestore.instance.collection('chatChannels');

  FirebaseUserRepository({FirebaseAuth firebaseAuth, this.onSave})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  Future<bool> isAuthenticated() async {
    final currentUser = await _firebaseAuth.currentUser();
    return currentUser != null;
  }

  Future<void> authenticate() {
    return _firebaseAuth.signInAnonymously();
  }

  Future<String> getUserId() async {
    return (await _firebaseAuth.currentUser()).uid;
  }

  Future<void> signUp(String email, String password) async {
    await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
  }

  Future<void> signIn(String email, String password) async {
    await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
  }

  Future<void> onSignOut() async {
    await _firebaseAuth.signOut();
  }

  Future<void> addNewUser(User user) {
    return _userCollection.add(user.toEntity().toDocument());
  }

  Future<void> getInitializedCurrentUser({String name, String status}) async {
    return _userCollection
        .document((await _firebaseAuth.currentUser()).uid)
        .get()
        .then((user) async {
      if (!user.exists) {
        var newUser = User(
                uid: (await _firebaseAuth.currentUser()).uid,
                name: name,
                status: status)
            .toEntity()
            .toDocument();
        _userCollection
            .document((await _firebaseAuth.currentUser()).uid)
            .setData(newUser);
      }
    }).catchError((e) => print("firebaseError ${e.toString()}"));
  }

  Future<void> deleteUser(User todo) async {
    return _userCollection.document(todo.uid).delete();
  }

  Stream<List<User>> users() {
    return _userCollection.snapshots().map((snapshot) {
      return snapshot.documents
          .map((doc) => User.fromEntity(UserEntity.fromSnapshot(doc)))
          .toList();
    });
  }

  Future<void> updateUsers(User update) {
    return _userCollection
        .document(update.uid)
        .updateData(update.toEntity().toDocument());
  }

  Future<void> getCreateChatChannel(
      {String otherUserId, onSaveCallBack onSave}) async {
    _userCollection
        .document((await _firebaseAuth.currentUser()).uid)
        .collection('engagedChatChannels')
        .document(otherUserId)
        .get()
        .then((snapshot) async {
      if (snapshot.exists) {
        onSave(snapshot.data['channelId']);
        setChannelId(snapshot.data['channelId']);
        print('exists id get');
        return;
      }

      String currentUID = (await _firebaseAuth.currentUser()).uid;

      var newChatChannel = _chatChannels.document();

      newChatChannel.setData(
          ChatChannel(userIds: [currentUID, otherUserId]).toDocument());

      //we need to save chatChannel id users who will chat togather
      var channel = {'channelId': newChatChannel.documentID};
      _userCollection
          .document((await _firebaseAuth.currentUser()).uid)
          .collection('engagedChatChannels')
          .document(otherUserId)
          .setData(channel);

      Firestore.instance
          .collection('user')
          .document(otherUserId)
          .collection('engagedChatChannels')
          .document(currentUID)
          .setData(channel);

      onSave(newChatChannel.documentID);
      setChannelId(newChatChannel.documentID);
      print('new id Created');
    }).catchError((e) => print('errorFirebase :${e.toString()}'));
  }

  Stream<List<TextMessage>> messages(String channelId) {
    return _chatChannels
        .document(channelId)
        .collection('messages')
        .orderBy('time')
        .snapshots()
        .map((snapshot) {
      return snapshot.documents
          .map((doc) =>
              TextMessage.fromEntity(TextMessageEntity.fromSnapshot(doc)))
          .toList();
    });
  }

  Future<void> sendMessage(TextMessageEntity message, String channelId) async {
    _chatChannels
        .document(channelId)
        .collection('messages')
        .add(message.toDocument())
        .catchError((e) => print('sendMessage ${e.toString()}'));
  }

  Future<String> getChannelId() async {
    return this._channelID;
  }

  Future<void> setChannelId(String channelId) async {
    this._channelID = channelId;
  }
}
