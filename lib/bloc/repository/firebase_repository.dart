import 'package:capital_academy_app/model/user.dart';
import 'package:capital_academy_app/model/user_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';



class FirebaseUserRepository {
  final FirebaseAuth _firebaseAuth;

  FirebaseUserRepository({FirebaseAuth firebaseAuth})
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

  Future<void> signUp(String email,String password)async{
    await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
  }
  Future<void> signIn(String email,String password)async{
    await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
  }
  Future<void> onSignOut()async{
    await _firebaseAuth.signOut();
  }

  final userCollection = Firestore.instance.collection('user');

  Future<void> addNewUser(User user) {
    return userCollection.add(user.toEntity().toDocument());
  }

  Future<void> getInitializedCurrentUser({String name,String status})async{
    return userCollection.document((await _firebaseAuth.currentUser()).uid)
        .get().then((user)async{
       if (!user.exists){
         var newUser=User(uid: (await _firebaseAuth.currentUser()).uid,name: name,status: status).toEntity().toDocument();
         userCollection.document((await _firebaseAuth.currentUser()).uid).setData(newUser);
       }
    }).catchError((e) => print("firebaseError ${e.toString()}"));
  }

  Future<void> deleteUser(User todo) async {
    return userCollection.document(todo.uid).delete();
  }

  Stream<List<User>> users() {
    return userCollection.snapshots().map((snapshot) {
      return snapshot.documents
          .map((doc) => User.fromEntity(UserEntity.fromSnapshot(doc)))
          .toList();
    });
  }

  Future<void> updateUsers(User update) {
    return userCollection
        .document(update.uid)
        .updateData(update.toEntity().toDocument());
  }
}